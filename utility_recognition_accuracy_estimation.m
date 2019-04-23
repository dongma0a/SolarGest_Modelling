%% our model is able to simulate gestures under various conditions, this file
%% gives an example of using the model to estimate gesture recognition performance
%% without performing field experiments.

%% steps:
% 1. simulate a set of gestures under various conditions
% 2. perform signal processing, such as interpolation and zscore transformation
% 3. perform feature extraction if nessesary, e.g., statistical feature and DWT coefficient
% 4. perform calssification using KNN or other machine learning based classifers

clear all
close all

%% parameter define, defult values
radius_hand = 0.06; % set radius of hand to 6cm
radius_solar_cell = 0.02;  % set radius of solar cell to 2cm
light_intensity = 100;  % set light intensity to 1000lux
hand_position_low = 0.02; % set the minimum distance between solar cell and hand to 2cm
hand_position_high = 0.1; % set the maximum distance between solar cell and hand to 2cm
hand_displacement = hand_position_high - hand_position_low; % displacement of hand movement
hand_move_speed = 0.2; % set the speed of hand move to 0.2m/s
solar_cell_current_density = 7; % current density of solar cell, in mA/cm2

%% classify 4 vertical gestures and 1 horizontal gesture:
%  'Ges_Up', 'Ges_Down', 'Ges_UpDown', 'Ges_DownUp', 'Ges_LeftRight'


%% generate 100 for each gesture, under various settings
gesture_current_array = [];
N = 512; % interpolate all the simulated gestures to the same length
for gesture_type = 1:5
    switch gesture_type
        case 1
            gesture = 'Ges_Up';
        case 2
            gesture = 'Ges_Down';
        case 3
            gesture = 'Ges_UpDown';
        case 4
            gesture = 'Ges_DownUp';
        case 5
            gesture = 'Ges_LeftRight';
    end
    for num = 1:100
        % add some variation on the parameters
        hand_move_speed = 0.1 + 0.3 * rand(1); % between 0.1 - 0.4 m/s 
        light_intensity = 50 + 10000 * rand(1); % between 50 - 10050 lux;
        radius_hand = 0.04 + 0.04 * rand(1); % between 4 - 8 cm;
        hand_position_high = 0.1 + 0.1 * rand(1); % between 10 - 20 cm;
        hand_position_low = 0.01 + 0.07 * rand(1); % between 1 - 8 cm;
        hand_height = 0.02 + 0.08 * rand(1); % between 2 - 10 cm
        
        if gesture_type ~= 5
            gest_time_series = gest_creation_vert(gesture,hand_position_low,...
                hand_position_high,hand_move_speed);
            current_time_series = current_calculation_vert(gest_time_series,...
                radius_hand,radius_solar_cell,light_intensity,solar_cell_current_density);
        else
            gest_time_series = gest_creation_hori(gesture,radius_hand,hand_move_speed);
            current_time_series = current_calculation_hori(gest_time_series,radius_solar_cell,...
                radius_hand,light_intensity,solar_cell_current_density,hand_height);
        end
        
        % interpolate the gesture time series to the same length (N = 512) for
        % classification. Readers can try different interpolation methods, like
        % spine interpolation using interpl function.
        current_time_series_interp = interpft(current_time_series, N);
        
        % add a white Gaussion noise that cannot be avoided in real measurement on the signal.
        % the amplitude of the noise should be measured using your own prototype
        current_time_series_interp = current_time_series_interp + 1 * randn(1,N);
        
        % using z-score transformation to normailze, can significantly
        % improve classification accuracy
%         current_time_series_interp = zscore(current_time_series_interp);
        
        % add a label for current gesture
        current_time_series_interp(N+1) = gesture_type;
        gesture_current_array = [gesture_current_array; current_time_series_interp];
    end
end

%% check the simulated gesture pattern
% figure;
% plot(gesture_current_array(101,1:512));

%% calssification using KNN
% here, feature extraction is not implemented, but a statistics based
% feature extraction can be tried using the provided FeatureExtractionAll.m
simulated_gesture = gesture_current_array(:,1:N);
label_gesture = gesture_current_array(:,N+1);
Mdl = fitcknn(simulated_gesture,label_gesture,'NumNeighbors',10,...
    'Distance','euclidean','Standardize',1); 
CVKNNMdl = crossval(Mdl);
% using cross validation to obtain the classification accuracy
classification_accuracy = 1-kfoldLoss(CVKNNMdl)

