function [v] = minimum(x)
%MINIMUM Minimum element of the N-D array x, interpreted as a vector.

if isrowvector(x)
    v = min(x, [], 2);
    return
end

v = min(squeeze(x), [], 1);
while ~isscalar(v)
    if isrowvector(v)
        v = v(:); % 2D-arrays are unaffected by squeeze
    else
        v = squeeze(v);
    end
    v = min(v, [], 1);
end

% This is ~3-4X slower for large arrays
% v = min(x(:));

end

