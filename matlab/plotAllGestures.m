clear all
close all
clc
folders=dir('gestures');
threshold=0.01;
folderNames= {folders.name};

index = find(cellfun(@(x) strcmp(x,'.')||strcmp(x,'..')||strcmp(x,'davide')||strcmp(x,'pinco'), folderNames, 'UniformOutput', 1));
folderNames(index)=[];

files=dir(char(strcat('gestures\',folderNames(1))));

fileNames = {files([files.isdir]==0).name};


persone=size(folderNames,2);
for i=fileNames
    figure('Name',char(i))
    for j=1:persone
        subplot(4,4,j)
        plotSottosegmenti('gestures',char(folderNames(j)),char(i),threshold);
        title(char(folderNames(j)))
        
    end
    mTextBox = uicontrol('style','text');
    set(mTextBox,'String',sprintf('Threshold = %0.4f',threshold));
    set(mTextBox,'Units','normal');
    set(mTextBox,'Position',[0.5,0,0.2,0.1]);
end