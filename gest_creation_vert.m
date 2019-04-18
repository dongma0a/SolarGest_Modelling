function gest_time_series = gest_creation_vert(gesture,hand_position_low,hand_position_high,hand_move_speed)
%% this function caculates time series of hand positions for a vertical gesture.
% INPUT
%   gesture               - a vertical gesture name, in string, e.g., 'Up'
%   hand_position_low     - the minimum distance between solar cell and
%                           hand during the vertical movement
%   hand_position_high    - the maximum distance between solar cell and
%                           hand during the vertical movement
%   hand_move_speed       - average speed of hand movement, in m/s
%
% OUTPUT
%   gest_time_series      - generated time series of hand positions

%% during a vertical movement, we assume hand and solar cell are always center-aligned.

move_time = (hand_position_high - hand_position_low)/hand_move_speed;% average time required 

%% to be practical, we use hand_move_speed as the average speed, but simulate the signle- 
%  direction movement to be a uniformly accelerated motion in the first half time/way and 
%  a uniformly retarded motion in the second half time/way, respectively. 
acceleration = 4*(hand_position_high - hand_position_low)/(move_time)^2;

% first half way/time
t1 = 0:0.001:0.5*move_time; % using 0.001s/(1000Hz) resolution
down_half_1 = hand_position_high - 0.5*acceleration*t1.^2;
up_half_1 = hand_position_low + 0.5*acceleration*t1.^2;

% second half way/time
t2 = 0:0.001:0.5*move_time;
down_half_2 = (hand_position_high-(hand_position_high-hand_position_low)/2) - (acceleration*0.5*move_time*t2 - 0.5*acceleration*t2.^2);
up_half_2 = hand_position_low + (hand_position_high-hand_position_low)/2 + (acceleration*0.5*move_time*t2 - 0.5*acceleration*t2.^2);

% combine
down = [down_half_1 down_half_2];
up = [up_half_1 up_half_2];


switch gesture       
    case 'Ges_Down'  
        gest_time_series = [down];
    case 'Ges_Up'
        gest_time_series = [up];
    case 'Ges_DownUp'
        gest_time_series = [down up];
    case 'Ges_UpDown'
        gest_time_series = [up down];
end
   
                
 
