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
