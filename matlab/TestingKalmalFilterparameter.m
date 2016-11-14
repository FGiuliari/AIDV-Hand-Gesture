function main
close all
clear all
workspace;
txt = readtable('gestures/elenaf/curly-braket-right.csv','Delimiter',' ','ReadVariableNames',false,'Format','%f %f %f %u64');
txt(:,1);
A=table2array(txt(:,1:3));
time=table2array(txt(:,4));
timeDiff=diff(time);
distanceVector=diff(A)
[B]=arrayfun(@(x,y,z) norm([x y z]),distanceVector(:,1),distanceVector(:,2),distanceVector(:,3));
velocity=B./double(timeDiff)
timeDiff=[0;timeDiff]
velocity=[0;velocity]
pos=cumsum(B)
pos=[0;pos]
A=[A velocity]
Q=0.1;
R=0.1
out=kalFilter(A(:,1:3),Q,R);

f = figure;
ax = axes('Parent',f,'position',[0.13 0.39  0.77 0.54]);
h = plot(out(:,1),out(:,2),'r-');
b = uicontrol('Parent',f,'Style','slider','Position',[81,54,419,23],...
              'Value',Q, 'min',0, 'max',1);
b2 = uicontrol('Parent',f,'Style','slider','Position',[81,20,419,23],...
              'Value',R, 'min',0, 'max',1);
b.Callback = @myCallback;
b2.Callback = @myCallback2;

function myCallback(src,event)
    Q=src.Value
    out=kalFilter(A(:,1:3),Q,R);
    hold off;
    plot(A(:,1),A(:,2),'b-o')
    hold on;
    plot(out(:,1),out(:,2),'r-');
end

function myCallback2(src,event)
    R=src.Value
    out=kalFilter(A(:,1:3),Q,R);
    hold off;
    plot(A(:,1),A(:,2),'b-o')
    hold on;
    plot(out(:,1),out(:,2),'r-');
   

end
end