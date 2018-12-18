function [v] = infnorm(x)
%INFNORM Infinity norm of the N-D array x, interpreted as a vector.

if isreal(x)
    v = max(maximum(x), -minimum(x));
else
    % Despite the extra allocation, maximum(x2) is actually faster than
    % abs(maximum(x)), since max of a complex array (checking for magnitude
    % equality and then comparing phase) is fundamentally slow.
    % Unfortunately, this also implies that there is a lot to gain by
    % re-writing this in C in order to avoid allocation abs(x) or abs2(x),
    % as well as avoiding all those square roots.
    x2 = real(x).^2 + imag(x).^2; % this is faster than abs(x)
    %x2 = x .* conj(x); % slower than above, since it does cplx mul
    v = sqrt(maximum(x2));
    %v = maximum(abs(x)); % faster than abs(maximum(x))
    %v = abs(maximum(x));
end

% This is ~2X slower for large real arrays, and ~30X slower for complex!
% v = norm(x(:), Inf);

end

