function [solution] = Inverse(x,y) % this works perfectly
    height = 24.25;
    x_copy = x;
    
    x = height - y; % defapt inaltimea pe Z
    y = -x_copy;
    
    %%
    L1 = 12.75;
    L2 = 11.5;

    % theta4 = asin(y/x); % hip pitch
    % x = x - x*sin(theta4); % update x position

    theta2 = -acos((x^2 + y^2 - L1^2 - L2^2)/(2*L1*L2)); % knee roll
    theta1 = atan(y/x) + atan((L2*sin(theta2))/(L1+L2*cos(theta2))); % hip roll
    theta3 = theta2 - theta1; % ankle roll
    solution = [rad2deg(theta1) rad2deg(-theta2) rad2deg(theta3)]; 

end