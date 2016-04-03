function dstate = two_compartment(t,state)
% Taken from Johnston et al.
% http://www.ncbi.nlm.nih.gov/pubmed/17360468
% Original model without competition/inhibition terms between CSC, TAC, D

% System parameters:
%		lambda: proliferation
% 	alpha: self-renewal
% 	beta: deat rate
% 	gamma: mitotic exhaustion rate
global LAMBDA_s ALPHA_s BETA_s;
global LAMBDA_t ALPHA_t BETA_t;
global BETA_d;
global GAMMA;

% Current state
S = state(1); %cancer stem cells
T = state(2); %transit-amplifying cells
D = state(3); %terminally differentiated cells

dS=(LAMBDA_s*ALPHA_s-BETA_s)*S;
dT=LAMBDA_s*(1-ALPHA_s)*S + LAMBDA_t*(ALPHA_t-(1-ALPHA_t)-BETA_t)*T;
dD=LAMBDA_t*(1-ALPHA_t)*T - (GAMMA+BETA_d)*D

dstate=[dS dT dD]';
end