%------------------------------------------------------------------------------
% eval
%------------------------------------------------------------------------------


%%% VAN MIJ

eval_causal_judgement_body(R, Subs, T) :-
    rule_subs(R, Subs),
    is_time(T),
    eval_atom(V, Subs, T) : causal_judgement_body(R, V).

%%%


eval_body(R, Subs, T) :-
    rule_subs(R, Subs),
    is_time(T),
    eval_atom(V, Subs, T) : rule_body(R, V).

eval_atom(VA, Subs, T) :-
    ground_atom(VA, GA, Subs),
    holds(GA, T).

eval_atom(VA, Subs, T) :-
    ground_atom(VA, GA, Subs),
    permanent(GA),
    is_time(T).

ground_atom(s(C, V), s(C, Obj), Subs) :-
    is_var_fluent(s(C, V)),
    subs(Subs, V, Obj).

ground_atom(s2(C, V, V2), s2(C, Obj, Obj2), Subs) :-
    is_var_fluent(s2(C, V, V2)),
    subs(Subs, V, Obj),
    subs(Subs, V2, Obj2).

ground_atom(isa(C, V), isa(C, Obj), Subs) :-
    is_var_permanent(isa(C, V)),
    subs(Subs, V, Obj).

ground_atom(isa2(C, V, V2), isa2(C, Obj, Obj2), Subs) :-
    is_var_permanent(isa2(C, V, V2)),
    subs(Subs, V, Obj),
    subs(Subs, V2, Obj2).

%------------------------------------------------------------------------------
% holds
%------------------------------------------------------------------------------

holds(s(C, Obj), T) :-
    init(s(C, Obj)),
    init_time(T).

holds(s2(C, Obj, Obj2), T) :-
    init(s2(C, Obj, Obj2)),
    init_time(T).
    
% frame axiom
holds(S, T+1) :-
    holds(S, T),
    is_time(T+1),
    not is_static_atom(S),
    not -holds(S, T+1).


% INCOMPOSSIBILITY ZORGT VOOR UITZONDERINGEN OP FRAME AXIOM!!
-holds(S, T) :-
    holds(S2, T),
    incompossible(S, S2).

% causes update
holds(GC, T+1) :-     
    rule_head_causes(R, VC),
    eval_body(R, Subs, T),
    ground_atom(VC, GC, Subs),
    is_time(T+1).

% arrow update
holds(GA, T) :-
    rule_subs(R, Subs),
    rule_arrow_head(R, VA),
    ground_atom(VA, GA, Subs),
    eval_body(R, Subs, T).



% holds(GC, T+1) :-     
%     causal_judgement_head(R, VC),
%     eval_body(R, Subs, T),
%     ground_atom(VC, GC, Subs),
%     is_time(T+1).


holds(GC, T+1) :-
    rule_choice(R, T, Subs),
    eval_causal_judgement_body(R, Subs, T),
    causal_judgement_head(R, VC),
    not is_var_permanent(VC),
    ground_atom(VC, GC, Subs),
    is_time(T+1).

% Substitution satisfies a single variable choice (for the application of this rule, per time)
rule_choice(R, T, Subs) :-
    possible_subs(R, Subs), is_time(T),
    not diff_choice(R, T, Subs).

%% If body is satisfied, then there must exist a possible choice for each ground substitution
:- eval_causal_judgement_body(R, Subs, T),
not possible_subs(R, Diff) : same_ground(R, Subs, Diff).

% diff_choice(R, T, Subs1):-
%     rule_choice(R, T, Subs2),
%     rule_div3(R, Ground, Tochoose, _), 
%     contains_var(Tochoose, V1), 
%     subs(Subs1, V1, O1), subs(Subs2, V1, O2), O1 != O2,
%     subs(Subs2, V2, O3) : contains_var(Ground, V2), subs(Subs1, V2, O3).


diff_choice(R, T, Diff):-
    rule_choice(R, T, Subs), possible_subs(R, Diff),
    rule_tochoose(R,V1), subs(Subs, V1, O1), subs(Diff, V1, O2), O1 != O2,
    subs(Diff, V2, O3) : rule_ground(R,V2), subs(Subs, V2, O3).


% A choice is only possible if it does not conflict with the permanent knowledge
possible_subs(R,Subs) :- 
    rule_subs(R,Subs), is_causal_judgement(R), use_rule(R),
    permanent(GH) : causal_judgement_head(R, Head), ground_atom(Head, GH, Subs), is_var_permanent(Head).


%% HIERONDER GA IK PROBEREN ZEKERHEID OP VALUATION ATOMS TE BEVORDEREN

% DEZE Kan trivial '1-prediction' geven:
% y=0, z=0, s2(c_temp, var_x, var_y) -> s2(c_temp, var_x, var_z)
possible_predictions(GA, T, 1) :-
    valuation(GA, T),
    rule_arrow_head(R, VA),
    ground_atom(VA, GA, Subs),
    eval_body(R, Subs, T),
    not head_in_body(R, Subs).

possible_predictions(GC, T, 1) :-
    valuation(GC, T),
    rule_head_causes(R, VC),
    ground_atom(VC, GC, Subs),
    eval_body(R, Subs, T-1).



%%%%%%%%%%%%%%% AANPAK MET DIFF_ATOMS

% same_ground also checks that Subs and Diff are 'possible' for R
different_option(R, Subs, Val, T, Notval) :-
    valuation_explanation(R, Subs, Val, T),
    causal_judgement_head(R, VC),
    same_ground(R, Subs, Diff),
    eval_body(R,Diff,T-1),
    ground_atom(VC, Val, Subs),
    ground_atom(VC, Notval, Diff),
    Val != Notval.


possible_predictions(Val, T, P) :-
    valuation_explanation(R, Subs, Val, T),
    P = #count {Notval : different_option(R, Subs, Val, T, Notval)}.  


%%%% DIT ALLEMAAL WEG

% %% INDEPENDENT CHOICES
% number_of_choices_for_var(V, C) :-
%     is_causal_judgement(R), use_rule(R), rule_independent(R,V),
%     singleton_group(VG, V),
%     C = #count { S : subs_group(VG, S)}.

% number_of_independent_vars(R, C) :-
%     is_causal_judgement(R), use_rule(R),
%     C = #count { V : rule_independent(R, V)}.


% 1 {independent_variable_order_for_rule (R, V, 1) : rule_independent(R,V)} 1 :- 
%     is_causal_judgement(R), use_rule(R), number_of_independent_vars(R,C), C > 0.
    
% 1{independent_variable_order_for_rule (R, V, I+1) : rule_independent(R,V)}1 :- 
%     independent_variable_order_for_rule(R, _, I), I < C, number_of_independent_vars(R,C).

% :- independent_variable_order_for_rule(R,V,I1), independent_variable_order_for_rule(R,V,I2), I1 != I2.


% number_of_rule_independent_choices(R, 0, 1) :- is_causal_judgement(R), use_rule(R).

% number_of_rule_independent_choices(R, I, X) :-
%     number_of_rule_independent_choices(R, I-1, Y), independent_variable_order_for_rule(R,V,I),
%     number_of_choices_for_var(V, N), X = Y*N.

% number_of_independent_choices(R, I) :- number_of_rule_independent_choices(R, C, I), number_of_independent_vars(R, C).

% possible_predictions(GC, T, Predictions) :-
%     valuation_explanation(R, Subs, GC, T), not head_in_body(R, Subs),
%     P = #count {Diff : different_possible_choice(R, Diff, Subs)}, number_of_independent_choices(R, C),
%     Q = P+C, Predictions = Q / C.    

% different_possible_choice(R, Diff, Subs) :-
%     valuation_explanation(R, Subs, GC, _),
%     possible_subs(R, Diff),
%     rule_tochoose(R,V1), subs(Subs, V1, O1), subs(Diff, V1, O2), O1 != O2,
%     subs(Diff, V2, O3) : rule_ground(R,V2), subs(Subs, V2, O3).    

%%%%% Tot hier WEG


%%% DIT TELT NIET HET AANTAL POSSIBLE INDEPENDENT CHOICES.... dus C is te hoog?


% DERDE POGING (use_rule kan weg toch?)
valuation_explanation(R, Subs, GC, T) :-
    valuation(GC, T),
    causal_judgement_head(R, VC),
    ground_atom(VC, GC, Subs),
    eval_causal_judgement_body(R, Subs, T-1),
    possible_subs(R, Subs).

head_in_body(R,Subs) :-
    causal_judgement_head(R, VC),
    rule_body(R, VA),
    ground_atom(VC, GC, Subs),
    ground_atom(VA, GC, Subs).


% possible_predictions(GC, T, P+1) :-
%     valuation_explanation(R, Subs, GC, T),
%     P = #count {Diff : choose_different_possible_choice(R, Diff, Subs)}.    



% possible_predictions(GC, T, P+1) :-
%     valuation(GC, T),
%     causal_judgement_head(R,VC),
%     use_rule(R),
%     ground_atom(VC, GC, Subs),
%     eval_causal_judgement_body(R, Subs, T-1),
%     possible_subs(R, Subs),
%     P = #count {Diff : choose_different_possible_choice(R, Diff, Subs)}.

% different_possible_choice(R, Diff, Subs) :-
%     valuation(GC, T),
%     causal_judgement_head(R,VC),
%     use_rule(R),
%     ground_atom(VC, GC, Subs),
%     eval_causal_judgement_body(R, Subs, T-1),
%     possible_subs(R, Subs),
%     possible_subs(R, Diff),
%     rule_tochoose(R,V1), subs(Subs, V1, O1), subs(Diff, V1, O2), O1 != O2,
%     subs(Diff, V2, O3) : rule_ground(R,V2), subs(Subs, V2, O3).    

% {choose_different_possible_choice(R, Diff, Subs)} :- different_possible_choice(R, Diff, Subs).

% % If two substitutions make the same 'choice', they cannot both be counted as 'different choice'
% :-  choose_different_possible_choice(R, Diff1, Subs), 
%     choose_different_possible_choice(R, Diff2, Subs),
%     Diff1 != Diff2,
%     subs(Diff2, V, O) : rule_tochoose(R, V), subs(Diff1, V, O).


% :-  different_possible_choice(R, Diff, Subs),
%     not choose_different_possible_choice(R, Diff2, Subs) : different_possible_choice(R, Diff2, Subs), same_choose(R, Diff, Diff2).

% same_choose(R, Diff1, Diff2) :-
%     is_causal_judgement(R),
%     use_rule(R),
%     % valuation(GC, T),
%     % causal_judgement_head(R,VC),
%     % ground_atom(VC, GC, _),
%     possible_subs(R, Diff1),
%     possible_subs(R, Diff2),
%     subs(Diff1, V, O) : rule_tochoose(R,V), subs(Diff2, V, O).

same_ground(R, Subs1, Subs2) :-
    is_causal_judgement(R),
    use_rule(R),
    possible_subs(R, Subs1),
    possible_subs(R, Subs2),
    subs(Subs2, V, O) :rule_ground(R, V), subs(Subs1, V, O).

%%% OPLOSSING TOT HIER


% {different_possible_choice(R, Diff, Subs)} :-
%     valuation(GC, T),
%     causal_judgement_head(R,VC),
%     ground_atom(VC, GC, Subs),
%     eval_causal_judgement_body(R, Subs, T-1),
%     possible_subs(R, Subs),
%     possible_subs(R, Diff),
%     rule_tochoose(R,V1), subs(Subs, V1, O1), subs(Diff, V1, O2), O1 != O2,
%     subs(Diff, V2, O3) : rule_ground(R,V2), subs(Subs, V2, O3).    


% % If two diff's make the same choice, they should not both be counted
% :-  different_possible_choice(R, Diff1, Subs), 
%     different_possible_choice(R, Diff2, Subs),
%     subs(Diff2, V, O) : rule_tochoose(R, V), subs(Diff1, V, O).

% :-  same_ground_different_choose(R, Subs, Diff),
%     not different_possible_choice(R, Diff, Subs) : same_ground_different_choose(R, Subs, Diff2), same_choose(R, Diff, Diff2).
%     % same_ground_and_choose(R, Diff, Diff2).


% same_ground_different_choose(R, Subs, Diff) :- 
%     % is_causal_judgement(R),
%     % use_rule(R),
%     valuation(GC, T),
%     causal_judgement_head(R,VC),
%     ground_atom(VC, GC, Subs),
%     eval_causal_judgement_body(R, Subs, _),
%     possible_subs(R, Subs),
%     possible_subs(R, Diff),
%     rule_tochoose(R,V1), subs(Subs, V1, O1), subs(Diff, V1, O2), O1 != O2,    
%     subs(Diff, V, O3) : rule_ground(R,V), subs(Subs, V, O3).    


% HIER STOPT EXPERIMENT

minimum_number_of_choices(GA, T, C) :-
    valuation(GA, T), C = #min { P : possible_predictions(GA, T, P)}.

% Valuation atoms should be at least possible to predict:
:- valuation(GA, T), not possible_predictions(GA, T, _).

%%% Is het bovenstaande niet netter met 'valuation_explanation??'


% exogenous action
holds(GA, T) :- exogenous(GA, T).

%------------------------------------------------------------------------------
% Utility functions
%------------------------------------------------------------------------------

is_rule(R) :-
    rule_var_group(R, _).

rule_subs(R, Subs) :-
    rule_var_group(R, VG),
    subs_group(VG, Subs).

atom_in_rule(A, R) :- 
    rule_body(R, A).

atom_in_rule(A, R) :- 
    rule_arrow_head(R, A).

atom_in_rule(A, R) :- 
    rule_causes_head(R, A).

%My additions:

var_in_rule(A, R) :- 
    var_in_caus_judg_head(A, R).

var_in_rule(A, R) :- 
    var_in_caus_judg_body(A, R).


atom_in_caus_judg_head(A,R) :-
    causal_judgement_head(R,A).

atom_in_caus_judg_body(A,R) :-
    causal_judgement_body(R,A).

var_in_caus_judg_body(V, R) :-
     atom_in_caus_judg_body(s(_, V), R).

var_in_caus_judg_body(V, R) :-
     atom_in_caus_judg_body(s2(_, V, _), R).

var_in_caus_judg_body(V, R) :-
     atom_in_caus_judg_body(s2(_, _, V), R).

var_in_caus_judg_body(V, R) :-
     atom_in_caus_judg_body(isa(_, V), R).

var_in_caus_judg_body(V, R) :-
     atom_in_caus_judg_body(isa2(_, V, _), R).

var_in_caus_judg_body(V, R) :-
     atom_in_caus_judg_body(isa2(_, _, V), R).


var_in_caus_judg_head(V, R) :-
     atom_in_caus_judg_head(s(_, V), R).

var_in_caus_judg_head(V, R) :-
     atom_in_caus_judg_head(s2(_, V, _), R).

var_in_caus_judg_head(V, R) :-
     atom_in_caus_judg_head(s2(_, _, V), R).

var_in_caus_judg_head(V, R) :-
     atom_in_caus_judg_head(isa(_, V), R).

var_in_caus_judg_head(V, R) :-
     atom_in_caus_judg_head(isa2(_, V, _), R).

var_in_caus_judg_head(V, R) :-
     atom_in_caus_judg_head(isa2(_, _, V), R).

%%%%

is_var(V) :- 
    subs(_, V, _).

var_in_rule(V, R) :-
     atom_in_rule(s(_, V), R).

var_in_rule(V, R) :-
     atom_in_rule(s2(_, V, _), R).

var_in_rule(V, R) :-
     atom_in_rule(s2(_, _, V), R).

var_in_rule(V, R) :-
     atom_in_rule(isa(_, V), R).

var_in_rule(V, R) :-
     atom_in_rule(isa2(_, V, _), R).

var_in_rule(V, R) :-
     atom_in_rule(isa2(_, _, V), R).

is_var_group(VG) :- 
    subs_group(VG, _).

is_gen_rule(R) :- is_causes_rule(R).
is_gen_rule(R) :- is_arrow_rule(R).

is_var_fluent(S) :- var_fluent(S, _).

is_var_permanent(S) :- var_permanent(S, _).

is_var_atom(S) :- is_var_fluent(S).
is_var_atom(S) :- is_var_permanent(S).

var_atom_group(VA, VG) :- var_fluent(VA, VG).    
var_atom_group(VA, VG) :- var_permanent(VA, VG).    

cause_head(s(C, V)) :-
    is_var_fluent(s(C, V)),
    not is_static_concept(C).

cause_head(s2(C, V, V2)) :-
    is_var_fluent(s2(C, V, V2)),
    not is_static_concept(C).

permanent(A) :- gen_permanent(A).

rule_causes_head(R, VC) :-
    rule_head_causes(R, VC).

is_ground_atom(G) :- ground_atom(_, G, _).

is_static_atom(s(C, X)) :-
    is_ground_atom(s(C, X)),
    is_static_concept(C).

is_static_atom(s2(C, X, Y)) :-
    is_ground_atom(s2(C, X, Y)),
    is_static_concept(C).

%------------------------------------------------------------------------------
% Incompossibility
%------------------------------------------------------------------------------

incompossible(X, Y) :- 
    incompossible(Y, X).

% Two var atoms are potentially incompossible
% if there is *some* substitution on which their groundings are incompossible.
potentially_incompossible_var_atoms(VA, VA2) :-
    ground_atom(VA, GA, Subs),    
    ground_atom(VA2, GA2, Subs),
    incompossible(GA, GA2).    

% This predicate is true if the var atoms are incompossible under
% *every* substitution (not just one).
%
% This only applies to unary var atoms.
definitely_incompossible_var_atoms(s(p, V), s(q, V)) :-
    is_var_atom(s(p, V)),
    is_var_atom(s(q, V)),
    incompatible_unary_predicates(p, q).

incompatible_unary_predicates(P, Q) :- 
    incompatible_unary_predicates(Q, P).

%------------------------------------------------------------------------------
% Pure concepts
%------------------------------------------------------------------------------

is_concept(C) :- is_type(C).

% NB t_object means external substance (i.e. situated in space)
is_type(t_object).

%------------------------------------------------------------------------------
% Distinguished time-steps
%------------------------------------------------------------------------------

init_time(T) :- 
    is_time(T),    
    not is_time(T-1).

last_time(T) :- 
    is_time(T),    
    not is_time(T+1).

%------------------------------------------------------------------------------
% Sub-types
%------------------------------------------------------------------------------

permanent(isa(T, X)) :-
    permanent(isa(T2, X)),
    sub_type(T2, T).
    
%------------------------------------------------------------------------------
% Var ordering
%------------------------------------------------------------------------------

less_var(V1, V2) :-
    var_type(V1, T),
    var_type(V2, T),
    V1 < V2.

appears_before(V1, V2, R) :-
    rule_body(R, s(_, V1)),
    var_in_body(V2, R).

appears_before(V1, V2, R) :-
    rule_body(R, s2(_, V1, V3)),
    var_in_body(V2, R),
    V2 != V3.

appears_before(V1, V2, R) :-
    rule_body(R, s2(_, V3, V1)),
    var_in_body(V2, R),
    V2 != V3.

appears_before(V1, V2, R) :-
    rule_body(R, s2(_, V1, V2)).

appears_before(V1, V2, R) :-
    rule_body(R, isa(_, V1)),
    var_in_body(V2, R).

appears_before(V1, V2, R) :-
    rule_body(R, isa2(_, V1, V3)),
    var_in_body(V2, R),
    V2 != V3.

appears_before(V1, V2, R) :-
    rule_body(R, isa2(_, V3, V1)),
    var_in_body(V2, R),
    V2 != V3.

appears_before(V1, V2, R) :-
    rule_body(R, isa2(_, V1, V2)).

var_in_body(V, R) :-
    rule_body(R, s(_, V)).

var_in_body(V, R) :-
    rule_body(R, s2(_, V, _)).

var_in_body(V, R) :-
    rule_body(R, s2(_, _, V)).

var_in_body(V, R) :-
    rule_body(R, isa(_, V)).

var_in_body(V, R) :-
    rule_body(R, isa2(_, V, _)).

var_in_body(V, R) :-
    rule_body(R, isa2(_, _, V)).

%------------------------------------------------------------------------------
% Var-atom ordering
%------------------------------------------------------------------------------

less_var_atom(X, Y) :- 
    less_var_atom(X, Z),
    less_var_atom(Z, Y).

less_var_atom(s(C, V), s2(C2, V2, V3)) :-
    is_var_atom(s(C, V)),
    is_var_atom(s2(C2, V2, V3)).

less_var_atom(s2(C, V, V2), isa(C2, V3)) :-
    is_var_atom(s2(C, V, V2)),
    is_var_atom(isa(C2, V3)).

less_var_atom(isa(C, V), isa2(C2, V2, V3)) :-
    is_var_atom(isa(C, V)),
    is_var_atom(isa2(C2, V2, V3)).

less_var_atom(s(C, V), s(C2, V2)) :-
    is_var_atom(s(C, V)),
    is_var_atom(s(C2, V2)),
    C < C2.

less_var_atom(s(C, V), s(C, V2)) :-
    is_var_atom(s(C, V)),
    is_var_atom(s(C, V2)),
    V < V2.

less_var_atom(s2(C, V, V2), s2(C2, V3, V4)) :-
    is_var_atom(s2(C, V, V2)),
    is_var_atom(s2(C2, V3, V4)),
    C < C2.

less_var_atom(s2(C, V, V2), s2(C, V3, V4)) :-
    is_var_atom(s2(C, V, V2)),
    is_var_atom(s2(C, V3, V4)),
    V < V3.

less_var_atom(s2(C, V, V2), s2(C, V, V3)) :-
    is_var_atom(s2(C, V, V2)),
    is_var_atom(s2(C, V, V3)),
    V2 < V3.

less_var_atom(isa(C, V), isa(C2, V2)) :-
    is_var_atom(isa(C, V)),
    is_var_atom(isa(C2, V2)),
    C < C2.

less_var_atom(isa(C, V), isa(C, V2)) :-
    is_var_atom(isa(C, V)),
    is_var_atom(isa(C, V2)),
    V < V2.

less_var_atom(isa2(C, V, V2), isa2(C2, V3, V4)) :-
    is_var_atom(isa2(C, V, V2)),
    is_var_atom(isa2(C2, V3, V4)),
    C < C2.

less_var_atom(isa2(C, V, V2), isa2(C, V3, V4)) :-
    is_var_atom(isa2(C, V, V2)),
    is_var_atom(isa2(C, V3, V4)),
    V < V3.

less_var_atom(isa2(C, V, V2), isa2(C, V, V3)) :-
    is_var_atom(isa2(C, V, V2)),
    is_var_atom(isa2(C, V, V3)),
    V2 < V3.

less_rule(R1, R2) :-
    is_rule(R1),
    is_rule(R2),
    rule_body(R1, V),
    { less_var_atom(V, V2) : rule_body(R2, V2) }.

has_rule_body(R) :-
    rule_body(R, _).
    
less_rule(X, Y) :-
    less_rule(X, Z),
    less_rule(Z, Y).

earlier_rule(R1, R2) :-
    is_arrow_rule(R1),
    is_arrow_rule(R2),
    R1 < R2.

earlier_rule(R1, R2) :-
    is_causes_rule(R1),
    is_causes_rule(R2),
    R1 < R2.



