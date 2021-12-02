time = linspace(0, 90, 90*100);
% % 
% figure;
% fun_6 = preprocessing.load_forcing_fun(10);
% y6 = fun_6(time);
% plot(time, y6);
% hold on;
% 
% fun_7 = preprocessing.load_forcing_fun(13);
% y7 = fun_7(time);
% plot(time, y7);

% figure;
% % 
fun_10 = tools.fofu_time_shift(10, 90, -1, -1, "nehmirror");
y10 = fun_10(time);
plot(time, y10);
hold on;

fun_11 = preprocessing.load_forcing_fun(10);
y11 = fun_11(time);
plot(time, y11);
hold on;
% 
% fun_12 = preprocessing.load_forcing_fun(12);
% y12 = fun_12(time);
% plot(time, y12);
% 
% hold on;
% 
% fun_13 = preprocessing.load_forcing_fun(13);
% y13 = fun_13(time);
% plot(time, y13);



