function y = vec( x )
%VEC y = vec( x ). Returns x(:).

y = x;

% Shouldn't return empty y directly; y(:) for an empty array actually
% returns an empty 0x1 array, so should continue to the reshape below.
% if isempty(y); return; end

% MUCH faster than y(:). It seems to just modify the mex struct directly?
y = reshape(y, numel(y), 1);

end
