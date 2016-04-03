function dstate = two_compartment(t,state)
% Taken from Johnston et al.
%	http://www.ncbi.nlm.nih.gov/pubmed/17360468
% Original model without competition/inhibition terms between CSC and CC

% System parameters:
%		lambda: proliferation
% 	alpha: self-renewal
% 	beta: deat rate
% 	gamma: mitotic exhaustion rate
global LAMBDA_s ALPHA_s BETA_s;
global LAMBDA_c ALPHA_c BETA_c;
global GAMMA

% Current state
S = state(1); %cancer stem cells
C = state(2); %cancer cells

dS=(LAMBDA_s*ALPHA_s-BETA_s)*S;
dC=LAMBDA_s*(1-ALPHA_s)*S + LAMBDA_c*(ALPHA_c-BETA_c-GAMMA)*C;

dstate=[dS dC]';
end