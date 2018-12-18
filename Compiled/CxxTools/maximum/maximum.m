function [v] = maximum(x)
%MAXIMUM Maximum element of the N-D array x, interpreted as a vector.

if isrowvector(x)
    v = max(x, [], 2);
    return
end

v = max(squeeze(x), [], 1);
while ~isscalar(v)
    if isrowvector(v)
        v = v(:); % 2D-arrays are unaffected by squeeze
    else
        v = squeeze(v);
    end
    v = max(v, [], 1);
end

% This is ~4X slower for large arrays
% v = max(x(:));

end

