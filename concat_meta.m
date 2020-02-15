function [] = concat_meta(folder, nFrames)
    files = dir([folder, 'metadata*.mat']);
    dim = size(files);
    totlen = dim(1);
    chunk = floor(nFrames / 200);
    disp(chunk);
    i = 1;
    totNum = 1;
    while i <= totlen
        nextLoad = min(totlen - i, chunk-1);
        for j = i:nextLoad+i
            currStruct = load([folder, 'metadata', num2str(i), '.mat']);
            if ~exist('allStruct', 'var')
                allStruct = currStruct;
            else
                allStruct = vertcat(allStruct, currStruct);
            end
            save([folder, 'merge', num2str(totNum), '.mat'])
            clear allStruct
        end
        totNum = totNum + 1;
        i = i + nextLoad+1;
    end
end    
    