clear

% load data
exercise=2;
site=1;
filename=['Exercise' num2str(exercise) '_Site' num2str(site) '_FIOESM_data.csv'];

data=dlmread(filename,',',1,0);
year=data(:,1);
month=data(:,2);
Hs=data(:,5);

% change year to run summer-to-summer
year(month>=7)=year(month>=7)+1;

% calculate annual maxima
yy=unique(year);
Annmax=zeros(length(yy),1);
for i=1:length(yy)
    bin=year==yy(i);
    Annmax(i)=max(Hs(bin));
end

% fit gumbel distribution
[mu, sigma]=gumbel_fit_mom(Annmax);

% calculate quantiles
N=logspace(0,3,100);
P=1-1./N;
x=gumbel_inv(P,mu,sigma);

% calculate return values 
T=[5 50 500];
RV=gumbel_inv(1-1./T,mu,sigma);
 
% bootstrap record to get confidence interval
trials=1000;
x_boot=zeros(trials,length(P));
RV_boot=zeros(trials,3);
for j=1:trials
    z=resample(Annmax);
    [mu, sigma]=gumbel_fit_mom(z);
    x_boot(j,:)=gumbel_inv(P,mu,sigma);
    RV_boot(j,:)=gumbel_inv(1-1./T,mu,sigma);
end
x_boot=sort(x_boot);
RV_boot=sort(RV_boot);

% create array of return values and 95% confidence bounds
return_values=zeros(3,3);
for i=1:3
    return_values(i,:)=[RV(i), RV_boot(round(trials*0.025),i), RV_boot(round(trials*0.975,i),i)];
end

% calculate empirical exceedance probabilities
n=length(Annmax);
k=1:n;
Pempirical=(k-0.31)/(n+0.38);

% plot results
figure
hold on; box on; grid on
plot(sort(Annmax),1-Pempirical,'ko')
plot(x,1-P,'r')
plot(x_boot(round(trials*0.025),:),1-P,'b--')
plot(x_boot(round(trials*0.975),:),1-P,'b--')
xlabel('Annual Max Hs [m]')
ylabel('Exceedance probability')
title(['Exercise ' num2str(exercise) ', Site ' num2str(site)])
ylim([1e-2 1])
set(gca,'yscale','log')
set(gca,'YMinorTick','off')
set(gca,'YMinorGrid','off')
set(gca,'YTick',[1e-2 2e-2 1e-1 2e-1 1])
set(gca,'YTickLabel',{'1/100','1/50','1/10','1/5','1'})

