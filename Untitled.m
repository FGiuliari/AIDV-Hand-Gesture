close all
clear all

punti=[0 1 0; -1 2 1; 2 2 2;3 3 3;3 4 4]
punti2=[0 1 0; -1 2 1; 2 2 2;3 3 3;3 4 5]
p=punti(:,1)
f=fit(punti(:,1),punti(:,2),'smoothingspline');
plot(punti(:,1),punti(:,2),'r--*')
hold on
plot(f,'g')

fn=csapi(punti(:,1),punti(:,2))
fnplt(fn,2)

figure()
p1x=punti(:,1)
p1y=punti(:,2)
subplot(2,1,1)
plot(p1x,'r')
subplot(2,1,2)
plot(p1y,'b')
figure()
p2x=punti2(:,1)
p2y=punti2(:,2)
subplot(2,1,1)
plot(p2x,'r')
subplot(2,1,2)
plot(p2y,'b')
