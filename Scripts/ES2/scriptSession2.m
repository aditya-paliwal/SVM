% clear;
% clc;
% 
% X = ( -3:0.01:3)';
% Y = sinc(X) + 0.1.*randn(length(X), 1);
% 
% % split test and train sets
% Xtrain = X(1:2:end);
% Ytrain = Y(1:2:end); 
% Xtest = X(2:2:end); 
% Ytest = Y(2:2:end);

gam = 1;
sig2 = 0.1;

gam_list = [];
sig2_list = [];
list_i = [1:10];

for i = list_i

[gam,sig2,cost] = tunelssvm({Xtrain, Ytrain, 'f', [], [], 'RBF_kernel', 'ds'}, 'gridsearch', 'crossvalidatelssvm',{10, 'mse';});
gam_list(i) = gam;
sig2_list(i) = sig2 ;

end

% for i = 1:length(sig_list)
%     sig2 = sig_list(i);
%     for j = 1:length(gam_list)
%         gam = gam_list(j);
%         [alpha,b] = trainlssvm({Xtrain,Ytrain,'f',gam,sig2,'RBF_kernel'});
%         YtestEst = simlssvm({Xtrain,Ytrain,'f',gam,sig2,'RBF_kernel'}, {alpha,b},Xtest);
%         mse_test = mse(YtestEst-Ytest);
%         mse_matrix(i,j) = mse_test;
%         plot(Xtest,Ytest,'.', 'MarkerSize', 15);
%         hold on;
%         plot(Xtest,YtestEst,'r-+', 'LineWidth', 2);
%         legend('Ytest','YtestEst');
%         title('gam = 1000, sig2 = 100');
%     end
% end

% 
% sig2 = 0.5;
% gam = 10;
% 
% X = 6.*rand(100, 3) - 3;
% Y = sinc(X(:,1)) + 0.1.*randn(100,1);
% 
% Xtrain = X(1:2:end);
% Ytrain = Y(1:2:end); 
% Xtest = X(2:2:end); 
% Ytest = Y(2:2:end);

% % 
% [~,alpha,b] = bay_optimize({Xtrain, Ytrain, 'f', gam, sig2}, 1);
% [~,gam] = bay_optimize({Xtrain, Ytrain, 'f', gam, sig2}, 2);
% [~,sig2] = bay_optimize({Xtrain, Ytrain, 'f', gam, sig2}, 3);
% % 
% sig2e = bay_errorbar({Xtrain, Ytrain, 'f', gam, sig2}, 'figure');
% 
% [selected, ranking] = bay_lssvmARD({X, Y, 'f', gam, sig2});
% 
% X = ( -6:0.2:6)';
% Y = sinc(X) + 0.1.*rand(size(X));
% 
% out = [15 17 19];
% Y(out) = 0.7+0.3*rand(size(out));
% out = [41 44 46];
% Y(out) = 1.5+0.2*rand(size(out));
% 
% model = initlssvm(X, Y, 'f', [], [], 'RBF_kernel');
% costFun = 'crossvalidatelssvm';
% model = tunelssvm(model, 'simplex', costFun, {10, 'mse';});
% plotlssvm(model);
% hold on;

% model = initlssvm(X,Y, 'f', [], [], 'RBF_kernel');
% costFun = 'rcrossvalidatelssvm';
% wFun = 'whuber';
% model = tunelssvm(model, 'simplex', costFun, {10, 'mae'}, wFun);
% model = robustlssvm(model);
% plotlssvm(model);

% load santafe.mat
% 
% order = 50;
% X = windowize(Z, 1:(order + 1));
% Y = X(:, end);
% X = X(:, 1:order);
% 
% gam = 1345;
% sig2 = 24;
% [alpha, b] = trainlssvm({X, Y, 'f', gam, sig2});
% 
% Xs = Z(end-order+1:end, 1);
% 
% nb = 50;
% prediction = predict({X, Y, 'f', gam, sig2}, Xs, nb);
% 
% figure;
% hold on;
% plot(Ztest, 'k');
% plot(prediction, 'r')
% hold off;

% load santafe.mat
% 
% 
% lag = 50; % lag of the series; lag 21 had the minimum MAPE
% X = windowize(Z,1:(lag+1));
% Y = X(:,end);
% X = X(:,1:lag);
% horizon = length(Ztest)-lag;
% 
% [gam,sig2] = tunelssvm({X,Y,'f',[],[],'RBF_kernel'}, 'simplex','crossvalidatelssvm', {10,'mae'});
% % model = bay_optimize({X,Y,'f',gam,sig2,'RBF_kernel','csa','original'},1);
% % model = bay_optimize({X,Y,'f',gam,sig2,'RBF_kernel','csa','original'},2);
% % model = bay_optimize({X,Y,'f',gam,sig2,'RBF_kernel','csa','original'},3);
% model = trainlssvm({X,Y,'f',gam,sig2, 'RBF_kernel', 'csa', 'original'});
% Zpt = predict(model,Ztest(1:lag),horizon);
% 
% mape = mean(abs(Zpt-Ztest(lag+1:end))./abs(Ztest(lag+1:end)));
% mae = mean(abs(Zpt-Ztest(lag+1:end)));
% figure;
% plot([Ztest(lag+1:end) Zpt]);
% xlabel('Time');
% legend('Test Data','Prediction');
% title(sprintf('Lag = %s; MAPE = %s; MAE = %s', num2str(lag), num2str(mape), num2str(mae)));
% mape;
% mae;
% 
% 
% 
% 
% 
% 
% 
