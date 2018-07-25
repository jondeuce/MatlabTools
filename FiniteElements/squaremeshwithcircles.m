function [p, t] = squaremeshwithcircles( bbox, centers, radii, h0, eta, isunion )
%SQUAREMESHWITHCIRCLES
%      BBOX:      Bounding box [xmin, xmax, ymin, ymax]
%      CENTRES:   Fixed node positions (NCIRCLES x 2)
%      RADII:     Fixed node positions (NCIRCLES x 1)
%      H0:        Initial edge length
%      ETA:       Parameter to shorten edges near circles. Zero gives none
%      ISUNION:   Flag to include circle interiors in domain (default true)

if nargin == 0; runMinExample; return; end

boxscale = min(diff(bbox,1));
if nargin < 6; isunion = true; end
if nargin < 5; eta = 5; end
if nargin < 4; h0 = boxscale/25; end

[x1,x2,y1,y2] = deal(bbox(1,1), bbox(2,1), bbox(1,2), bbox(2,2));
corners = [x1,y1; x2,y1; x1,y2; x2,y2];
circlePoints = gencirclepointsinbox(h0, bbox, centers, radii);
circlePoints = circlePoints(isinoronbox(circlePoints, bbox, sqrt(eps(boxscale))), :);

fdrectangle = @(p) drectangle(p,x1,x2,y1,y2);
fdcircles = @(p) dcircles(p,centers(:,1),centers(:,2),radii,~isunion);
fclamp = @(d, dmin, dmax) max(min(d, dmax), dmin);

if eta == 0.0
    fh = @huniform;
else
    fh = @(p) h0 * (1 + eta * fclamp(abs(fdcircles(p)), 0, boxscale/2)/boxscale);
end

if isunion
    fd = fdrectangle;
else
    fd = @(p) ddiff(fdrectangle(p), fdcircles(p));
end

pfix = unique([corners; circlePoints], 'rows');
% pfix = corners;

[p, t] = distmesh2d(fd,fh,h0,bbox,pfix);

% Set side lengths to be exact
deps = sqrt(eps)*h0;
approx_eq = @(a,b) abs(bsxfun(@minus,a,b))<=10*deps;

p(approx_eq(p(:,1),x1),1) = x1;
p(approx_eq(p(:,1),x2),1) = x2;
p(approx_eq(p(:,2),y1),2) = y1;
p(approx_eq(p(:,2),y2),2) = y2;

end

function [p, t] = runMinExample

% bbox    = [-20,-20; 20,20];
% centers = [5.5, 5.5; -7.0,-0.8; -7.0,-0.8];
% radii   = [     2.5;       4.9;       2.0];

bbox    = [-1.0 -1.0;  1.0 1.0];
centers = [ 0.0 -0.5; -0.4 0.8; 0.70 0.70];
radii   = [      0.5;      0.5;      0.38];

% boxscale = min(diff(bbox,1));
% circlesPerRow = 3;
% circlesPerCol = 3;
% Ncircles = circlesPerRow * circlesPerCol;
% [X,Y] = meshgrid(linspacePeriodic(bbox(1,1),bbox(2,1),circlesPerRow), ...
%                  linspacePeriodic(bbox(1,2),bbox(2,2),circlesPerCol));
% dX = (bbox(2,1) - bbox(1,1))/circlesPerRow;
% dY = (bbox(2,2) - bbox(1,2))/circlesPerCol;
% centers = [X(:), Y(:)];
% radii = 0.5*min(dX,dY)/2*ones(Ncircles,1);

Nmin = 100; % points for smallest circle
h0 = 2*pi*min(radii)/Nmin; % approximate scale
eta = 5; % approx ratio between largest/smallest edges

figure
[p, t] = squaremeshwithcircles( bbox, centers, radii, h0, eta );

end

% fd=@(p) drectangle(p,-1,1,-1,1);
% fh=@(p) 0.03+0.3*abs(dcircles(p,[-0.2,0.3],[0,0],[0.25,0.5],false));
% figure, [p,t]=distmesh2d(fd,fh,0.03,[-1,-1;1,1],[-1,-1;-1,1;1,-1;1,1]);
