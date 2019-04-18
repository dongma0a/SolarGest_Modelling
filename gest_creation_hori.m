function gest_time_series = gest_creation_hori(gesture,radius_hand,hand_move_speed)
%% this function caculates time series of hand positions for a horizontal gesture.
% INPUT
%   gesture               - a hirizontal gesture name, in string, e.g., 'Left'
%   radius_hand           - radius of hand
%   hand_move_speed       - average speed of hand movement, in m/s
%
% OUTPUT
%   gest_time_series      - generated time series of hand positions

%% the initial position corresponds to the case where edge of hand (either left or right)
%  aligned to the center of solar cell, for Ges_Left/Ges_LeftRight and
%  Ges_Right/Ges_RightLeft, repectively.


%% consider a single direction movement, either left or right
move_dist = 2 * radius_hand; % movement distance is the diameter of hand
move_time = move_dist/hand_move_speed; % average time required  

%% to be practical, we use hand_move_speed as the average speed, but simulate the signle- 
% direction movement to be a uniformly accelerated motion in the first half time/way and 
% a uniformly retarded motion in the second half time/way, respectively. 
acceleration = 4 * move_dist/(move_time)^2;

% first half way/time
t1 = 0:0.001:0.5*move_time; % using 0.001s/(1000Hz) resolution
left_half_1 = 0.5*acceleration*t1.^2;

% second hadf way/time
t2 = 0:0.0021:0.5*move_time;
left_half_2 = move_dist/2+ (acceleration*0.5*move_time*t2 - 0.5*acceleration*t2.^2);

% combine left_half_1 and left_half_1 to be a single left movement
left = [left_half_1 left_half_2];
% right move is the recerse of left
right = left(end:-1:1);

switch gesture       
    case 'Ges_Left'  
        gest_time_series = [left];
    case 'Ges_Right'
        gest_time_series = [right];
    case 'Ges_LeftRight'
        gest_time_series = [left right];
    case 'Ges_RightLeft'
        gest_time_series = [right left];
end
end
   
                
 
