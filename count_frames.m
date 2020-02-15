function num = count_frames(vfile)
    vidObj = VideoReader(vfile);
    num = 0;
    while hasFrame(vidObj)
        readFrame(vidObj);
        num = num + 1;
    end
end
    