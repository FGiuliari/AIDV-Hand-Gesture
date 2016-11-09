
close all
clear all


samples1=zeros(10,3);

samples2=zeros(91,3);

t=0:1:9;
samples1(:,1)=t;
samples1(:,2)=-sin(2*pi*t/9);
samples1(:,3)=t;
t=0:0.1:9;
samples2(:,1)=-cos(2*pi*t/9);
samples2(:,2)=-sin(2*pi*t/9);
samples2(:,3)=t;

rumore=normrnd(0,0.05,91,1)
samples2(:,1)=samples2(:,1)+rumore
samples2(:,2)=samples2(:,2)+rumore
rumore=normrnd(0,0.2,91,1)
samples2(:,3)=samples2(:,3)+rumore
samples3=[0 0 0; 1 1 1; 0 2 2;0 5 3;0 6 8]
figure(1)
plot3(samples2(:,1),samples2(:,2),samples2(:,3),'g*-')
%hold on
%plot(samples1(:,1),samples1(:,2),'r*-')

figure(2)

t = cumsum(sqrt([0,diff(samples2(:,1)')].^2 + [0,diff(samples2(:,2)')].^2));
subplot(3,1,1)
plot(t,samples2(:,1),'r*-')
title('x on curve')
hold on
fx=fit(t',samples2(:,1),'poly4')
plot(fx,'b')
xlabel('curve length')
ylabel('x')

subplot(3,1,2)
plot(t,samples2(:,2),'r*-')
title('y on curve')
hold on
fy=fit(t',samples2(:,2),'poly4')
plot(fy,'b')
xlabel('curve length')
ylabel('y')

subplot(3,1,3)
plot(t,samples2(:,3),'r*-')
title('z on curve')
hold on
fz=fit(t',samples2(:,3),'poly4')
plot(fz,'b')
xlabel('curve length')
ylabel('z')


resample=zeros(ceil(t(end)),3)
resample(:,1)=fx(0:ceil(t(end))-1)
resample(:,2)=fy(0:ceil(t(end))-1)
resample(:,3)=fz(0:ceil(t(end))-1)
figure(1)
hold on
plot3(resample(:,1),resample(:,2),resample(:,3),'b-*')


