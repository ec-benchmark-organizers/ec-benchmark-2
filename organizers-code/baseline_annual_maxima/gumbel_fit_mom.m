function [mu, sigma] = gumbel_fit_mom(x)

% moment estimators for Gumbel distribution
sigma=sqrt(6)*std(x)/pi;
mu=mean(x)-0.577216*sigma;