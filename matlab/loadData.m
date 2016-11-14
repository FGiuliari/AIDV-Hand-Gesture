clear all
close all
%filename = 'logs/hand_tracking_log_2016-10-13-17-40-36.txt';
%delimiterIn = ':';

filename = 'gestures/chiara/check.csv';
delimiterIn = ' ';
%headerlinesIn = 1;
txt = readtable(filename,'Delimiter',delimiterIn,'ReadVariableNames',false,'Format','%f %f %f %u64');
txt(:,1)
A=table2array(txt(:,1:3))
num_samples=size(A,1)
plot(A(:,1),A(:,2),'b*-')

c=0
for i=1:10:num_samples-30
    c=c+1
    c='y'
    plot(A(i:i+30,1),A(i:i+30,2))
    hold on
    waitforbuttonpress
end

t = sqrt([0,diff(A(:,1)')].^2 + [0,diff(A(:,2)')].^2);
d=[diff(A(:,1)) diff(A(:,2)) diff(A(:,3))];

for i=1:num_samples-1
    d(i,:)=[d(i,1)/norm(d(i,:)) d(i,2)/norm(d(i,:)) d(i,3)/norm(d(i,:))];
end
diffe=diff(d)
dir=zeros(num_samples-2,1)
for i=1:num_samples-2
    dir(i)=norm(diffe(i,:));
end
split=find(dir>1)
split=split+1
split=[1; split]
figure()
for i=2:size(split,1)
        plot(A(split(i-1):split(i),1),A(split(i-1):split(i),2),'*-')
        hold on
        waitforbuttonpress
end
