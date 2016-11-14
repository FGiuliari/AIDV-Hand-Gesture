% spline
close all
clear all


%% Importazione Dataset
txt = readtable('gestures/elenaf/curly-braket-right.csv','Delimiter',' ','ReadVariableNames',false,'Format','%f %f %f %u64');
txt(:,1);
A=table2array(txt(:,1:3));
time=table2array(txt(:,4));
timeDiff=diff(time);
distanceVector=diff(A)
[B]=arrayfun(@(x,y,z) norm([x y z]),distanceVector(:,1),distanceVector(:,2),distanceVector(:,3));
velocity=B./double(timeDiff)
velocity=[0;velocity]
pos=cumsum(B)
pos=[0;pos]
A=[A velocity]
%yy=spline(pos,A',0:1:floor(pos(end)))'
%yy=interp1(pos,A,0:1:floor(pos(end)),'linear')
yy=csaps(pos,A',0.2,0:1:floor(pos(end)))'
out=kalFilter(A(:,1:3));

plot(A(:,1),A(:,2),'o')
hold on
plot(yy(:,1),yy(:,2),'r*-')

figure()
subplot(2,1,1)
scatter(A(:,1),A(:,2),[],A(:,4),'filled')
caxis([0, 1])
colorbar
subplot(2,1,2)
scatter(yy(:,1),yy(:,2),[],yy(:,4),'filled')
caxis([0, 1])
colorbar

test=smooth(pos,velocity,0.06,'lowess');
%test2=smooth(0:1:floor(pos(end)),yy(:,4),0.1,'rloess');
smoothedVel=interp1(pos,test,0:1:floor(pos(end)),'linear')


figure()
subplot(2,1,1)
plot(pos,velocity,'-o')
hold on
plot(pos,test,'-r')
legend('velocity','smoothed velocity')

subplot(2,1,2)
plot(0:1:floor(pos(end)),yy(:,4),'-o')
hold on
plot(0:1:floor(pos(end)),smoothedVel,'-r')
legend('velocity','smoothed velocity')

figure()
subplot(2,1,1)
scatter(A(:,1),A(:,2),[],test,'filled')
caxis([0, 1])
colorbar
subplot(2,1,2)
scatter(yy(:,1),yy(:,2),[],smoothedVel,'filled')
caxis([0, 1])
colorbar


rap=rdivide(yy(2:end,4),yy(1:end-1,4))

rap2=rdivide(smoothedVel(3:end),smoothedVel(2:end-1))
figure()
plot(rap)
hold on
plot(rap2)

%% Segmentazione
%mi calcolo i versori dei vettori spostamento punto punto

dist=diff(yy(:,1:3))
distNorm=arrayfun(@(x,y,z) norm([x y z]),dist(:,1),dist(:,2),dist(:,3))
ver=bsxfun(@rdivide,dist,distNorm)

cos=[1 bsxfun(@dot,ver(1:end-1,:)',ver(2:end,:)')]
rad=acos(cos)
sepAngle=find(rad>pi/7) %% separatore su una differenza di pi/5 rad == 36 gradi
sve=smoothedVel.*(1/max(smoothedVel))

sepVel=find(sve<0.3)

figure()
subplot(3,1,1)
sepAngle=[1 sepAngle size(yy,1)]


for i=1:size(sepAngle,2)-1 
    plot(yy(sepAngle(i):sepAngle(i+1),1),yy(sepAngle(i):sepAngle(i+1),2),'-*')
    hold on
end
min=sve;
min(min>0.3)=1;
DataInv = 1.01*max(min) - min;
[peaks sepVel]=findpeaks(DataInv);

sepVel=[1 sepVel size(yy,1)]

subplot(3,1,2)


for i=1:size(sepVel,2)-1 
    plot(yy(sepVel(i):sepVel(i+1),1),yy(sepVel(i):sepVel(i+1),2),'-*')
    hold on
end


sep=unique([sepVel sepAngle])

diff(sep)
sep(find((diff(sep)<5))+1)=[]
sep=[sep size(yy,1)]
subplot(3,1,3)
for i=1:size(sep,2)-1 
    plot(yy(sep(i):sep(i+1),1),yy(sep(i):sep(i+1),2),'-*')
    hold on
end

figure()
plot(sve)
hold on
plot(min)
%%
%test;


