function [p, t] = squareMeshWithCircles( bbox, centers, radii, h0, eta )
%SQUAREMESHWITHCIRCLES
%      BBOX:      Bounding box [xmin, ymin
%                               xmax, ymax]
%      CENTRES:   Fixed node positions (NCIRCLESX2)
%      RADII:     Fixed node positions (NCIRCLESx1)

if nargin == 0; [p, t] = runMinExample; return; end

boxscale = min(diff(bbox,1));
if nargin < 4; h0 = boxscale/25; end
if nargin < 5; eta = 5; end

corners = [bbox(1),bbox(3); bbox(2),bbox(3); bbox(1),bbox(4); bbox(2),bbox(4)];
circlePoints = getCirclePoints(h0, centers, radii);
circlePoints = circlePoints(isInBox(circlePoints, bbox), :);

fdcircles = @(p) dcircles(p,centers(:,1),centers(:,2),radii,false);
fclamp = @(d, dmin, dmax) max(min(d, dmax), dmin);
fd = @(p) drectangle(p,bbox(1),bbox(2),bbox(3),bbox(4));
fh = @(p) h0 * (1 + eta * fclamp(fdcircles(p), 0, boxscale/2)/boxscale);
% fh = @huniform;

pfix = unique([corners; circlePoints], 'rows');
% pfix = corners;

[p, t] = distmesh2d(fd,fh,h0,bbox,pfix);


deps = sqrt(eps)*h0;
p(abs(p(:,1)-bbox(1,1))<=10*deps,1) = bbox(1,1);
p(abs(p(:,1)-bbox(2,1))<=10*deps,1) = bbox(2,1);
p(abs(p(:,2)-bbox(1,2))<=10*deps,2) = bbox(1,2);
p(abs(p(:,2)-bbox(2,2))<=10*deps,2) = bbox(2,2);

end

function circlePoints = getCirclePoints(h0, centers, radii)

Ns = round(2*pi*radii/h0);
Ns = max(Ns,8); %circle should have at least 8 points
Ntotal = sum(Ns);
circlePoints = zeros(Ntotal, 2);

idx = 1;
for ii = 1:length(radii)
    r = radii(ii);
    N = Ns(ii);
    th = linspacePeriodic(0,2*pi,N).';
    circlePoints(idx:idx+N-1,:) = bsxfun(@plus, r*[cos(th), sin(th)], centers(ii,:));
    idx = idx + N;
end

end

function b = isInBox(p, bbox)

b = bbox(1,1) < p(:,1) & p(:,1) < bbox(2,1) & ...
    bbox(1,2) < p(:,2) & p(:,2) < bbox(2,2);

end

function [p, t] = runMinExample

bbox = [-20,-20; 20,20];
% boxscale = min(diff(bbox,1));

centers = [5.5, 5.5; -7.0,-0.8; -7.0,-0.8];
radii   = [     2.5;       4.9;       2.0];

% circlesPerRow = 3;
% circlesPerCol = 3;
% Ncircles = circlesPerRow * circlesPerCol;
% [X,Y] = meshgrid(linspacePeriodic(bbox(1,1),bbox(2,1),circlesPerRow), ...
%                  linspacePeriodic(bbox(1,2),bbox(2,2),circlesPerCol));
% dX = (bbox(2,1) - bbox(1,1))/circlesPerRow;
% dY = (bbox(2,2) - bbox(1,2))/circlesPerCol;
% centers = [X(:), Y(:)];
% radii = 0.5*min(dX,dY)/2*ones(Ncircles,1);

Nmin = 25; % points for smallest circle
h0 = 2*pi*min(radii)/Nmin; % approximate scale
eta = 5; % approx ratio between largest/smallest edges

figure
[p, t] = squareMeshWithCircles( bbox, centers, radii, h0, eta );

end

% fd=@(p) drectangle(p,-1,1,-1,1);
% fh=@(p) 0.03+0.3*abs(dcircles(p,[-0.2,0.3],[0,0],[0.25,0.5],false));
% figure, [p,t]=distmesh2d(fd,fh,0.03,[-1,-1;1,1],[-1,-1;-1,1;1,-1;1,1]);
