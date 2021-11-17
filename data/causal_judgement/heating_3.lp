% senses(s2(c_shines, obj_sun, obj_rock_on_floor), 1).
% senses(s2(c_notshines, obj_sun, obj_rock_on_floor), 2).
% senses(s2(c_notshines, obj_sun, obj_rock_on_floor), 3).

% senses(s2(c_shines, obj_sun, obj_rock_on_floor), 4).
% senses(s2(c_notshines, obj_sun, obj_rock_on_floor), 5).


% senses(s2(c_shines, obj_sun, obj_rock_on_floor), 6).
% senses(s2(c_shines, obj_sun, obj_rock_on_floor), 7).
% senses(s2(c_notshines, obj_sun, obj_rock_on_floor), 8).


senses(s2(c_temp, obj_rock_on_floor, obj_number_0), 1).
senses(s2(c_temp, obj_rock_on_floor, obj_number_4), 2).
senses(s2(c_temp, obj_rock_on_floor, obj_number_8), 3).
senses(s2(c_temp, obj_rock_on_floor, obj_number_0), 4).
senses(s2(c_temp, obj_rock_on_floor, obj_number_6), 5).
senses(s2(c_temp, obj_rock_on_floor, obj_number_9), 6).

valuation(s2(c_temp, obj_rock_on_floor, obj_number_0), 7).
valuation(s2(c_temp, obj_rock_on_floor, obj_number_3), 8).
valuation(s2(c_temp, obj_rock_on_floor, obj_number_5), 9).

% HARDER
senses(s(c_shinedon, obj_rock_on_floor), 1).
senses(s(c_shinedon, obj_rock_on_floor), 2).
senses(s(c_notshinedon, obj_rock_on_floor), 3).

senses(s(c_shinedon, obj_rock_on_floor), 4).
senses(s(c_shinedon, obj_rock_on_floor), 5).
senses(s(c_notshinedon, obj_rock_on_floor), 6).

senses(s(c_shinedon, obj_rock_on_floor), 7).
senses(s(c_shinedon, obj_rock_on_floor), 8).
senses(s(c_notshinedon, obj_rock_on_floor), 9).



% EASIER
% senses(s(c_shinedon, obj_rock_on_floor), 1).

% senses(s(c_shinedon, obj_rock_on_floor), 2).


% senses(s(c_notshinedon, obj_rock_on_floor), 3).

% % senses(s(c_shinedon, obj_rock_on_floor), 4).
% senses(s(c_shinedon, obj_rock_on_floor), 5).
% senses(s(c_notshinedon, obj_rock_on_floor), 6).

% % senses(s(c_shinedon, obj_rock_on_floor), 7).
% senses(s(c_shinedon, obj_rock_on_floor), 8).
% senses(s(c_notshinedon, obj_rock_on_floor), 9).











% senses(s(c_cold, obj_rock_on_floor), 3).
% senses(s(c_cold, obj_rock_on_floor), 4).
% senses(s(c_cold, obj_rock_on_floor), 5).
% senses(s(c_hot, obj_rock_on_floor), 6).
% senses(s(c_hot, obj_rock_on_floor), 7).




% senses(s(c_cold, obj_rock_on_floor), 1).
% senses(s(c_hot, obj_rock_on_floor), 2).
% senses(s(c_cold, obj_rock_on_floor), 3).
% senses(s(c_cold, obj_rock_on_floor), 4).
% senses(s(c_cold, obj_rock_on_floor), 5).
% senses(s(c_hot, obj_rock_on_floor), 6).
% senses(s(c_hot, obj_rock_on_floor), 7).

% senses(s(c_cold, obj_rock_on_floor), 8).
% senses(s(c_cold, obj_rock_on_floor), 9).
% senses(s(c_cold, obj_rock_on_floor), 10).
% senses(s(c_hot, obj_rock_on_floor), 11).

is_time(1..10).

% :-	holds(s(c_cold, X), T),
% 	holds(s(c_hot, X), T).

% :- permanent(isa(t_rock, X)), is_time(T),
% 	not has_temp(X,T).

% has_temp(X,T) :- holds(s(c_cold, X), T).
% has_temp(X,T) :- holds(s(c_hot, X), T).

% incompossible(s(c_cold, X), s(c_hot, X)) :-
% 	permanent(isa(t_rock, X)).


incompossible(s(c_shinedon, X), s(c_notshinedon, X)) :-
 	permanent(isa(t_rock, X)).

:-	holds(s(c_shinedon, X), T),
	holds(s(c_notshinedon, X), T).


:- permanent(isa(t_rock, X)), not holds(s(c_shinedon, X), T), not holds(s(c_notshinedon, X), T), is_time(T).




% incompossible(s2(c_shines, Y, X), s2(c_notshines, Y, X)) :-
%  	permanent(isa(t_rock, X)), permanent(isa(t_shiner, Y)).

% :-	holds(s2(c_shines, X, Y), T),
% 	holds(s2(c_notshines, X, Y), T).

% :- permanent(isa(t_rock, X)), permanent(isa(t_shiner, Y)), not holds(s2(c_shines, Y, X), T), not holds(s2(c_notshines, Y, X), T).



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


