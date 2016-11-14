close all
clear all

training_set=zeros(100,15);
lab=zeros(100,1);
samples1=zeros(91,3);
t=0:0.1:9;
samples1(:,1)=-cos(2*pi*t/9);
samples1(:,2)=-sin(2*pi*t/9);
samples1(:,3)=t;
for i=1:50
    tr_sam=zeros(91,3);
    rumore=normrnd(0,0.05,91,1);
    tr_sam(:,1)=samples1(:,1)+rumore;
    rumore=normrnd(0,0.05,91,1);
    tr_sam(:,2)=samples1(:,2)+rumore;
    rumore=normrnd(0,0.2,91,1);
    tr_sam(:,3)=samples1(:,3)+rumore;
    t = cumsum(sqrt([0,diff(tr_sam(:,1)')].^2 + [0,diff(tr_sam(:,2)')].^2));
    fx=fit(t',tr_sam(:,1),'poly4');
    fy=fit(t',tr_sam(:,2),'poly4');
    fz=fit(t',tr_sam(:,3),'poly4');
    
    training_set(i,1)=fx.p1;
    training_set(i,2)=fx.p2;
    training_set(i,3)=fx.p3;
    training_set(i,4)=fx.p4;
    training_set(i,5)=fx.p5;
    
    training_set(i,6)=fy.p1;
    training_set(i,7)=fy.p2;
    training_set(i,8)=fy.p3;
    training_set(i,9)=fy.p4;
    training_set(i,10)=fy.p5;
    
    training_set(i,11)=fz.p1;
    training_set(i,12)=fz.p2;
    training_set(i,13)=fz.p3;
    training_set(i,14)=fz.p4;
    training_set(i,15)=fz.p5;
    lab(i)=1;
end


t=0:0.1:9;
samples1(:,1)=t.^2;
samples1(:,2)=t;
samples1(:,3)=t;
for i=51:100
    tr_sam=zeros(91,3);
    rumore=normrnd(0,0.05,91,1);
    tr_sam(:,1)=samples1(:,1)+rumore;
    rumore=normrnd(0,0.05,91,1);
    tr_sam(:,2)=samples1(:,2)+rumore;
    rumore=normrnd(0,0.2,91,1);
    tr_sam(:,3)=samples1(:,3)+rumore;
    t = cumsum(sqrt([0,diff(tr_sam(:,1)')].^2 + [0,diff(tr_sam(:,2)')].^2));
    fx=fit(t',tr_sam(:,1),'poly4');
    fy=fit(t',tr_sam(:,2),'poly4');
    fz=fit(t',tr_sam(:,3),'poly4');
    
    training_set(i,1)=fx.p1;
    training_set(i,2)=fx.p2;
    training_set(i,3)=fx.p3;
    training_set(i,4)=fx.p4;
    training_set(i,5)=fx.p5;
    
    training_set(i,6)=fy.p1;
    training_set(i,7)=fy.p2;
    training_set(i,8)=fy.p3;
    training_set(i,9)=fy.p4;
    training_set(i,10)=fy.p5;
    
    training_set(i,11)=fz.p1;
    training_set(i,12)=fz.p2;
    training_set(i,13)=fz.p3;
    training_set(i,14)=fz.p4;
    training_set(i,15)=fz.p5;
    lab(i)=2;
end

mdl = fitcknn(training_set,lab);
t=0:0.1:9;
samples1(:,1)=t.^2;
samples1(:,2)=t;
samples1(:,3)=t;
tr_sam=zeros(91,3);
rumore=normrnd(0,0.05,91,1);
tr_sam(:,1)=samples1(:,1)+rumore;
rumore=normrnd(0,0.05,91,1);
tr_sam(:,2)=samples1(:,2)+rumore;
rumore=normrnd(0,0.2,91,1);
tr_sam(:,3)=samples1(:,3)+rumore;
t = cumsum(sqrt([0,diff(tr_sam(:,1)')].^2 + [0,diff(tr_sam(:,2)')].^2));
fx=fit(t',tr_sam(:,1),'poly4');
fy=fit(t',tr_sam(:,2),'poly4');
fz=fit(t',tr_sam(:,3),'poly4');
plot(fz)

plot3(tr_sam(:,1),tr_sam(:,2),tr_sam(:,3))

testing_set=zeros(1,15);

testing_set(1,1)=fx.p1;
testing_set(1,2)=fx.p2;
testing_set(1,3)=fx.p3;
testing_set(1,4)=fx.p4;
testing_set(1,5)=fx.p5;

testing_set(1,6)=fy.p1;
testing_set(1,7)=fy.p2;
testing_set(1,8)=fy.p3;
testing_set(1,9)=fy.p4;
testing_set(1,10)=fy.p5;

testing_set(1,11)=fz.p1;
testing_set(1,12)=fz.p2;
testing_set(1,13)=fz.p3;
testing_set(1,14)=fz.p4;
testing_set(1,15)=fz.p5;
label = predict(mdl,testing_set)