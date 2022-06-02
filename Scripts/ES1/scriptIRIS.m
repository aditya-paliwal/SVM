
clear;
clc;

load iris.mat

% Xtrain = trainset;
% Ytrain = labels_train;
% Xtest = testset;
% Ytest = labels_test;

% % % polynomial kernal
% type = 'c';
% gam = 1;
% t = 1;
% err_list = [];
% degree_list = 1:20;
% % 
% for degree = degree_list
%     [alpha,b] = trainlssvm({Xtrain,Ytrain,type,gam,[t;degree],'poly_kernel'});
%     [Yht, Zt] = simlssvm({Xtrain,Ytrain,type,gam,[t;degree],'poly_kernel'}, {alpha,b}, Xtest);
%     err = sum(Yht~=Ytest); 
%     err_list = [err_list;  err/length(Ytest)*100];
% end
% 
% plot(degree_list, err_list, '-o', 'LineWidth', 3)

% % figure
% figure;
% plotlssvm({Xtrain,Ytrain,type,gam,[t;degree],'poly_kernel'},{alpha,b})
% title({'Polynomial kernel' 'Degree:' degree})
 

% fprintf('\n on test: #misclass = %d, error rate = %.2f%%\n', err, err/length(Ytest)*100)

%RBF Kernel sig2
% 
%  gam = 1;
%  type = 'c';
%  sig2list = [0.001, 0.01, 0.1, 0.5, 1, 5, 10, 20, 50, 100];
%  errlist = [];
%  for sig2=sig2list
%      disp(['gam : ', num2str(gamma), '   sig2 : ', num2str(sig2)]),
%      [alpha,b] = trainlssvm({Xtrain,Ytrain,type,gamma,sig2,'RBF_kernel'});
%  
%      % Plot the decision boundary of a 2-d LS-SVM classifier
%      plotlssvm({Xtrain,Ytrain,type,gamma,sig2,'RBF_kernel','preprocess'},{alpha,b});
%  
%      % Obtain the output of the trained classifier
%      [Yht, Zt] = simlssvm({Xtrain,Ytrain,type,gamma,sig2,'RBF_kernel'}, {alpha,b}, Xtest);
%      err = sum(Yht~=Ytest); 
%      errlist=[errlist; err/length(Ytest)*100];
%      fprintf('\n on test: #misclass = %d, error rate = %.2f%% \n', err, err/length(Ytest)*100)
%  end
%  
%  plot(sig2list,errlist,'-s','Linewidth',3)
%  ylabel('error rate %'); xlabel('sig2')
%  title('RBF Kernel: Effect of  sig2 on classification error')
%  ylim([0 60])

 %% RBF Kernel gamm
% sig2 = 12;
% gamlist = [0.01, 0.5, 4, 10, 20, 100];
% errlistg = [];
% for gam = gamlist
%     [alpha,b] = trainlssvm({Xtrain,Y,'c',gam,sig2,'RBF_kernel'});
%     Ytest = simlssvm({Xtrain,Y,'c',gam,sig2,'RBF_kernel'},{alpha,b},Xt);
%     err = sum(Ytest~=Yt);
%     errlistg = [errlistg; err/length(Yt)*100];
% 
% end
% 
% plot(gamlist, errlistg)
% ylabel('error rate '); xlabel('gamma ')
% title('RBF Kernel gam')

%%% TUNING PARAMETERS:

% gam=1;
% sig2=0.01;

% for gam=gamlist,
%     errlist=[];
%     
%     for sig2=sig2list,
%         % calculate the prediction error
%         err = leaveoneout({Xtrain, Ytrain, 'c', gam, sig2, 'RBF_kernel'}, 'misclass'); 
%         errlist = [errlist; err];
%         %fprintf('\n on test: #misclass = %d, error rate = %.2f%% \n', err, (err/10)*100)         
%     end
% 
%     % make a plot of the % misclassification wrt. sig2 for each gam val
%     figure;
%     plot(log(sig2list), errlist, '*-', 'LineWidth', 3, 'MarkerSize', 12),
%     xlabel(sprintf('log(sig2)-with-gam = %s', num2str(gam))), ylabel('avg. num. misclassified (in 8 folds)'),
% end

% kernel_type = 'poly_kernel'; % or 'lin_kernel', 'poly_kernel'
% global_opt = 'csa'; % 'csa' or 'ds'
% [gam,sig2,cost] = tunelssvm({Xtrain, Ytrain, 'c', [], [], 'RBF_kernel'}, 'gridsearch','crossvalidatelssvm',{10, 'misclass'});


% [alpha,b] = trainlssvm({Xtrain,Ytrain,'c',100,0.01,'RBF_kernel'});
% [Yest, Ylatent] = simlssvm({Xtrain,Ytrain,'c',gam,sig2,'RBF_kernel'},{alpha,b},Xtest);
% roc(Ylatent , Ytest)

% bay_modoutClass({Xtrain, Ytrain, 'c', gam, sig2}, 'figure');
% colorbar;
% 
% %% vary sigma2 on baysian interface:
% sig2 = 1;
% gam = 20;
% 
% bay_modoutClass({Xtrain, Ytrain, 'c', gam, sig2}, 'figure');
% colorbar;

% real dataset
% 
% % plot the data
% figure;
% hold on;
% % plot the train set
% gscatter(Xtrain(:,1), Xtrain(:,2), Ytrain,'br', 'xo');
% % plot the test set
% % gscatter(Xtest(:,1), Xtest(:,2), Ytest, 'br', 'xo');
% hold off;
% title('Diabetes Data: Training Set');
% % title('Diabetes Data: Test Set');
% xlabel('x1');
% ylabel('x2');

% 
kernel = 'RBF_kernel'; % 'RBF_kernel' or 'lin_kernel'
model = {Xtrain,Ytrain,'c',[],[],kernel};
[gam,sig2,cost] = tunelssvm(model,'simplex', 'crossvalidatelssvm', {10,'misclass'});
[alpha,b] = trainlssvm({Xtrain,Ytrain,'c',gam,sig2, kernel});
% % 
% plotlssvm({Xtrain, Ytrain, 'c', gam, sig2, kernel, 'preprocess'}, {alpha, b});
% % 
[Ysim, Ylatent] = simlssvm({Xtrain,Ytrain,'c',gam,sig2,kernel},{alpha,b},Xtest);
roc(Ylatent,Ytest);



