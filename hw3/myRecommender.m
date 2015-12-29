function [ U, V ] = myRecommender( rateMatrix, lowRank )
    % Please type your name here:
    name = 'Xiaoye Huang';
    disp(name); % Do not delete this line.

    % Parameters
    maxIter = 270; 
    learningRate = 4.7778e-04; 
    regularizer =1.7778 ; 
    
    % Random initialization:
    [n1, n2] = size(rateMatrix);
    U = rand(n1, lowRank) / lowRank;
    V = rand(n2, lowRank) / lowRank;

    % Gradient Descent:
    iteration=1;
    
    e=100000000000000;
    enew=trace((rateMatrix-U*V' .* (rateMatrix > 0))*(rateMatrix-U*V' .* (rateMatrix > 0))')+regularizer*trace(U'*U)+regularizer*trace(V'*V);
    threshold=45;
    while(iteration<maxIter&e-enew>threshold)
        e=enew;
        u=U+2*learningRate*((rateMatrix-U*V' .* (rateMatrix > 0))*V-regularizer*U);
        v=V+2*learningRate*((rateMatrix-U*V' .* (rateMatrix > 0))'*U-regularizer*V);
        U=u;
        V=v;
        enew=trace((rateMatrix-U*V' .* (rateMatrix > 0))*(rateMatrix-U*V' .* (rateMatrix > 0))')+regularizer*trace(U'*U)+regularizer*trace(V'*V);
        iteration=iteration+1;
    end
    
end