% The sensory sequence

senses(s(c_on, obj_sensor_a), 1).
senses(s(c_green, obj_sensor_a), 1).

senses(s(c_off, obj_sensor_a), 2).
senses(s(c_black, obj_sensor_a), 2).

senses(s(c_on, obj_sensor_a), 3).
senses(s(c_green, obj_sensor_a), 3).

senses(s(c_off, obj_sensor_a), 4).
senses(s(c_black, obj_sensor_a), 4).


senses(s(c_on, obj_sensor_a), 5).
senses(s(c_green, obj_sensor_a), 5).

is_time(1..6).

% At most one
:-
    holds(s(c_on, X), T),
    holds(s(c_off, X), T).

incompossible(s(c_on, X), s(c_off, X)) :-
    permanent(isa(t_light, X)).

% % At least one
% :-
%     permanent(isa(t_object, X)),
%     is_time(T),
%     not holds(s(c_on, X), T),
%     not holds(s(c_off, X), T).


% At most one
:-
    holds(s(c_green, X), T),
    holds(s(c_black, X), T).

incompossible(s(c_black, X), s(c_green, X)) :-
    permanent(isa(t_light, X)).


% % At least one
% :-
%     permanent(isa(t_object, X)),
%     is_time(T),
%     not holds(s(c_green, X), T),
%     not holds(s(c_black, X), T).
