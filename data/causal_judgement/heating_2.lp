% This example shows the value of valuation. 
% Valuation ensures the AE finds the successor relation, 
% instead of settling for 'there exists a number'.

senses(s2(c_temp, obj_rock_on_floor, obj_number_0), 1).
senses(s2(c_temp, obj_rock_on_floor, obj_number_1), 2).
senses(s2(c_temp, obj_rock_on_floor, obj_number_2), 3).
senses(s2(c_temp, obj_rock_on_floor, obj_number_3), 4).
senses(s2(c_temp, obj_rock_on_floor, obj_number_4), 5).
senses(s2(c_temp, obj_rock_on_floor, obj_number_5), 6).
validation(s2(c_temp, obj_rock_on_floor, obj_number_6), 7).

% Time
is_time(1..8).


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


