function [response] = LIPM(lipmD,x_pos,y_pos)
%LIPM Gives the response to the initial conditions provided (x_pos, y_pos)
%when the system is not actuated.

% time constants
Ts = 0.5; % [s]
timespan = 6.5; % [s]
t = 0:Ts:timespan; % time vector for response

% [x_pos;xd;y_pos;y_speed]
x0 = [x_pos;0;y_pos;0]; % initial conditions

% consider the system unactuated
u = zeros(length(t),2); 

% simulate the system and obtain response
[y,t,x] = lsim(lipmD, u, t, x0);
clf;
response.y = y;
response.t = t;
response.x = x;
% 
% figure(2)
% title('states');
% subplot(4,1,1)
% plot(t,x(:,1))
% title('x.pos')
% hold on
% subplot(4,1,2)
% plot(t,x(:,2))
% title('xd')
% subplot(4,1,3)
% plot(t,x(:,3))
% title('y.pos')
% subplot(4,1,4)
% plot(t,x(:,4))
% title('yd')


end

