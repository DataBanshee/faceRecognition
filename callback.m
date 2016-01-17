function callback(o,e,idx,ImageData)
        %# show selected image in a new figure
        figure(2), imshow(ImageData{idx},[])
        title(num2str(idx))
    end