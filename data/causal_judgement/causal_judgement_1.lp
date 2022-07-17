% The given sequence

senses(s(c_off, obj_sensor_a), 1).
senses(s2(c_r, obj_sensor_a, obj_sensor_b), 2).
senses(s(c_on, obj_sensor_a), 2).
senses(s(c_off, obj_sensor_a), 3).
senses(s2(c_r, obj_sensor_a, obj_sensor_b), 4).
senses(s(c_on, obj_sensor_a), 6).
senses(s2(c_r, obj_sensor_a, obj_sensor_b), 6).

is_object(obj_sensor_a).
is_object(obj_sensor_b).


is_time(1..8).

% Input exclusions
% Every object (of type 1) is either on or off
% X : sensor_1 → on(X) ⊕ off(X)
% At most one
:-
    holds(s(c_on, X), T),
    holds(s(c_off, X), T).

% At least one
:-
    permanent(isa(t_object_1, X)),
    is_time(T),
    not holds(s(c_on, X), T),
    not holds(s(c_off, X), T).


% At most one
:-
    holds(s(c_off, X), T),
    holds(s2(c_r, X, Y), T).


% Incompossibility
incompossible(s(c_on, X), s(c_off, X)) :-
   permanent(isa(t_object, X)).

incompossible(s2(c_r, X, Y), s(c_off, X)) :-
    permanent(isa(t_object, X)), permanent(isa(t_object, Y)).