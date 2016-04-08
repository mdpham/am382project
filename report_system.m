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
global k_0 m_0 k_1 m_1;
% Model extension
global THETA PHI;
global feedback_type;

% Current state
S = state(1); %cancer stem cells
T = state(2); %transit-amplifying cells
D = state(3); %terminally differentiated cells

switch feedback_type
case 0
  % SATURATING FEEDBACK
  dS = (s_3-s_1)*S - S*(s_2 + k_0*S/(1+m_0*S)) + T*THETA*(t_2 + k_1*T/(1+m_1*T));
  dT = (t_3-t_1)*T - T*(t_2 + k_1*T/(1+m_1*T)) + S*(1-PHI)*(s_2 + k_0*S/(1+m_0*S));
  dD = -c*D + T*(1-THETA)*(t_2 + k_1*T/(1+m_1*T)) + S*PHI*(s_2 + k_0*S/(1+m_0*S));
case 1
  % LINEAR FEEDBACK
  dS = (s_3-s_1)*S - S*(s_2 + k_0*S) + T*THETA*(t_2 + k_1*T);
  dT = (t_3-s_1)*T - T*(t_2 + k_1*T) + S*(1-PHI)*(s_2 + k_0*S);
  dD = -c*D + T*(1-THETA)*(t_2 + k_1*T) + S*PHI*(s_2 + k_0*S);
end;

%
dstate=[dS dT dD]';
end
