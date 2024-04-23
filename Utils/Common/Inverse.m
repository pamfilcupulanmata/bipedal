function [solution] = Inverse(x,y,z)
% hip  roll , knee roll , ankle roll , hip pitch , ankle pitch
    height = 24.25;
    x_copy = x;
    
    x = height - z; % defapt inaltimea pe Z
    z = -x_copy;
    
    %%
    L1 = 12.75;
    L2 = 11.5;

    theta4 = atan(y/x); % hip pitch
    
    theta2 = -acos((x^2 + z^2 - L1^2 - L2^2)/(2*L1*L2)); % knee roll
    theta1 = atan(z/x) + atan((L2*sin(theta2))/(L1+L2*cos(theta2))); % hip roll
    theta3 = theta2 - theta1; % ankle roll
    theta5 = -theta4;
    solution = [rad2deg(theta1) rad2deg(-theta2) rad2deg(theta3) rad2deg(theta4) rad2deg(theta5)];
    % hip  roll , knee roll , ankle roll , hip pitch , ankle pitch
end