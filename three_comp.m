function dstate = three_compartment(t,state)
% Taken from Johnston et al.
% http://www.ncbi.nlm.nih.gov/pubmed/17360468
% Continuous model without competition/inhibition terms between CSC, TAC, D

% System parameters:
% 	_1: death
% 	_2: differentiation
% 	_3: self-renewal
% 	c: mitotic exhaustion rate
global s_1 s_2 s_3;
global t_1 t_2 t_3;
global c;

% Current state
S = state(1); %cancer stem cells
T = state(2); %transit-amplifying cells
D = state(3); %terminally differentiated cells

% 
dS = (s_3-s_1-s_2)*S;
dT = (t_3-t_1-t_2)*T + s_2*S;
dD = t_2*T - c*D;

dstate=[dS dT dD]';
end