function dataout=resample(datain,n)

% outputs a random sample of the rows of datain
% samples are drawn at random with replacement
% n is an optional input to specify how many samples to draw
% if n is not entered dataout is same size as datain

% number of samples to draw
if nargin==1
    n=size(datain,1);
end
% random selections of lines from input data
N=size(datain,1);
lines=ceil(N*rand(n,1));
% output selection
dataout=datain(lines,:);