:- op(1100, xfx, if).
:- op(1000, xfy, or).
:- op(900, xfy, and).                        

backward(true) :- !.                                % Goal reached
backward(Fact and Facts) :- !,                      % Conjunction of facts
    backward(Fact),
    backward(Facts).
backward(Fact or Facts) :- !,                       % Disjunction of facts
    ((backward(Fact),!);
    backward(Facts)).
backward(callp(X)) :- !,                            % Callable fact
    call(X).
backward(Fact) :- !,                                % Single fact
    rule(Fact if Condition),                        % Match rule
    backward(Condition).                            % Check condition    

assertFact(Fact):-                                  % Assert fact if not already true
    \+( Fact ),!,                                   % Not already true, so stop backtracking
    assertz(Fact).                              
assertFact(_).                                      % Fact is already true, so do nothing

assert_list([]) :- !.
assert_list([Fact|Facts]) :-                        % Assert list of facts
    assertFact(rule(Fact if true)),
    assert_list(Facts).

forward_assert(Steps, FinalBase) :-                 % Call forward and assert facts
    forward(Steps, FinalBase),                                 
    assert_list(FinalBase).

forward_goal(Steps, Goal) :-
    forward_iteration(Steps, FinalBase),                                % Get all facts from the base
    member(Goal, FinalBase).                                            % See if the goal is reached

forward(Steps, FinalBase) :-
    forward_iteration(Steps, nil, [true], FinalBase).                   % Current base is [true]

forward_iteration(Steps, PreviousBase, CurrentBase, FinalBase) :-
    (   ( Steps = 0                                                     % Reached max iterations
        ; PreviousBase = CurrentBase )                                  % Reached a fixed point
    ->  FinalBase = CurrentBase
    ;   setof(Fact, derived(Fact, CurrentBase), NewFacts),              % Derive new facts
        ord_union(NewFacts, CurrentBase, NewBase),                      % Add new facts into current base
        succ(Steps0, Steps),
        forward_iteration(Steps0, CurrentBase, NewBase, FinalBase) ).   % Repeat with new base

derived(Fact, Base) :-                              
    rule(Fact if Condition),                                            % Match a rule
    satisfy(Base, Condition).                                           % Verify if condition is satisfied given base

satisfy(Base, G and Gs) :-                                              % Condition is a conjunction
    !,
    member(G, Base),
    satisfy(Base, Gs).
satisfy(Base, G or Gs) :-                           % Condition is a disjunction
    !,
    (   member(G, Base)
    ;   satisfy(Base, Gs) ).
satisfy(_, callp(X)) :-                             % Condition is a callable fact
    !,
    call(X).
satisfy(Base, Condition) :-                         % Condition is an atomic proposition
    member(Condition, Base).