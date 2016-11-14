function [ ] = plotSottosegmenti( cartella, persona, gesto,threshold)
    %filename = 'logs/hand_tracking_log_2016-10-13-17-40-36.txt';
    %delimiterIn = ':';

    filename = strcat(cartella,'/',persona,'/',gesto);
    delimiterIn = ' ';
    %headerlinesIn = 1;
    txt = readtable(filename,'Delimiter',delimiterIn,'ReadVariableNames',false,'Format','%f %f %f %u64');
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
    le=cumsum(distVector);

    point=le+repmat(A(1,:),size(le,1),1);
    point=[A(1,:); point];
   % hold on 
 %   plot(point(:,1),point(:,2),'r-*')


%    figure()
 %   scatter(point(:,1),point(:,2),[],[0 ;velocity],'filled')
    sep=[1];
    sep=[sep ;find(velocity<threshold)];
  %  figure()
    
    plot(point(1:sep(1),1),point(1:sep(1),2),'-');
    for i=1:size(sep)-1
        hold on;
        plot(point(sep(i):sep(i+1),1),point(sep(i):sep(i+1),2),'-');
    end
    hold on;
    plot(point(sep(end):end,1),point(sep(end):end,2),'-');
end

