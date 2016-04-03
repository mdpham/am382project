clear all; close all;

% System parameters
global s_1 s_2 s_3;
global t_1 t_2 t_3;
global c;

% Prompt user
parameter_setting=input('Model parameters: \n 0: Unbound CSC growth \n 1: Exp CSC decay \n');
switch parameter_setting
	case 0 %Unbound growth for s_3>0.5
		s_1=0.1; s_2=0.3; s_3=0.6;
		t_1=0.1; t_2=0.4; t_3=0.5;
		c=0.25;
	case 1 %Exponential decay for s_3<0.5
		s_1=0.3; s_2=0.3; s_3=0.4;
		t_1=0.1; t_2=0.4; t_3=0.5;
		c=0.25;
	otherwise
		s_1=0.25; s_2=0.25; s_3=0.5;
		t_1=0.1; t_2=0.4; t_3=0.5;
		c=0.25;
end;
initial_conditions=input('Initial conditions: [CSC T D] \n');
state0=initial_conditions;

% Simulate system
odefun=@three_compartment;
tend=[0 50];
[t, s]=ode45(odefun,tend,state0);

% Plot results
plot(t,s(:,1),t,s(:,2),t,s(:,3),'linewidth',2);
xlabel('time');ylabel('population');
title(['CSC_0=' num2str(state0(1)) ', T_0=' num2str(state0(2)) ', D=' num2str(state0(3))]);
legend('CSC','T','D');