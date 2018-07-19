function b = isinbox(p, bbox)
%ISINBOX Returns logical array of length size(p,1), indicating whether the
%corresponding point p(i,:) is strictly within the box bbox.

b = bbox(1,1) < p(:,1) & p(:,1) < bbox(2,1) & ...
    bbox(1,2) < p(:,2) & p(:,2) < bbox(2,2);

end