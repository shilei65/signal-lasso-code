% Get data based on the strategies and unity data
% UG game

function [ y,Fai ] = get_data_ug( Stra,Unity,Length )
% input Stra£ºstrategy, Unity£ºpayoff in different time, Length£ºamount of
% data length

    SIZE = size(Stra,1);
   
    Length1 = floor(Length*SIZE);       
    Unity_temp = Unity(:,1:Length1);    %payoff at length*SIZE
    y=reshape(Unity_temp', Length1*SIZE,1);% responses
    Stra_temp = Stra(:,1:2*Length1);      %strategy at given time
    
    Fai=zeros(Length1*SIZE,SIZE*SIZE);     % design matrix Fai
    for k=1:SIZE
        TEMP=zeros(Length1,SIZE);       
        player1=k;
        for t = 2:2:2*Length1 
            stra_p_player1=Stra_temp(player1,t-1);  
            stra_q_player1=Stra_temp(player1,t);    
            for i=1:SIZE
                player2=i;
                stra_p_player2=Stra_temp(player2,t-1);  
                stra_q_player2=Stra_temp(player2,t);  
                TEMP(t/2,i)=Payoff_ug(stra_p_player1,stra_q_player1,stra_p_player2,stra_q_player2);  
            end
        end
        aa=(k-1)*Length1;
        bb=(k-1)*SIZE;
        for row = 1:Length1
            for col = 1:SIZE                
                Fai(aa+row,bb+col)= TEMP(row,col); % get Fai
            end
        end       
    end
   
end