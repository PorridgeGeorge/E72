function output = ziplineOBJ(P)
Y = P(1);
T = P(2);

solution = velocity72([Y T 70]);
output = -solution(1);

end

