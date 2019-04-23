%% example of using the proposed model to investigate the impact of different parameters

%% steps:
% 1. define and set parameters (detailed illustration of parameters please
%    refer to Figure 2(b) in the paper)
% 2. discretize a gesture and generate times series of hand positions.
%    Consider horizontal and vertical gestures individually.
% 3. calculate the solar cell output current when hand is at a certain
%    position, and then form the gesture pattern. Consider horizontal and 
%    vertical gestures individually.
% 4. vary the parameters and investigate their impacts

clear all 
close all

%% parameter define, defult values
radius_hand = 0.06; % set radius of hand to 6cm
radius_solar_cell = 0.02;  % set radius of solar cell to 2cm
light_intensity = 1000;  % set light intensity to 1000lux
hand_position_low = 0.02; % set the minimum distance between solar cell and hand to 2cm
hand_position_high = 0.1; % set the maximum distance between solar cell and hand to 2cm
hand_displacement = hand_position_high - hand_position_low; % displacement of hand movement
hand_move_speed = 0.2; % set the speed of hand move to 0.2m/s
solar_cell_current_density = 7; % current density of solar cell, in mA/cm^2
hand_height = 0.05; % distance between hand and solar cell when performing horizontal gesture

%% define 4 horizontal gestures:
% 'Ges_Left', 'Ges_Right', 'Ges_LeftRight', 'Ges_RightLeft'

%% define 4 vertical gestures:
% 'Ges_Up', 'Ges_Down', 'Ges_UpDown', 'Ges_DownUp'


%% a gesture is in fact comprised of a time series of hand positions. Given the initial 
% hand position, moving direction and speed of hand movement, one can calculate hand 
% positions at any successive points in time

% for horizatal gestures, e.g., 'Ges_LeftRight'
gesture_1 = 'Ges_LeftRight';
gest_time_series_1 = gest_creation_hori(gesture_1,radius_hand,hand_move_speed);

% for vertical gestures, e.g., 'Ges_DownUp'
gesture_2 = 'Ges_DownUp';
gest_time_series_2 = gest_creation_vert(gesture_2,hand_position_low,hand_position_high,hand_move_speed);


%% based on the time series hand positions, a time series solar cell current can be calculated,
% which is actully the gesture pattern we need
current_time_series_1 = current_calculation_hori(gest_time_series_1,radius_solar_cell,...
    radius_hand,light_intensity,solar_cell_current_density,hand_height);
current_time_series_2 = current_calculation_vert(gest_time_series_2,radius_hand,...
    radius_solar_cell,light_intensity,solar_cell_current_density);
figure(1)
plot(current_time_series_1, 'LineWidth',2);hold on
plot(current_time_series_2, 'LineWidth',2);hold on
set(gca,'FontSize',14);
xlabel('time (ms)')
ylabel('current (mA)')
legend('LeftRight','DownUp');

%% example 1: investigation of hand_move_speed, 0.2m/s and 0.3m/s for DownUp gesture
gest_time_series_speed_1 = gest_creation_vert(gesture_2,hand_position_low,hand_position_high,0.2);
current_time_series_speed_1 = current_calculation_vert(gest_time_series_speed_1,radius_hand,...
    radius_solar_cell,light_intensity,solar_cell_current_density);

gest_time_series_speed_2 = gest_creation_vert(gesture_2,hand_position_low,hand_position_high,0.3);
current_time_series_speed_2 = current_calculation_vert(gest_time_series_speed_2,radius_hand,...
    radius_solar_cell,light_intensity,solar_cell_current_density);

figure;
plot(current_time_series_speed_1, 'LineWidth',2);hold on
plot(current_time_series_speed_2, 'LineWidth',2);hold on
set(gca,'FontSize',14);
xlabel('time (ms)')
ylabel('current (mA)')
legend('speed = 0.2m/s','speed = 0.3m/s');
title('Example 1: impact of speed')


%% example 2: investigation of light_intensity, 3k lux and 5k lux for DownUp gesture
gest_time_series_intensity_1 = gest_creation_vert(gesture_2,hand_position_low,hand_position_high,hand_move_speed);
current_time_series_intensity_1 = current_calculation_vert(gest_time_series_intensity_1,radius_hand,...
    radius_solar_cell,3000,solar_cell_current_density);

gest_time_series_intensity_2 = gest_creation_vert(gesture_2,hand_position_low,hand_position_high,hand_move_speed);
current_time_series_intensity_2 = current_calculation_vert(gest_time_series_intensity_2,radius_hand,...
    radius_solar_cell,5000,solar_cell_current_density);

figure;
plot(current_time_series_intensity_1, 'LineWidth',2);hold on
plot(current_time_series_intensity_2, 'LineWidth',2);hold on
set(gca,'FontSize',14);
xlabel('time (ms)')
ylabel('current (mA)')
legend('intensity = 3k lux','intensity = 5k lux');
title('Example 2: impact of light intensity')










