clear;
close all;

addpath('Utils\');
%%
global g m1 l1 lc1 I1 m2 l2 lc2 I2
g = 0;

m1 = 7.848;
l1 = 0.3;
lc1 = 0.1554;
I1 = 0.176;

m2 = 4.49;
l2 = 0.15;
lc2 = 0.0341;
I2 = 0.0411;

%% simulation 
% time
tspan = [0 2.5];

% initial condition
ini = 0.05;
% ini = 0;
x0 = [ini,0,ini,0];

% Controller
controller = @PDcontroller;

% Reference Signal
refFun = @(t) deal((t<1)*pi/2,0,0);

% simulation with ode!
[t, y] = ode45(@(t,x) RR_dynamics(t,x,controller,refFun), tspan, x0);

%% Generate outputs
[q_ref,v_ref,a_ref] = refFun(t);

tau = zeros(length(t),2);
e = zeros(length(t),2);

for i = 1:length(t)
    [tau(i,:), e(i,:)] = controller(t(i),y(i,:),refFun);
end

%% Plotting and Info
plotting(t,y,q_ref,e,tau)

t_s = linspace(0,2,1000*2);
tau_s = interp1(t,tau,t_s);
fprintf('Tau saturate for: %.3f %.3f second\n', sum(abs(tau_s)==10)/1000)
