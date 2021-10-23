
%------------------------------------------------------------------------------
% The sensory given.
%------------------------------------------------------------------------------

%----------------------------------------
%   Time            Sensor a    Sensor b
%                            
%   1               ?           ?
%   2               off         a
%   3               on          a
%   4               off         ?
%   5               ?           ?
%   6               off         a
%   7               ?           ?
%----------------------------------------

% The given sequence

%senses(s2(c_nextto, obj_sensor_a, obj_sensor_b), 2).
senses(s(c_off, obj_sensor_a), 1).
senses(s2(c_r, obj_sensor_a, obj_sensor_b), 2).
senses(s(c_on, obj_sensor_a), 2).
senses(s(c_off, obj_sensor_a), 3).
senses(s2(c_r, obj_sensor_a, obj_sensor_b), 4).
senses(s(c_on, obj_sensor_a), 6).
senses(s2(c_r, obj_sensor_a, obj_sensor_b), 6).

% Elements
%MOET JE VAN ALLES ZEGGEN DAT HET EEN OBJECT IS??
% WAT GEBEURT ER ALS JE DIT NIET DOET?
%Vanuit is_object(x) leidt je 'permanent(isa(t_object, x)' af

% IK DENK DAT JE DIT GEBRUIKT VOOR SPATIAL UNITY CONDITION?
is_object(obj_sensor_a).
is_object(obj_sensor_b).
%is_object(grid).
% is_concept wordt automatisch gegenereerd in 'interpretation'

% is_concept(c_on).
% is_concept(c_off).
% is_concept(c_r).
% is_concept(c_nextto).


is_time(1..8).

% Input exclusions
% Every object (of type 1) is either on or off
% X : sensor_1 → on(X) ⊕ off(X)
% At most one
:-
    holds(s(c_on, X), T),
    holds(s(c_off, X), T).

% At least one
% :-
%     permanent(isa(t_object_1, X)),
%     is_time(T),
%     not holds(s(c_on, X), T),
%     not holds(s(c_off, X), T).


% At most one
:-
    holds(s(c_off, X), T),
    holds(s2(c_r, X, Y), T).


% Incompossibility
% WAAR KOMEN DEZE PERMANENTS VANDAAN??
incompossible(s(c_on, X), s(c_off, X)) :-
   permanent(isa(t_object, X)).

incompossible(s2(c_r, X, Y), s(c_off, X)) :-
    permanent(isa(t_object, X)), permanent(isa(t_object, Y)).



% Input exclusions
% Every sensor (of type 2) is either a, b, or c
% X : sensor_2 → a(X) ⊕ b(X) ⊕ c(X)


% WAT IS DIT?
exclusion_output("c_on+c_off").
exclusion_output("c_off+c_r").
