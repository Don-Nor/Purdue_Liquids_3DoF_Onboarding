function RocketAnimation(pos, rot)
% Description:
%
% Inputs:
% position - x and y [m]
% rotation - angle [rad]


% Initialize figure for animation
figure(2)
hold on;

x = pos(:,1);
y = pos(:,2);

w = 0.1;
h = 1.5;

pgon = polyshape([-w/2,-w/2,0,w/2,w/2],[0,h,1.2*h,h,0]);


% Loop through position and rotation arrays to animate the rocket
for i = 1:length(pos)
    % Update rocket position and rotation here
    pgonDraw = rotate(pgon, rad2deg(rot(i)-pi/2));
    pgonDraw = translate(pgonDraw, [x(i),y(i)]);
    plot(pgonDraw)

    axis equal
    xlabel('Downrange [m]')
    ylabel('Altitude [m]')


    hold off
    pause(0.01)

end