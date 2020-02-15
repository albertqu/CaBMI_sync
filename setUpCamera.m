function [vidobj, timeMat] = setUpCamera(folder)
% folder: str
    % name of output folder, can be relative path to the default
    % F:/camera_cabmi or absolute path DISK:\**path**
    % addpath('F:\camera_cabmi\camera_code');
    FORM = 'MJPG_640x480';
    DEFAULT_PATH = 'F:\camera_cabmi\';
    flag = folder(1);
    if flag == ':'
        outputFolder = folder;
    else
        outputFolder = [DEFAULT_PATH, folder, '\'];
    end
    if ~exist(outputFolder, 'dir')
        mkdir(outputFolder)
    end
    vidfile = [outputFolder, 'behavior'];
    timeMat = [outputFolder, 'metadata'];
    
    vidobj = videoinput('winvideo', 1, FORM);
    vidobj.FramesPerTrigger = Inf;
    vidobj.LoggingMode = 'disk&memory';
    src = getselectedsource(vidobj);
    frameRates = set(src, 'FrameRate');
    src.FrameRate = frameRates{1};
    
    vidWriter = VideoWriter(vidfile,'MPEG-4'); 
    vidWriter.FrameRate = str2double(frameRates{1});
    vidobj.Disklogger = vidWriter;
end
    
    
    