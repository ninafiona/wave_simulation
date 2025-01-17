%  [min_z_outer, max_z_outer] = plottingPlane(Nx, Ny, Nz, sensor_data.uz, thickness_grid, dt, source_radius, gel, z_height)
% function [min_z_outer, max_z_outer] = plottingPlane(Nx, Ny, Nz, uz, thickness_grid, dt, source_radius, gel, z_height)
uz = sensor_data.uz;
[x y] = meshgrid(1:Nx); % SAME AS SENSORS IN SIMULATION
nbr_of_sensors = size(uz,1);
nbr_of_timesteps = size(uz,2);
ts = 1 * nbr_of_timesteps;
pos_top = vel_to_pos(uz(end-Nx*Ny+1:end,:), dt);
% pos = vel_to_pos(uz, dt);
uz_bottom = uz(1:Nx*Ny,:);
max_z = max(max(pos_top(:,1:ts)))
min_z = min(min(pos_top(:,1:ts)))
max_b = max(uz_bottom,[], 'all');
min_b = min(uz_bottom,[], 'all');

uz_3d = reshape(sensor_data.uz,Nx,Ny,Nz,kgrid.Nt);
uz_2d_top = zeros(Nx,Ny,kgrid.Nt);
uz_2d_top(:,:,:) = uz_3d(:,:,gel_surface_z,:);
uz_2d_bottom = zeros(Nx,Ny,kgrid.Nt);
uz_2d_bottom(:,:,:) = uz_3d(:,:,1,:);

for t=1:1:ts; %nbr_of_timesteps
%     pos_t = pos(:,t); % activate for round simulation
%     pos_t = pos(1:Nx*Ny,t); % activate for quadratic simulation bottom
    pos_t = pos_top(:,t); % activate for quadratic simulation
%     uz_0t = uz_0(end-Nx*Ny+1:end,t);
    pos_plane = zeros(Nx, Ny);
%     pos_plane(logical(gel(:,:,z_height+thickness_grid-1) == 1)) = pos_t; % activate for round
    pos_plane(:) = pos_t; % activate for quadratic
%     pos_plane(logical(gel(:,:,z_height+thickness_grid-1) == 1)) = uz_0t;
%         pos_inner_zero = pos_plane;
%         pos_inner_zero(Nx/2 - source_radius:Nx/2 + source_radius, Ny/2 - source_radius:Ny/2 + source_radius) = 0;
%         if(max_z_outer < max(max(pos_inner_zero)))
%             max_z_outer = max(max(pos_inner_zero));
%         end
%         if(min_z_outer > min(min(pos_inner_zero)))
%             min_z_outer = min(min(pos_inner_zero));
%         end
    surf(x,y,pos_plane);
    zlim([-0.001 0.001]);
%     zlim([2*min_z 2*max_z]);
%     zlim([2.5e-3 0.6*max_v]);
    ts = ['timestep '  num2str(t)  ' of '  num2str(length(uz(1,:))) ' (' num2str(t_end*1000) ' ms)'];
    title(ts);
    pause(0.1);
end
% end