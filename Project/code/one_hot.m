function u = one_hot(u1, cd)
u = zeros(u1);
for i = 1:u1(1)
    u(i,cd(i)) = 1;
end