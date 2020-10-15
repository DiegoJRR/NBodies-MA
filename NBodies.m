bodies = [Body(), Body(), Body()];
dt = 1;
t = 0:dt:dt*1000;

for ti = 1:1000
    for i = 1:3
       idxs = setdiff(1:3, i);
       bodies(i).updateBody(bodies(idxs(1)), bodies(idxs(2)), dt, ti);
    end
end

plot3(pos1(:, 1), pos1(:, 2), pos1(:, 3), 'k.-')
