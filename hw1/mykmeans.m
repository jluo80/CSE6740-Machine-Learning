function [ class, centroid ] = mykmeans( pixels, K )
%
% Your goal of this assignment is implementing your own K-means.
%
% Input:
%     pixels: data set. Each row contains one data point. For image
%     dataset, it contains 3 columns, each column corresponding to Red,
%     Green, and Blue component.
%
%     K: the number of desired clusters. Too high value of K may result in
%     empty cluster error. Then, you need to reduce it.
%
% Output:
%     class: the class assignment of each data point in pixels. The
%     assignment should be 1, 2, 3, etc. For K = 5, for example, each cell
%     of class should be either 1, 2, 3, 4, or 5. The output should be a
%     column vector with size(pixels, 1) elements.
%
%     centroid: the location of K centroids in your result. With images,
%     each centroid corresponds to the representative color of each
%     cluster. The output should be a matrix with size(pixels, 1) rows and
%     3 columns. The range of values should be [0, 255].
%     
%
% You may run the following line, then you can see what should be done.
% For submission, you need to code your own implementation without using
% the kmeans matlab function directly. That is, you need to comment it out.
    

%begin initialize

    MaximumIterationNumber=100;
    numberOfPixels=size(pixels,1);
    mu=zeros(K,3);
    
    for i=1:K
        shuffle=randperm(numberOfPixels);
        choose=pixels(shuffle(1:K),:);
        mu(i,:)=mean(choose);
    end

%     mu(1,:)=[0,255,0];
%     mu(2,:)=[0,0,255];
%     for i=3:K
%         shuffle=randperm(numberOfPixels);
%         choose=pixels(shuffle(1:K),:);
%         mu(i,:)=mean(choose);
%     end




     r_old=zeros(numberOfPixels,K);
     r_new=ones(numberOfPixels,K);
     iteration=0;

    
%begin iteration
    while (isequal(r_old,r_new)==0&iteration<MaximumIterationNumber)
        %E
        r_old=r_new;
        r_new=zeros(numberOfPixels,K);
        distance=zeros(numberOfPixels,K);
        for i=1:numberOfPixels
            for j=1:K
                distance(i,j)=sqrt((pixels(i,1)-mu(j,1))^2+(pixels(i,2)-mu(j,2))^2+(pixels(i,3)-mu(j,3))^2);
            end
            [minValue,minIndex]=min(distance(i,:));
            r_new(i,minIndex)=1;
        end
        %M
        for k=1:K
            a= find(r_new(:,k)==1);
%             if isempty(a)
%                 error('Error! Empty cluster appears, trying to use smaller K')
%             end
            mu(k,:)=mean(pixels(a,:));
        end
        iteration=iteration+1;    
        
    end
    class=zeros(numberOfPixels,1);
    for i=1:numberOfPixels
        class(i,1)=find(r_new(i,:)==1);
    end
    centroid=mu;
    class;
    centroid;


	%[class, centroid] = kmeans(pixels,K);
end

