data = xlsread('dataproject5');

matrixzeros = zeros(2515);
daily_returns = matrixzeros(:, [1 2 3 4]);

for i = 1 : 2515 
    val1 = data(i, 1);
    val2 = data(i + 1, 1);
    returns = (val2 - val1)/val1;
    daily_returns(i, 1) = returns;
    val3 = data(i, 2);
    val4 = data(i+1, 2);
    returns2 = (val4 - val3)/val3;
    daily_returns(i, 2) = returns2;
    val5 = data(i, 3);
    val6 = data(i + 1, 3);
    returns3 = (val6 - val5)/val5;
    daily_returns(i, 3) = returns3;
end

mean_amzn = sum(daily_returns(:, 1))/2515;
mean_duk = sum(daily_returns(:, 2))/2515;
mean_ko = sum(daily_returns(:, 3))/2515;
stdev_amzn = std(daily_returns(:,1));
stdev_duk = std(daily_returns(:,2));
stdev_ko = std(daily_returns(:,3));
var_amzn = (stdev_amzn)^2;
var_duk = (stdev_duk)^2;
var_ko = (stdev_ko)^2;

R_AMZN_DUK = corrcoef((daily_returns(:, 1)), (daily_returns(:,2)));
R_AMZN_KO = corrcoef((daily_returns(:, 1)), (daily_returns(:,3)));
R_DUK_KO = corrcoef((daily_returns(:, 2)), (daily_returns(:,3)));

matrix_initial_amz = matrixzeros(1, :);
matrix_initial_duk = matrixzeros(1, :);
matrix_initial_ko = matrixzeros(1, :);

for i = 1 : 2515
     val_amz = .5 * daily_returns(i, 1);
     val_duk = .3 * daily_returns(i, 2);
     val_ko = .2 * daily_returns(i, 3);
     matrix_initial_amz(i) = val_amz;
     matrix_initial_duk(i) = val_duk;
     matrix_initial_ko(i) = val_ko;
end

R_amz = sum(matrix_initial_amz) / 2515;
R_duk = sum(matrix_initial_duk) / 2515;
R_ko = sum(matrix_initial_ko) / 2515;

R = (sum(matrix_initial_amz) + sum(matrix_initial_duk) + sum(matrix_initial_ko)) / 2515 

var_R = ((0.5^2)*(var_amzn) + (0.3^2)*(var_duk) + (0.2^2)*(var_ko) + (2 * ((0.5 * 0.3 * 0.1531 * 0.0195 * 0.0094)+(0.5 * 0.2 * 0.2561 * 0.0195 * 0.0093)+(0.2 * 0.3 * 0.4639 * 0.0094 * 0.0093))));
std_R = sqrt(var_R);

% function to be minimized 

x0 = [0;0;0;0];
[x, fval] = fmincon('objfun', x0, [], [], [], [], [0; 0; 0; 0], [1;1;1;1], 'constraint')


est1 = sqrt(((.9998^2)*(var_amzn) + (.0001^2)*(var_duk) + (0^2)*(var_ko) + (2 * ((.9998 * .0001 * 0.1531 * 0.0195 * 0.0094)+(.9998 * .0001 * 0.2561 * 0.0195 * 0.0093)+(0 * .0001 * 0.4639 * 0.0094 * 0.0093))))) 
est2 = sqrt(((0.7462^2)*(var_amzn) + (0.1922^2)*(var_duk) + (0.0152^2)*(var_ko) + (2 * ((0.7462 * 0.1922 * 0.1531 * 0.0195 * 0.0094)+(0.7462 * 0.0152 * 0.2561 * 0.0195 * 0.0093)+(0.1922 * 0.0152 * 0.4639 * 0.0094 * 0.0093))))) 
est3 = sqrt(((.4677^2)*(var_amzn) + (.2568^2)*(var_duk) + (.0205^2)*(var_ko) + (2 * ((.4677 * .2568 * 0.1531 * 0.0195 * 0.0094)+(.4677 * .0205 * 0.2561 * 0.0195 * 0.0093)+(.0205 * .2568 * 0.4639 * 0.0094 * 0.0093))))) 
est4 = sqrt(((.0556^2)*(var_amzn) + (.1974^2)*(var_duk) + (.1642^2)*(var_ko) + (2 * ((.0556 * .1974 * 0.1531 * 0.0195 * 0.0094)+(.0556 * .1642 * 0.2561 * 0.0195 * 0.0093)+(.1642 * .1974 * 0.4639 * 0.0094 * 0.0093))))) 
