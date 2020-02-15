function absTimes = getAbsTimeStruct(metadata)
    k=[];
    dim = size(metadata);
    len = dim(1);
    for j =1:len
        a = metadata(j);
        k = [k; a.AbsTime];
    end
    absTimes = k;