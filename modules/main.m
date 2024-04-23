% SP = support point
% standard data type definitions
init_equilibrium = [-3 ; 5]; % [x ; y]
positions = struct();
positions.COM = [0; 0; CoM_location(3)];
positions.COM_world = positions.COM;
positions.COM_xy_proj = positions.COM(1:2);
positions.LeftFoot = zeros(3,1);
positions.RightFoot = zeros(3,1);
speed = 3; % [m/s]
step_length = 3;
step_height = 3;
step_width = 6;

angles = struct('left', zeros(10,5), 'right', zeros(10,5));
angles.left = zeros(10,5);
angles.right = zeros(10,5);
isFirst = 1;
% go to init position
[angles_init, positions] = COM(init_equilibrium(1), init_equilibrium(2), positions.COM(3)-3, speed, positions, isFirst);
% all other angles shall be apended to the angles matrix

% initialise the LIPM system
zc = positions.COM(3);
lipmD = initialiseLIPM(zc);
system = struct('model',lipmD);

% get the position of the COM relative to the support point
% initial conditions for the LIPM state-space
angles_pendulum_full = struct('left',[],'right',[]);

response = LIPM(system.model,0.75,0.75);
response.round_x = round(response.x);
positions.initialPosition = positions;

steps = input('Insert number of steps: ');
isFirst = 1;

for i = 1:steps
    % i%2 == 1 --> right leg first -- else -- left leg
    x_pos = 0.75;
    y_pos = 0.75;
    positions.initialPosition = positions;
    [angles_pendulum, positions] = COM(response.round_x(end,1)-1, -response.round_x(end,3)*0.5, positions.COM(3), 2*speed, positions, isFirst);
    
    if mod(i,2) == 1
        [angles_pendulum.right, positions] = swing_leg(step_length, step_width, step_height, positions, true, isFirst);
    else
        [angles_pendulum.left, positions] = swing_leg(step_length, -step_width, step_height, positions, false, isFirst);
    end

    isFirst = 0;
    angles_pendulum_full.left = [angles_pendulum_full.left;angles_pendulum.left];
    angles_pendulum_full.right = [angles_pendulum_full.right;angles_pendulum.right];
end

%% output
angles.left = [angles_init.left ; angles_pendulum_full.left];
angles.right = [angles_init.right; angles_pendulum_full.right];

right_leg_import = build_structure(real([angles.right; angles.right(end,:)]));
left_leg_import = build_structure(real([angles.left; angles.left(end,:)]));







