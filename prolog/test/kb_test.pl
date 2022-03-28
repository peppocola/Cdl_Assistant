:- op(1100, xfx, if).
:- op(1000, xfy, or).
:- op(900, xfy, and).
:- dynamic rule/1.

rule(eats_flies(fritz) if true).
rule(croaks(fritz)     if true).
rule(eats_flies(frotz) if true).
rule(croaks(frotz)     if true).
rule(sings(tweety)     if true).
rule(chips(tweety)     if true).
rule(has_wings(tweety) if true).
rule(croaks(krogr)    if true).
rule(chips(kroger)     if true).
rule(canary(X)         if sings(X) and chips(X) and has_wings(X)).
rule(frog(X)           if croaks(X) and eats_flies(X)).
rule(green(X)          if frog(X)).
rule(yellow(X)         if canary(X)).
rule(node(a) if true).
rule(node(b) if true).
rule(node(c) if true).
rule(node(d) if true).
rule(node(e) if true).
rule(connected(a,b) if true).
rule(connected(b,c) if true).
rule(connected(c,d) if true).
rule(connected(d,e) if true).
rule(funny(c,d) if true).
rule(wonderful(X,Y) if nice(X,Y) or funny(X,Y)).
rule(connected(X,Z) if connected(X,Y) and connected(Y,Z)).
rule(path([Node|[]]) if node(Node)).
rule(path([Node, NextNode|Nodes]) if connected(Node, NextNode) and path([NextNode|Nodes])).
rule(int(0) if true).
rule(int(1) if true).
rule(int(2) if true).
rule(int(3) if true).
rule(int(4) if true).
rule(int(5) if true).
rule(int(6) if true).
rule(int(7) if true).
rule(int(8) if true).
rule(int(9) if true).
rule(int(10) if true).
rule(iszero(X) if int(X) and callp(X = 0)).
rule(has_n(_, 0) if true).
rule(has_n([H|T], N) if has_n(T, M) and node(H) and callp(succ(M,N))).
rule(has_n([_|T], N) if has_n(T, N)).
