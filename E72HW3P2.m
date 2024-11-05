% road height h
% existing height e

% Goal: output a function that maps h against x and the cost C


%Questions does matlab know to stop once the forloop expands past 101
%How do I relate cost and cut
 
% Going to have a 606*101 matrix with the constraints in the rows and the
% postions from 1:d:L in the columns
%give it a road and find the cost

function output = E72HW3P2(h)

L = 100;
cost = 0;
x = 1:101;
e = 5*sin((3*pi*x)/L) + sin((10*pi*x)/L);
%h = mean(e).*ones(1,101);

for i = 1:100
    if h(i) < e(i)
        cost = cost + (2*(e(i)-h(i))^2 + 30*(e(i)-h(i)));
    else
        cost = cost + (12*(h(i)-e(i))^2) + (h(i)-e(i));
    end
end


output = cost

