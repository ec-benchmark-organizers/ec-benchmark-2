clear

% select case
exercise=1;
site=1;

% load data
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

% write return value outputs
if exercise==1
    filename=['Ex' num2str(exercise) '_Site' num2str(site) '_ReturnValues_Baseline.csv'];
    header='Return Period [years],Return Value [m],CI 2.5%% [m],CI 97.5%% [m]\n';
elseif exercise==2
    filename=['Ex' num2str(exercise) '_Site' num2str(site) '_Quantiles_Baseline.csv'];
    header='Exceedance Prob,Quantile [m],CI 2.5%% [m],CI 97.5%% [m]\n';
end
fid=fopen(filename,'w');
fprintf(fid,header);
fclose(fid);
RVlow=RV_boot(round(trials*0.025),:);
RVhigh=RV_boot(round(trials*0.975,i),:);
dlmwrite(filename,[T(:) RV(:) RVlow(:) RVhigh(:)],'-append');

% write distribution outputs
if exercise==1
    filename=['Ex' num2str(exercise) '_Site' num2str(site) '_AnnualDist_Baseline.csv'];
elseif exercise==2
    filename=['Ex' num2str(exercise) '_Site' num2str(site) '_F25Dist_Baseline.csv'];
end
header='Exceedance Prob,Quantile [m],CI 2.5%% [m],CI 97.5%% [m]\n';
fid=fopen(filename,'w');
fprintf(fid,header);
fclose(fid);
xlow=x_boot(round(trials*0.025),:);
xhigh=x_boot(round(trials*0.975),:);
dlmwrite(filename,[1-P(:) x(:) xlow(:) xhigh(:)],'-append');

% calculate empirical exceedance probabilities
n=length(Annmax);
k=1:n;
Pempirical=k/(n+1);

% plot results
figure
hold on; box on; grid on
plot(sort(Annmax),1-Pempirical,'ko')
plot(x,1-P,'r')
plot(xlow,1-P,'b--')
plot(xhigh,1-P,'b--')
xlabel('Annual Max Hs [m]')
ylabel('Exceedance probability')
title(['Exercise ' num2str(exercise) ', Site ' num2str(site)])
ylim([1e-2 1])
set(gca,'yscale','log')
set(gca,'YMinorTick','off')
set(gca,'YMinorGrid','off')
set(gca,'YTick',[1e-2 2e-2 1e-1 2e-1 1])
set(gca,'YTickLabel',{'1/100','1/50','1/10','1/5','1'})
