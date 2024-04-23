function [angles, positions] = COM(xc,yc,zc,speed,positions, isFirst)
%% [angles,positions(struct)] = [xc,yc,zc,speed,positions(struct)] => speed in [m/s] and positions in [cm]
    Ts = 0.005;
    Right = positions.RightFoot; % current position
    final_position = com_to_legs(-xc,yc,zc,positions); % final position
    distance = abs(Right-final_position);
    % i have to create a trajectory from the current position to final pos
    num_samples = (max(distance/10)/speed)/Ts;
    trajectory.x = linspace(Right(1), final_position(1), num_samples);
    if isFirst
        trajectory.y = linspace(Right(2), final_position(2), num_samples+1);
    else
        trajectory.y = [linspace(Right(2), 0, (num_samples/2)+1) linspace(0, Right(2)*0.5, (num_samples/2)+1)];
    end
    trajectory.z = linspace(Right(3), Right(3)+final_position(3), num_samples);

    angles.right = Inverse_matrix(trajectory);
    angles.left = -angles.right;

    positions.RightFoot = [final_position(1:2); Right(3)+final_position(3)];
    positions.LeftFoot = positions.RightFoot;
    positions.LeftFoot(2) = -positions.LeftFoot(2);
    positions.COM = [xc;yc;zc];
    positions.COM_xy_proj = positions.COM(1:2);
end

function [legs_position] = com_to_legs(xc,yc,zc,positions)
%% function is designed for Right leg and derive the left leg from this one
    poz_initiala = positions.COM;
    poz_finala = [xc; yc; zc];
    legs_position = [xc; yc; poz_initiala(3)-poz_finala(3)];
end