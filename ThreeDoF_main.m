% Author: Donovan Norris

%% Program Description

%% Initialization
clear;
clc;

%% Parameters

thrust = 2000 ; % Given thrust parameter, N
mass = 40 ; % Given mass parameter, kg
burnTime = 10 ; % Given burn time parameter, s
outerDiameter = 0.1 ; % Given outer diamter of the rocket parameter, m
dragCoefficient = 0.75 ; % Given drag coefficient
g = 9.8; % Gravity m/s^2
area = pi * (outerDiameter / 2) ^ 2; % Area of the rocket, m^2
phi = (5 / 180) * pi; % Launch angle in radians from top down, rads
theta = (0 / 180) * pi; % Launch angle in radius from x-axis sweeping positive, rads
x0 = [0, 0, 0]; % Initial Launch Height, m
xdot0 = [0, 0, 0]; % Initial Launch Velocity, m
densityAir = 1.225; % Air density (constant), 
tspan = [0 70];

parameters = [thrust, mass, area, dragCoefficient, g, densityAir]; % Parameters needed for velocity calculations

%% Calculations

[t, x] = ode45(@(t, x)velocity(t, x, thrust, mass, area, dragCoefficient, g, densityAir, phi, burnTime, theta), tspan, [x0 xdot0]);


function dx = velocity(t, x, thrust, mass, area, dragCoefficient, g, densityAir, phi, burnTime, theta)

dx = [
    x(4); % X component, posiiton
    x(5); % Y component, position
    x(6); % Z component, position
    ((t <= burnTime) * thrust * cos(theta) * sin(phi) - ((dragCoefficient * area * densityAir) * x(6)^2 / 2) * cos(theta) * sin(phi)) / mass; % X component, velocity
    ((t <= burnTime) * thrust * sin(theta) * sin(phi) - ((dragCoefficient * area * densityAir) * x(6)^2 / 2) * sin(theta) * sin(phi)) / mass; % Y component, velocity
    ((t <= burnTime) * thrust * cos(phi) - g * mass - ((dragCoefficient * area * densityAir) * x(6)^2 / 2) * cos(phi)) / mass]; % Z component, velocity

end
%% Display
figure(1)
title('Rocket Height vs Time')
plot(t,x(:,3),'k')
xlabel('Time (s)')
ylabel('Height (m)')
grid on

figure(2);
title('Rocket Velocity vs Time')
plot(t, x(:,6), 'r')
xlabel('Time (s)')
ylabel('Velcoity (m/s)')
grid on
