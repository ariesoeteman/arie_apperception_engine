

%------------------------------------------------------------------------------
% The cost of an interpretation depends on the complexity of the rules.
%
% We count the number of atoms appearing
%------------------------------------------------------------------------------

:~ rule_body(R, A). [1 @ 2, R, A]

:~ rule_arrow_head(R, A). [1 @ 2, R, A]

:~ rule_causes_head(R, A). [1 @ 2, R, A]

:~ init(A). [1 @ 2, A]

:~ gen_permanent(A). [1 @ 2, A]


%%
%% Clauses below are added for geometric logic
%%

:~ causal_judgement_body(R, A). [1 @ 2, R, A, 1]

:~ causal_judgement_head(R, A). [1 @ 2, R, A, 2]


% extra minimization on rules that contain an existential
:~ causal_judgement_head(R, A), rule_tochoose(R,_). [1 @ 1, R, A]


#minimize {C @ 3, GA, T : minimum_number_of_choices(GA, T, C), C != #sup}.

%%
%% Until here
%%

%------------------------------------------------------------------------------
% Forcing atoms to be true is the same cost as initial atoms.
%------------------------------------------------------------------------------

:~ force(A, T). [1 @ 1, A, T]

%------------------------------------------------------------------------------
% For accumulating statistics
%------------------------------------------------------------------------------

used_arrow_rule(R) :-
    is_arrow_rule(R),
    use_rule(R).

used_causes_rule(R) :-
    is_causes_rule(R),
    use_rule(R).

used_causal_judgement(R) :-
    is_causal_judgement(R),
    use_rule(R).