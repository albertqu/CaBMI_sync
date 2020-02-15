function [] = syncMain(folder, duration)
    CHUNK = 200;
    %camera stuff
    [vidobj, timeMat] = setUpCamera(folder);
    %nidaq setup
    
    %start recording
    start(vidobj);
    tic;
    % check if it is needed to save videoframes from data
    % single threaded solution (keep grabbing frame while left with 200 frames): 
    % could use a dedicated thread for
    % videoloading
    
    %handle keyboardInterrupt
    logFrame = 0; % currently: frameNumber // CHUNK
    tp = toc;
    while toc < duration
        [~, ~, metadata] = getdata(vidobj, CHUNK);
        save([timeMat, num2str(logFrame), '.mat'], 'metadata');
        logFrame = logFrame + 1;
        tc = toc;
        if tc - tp > 60
            mt = tc / 60;
            disp(['Time elapsed (min): ', num2str(mt)]);
            tp = toc;
        end
    end
    stop(vidobj);
    while vidobj.FramesAvailable > 0
        grabFrame = min(vidobj.FramesAvailable, CHUNK);
        [~, ~, metadata] = getdata(vidobj, grabFrame);
        save([timeMat, num2str(logFrame), '.mat'], 'metadata');
        logFrame = logFrame + 1;
    end
end