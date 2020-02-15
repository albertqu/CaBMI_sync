function [] = recordNIDAQ(folder, duration)
    % folder: str
    % name of output folder, can be relative path to the default
    % F:/camera_cabmi or absolute path DISK:\**path**
    % addpath('F:\camera_cabmi\camera_code');
    % duration: str
    % in seconds
    if ~exist(folder, 'dir')
        mkdir(folder);
    end
    s = daq.createSession('ni');
    addAnalogInputChannel(s, 'Dev1', 'ai0', 'Voltage')
    s.DurationInSeconds = duration;
    % MOVE PROCESS TO BACKGROUND TO SAVE MEMORY
    [data, timeStamps, triggerTime] = startForeground(s);
    t0 = datetime(triggerTime, 'ConvertFrom', 'datenum');
    dim = size(timeStamps);
    allTimes = zeros(dim(1), 6);
    for i=1:size(timeStamps)
        allTimes(i, :) = datevec(t0 + seconds(timeStamps(i)));
    end
    res.data = data;
    res.AbsTime = allTimes;
    save([folder, 'stamps.mat'], 'res');
    release(s);
end