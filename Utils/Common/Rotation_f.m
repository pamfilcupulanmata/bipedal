function [R] = Rotation_f(angle,about_axis)
%ROTATION_F Summary of this function goes here
%   Detailed explanation goes here
angle_in_rad = deg2rad(angle);
if isequal(about_axis,'x')
    R = [1 0 0; 0 cos(angle_in_rad) -sin(angle_in_rad); 0 sin(angle_in_rad) cos(angle_in_rad)];
elseif isequal(about_axis,'y')
    R = [cos(angle_in_rad) 0 sin(angle_in_rad); 0 1 0; -sin(angle_in_rad) 0 cos(angle_in_rad)];
else
    R = [cos(angle_in_rad) -sin(angle_in_rad) 0; sin(angle_in_rad) cos(angle_in_rad) 0; 0 0 1];
end

