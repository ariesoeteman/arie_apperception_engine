item(1..2).
score(1,5).
score(1,4).
score(2,3).
score(2,6).
1 { select(I) : item(I) } 1.
min_score(I,M) :- item(I), M = #min {S : score(I,S)}.

#minimize { S @ 3 ,I : select(I), min_score(I,S) }.
#show select/1.

valuation(a,1).
valuation(b,1).
valuation(c,2).

valuation(d,3).
% :- valuation(GC, T), not possible_predictions(GC, T, _).


possible_predictions(a, 1, 3).
possible_predictions(a, 1, 4).

possible_predictions(b, 1, 5).
possible_predictions(b, 1, 6).
possible_predictions(c, 2, 7).
possible_predictions(c, 2, 8).



minimum_number_of_choices(GA, T, C) :-
    valuation(GA, T), C = #min { P : possible_predictions(GA, T, P)}.

#minimize {C @ 3, GA, T :  minimum_number_of_choices(GA, T, C)}.

#show minimum_number_of_choices/3.
