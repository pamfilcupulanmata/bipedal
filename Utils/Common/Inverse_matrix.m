function [angles_matrix_for_trajectory] = Inverse_matrix(trajectory)
%INVERSE_VECTOR This function uses 'Inverse.m' just to compute the angle
%matrix for the trajectory passed so it is remembered since it repeats.
x_vector = trajectory.x;
y_vector = trajectory.y;
z_vector = trajectory.z;
angles_matrix_for_trajectory = [];

for i=1:size(trajectory.x,2)
    angles = Inverse(x_vector(i), y_vector(i), z_vector(i));
    angles_matrix_for_trajectory = [angles_matrix_for_trajectory; angles];
end
end

