Ts = 0.005;
T_singleSupport = 0.4; % [s]
T_doubleSupport = 0.8; % [s]
positions = struct();
positions.COM = [0; 0; CoM_location(3)];
positions.COM_world = positions.COM;
positions.COM_xy_proj = positions.COM(1:2);
positions.LeftFoot = [0; 0; 0];
positions.RightFoot = [0; 0; 0];
trajectory = struct('x', zeros(1,20), 'y', zeros(1,20), 'z', zeros(1,20));

%% go to init position
previous_positions = positions;
positions = com_to_legs(-3, 7, positions.COM(3)-3, positions); % pozitia picioarelor pt poz COM dorita


