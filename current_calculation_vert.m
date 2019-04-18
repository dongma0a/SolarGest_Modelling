function current_time_series = current_calculation_vert(gest_time_series,radius_hand,...
    radius_solar_cell,light_intensity,solar_cell_current_density)
%% this function caculates time series of solar cell current for a vertical gesture.
% INPUT
%   gest_time_series               - time series hand positions that form a gesture
%   radius_solar_cell              - radius of solar cell
%   radius_hand                    - radius of hand
%   light_intensity                - light intensity in lux
%   solar_cell_current_density     - current density of solar cell, in mA/cm^2
%
% OUTPUT
%   current_time_series            - generated current pattern under a given gesture

% initialization
current_time_series = zeros(1,length(gest_time_series)); 
current_at_certain_position_left = zeros(1,length(gest_time_series));


%% refer to Section 2.1 in the paper. Here, solar_cell_current_density corresponds 
%  to Jsc* in the paper, as it is measured under standard_illunination_intensity.

standard_illunination_intensity = 100; %mW/cm^2, corresponds to I* in the paper

% since the unit of light_intensity is lux, we convert lux to mW/cm^2 
conversion_factor = 1.46412884333821*10^(-4);
light_intensity_in_mW = light_intensity * conversion_factor;

area_solar_cell = pi*(radius_solar_cell*100)^2;% area of solar cell in cm^2


%% refer to Figure 2(c) in our paper, and do the calculation
for i = 1: length(gest_time_series)
    current_position = gest_time_series(i); % current_position
    % theta1 are calculted as following
    theta1 = (360/(2*pi)) * atan((radius_hand - radius_solar_cell)/current_position);
    theta1 = round(theta1);
    
    
    %% culculate the current for the left part in Figure 2(c) in the paper, and
    % the right part is symetric
    for angle_left = theta1:1:90 % using 1 degree step 
        % based on Lambert's cosine law, the efftive light intensity with
        % the incident angle less than 90 degree
        effective_light_intensity_in_mW = cos(angle_left*((2*pi)/360))*light_intensity_in_mW;
        % refer to equation (2) in the paper
        current_at_certain_angle_left = area_solar_cell*solar_cell_current_density*(effective_light_intensity_in_mW/standard_illunination_intensity);
        current_at_certain_position_left(i) = current_at_certain_position_left(i) + current_at_certain_angle_left;            
    end
    current_time_series(i) = 2 * current_at_certain_position_left(i);
end

