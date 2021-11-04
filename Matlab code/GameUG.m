% % Generate the evolutionary UG game data

function [Stra,Unity] = GameUG(Adj)

N = size(Adj,1);% N is the number of nodes
Stra=[];
stra=[rand(N,1),rand(N,1)];
Unity=[];% fiteness

for T=1:4*N
    for i=1:N
        player1=i;% player i
        stra_p_player1=stra(player1,1);    
		stra_q_player1=stra(player1,2);    
        score1=0;
        Neig=[];
        for j=1:N
            if Adj(player1,j)==1
                Neig=[Neig,j];              %report the neigbour of player1
                player2=j;                  %obtain the neighbour of individual and its strategy
                stra_p_player2=stra(player2,1);         % strategy of player j, j is proposer
				stra_q_player2=stra(player2,2);         % strategy of player j, j is responser
                score1=score1+Payoff_ug(stra_p_player1,stra_q_player1,stra_p_player2,stra_q_player2);%payoff of player1
            end            
        end
        unity(i)=score1;                    %calculating the payoff of each individual
    end
    Unity=[Unity,unity'];                     
    Stra=[Stra,stra];                       
     
    % strategy updating rule
    stra1=stra;                 
    for i=1:N        
        player1=i;
        Neig=[];
        Neip=[];
        for j=1:N
            if Adj(player1,j)==1
                Neig=[Neig,j];   
				Neip=[Neip,unity(j)];
            end            
        end
        % find the neighbour with maximumm payoff
		Neig_choose_id=find(max(Neip)==Neip);
		Neig_choose=Neig(Neig_choose_id(1));
        
        if unity(Neig_choose)/(unity(i)+sum(Neip))>rand(1)
            stra(i,:)=stra1(Neig_choose,:);
        else
            stra(i,:)=stra1(i,:);
        end
        
        % strategy mutation
        stra(i)=stra(i)+(0.1*rand(1)-0.05);
        if (stra(i)>1)
            stra(i)=1;
        elseif (stra(i)<0)
            stra(i)=0;
        end
        
    end
    
end

end




