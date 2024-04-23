function [angles_trajectory, positions] = swing_leg(step_x, step_y, step_z, positions, isRight, isFirst)
%SWING_LEG Swing leg to Pendulum position; step_x, step_y, step_z,
%positions(structure)

positions.COM(1) = step_x;
positions.COM(2) = step_y;
positions.COM_xy_proj = positions.COM(1:2);

if isRight == true
    leg_state.current = positions.RightFoot;
    leg_state.previous = positions.initialPosition.RightFoot;
    positions.RightFoot(1) = step_x;
    positions.RightFoot(2) = step_y;
else
    leg_state.current = positions.LeftFoot;
    leg_state.previous = positions.initialPosition.LeftFoot;
    leg_state.previous(2) = -leg_state.previous(2);
    positions.LeftFoot(1) = step_x;
    positions.LeftFoot(2) = step_y;
end

trajectory = calculate_trajectory(step_x, step_z, leg_state.previous, isFirst);


trajectory.y = linspace(leg_state.previous(2), step_y, length(trajectory.x));


angles_trajectory = Inverse_matrix(trajectory);
if isRight == false
    angles_trajectory = -angles_trajectory;
end
positions.COM(1) = step_x;
positions.COM(2) = step_y;
positions.COM_xy_proj = positions.COM(1:2);

end

function [trajectory] = calculate_trajectory(step_length, step_height, state_pos, first_step)
offset = 0;
if first_step == 1
    A = [0 0 1;(step_length/2)^2 step_length/2 1;step_length^2 step_length 1];
    b = [state_pos(3)+offset;state_pos(3)+ step_height;state_pos(3)+offset];
    trajectory.x = linspace(0,step_length,13);
else
    A = [state_pos(1)^2 state_pos(1) 1;0 0 1;step_length^2 step_length 1];
    b = [state_pos(3)+offset;step_height+state_pos(3);state_pos(3)+offset];
    trajectory.x = linspace(state_pos(1), step_length,13);
end

solution = A\b;
a = solution(1);
b = solution(2);
c = solution(3);

trajectory.z = a*trajectory.x.^2 + b*trajectory.x + c;
if first_step == 1
    trajectory.x = linspace(state_pos(1),step_length,13);
end
trajectory.y = zeros(size(trajectory.x));

% figure()
% plot(trajectory.x,trajectory.z);
end

