% Payoff matrix of UG game  p-proposer q-responder
% stra_p_player1   pi
% stra_q_player1   qi
% stra_p_player2   pj
% stra_q_player2   qj
% ui=(i-pi)*(pi>=qj)+pj*(pj>=qi)
function score=Payoff(stra_p_player1,stra_q_player1,stra_p_player2,stra_q_player2)

	score=(stra_p_player1>=stra_q_player2)*(1-stra_p_player1)+(stra_p_player2>=stra_q_player1)*stra_p_player2;
    
end