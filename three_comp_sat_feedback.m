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
% Saturating feedback parameters
global k_0 m_0; %CSC
global k_1 m_1; %T

% Current state
S = state(1); %cancer stem cells
T = state(2); %transit-amplifying cells
D = state(3); %terminally differentiated cells

% Genetic mutation for t>100 to switch unbound/steady-state
global mutation parameter_setting;
if mutation
  switch parameter_setting
  case 0 %Currently unbound growth
    s_1=0.1; s_2=0.3; s_3=k_0/m_0+s_1+s_2-0.25;
		t_1=0.1; t_2=0.4; t_3=k_1/m_1+t_1+t_1-0.25;
		c=0.25;
  case 1 %Currently steady-state
    s_1=0.1; s_2=0.3; s_3=k_0/m_0+s_1+s_2+0.25;
		t_1=0.1; t_2=0.4; t_3=k_1/m_1+t_1+t_1+0.25;
		c=0.25;
  end;
end

%
dS = (s_3-s_1-s_2)*S - (k_0*S^2)/(1+m_0*S);
dT = (t_3-t_1-t_2)*T - (k_1*T^2)/(1+m_1*T) + s_2*S + (k_0*S^2)/(1+m_0*S);
dD = -c*D + t_2*T + (k_1*T^2)/(1+m_1*T);

dstate=[dS dT dD]';

% From paper:
%   We require s=s_3-s_1-s_2 > 0 for viability
%   CSC steady-state exists for 0<s<(k_0/m_0) otherwise unbound growth
%   At CSCss, 0<t<(k_1/m_1) exhibits single real positive T steady-state
end
