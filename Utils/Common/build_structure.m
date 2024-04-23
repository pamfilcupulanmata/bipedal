function [structure_with_time] = build_structure(angles_matrix)
%BUILD_STRUCTURE Builds the structure to import in simulink for the joints

angles.time = 0:0.05:(size(angles_matrix,1)-1)*0.05;
angles.signals.values = zeros(1, size(angles_matrix, 2), size(angles_matrix, 1));  % Initialize angles.signals.values
for i = 1:size(angles_matrix, 1)
    angles.signals.values(1,:,i) = angles_matrix(i,:);
end
angles.signals.dimensions = [1 size(angles_matrix, 2)];

structure_with_time = angles;
end

