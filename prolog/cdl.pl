:- op(1100, xfx, if).
:- op(1000, xfy, or).
:- op(900, xfy, and).
:- multifile rule/1.
:- dynamic rule/1.
/*
cdl(N, C, Y, T) -->
    N is the name of the cdl
    C is the class code
    Y is the number of years it takes to complete the class
*/
rule(cdl('informatica', 'l-31', 3, 162) if true).
