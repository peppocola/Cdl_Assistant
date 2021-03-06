set_of(Template, Goal, Bag) :-
    setof(Template, backward(Goal), Bag).

find_all(Template, Goal, Bag) :-
    findall(Template, backward(Goal), Bag).

baggy_of(Template, Goal, Bag) :-
    bagof(Template, backward(Goal), Bag).

is_set(Lst) :-
    list_to_set(Lst, Set),
    Lst == Set.

sample([X], [P], Cumul, Rand, X) :-
    Rand < Cumul + P, !.
sample([X|_], [P|_], Cumul, Rand, X) :-
    Rand < Cumul + P,!.
sample([_|Xs], [P|Ps], Cumul, Rand, Y) :-
    Cumul1 is Cumul + P,
    Rand >= Cumul1,
    sample(Xs, Ps, Cumul1, Rand, Y).

sample(Xs, Ps, Y) :- random(R), sample(Xs, Ps, 0, R, Y).

list_sum([],0).
list_sum([Head|Tail], TotalSum):-
    list_sum(Tail, Sum1),
    TotalSum is Head+Sum1.

max_l([Y],[X],Y,X) :- !.
max_l([_|Ys], [X|Xs], My, Mx):- max_l(Ys, Xs, My, Mx), Mx > X, !.
max_l([Y|Ys], [X|Xs], Y, X):- max_l(Ys, Xs, _, Mx), X >=  Mx, !.

min_l([Y],[X],Y,X) :- !.
min_l([_|Ys], [X|Xs], My, Mx):- min_l(Ys, Xs, My, Mx), Mx < X, !.
min_l([Y|Ys], [X|Xs], Y, X):- min_l(Ys, Xs, _, Mx), X =<  Mx, !.
