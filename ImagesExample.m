function ImagesExample()
    ImageData = ReadImgs('faceDatabase','*.jpg');
    figure(1)
    for i=1:43
        subplot(8,6,i);
        h = imshow(ImageData{i}, 'InitialMag',100, 'Border','tight');
        title(num2str(i))
        set(h, 'ButtonDownFcn',{@callback,i})
    end

%# mouse-click callback function
    function callback(o,e,idx)
        %# show selected image in a new figure
        figure(2), imshow(ImageData{idx})
        title(num2str(idx))
    end
end