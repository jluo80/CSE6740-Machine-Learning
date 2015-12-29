function [ class ] = mycluster( bow, K )
%
% Your goal of this assignment is implementing your own text clustering algo.
%
% Input:
%     bow: data set. Bag of words representation of text document as
%     described in the assignment.
%
%     K: the number of desired topics/clusters. 
%
% Output:
%     class: the assignment of each topic. The
%     assignment should be 1, 2, 3, etc. 
%
% For submission, you need to code your own implementation without using
% any existing libraries

% YOUR IMPLEMENTATION SHOULD START HERE!

    n = size(bow, 1); % # samples
    words = size(bow, 2); % # words
    
    pi = ones(1, K) ./ (K + 0.0); % prior of each topic
    
    mu = rand(K, words); % random initialization
    s = sum(mu, 2);
    mu = mu ./ repmat(s, 1, words); % normalize to one
    
    gamma = zeros(n, K); % latent variable
    maxiter = 100;
    iter = 0;
    while iter < maxiter
        iter = iter + 1;
    
        %expectation
       
        for i = 1 : n % for each document
            gamma(i, :) = pi .* prod( mu .^ repmat(bow(i, :), K, 1), 2)';
            s = sum(gamma(i, :));
            gamma(i, :) = gamma(i, :) ./ s; % normalize to one
        end
        
        %maximization
        
        
        mu = gamma' * bow;
        s = sum(mu, 2);
        mu = mu ./ repmat(s, 1, words);
                
        pi = sum(gamma, 1) ./ n;
    end
    
    [~, class] = max(gamma, [], 2);
end

