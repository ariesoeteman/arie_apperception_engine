
senses(s2(c_temp, obj_rock_on_floor, obj_number_0), 1).
senses(s2(c_temp, obj_rock_on_floor, obj_number_5), 2).
senses(s2(c_temp, obj_rock_on_floor, obj_number_2), 3).
senses(s2(c_temp, obj_rock_on_floor, obj_number_1), 4).
senses(s2(c_temp, obj_rock_on_floor, obj_number_2), 5).
senses(s2(c_temp, obj_rock_on_floor, obj_number_8), 6).
senses(s2(c_temp, obj_rock_on_floor, obj_number_9), 7).
% senses(s2(c_temp, obj_rock_on_floor, obj_number_1), 8).
% senses(s2(c_temp, obj_rock_on_floor, obj_number_2), 9).
% senses(s2(c_temp, obj_rock_on_floor, obj_number_4), 10).
% senses(s2(c_temp, obj_rock_on_floor, obj_number_5), 11).


senses(s(c_cold, obj_rock_on_floor), 1).
senses(s(c_hot, obj_rock_on_floor), 2).
senses(s(c_cold, obj_rock_on_floor), 3).
senses(s(c_cold, obj_rock_on_floor), 4).
senses(s(c_cold, obj_rock_on_floor), 5).
senses(s(c_hot, obj_rock_on_floor), 6).
senses(s(c_hot, obj_rock_on_floor), 7).

% senses(s(c_cold, obj_rock_on_floor), 8).
% senses(s(c_cold, obj_rock_on_floor), 9).
% senses(s(c_cold, obj_rock_on_floor), 10).
% senses(s(c_hot, obj_rock_on_floor), 11).


% permanent(s(c_treshold, obj_number_4)).

% senses(s2(c_temp, obj_y, obj_number_5), 2).

%senses(s(c_cold, obj_rock_on_floor), 3).
% senses(s2(c_temp, obj_y, obj_number_0), 3).

%senses(s(c_hot, obj_rock_on_floor), 4).
%senses(s2(c_temp, obj_rock_on_floor, obj_number_7), 4).

% senses(s2(c_temp, obj_y, obj_number_0), 5).

% is_object(obj_rock_on_floor).
% is_concept(cold).
% %is_concept(hot).
% is_concept(temp).

% is_concept(treshold).
% Time
is_time(1..8).

:-	holds(s(c_cold, X), T),
	holds(s(c_hot, X), T).

:- permanent(isa(t_rock, X)), is_time(T),
	not has_temp(X,T).

has_temp(X,T) :- holds(s(c_cold, X), T).
has_temp(X,T) :- holds(s(c_hot, X), T).

incompossible(s(c_cold, X), s(c_hot, X)) :-
	permanent(isa(t_rock, X)).

% % ∃! clause for temp : at most one
:-	holds(s2(c_temp, X, Y), T),
	holds(s2(c_temp, X, Y2), T),
	Y != Y2.

% ∃! clause for temp : at least one
:-	permanent(isa(t_rock, X)),
	is_time(T),
	not aux_c_temp(X, T).

aux_c_temp(X,T) :- holds(s2(c_temp, X,_),T).

% Incompossibility for c_temp
incompossible(s2(c_temp, X, Y), s2(c_temp, X, Y2)) :-
	permanent(isa(t_rock, X)),
	permanent(isa(t_number, Y)),
	permanent(isa(t_number, Y2)),
	Y != Y2.


