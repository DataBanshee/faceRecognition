function rec = similarityScore(testFaceFeat,trainFaceFeat)

rec =[];


for i=1:size(testFaceFeat,1)
    Distance_inv =[];
    for j=1:size(trainFaceFeat,1)
        temp = ( norm(testFaceFeat(i,:) - trainFaceFeat(j,:) ) )^2;
        Distance_inv = [Distance_inv 1/(1+temp)];
    end
    [Similarity_min , Recognized_index] = max(Distance_inv);
    rec=[rec Recognized_index];
    
end




end