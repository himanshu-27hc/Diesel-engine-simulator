clear all
close all
clc
% we will caculate efficiency of diesel cycle and will plot it in P-V
% diagram
% programme for diesel cycle
gamma = 1.4; % adiabetic index for air would be used for calculatin efficiecy
t3 = 2300; % temperature after heat addition

% cut_off = 6%

% STATE 1 VARIABLES
p1 = 1.01325; % pressure at starting of compression in (MPa)
t1 = 500; % temperature at starting of compression in (Kelvin)

% engine geometric parametrs
bore = .1;
stroke = .1;
con_rod = .15;
cr = 14;

% calculating swept and clearnce volume
v_swept = (pi/4)*bore^2*stroke;
v_clearance = v_swept/(cr-1);
v1 = v_swept+v_clearance;
v2 = v_clearance;



% STATE 2 VARIABLES
% we wll use p1v1^gamma = p2v2^gamma
p2 = (p1*v1/v2)^gamma;
constant_c = p1*v1^gamma;
v_compression = piston_kinematics(bore,stroke,con_rod,cr,180,0);
p_compression = constant_c./v_compression.^gamma;
%p1v1/t1 = p2v2/t2
t2 = p2*v2*t1/(p1*v1);

% STATE 3 VARIABLES
p3 = p2;
%we will use (v3/v2) = (t3/t2)
v3 = (t3/t2)*v2;
constant_c = p3*v3^gamma;
v_expension = v3:.00001:v1;
p_expension = constant_c./(v_expension.^gamma);



% STATE 4 VARIABLES
v4 = v1;
%we will use (p4/p1) = (t4/t1)
% we will use (t4/t3) = (v3/v4)^((gamma-1)/gamma)
t4 = (v3/v4)^((gamma-1))*t3;
p4 = p3*v3^gamma/v4^gamma;

% plotting of diesel cycle
hold on
plot(v1,p1,'*','color','r')
plot(v_compression,p_compression,'color','b')
plot(v2,p2,'*','color','r')
plot([v2 v3],[p2 p3],'color','g')
plot(v3,p3,'*','color','r')
plot(v_expension,p_expension,'color','k')

plot(v4,p4,'*','color','r')
plot([v4 v1],[p4 p1],'color','m')
xlabel('Volume(in m^3)')
ylabel('Pressure(in KPa)')
title('Diesel cycle ')
grid on
