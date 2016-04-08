clear all; close all;

% System parameters
global s_1 s_2 s_3;
global t_1 t_2 t_3;
global c;
global k_0 m_0 k_1 m_1;
k_0=0.1; m_0=0.1; k_1=0.01; m_1=0.01;
% Saturating feedback steady state solution for combined rates below threshold
% Linear feedback will always reach steady state for non-negative combined rates
s_1=0.1; s_2=0.3; s_3=k_0/m_0+s_1+s_2-0.25;
t_1=0.1; t_2=0.4; t_3=k_1/m_1+t_1+t_1-0.25;
c=0.25;
% Initial conditions ([1 0 0])
state0=[1 0 0]; %Initial conditions: 1 CSC cell

%=== Prompt user
% Which model? Either linear or saturating feedback for homeostasis
% 0: Saturating
% 1: Linear
global feedback_type
feedback_type=logical(input('What model? \n 0: Saturating Feedback \n 1: Linear Feedback \n Enter and click return:'));

% Saturating: Allow for de-differentiation?
% Linear: Do nothing
global dedifferentiation;
global THETA PHI; %Proportion of T->S and S->D division
dedifferentiation=logical(input('Allow for dedifferentiation of T cells? \n 0: No \n 1: Yes \n Enter and click return:'));
if dedifferentiation
	THETA=max(min(input('What proportion of T->S [0,1]? \n'),1),0);
else
	THETA=0; % 0 proportion of T->S
end;
termdifferentiation=logical(input('Allow for terminal differentiation of S cells? \n 0: No \n 1: Yes \n Enter and click return:'));
if termdifferentiation
	PHI=max(min(input('What proportion of S->D [0,1]? \n'),1),0);
else
	PHI=0; % 0 proportion S->D
end;
%===

% Simulate system
odefun=@report_system;
tend=[0 500];
[t, s]=ode45(odefun,tend,state0);

display('Results stored in variables t,s. Plot accordingly. (Raw plot in Figure(1))');
plot(t,s(:,1),t,s(:,2),t,s(:,3),'linewidth',1.5);
ylabel('population (cells)');xlabel('time (days)');
