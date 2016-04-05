clear all; close all;

% System parameters
global s_1 s_2 s_3;
global t_1 t_2 t_3;
global c;
% Saturating feedback
global k_0 m_0 k_1 m_1;
k_0=0.1; m_0=0.1; k_1=0.01; m_1=0.01;

%=== Prompt user
% Model parameters
global parameter_setting;
parameter_setting=input('Model parameters: \n 1: CSC steady-state \n 0: CSC unbound \n');
switch parameter_setting
case 0 %Unbound growth for s,t > k0/m0,k1/m1
	s_1=0.1; s_2=0.3; s_3=k_0/m_0+s_1+s_2+0.25;
	t_1=0.1; t_2=0.4; t_3=k_1/m_1+t_1+t_1+0.25;
	c=0.25;
case 1 %Steady-state for s,t < k0/m0,k1/m1
	s_1=0.1; s_2=0.3; s_3=k_0/m_0+s_1+s_2-0.25;
	t_1=0.1; t_2=0.4; t_3=k_1/m_1+t_1+t_1-0.25;
	c=0.25;
case 2 %S=0 unstable for alpha>0, globally attracting for alpha<0
	% alpha= s_3-s_1-s_2;
	k_0=0.001; k_1=0.001;
	% SS
	s_1=0.25; s_2=0.25; s_3=0.6;
	t_1=0.1; t_2=0.4; t_3=0.6;
	% Extinct
	% s_1=0.25; s_2=0.25; s_3=0.4;
	c=0.25;
end;
% Mutation kick to change system behaviour
global mutation kicks;
mutation=logical(input('Mutate by increasing S self-renewal rate every 75t from 75t? \n 1: Yes \n 0: No \n'));
if mutation
	kicks=zeros(5,1);
else
	kicks=ones(5,1);
end;

% Constant harvesting
global harvest harvest_rate harvest_mutation;
harvest=logical(input('Harvest T between t=100..110? \n 1: Yes \n 0: No \n'));
if harvest
	% Ask for efficiency of harvesting between 0 and 1
	harvest_rate=max(min(input('Reduce to 0..1? \n'),1),0);
	harvest_mutation=0;
end;

% Initial conditions ([1 0 0])
% initial_conditions=input('Initial conditions: [CSC T D] \n');
% state0=initial_conditions;
state0=[1 0 0]; %Initial conditions: 1 CSC cell
%===

% Simulate system
odefun=@three_comp_sat_feedback;
tend=[0 500];
[t, s]=ode45(odefun,tend,state0);

% Plot results
figure(1);
% Use logscale since kicking to unbound will explode values
if mutation
	s=log(s);
end;
plot(t,s(:,1),t,s(:,2),t,s(:,3),'linewidth',2);
xlabel('Time (days)');
if mutation
	ylabel('Population (log)');
else
	ylabel('Population');
end;
% title(['CSC_0=' num2str(state0(1)) ' T_0=' num2str(state0(2)) ' D_0=' num2str(state0(3))]);
legend('CSC','T','D');


% % DIRECTION FIELD
% [csc,tac]=meshgrid(0:50,0:50);
% dsdt = @(S,T) (s_3-s_1-s_2).*S - (k_0.*S.^2)/(1+m_0.*S);
% dtdt = @(S,T) (t_3-t_1-t_2).*T - (k_1.*T.^2)/(1+m_1.*T) + s_2*S + (k_0.*S.^2)./(1+m_0.*S);
% u=dsdt(csc,tac);
% v=dtdt(csc,tac);
% figure(2);
% quiver(csc,tac,u,v);
