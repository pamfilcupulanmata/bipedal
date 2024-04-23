function [positions] = com_to_legs(xc,yc,zc,positions)
    poz_COM_finala = [xc; yc; zc];
    legs_position.right = [-xc; yc; positions.COM(3)-poz_COM_finala(3)];
    legs_position.left = [-xc; -yc; positions.COM(3)-poz_COM_finala(3)];
    positions = update_position(positions, poz_COM_finala, legs_position);
end

function [positions] = update_position(positions,poz_finala_COM,legs)
positions.COM = poz_finala_COM;
positions.COM_xy_proj = poz_finala_COM(1:2);
positions.COM_world = [positions.COM_world(1) + positions.COM(1); positions.COM(2) ;positions.COM(3)];
positions.LeftFoot = legs.left;
positions.RightFoot = legs.right;
end
