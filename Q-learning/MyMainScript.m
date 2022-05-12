delta = 0.01;
d = 2;
M = 100;

%% ds
V = zeros(2*M+1,2*M+1);
total_runs = 100;
for num_runs = 1:total_runs
    x = zeros(d,1);
    for i=1:d
        x(i) = randi([-M,M]);
    end
    Q = zeros(2*M+1,2*M+1,d);
for n = 1:1000000
    u = randi(d);
    y = next_state(x,u, M);
    Q(x(1)+M+1,x(2)+M+1,u) = Q(x(1)+M+1,x(2)+M+1,u) + (1/(1+floor(n/5000)))* (min(min(Q(y(1) + M + 1,y(2) + M+1,:)), drop(delta*y))- Q(x(1)+M+1,x(2)+M+1,u));
%     disp('Q')
%     disp(Q(x(1)+M+1,x(2)+M+1,u))
%     disp('x')
%     disp(x)
    x = y;
end



for x = 1: 2*M+1
    for y = 1: 2*M+1
        V(x,y) = V(x,y) + min(Q(x,y,:));
    end
end


end
V = V/total_runs;
surf(V);

%%





function y_i = next_state(x,i, M)
    toss = randi(2);
    if toss==2
        toss = -1;
    end
    z = zeros(size(x,1),1);
    z(i) = 1;
    y_i = x + toss*z;
    
    if y_i(i) < -M
        y_i(i) = -M;
    end
    if y_i(i) > M
        y_i(i) = M;
    end
end