function [p_word_given_topic, p_doc_given_topic, pi] = mycluster2(bow, K)
% bow is the bag of words representation of documents 
% K is the number of topics

    num_words = size(bow, 2);
    num_docs = size(bow, 1);
    
    pi = ones(K, 1) ./ (K + 0.0);
    
    p_word_given_topic = rand(num_words, K);
    s = sum(p_word_given_topic, 1);
    p_word_given_topic = p_word_given_topic ./ repmat(s, num_words, 1);
    
    p_doc_given_topic = rand(num_docs, K);
    s = sum(p_doc_given_topic, 1);
    p_doc_given_topic = p_doc_given_topic ./ repmat(s, num_docs, 1);
    
    p_topic_given_doc_word = zeros(K, num_docs, num_words);
    
    maxiter = 30;
    iter = 0;
    while iter < maxiter
        iter = iter + 1
        
        %expectation 
        for c = 1 : K
            p_topic_given_doc_word(c, :, :) = pi(c) * p_doc_given_topic(:, c) * p_word_given_topic(:, c)';
        end
        s = sum(p_topic_given_doc_word, 1);
        p_topic_given_doc_word = p_topic_given_doc_word ./ repmat(s, K, 1, 1);
        
        %maximization
        
        for c = 1 : K
            p_word_given_topic(:, c) = sum(bow .* squeeze(p_topic_given_doc_word(c, :, :)), 1)';
            s = sum(p_word_given_topic(:, c));
            p_word_given_topic(:, c) = p_word_given_topic(:, c) ./ s;
        end
        
        for c = 1 : K
            p_doc_given_topic(:, c) = sum(bow .* squeeze(p_topic_given_doc_word(c, :, :)), 2);
            s = sum(p_doc_given_topic(:, c));
            p_doc_given_topic(:, c) = p_doc_given_topic(:, c) ./ s;
        end
        
        for c = 1 : K
            pi(c) = sum(sum(bow .* squeeze(p_topic_given_doc_word(c, :, :)), 1), 2);
        end
        pi = pi ./ sum(pi);
    end
end
