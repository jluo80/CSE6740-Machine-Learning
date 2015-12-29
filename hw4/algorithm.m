function prob = algorithm(q)

% plot and return the probability
    load('sp500.mat');
    fi=[[q,1-q];[1-q,q]];
    [nrow,~]=size(price_move);
    alpha=zeros(nrow,2);
    beta=zeros(nrow,2);
    alpha(1,1)=0.2*fi(1,(3-price_move(1))/2);
    alpha(1,2)=0.8*fi(2,(3-price_move(1))/2);
    for i=2:nrow
        alpha(i,1)=fi(1,(3-price_move(i))/2)*(alpha(i-1,1)*0.8+alpha(i-1,2)*0.2);
        alpha(i,2)=fi(2,(3-price_move(i))/2)*(alpha(i-1,1)*0.2+alpha(i-1,2)*0.8);
    end
    px=alpha(nrow,1)+alpha(nrow,2);
    beta(nrow,1)=1;
    beta(nrow,2)=1;
    for i=nrow-1:-1:1
        beta(i,1)=0.8*fi(1,(3-price_move(i+1))/2)*beta(i+1,1)+0.2*fi(2,(3-price_move(i+1))/2)*beta(i+1,2);
        beta(i,2)=0.2*fi(1,(3-price_move(i+1))/2)*beta(i+1,1)+0.8*fi(2,(3-price_move(i+1))/2)*beta(i+1,2);
    end
    output=alpha.*beta/px;
    prob=output;
    %prob=output(:,1);

end
