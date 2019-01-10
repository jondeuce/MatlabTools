function [varargout] = disp_wide(A, varargin)
%DISP_WIDE Displays the matrix A without wrapping.

S = num2str(A, varargin{:});
S = reshape(strrep(S(:).', '0', ' ').', size(S));

fprintf('\n');
for ii = 1:size(S,1)
    fprintf('%s\n', S(ii,:));
end
fprintf('\n');

if nargout > 0
    varargout{1} = S;
end

end

