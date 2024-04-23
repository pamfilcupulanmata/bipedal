function [T] = Forward(theta_ankle_roll, theta_ankle_pitch, theta_knee, theta_hip_roll, theta_hip_pitch, transform) % 
%FORWARD ankle roll, ankle_pitch, knee roll, hip roll, hip pitch

Screw1 = [Rotation_f(theta_hip_roll,'z') zeros(3,1); zeros(1,3) 1];
Screw2 = [(Rotation_f(theta_hip_pitch,'x'))' zeros(3,1); zeros(1,3) 1]; % transposed because the actual frame is flipped and i don't wanna rotate again
Screw3 = [Rotation_f(theta_knee,'z') zeros(3,1); zeros(1,3) 1];
Screw4 = [Rotation_f(theta_ankle_roll,'z') zeros(3,1); zeros(1,3) 1];
Screw5 = [Rotation_f(theta_ankle_pitch,'x')' zeros(3,1); zeros(1,3) 1];

foot_ankle = transform(1:4,1:4);
ankle_foot = [foot_ankle(1:3,1:3)' -foot_ankle(1:3,1:3)'*foot_ankle(1:3,4);zeros(1,3) 1];
ankle_knee = transform(1:4,5:8);
knee_ankle = [ankle_knee(1:3,1:3)' -ankle_knee(1:3,1:3)'*ankle_knee(1:3,4) ; zeros(1,3) 1];
knee_hip = transform(1:4,9:12);
hip_knee = [knee_hip(1:3,1:3)' -knee_hip(1:3,1:3)'*knee_hip(1:3,4) ; zeros(1,3) 1];

full_transf = foot_ankle * ankle_knee * knee_hip;

hip = full_transf * Screw1 * Screw2;
knee = hip_knee * Screw3;
ankle = knee_ankle * Screw4 * Screw5;
foot_endeffector = ankle_foot;

view_frames([hip knee ankle foot_endeffector]);
end

