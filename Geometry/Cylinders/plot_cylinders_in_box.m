function [Fig] = plot_cylinders_in_box( p, v, r, BoxDims, BoxCenter, titlestr, fig, col, alpha, verb )
%PLOT_CYLINDERS_IN_BOX Plots the cylinderes defined by the [3xN] set of
%points and directinos p and v and [1xN] radii r in the box defined by the
%[3x1] vectors BoxDims and BoxCenter.

if nargin < 10 || isempty(verb);     verb = false; end
if nargin < 9  || isempty(alpha);    alpha = 0.2; end
if nargin < 8  || isempty(col);      col = 'b'; end
if nargin < 7  || isempty(fig);      fig = figure; end
if nargin < 6  || isempty(titlestr); titlestr = ''; end

BoxBounds = [ BoxCenter(:)' - 0.5*BoxDims(:)'
              BoxCenter(:)' + 0.5*BoxDims(:)' ];
[~, fig] = rectpatchPlot( BoxBounds, fig );

for ii = 1:size(p,2)
    if verb; fprintf('Minor cylinder %d/%d\n', ii, size(p,2)); end
    cylinderPlot( p(:,ii), v(:,ii), r(ii), 2*norm(BoxDims), fig, col, alpha );
end

axis image
axis( (1+1e-2) * BoxBounds(:)' )

xlabel('x'); ylabel('y'); zlabel('z');
if ~isempty( titlestr ); title( titlestr ); end

% Should avoid drawnow here in case this function is called many times in
% an inner loop, e.g. to plot many different cylinders
% drawnow

if nargout >= 1; Fig = fig; end

end
