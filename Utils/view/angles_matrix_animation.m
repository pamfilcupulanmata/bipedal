function angles_matrix_animation(angles_matrix, default_configuration_transforms)
%ANGLES_MATRIX_ANIMATION this function simulates for the already computed angles
    for i=1:size(angles_matrix,1)
        teta1 = angles_matrix(i,1); % hip roll
        teta2 = angles_matrix(i,2); % knee roll
        teta3 = angles_matrix(i,3); % ankle roll
        teta4 = angles_matrix(i,4); % hip pitch
        teta5 = angles_matrix(i,4); % ankle pitch
        Forward(teta3, teta5, teta2, teta1, teta4, default_configuration_transforms);
        pause(0.1)
        clf;
    end
end

