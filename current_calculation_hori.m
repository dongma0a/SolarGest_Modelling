function current_time_series = current_calculation_hori(gest_time_series,radius_solar_cell,...
    radius_hand,light_intensity,solar_cell_current_density,hand_height)
%% this function caculates time series of solar cell current for a horizontal gesture.
% INPUT
%   gest_time_series               - time series of hand positions that form a gesture
%   radius_solar_cell              - radius of solar cell
%   radius_hand                    - radius of hand
%   light_intensity                - light intensity in lux
%   solar_cell_current_density     - current density of solar cell, in mA/cm^2
%   hand_height                    - distance between solar cell and hand 
%
% OUTPUT
%   current_time_series            - generated current pattern under a given gesture


%% initialization
current_time_series = zeros(1,length(gest_time_series)); % the generate current curve/array
current_at_certain_position_left = zeros(1,length(gest_time_series));
current_at_certain_position_right = zeros(1,length(gest_time_series));


% assume the distance between solar cell and hand is 5cm, when performing
% a horizontal gesture
% hand_height = 0.05;

%% refer to Section 2.1 in the paper. Here, solar_cell_current_density corresponds 
%  to Jsc* in the paper, as it is measured under standard_illunination_intensity.

standard_illunination_intensity = 100; %mW/cm^2, corresponds to I* in the paper

% since the unit of light_intensity is lux, we convert lux to mW/cm^2 
conversion_factor = 1.46412884333821*10^(-4);
light_intensity_in_mW = light_intensity * conversion_factor;

area_solar_cell = pi*(radius_solar_cell*100)^2;% area of solar cell in cm^2

%% refer to Figure 2(d) in our paper, and do the calculation
for i = 1: length(gest_time_series)
    current_position = gest_time_series(i); % current position
    % theta3 and theta4 are calculted as following
    theta3 = (360/(2*pi)) * atan((2*radius_hand - current_position)/hand_height);
    theta4 = (360/(2*pi)) * atan(current_position/hand_height);
    theta3 = round(theta3);
    theta4 = round(theta4);
   
    %% culculate the current for the left part in Figure 2(d) in the paper
    for angle_left = theta3:90 % using 1 degree step 
        % based on Lambert's cosine law, the efftive light intensity with
        % the incident angle less than 90 degree
        effective_light_intensity_in_mW = cos(angle_left*((2*pi)/360))*light_intensity_in_mW;
        % refer to equation (2) in the paper
        current_at_certain_angle_left = area_solar_cell*solar_cell_current_density*(effective_light_intensity_in_mW/standard_illunination_intensity);
        current_at_certain_position_left(i) = current_at_certain_position_left(i) + current_at_certain_angle_left; 
    end
    
    %% culculate the current for the right part in Figure 2(d) in the paper
    for angle_right = theta4:90 % using 1 degree step 
        % based on Lambert's cosine law, the efftive light intensity with
        % the incident angle less than 90 degree
        effective_light_intensity_in_mW = cos(angle_right*((2*pi)/360))*light_intensity_in_mW;
        % refer to equation (2) in the paper
        current_at_certain_angle_right = area_solar_cell*solar_cell_current_density*(effective_light_intensity_in_mW/standard_illunination_intensity);
        current_at_certain_position_right(i) = current_at_certain_position_right(i) + current_at_certain_angle_right;        
    end
    
    current_time_series(i) = current_at_certain_position_left(i) + current_at_certain_position_right(i);
end


