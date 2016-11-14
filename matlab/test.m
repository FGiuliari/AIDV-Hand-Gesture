clear all
close all
    threshold =0.7

    txt = readtable('gestures/andrea/curly-braket-left.csv','Delimiter',' ','ReadVariableNames',false,'Format','%f %f %f %u64');
    txt(:,1);
    A=table2array(txt(:,1:3));
    time=table2array(txt(:,4));
    num_samples=size(A,1);
 %   plot(A(:,1),A(:,2),'b*-')

    distVector=diff(A);
    timeDiff=diff(time);
    norm(distVector(1,:));

    [B]=arrayfun(@(x,y,z) norm([x y z]),distVector(:,1),distVector(:,2),distVector(:,3));
    velocity=B./double(timeDiff);
    distvel=diff(velocity)
   % hold on 
 %   plot(A(:,1),A(:,2),'r-*')


  figure()
    subplot(2,1,1)
    scatter(A(:,1),A(:,2),[],[0 ;0;distvel],'filled')
    subplot(2,1,2)
    scatter(A(:,1),A(:,2),[],[0 ;velocity],'filled')

    sep=[1];
    sep=[sep ;find(abs(velocity)>threshold)];
    figure()
    
    plot(A(1:sep(1),1),A(1:sep(1),2),'-');
    for i=1:size(sep)-1
        hold on;
        plot(A(sep(i):sep(i+1),1),A(sep(i):sep(i+1),2),'-');
    end
    hold on;
    plot(A(sep(end):end,1),A(sep(end):end,2),'-');