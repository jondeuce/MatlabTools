function y = abs2( x )
%ABS2 y = abs2( x ). Returns abs(x).^2 elementwise without needing to take
% the square root of x first.

if isreal(x)
    y = x.*x;
else
    y = x.*conj(x);
end

if ~isreal(y)
    y = real(y);
end

end

