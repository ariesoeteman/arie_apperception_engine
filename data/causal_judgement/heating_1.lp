%% The sensory sequence for the final example in Ch.3 of the thesis

senses(s2(c_temp, obj_rock_on_floor, obj_number_0), 1).
senses(s2(c_temp, obj_rock_on_floor, obj_number_5), 2).
senses(s2(c_temp, obj_rock_on_floor, obj_number_2), 3).
senses(s2(c_temp, obj_rock_on_floor, obj_number_1), 4).
senses(s2(c_temp, obj_rock_on_floor, obj_number_5), 5).
senses(s2(c_temp, obj_rock_on_floor, obj_number_8), 6).

validation(s2(c_temp, obj_rock_on_floor, obj_number_3), 7).
validation(s2(c_temp, obj_rock_on_floor, obj_number_2), 8).
validation(s2(c_temp, obj_rock_on_floor, obj_number_7), 9).
validation(s2(c_temp, obj_rock_on_floor, obj_number_9), 10).


exogenous(s(c_shinedon, obj_rock_on_floor), 1).
exogenous(s(c_notshinedon, obj_rock_on_floor), 2).
exogenous(s(c_notshinedon, obj_rock_on_floor), 3).

exogenous(s(c_shinedon, obj_rock_on_floor), 4).
exogenous(s(c_shinedon, obj_rock_on_floor), 5).

exogenous(s(c_notshinedon, obj_rock_on_floor), 6).
exogenous(s(c_notshinedon, obj_rock_on_floor), 7).
exogenous(s(c_shinedon, obj_rock_on_floor), 8).
exogenous(s(c_shinedon, obj_rock_on_floor), 9).

exogenous(s(c_shinedon, obj_rock_on_floor), 10).



is_object(obj_rock_on_floor).

is_time(1..11).


% ∃! clause for temp : at most one
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


% ∃! clause for treshold : at most one
:-	holds(s(c_treshold, X1), _),
	holds(s(c_treshold, X2), _),
	X1 != X2.

incompossible(s(c_shinedon, X), s(c_notshinedon, X)) :-
 	permanent(isa(t_rock, X)).