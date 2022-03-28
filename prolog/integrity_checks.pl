:- op(1100, xfx, if).
:- op(1000, xfy, or).
:- op(900, xfy, and).
:- multifile rule/1.
:- dynamic rule/1.

rule(valid_teaching_list(TeachingList, Cdl) if
    % all elements are teaching
    is_teaching_list(TeachingList) and
    % teachings belong to cdl
    belongs_to_cdl(TeachingList, Cdl) and
    % there are no repetitions
    callp(is_set(TeachingList))
).
rule(valid_teaching_list(TeachingList, Cdl, SubYear) if
    % all elements are teaching
    is_teaching_list(TeachingList) and
    % there are no repetitions
    callp(is_set(TeachingList)) and
    % exams are in the subscription year or in the previous years and belongs to cdl
    valid_sub_year(TeachingList, Cdl, SubYear, 2)
).

rule(valid_teaching_list(TeachingList, Cdl, SubYear, SubSemester) if
    % all elements are teaching
    is_teaching_list(TeachingList) and
    % there are no repetitions
    callp(is_set(TeachingList)) and
    % exams are in the subscription year or in the previous years and belongs to cdl
    valid_sub_year(TeachingList, Cdl, SubYear, SubSemester)
).

rule(is_teaching_list([]) if true).
rule(is_teaching_list([Teaching|Teachings]) if
    % teaching is a teaching
    teaching(Teaching, _, _, _) and
    % recursively call on the teaching list
    is_teaching_list(Teachings)
).

rule(valid_sub_year([], _, _, _) if true).
rule(valid_sub_year([Teaching|Teachings], Cdl, SubYear, SubSemester) if
    % teaching belongs to cdl
    taught_in(Teaching, Cdl, Year, _) and
    % year is less than or equal to the subscription year
    callp(Year < SubYear) and
    % recursively call on the teaching list
    valid_sub_year(Teachings, Cdl, SubYear, SubSemester)
).
rule(valid_sub_year([Teaching|Teachings], Cdl, SubYear, SubSemester) if
    % teaching belongs to cdl
    taught_in(Teaching, Cdl, Year, Semester) and
    % year is less than or equal to the subscription year
    callp(Year = SubYear) and
    % also check the semester
    callp(Semester =< SubSemester) and
    % recursively call on the teaching list
    valid_sub_year(Teachings, Cdl, SubYear, SubSemester)
).

rule(valid_cfu_number(DoneExams, Cdl, RequiredCfu) if
    % retrieve max number of cfu from cdl
    cdl(Cdl, _, _, MaxCfu) and
    % sum cfus of done exams
    sum_cfu(DoneExams, AchievedCfu) and
    % check if the goal is reachable
    callp(Sum is AchievedCfu + RequiredCfu) and
    callp(Sum =< MaxCfu)
).

rule(sum_cfu([], 0) if true).
rule(sum_cfu([Teaching|Teachings], Sum) if
    % retrieve cfu
    teaching(Teaching, Cfu, _, _) and
    % recursively call on the teaching list
    sum_cfu(Teachings, Sum1) and
    % add the cfu of the teaching to the sum
    callp(Sum is Sum1 + Cfu)
).

rule(sum_multiple_cfu([], []) if true).
rule(sum_multiple_cfu([Ordering|Orderings], [Sum|Sums]) if 
    sum_multiple_cfu(Orderings, Sums) and
    sum_cfu(Ordering, Sum)
).
rule(belongs_to_cdl([], _) if true).
rule(belongs_to_cdl([Teaching|Teachings], Cdl) if
    % teaching is a teaching
    taught_in(Teaching, Cdl, _, _) and
    % recursively call on the teaching list
    belongs_to_cdl(Teachings, Cdl)
).