function mv = solver(ai,af,w)
%
% Copyright 2004 The MathWorks, Inc.

nBlocks = max(ai(:));
[m,n] = size(ai);

% Make increment tables
% N=1, E=2, S=3, W=4
I = [0  1  0 -1];
J = [1  0 -1  0];
a = ai;
mv = zeros(200000,2);
mi = 1;

while ~isequal(af,a)

    % Pick a random block
    bid = ceil(rand*nBlocks);
    [i,j] = find(a==bid);

    % Move it in a random direction
    r = ceil(rand*4);
    ni = i + I(r);
    nj = j + J(r);

    % Is it a legal move? Check edges
    if (ni<1) || (ni>m) || (nj<1) || (nj>n)
        continue
    end

    % Is it a legal move? Check for collision
    if a(ni,nj)>0
        continue
    end

    % Check distance
    % Get the target location
    [ti,tj] = find(af==bid);
    d = (ti-i)^2 + (tj-j)^2;
    dn = (ti-ni)^2 + (tj-nj)^2;
    % Have we moved closer to the target location?
    if (d<dn) && (rand>0.05)
        continue
    end

    % Move the block
    a(ni,nj) = bid;
    a(i,j) = 0;

    % Record the move
    mv(mi,[1 2]) = [bid r];
    mi = mi+1;
end
%mv = mv(1:mi-1,:)
