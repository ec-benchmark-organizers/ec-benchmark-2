function x = gumbel_inv(P,mu,sigma)

% calculates inverse of Gumbel CDF

x = mu + sigma.*(-log(-log(P)));