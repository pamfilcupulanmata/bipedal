function view_frames(transform_matrices)
%TEST_FRAMES - view frames and segments
original_frame = [eye(3) zeros(3,1) ; zeros(1,3) 1];
o_3 = 1:3;

clf; % clear figure if one is open

translations = [];
n = size(transform_matrices)/4;
n = n(2);
past_matrix = original_frame;
plot_segment([1 0 0],[2 5 5],'b')

for i=0:n-1
    current_matrix = transform_matrices((1:4),(1:4)+i*4);
    current_matrix_transformed = past_matrix * current_matrix;
    rotation = current_matrix_transformed(o_3,o_3);
    translation = current_matrix_transformed(o_3,4);
    past_matrix = current_matrix_transformed;
    plot_frame(translation,rotation);
    translations = [translations translation];
end

for i=1:size(translations,2)-1
    plot_segment(translations(:,i),translations(:,i+1),'b');
end

% Set axis properties
axis([-20 25 -20 25 0 25;])
xlabel('X');
ylabel('Y');
zlabel('Z');
title('Frames View');

end

function plot_segment(start_point, end_point, color)
    plot3([start_point(1) end_point(1)], [start_point(2) end_point(2)], [start_point(3) end_point(3)], color, 'LineWidth', 1.5);
end

function plot_frame(translation, rotation)
    quiver3(translation(1), translation(2), translation(3), rotation(1,1), rotation(2,1), rotation(3,1), 'r', 'LineWidth', 2); hold on;
    quiver3(translation(1), translation(2), translation(3), rotation(1,2), rotation(2,2), rotation(3,2), 'g', 'LineWidth', 2);
    quiver3(translation(1), translation(2), translation(3), rotation(1,3), rotation(2,3), rotation(3,3), 'b', 'LineWidth', 2);
end

