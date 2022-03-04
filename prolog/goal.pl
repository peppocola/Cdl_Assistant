:- op(1100, xfx, if).
:- op(1000, xfy, or).
:- op(900, xfy, and).
:- multifile rule/1.
:- dynamic rule/1.

% TODO :
% - topics teaching can lead to more exams than stricly necessary (do some intersection to prioritize exams which satisfy more prerequisites)
% - optional teachings can be improved 
% - admission test
% - optional teachings from other cdl
% - add check on goal cfu

rule(goal_cdl(Cdl, DoneExams, Ordering) if
    cdl(Cdl, _, NoYears, _) and
    goal_cdl(Cdl, DoneExams, NoYears, 2, Ordering)
).

rule(goal_cdl(Cdl, DoneExams, SubYear, Ordering) if
    cdl(Cdl, _, _, _) and
    goal_cdl(Cdl, DoneExams, SubYear, 2, Ordering)
).

rule(goal_cdl(Cdl, DoneExams, SubYear, SubSemester, Ordering) if
    % check integrity of the parameters
    cdl(Cdl, _, NoYears, _) and
    callp(SubYear =< NoYears) and
    callp(SubSemester =< 2) and
    valid_teaching_list(DoneExams, Cdl, SubYear, SubSemester) and
    % find all the teachings in the selected year and below
    callp(
        find_all(
            Cdl_Teaching, 
            (
                teaching(Cdl_Teaching, _, _, false) and
                taught_in(Cdl_Teaching, Cdl, Year, Semester) and 
                callp(Year =< SubYear)
            ), Cdl_Teachings)
        ) and
    % find the teaching which are of a semester higher than the selected
    callp(
        find_all(
            Cdl_Teaching, 
            (taught_in(Cdl_Teaching, Cdl, Year, Semester) and callp(Year = SubYear) and callp(Semester > SubSemester)),
            To_Remove_Cdl_Teachings)
        ) and
    % remove teachings
    callp(subtract(Cdl_Teachings, To_Remove_Cdl_Teachings, Adjusted_Cdl_Teachings)) and
    % remove teachings which are already done
    callp(subtract(Adjusted_Cdl_Teachings, DoneExams, ToDoExams)) and
    (
        (
            callp(SubYear = NoYears) and
            callp(SubSemester = 2) and
            % if the last semester is reached, should add optional teachings
            callp(
                find_all( 
                    OptionalTeaching,
                    (
                        teaching(OptionalTeaching, _, _, true) and
                        taught_in(OptionalTeaching, Cdl, SubYear, SubSemester)
                    ),
                    OptionalTeachings
                )
            ) and
            callp(random_permutation(OptionalTeachings, [FirstOptionalExam, SecondOptionalExam|_])) and
            callp(append(ToDoExams, [FirstOptionalExam, SecondOptionalExam], ToShuffleExams))

        ) or
        (   
            callp(ToShuffleExams = ToDoExams)
        )
    ) and
    % random permute the exams
    callp(random_permutation(ToShuffleExams, ShuffledExams)) and
    % find an ordering which respects prerequisites
    ordering(ShuffledExams, DoneExams, Cdl, Ordering)
).

rule(goal_covers(Cdl, DoneExams, Topics, Ordering) if
    cdl(Cdl, _, NoYears, _) and
    goal_covers(Cdl, DoneExams, Topics, NoYears, 2, Ordering)
).

rule(goal_covers(Cdl, DoneExams, Topics, SubYear, Ordering) if
    cdl(Cdl, _, _, _) and
    goal_covers(Cdl, DoneExams, Topics, SubYear, 2, Ordering)
).

rule(goal_covers(Cdl, DoneExams, Topics, SubYear, SubSemester, Ordering) if
    % check integrity of the parameters
    cdl(Cdl, _, NoYears, _) and
    callp(SubYear =< NoYears) and
    callp(SubSemester =< 2) and
    valid_teaching_list(DoneExams, Cdl, SubYear, SubSemester) and
    % find all the teachings in the selected year and below
    callp(
        find_all(
            Cdl_Teaching, 
            (
                taught_in(Cdl_Teaching, Cdl, Year, Semester) and
                callp(Year =< SubYear) and
                covers(Cdl_Teaching, Topic) and
                callp(member(Topic, Topics))
            ),
            Cdl_Teachings)
        ) and
    % find the teaching which are of a semester higher than the selected
    callp(
        find_all(
            Cdl_Teaching, 
            (
                taught_in(Cdl_Teaching, Cdl, Year, Semester) and
                callp(Year = SubYear) and
                callp(Semester > SubSemester) and
                covers(Cdl_Teaching, Topic) and
                callp(member(Topic, Topics))
            ),
            To_Remove_Cdl_Teachings)
        ) and
    % remove teachings
    callp(subtract(Cdl_Teachings, To_Remove_Cdl_Teachings, Adjusted_Cdl_Teachings)) and
    % remove teachings which are already done
    callp(subtract(Adjusted_Cdl_Teachings, DoneExams, ToDoExams)) and
    % random permute the exams
    callp(random_permutation(ToDoExams, ShuffledExams)) and
    % find an ordering which respects prerequisites
    ordering(ShuffledExams, DoneExams, Cdl, Ordering)
).


rule(goal_cfu_count(Cdl, DoneExams, RequiredCfu, Ordering, Count) if
    cdl(Cdl, _, NoYears, _) and
    goal_cfu(Cdl, DoneExams, NoYears, 2, RequiredCfu, Ordering) and
    sum_cfu(Ordering, Count)
).

rule(goal_cfu(Cdl, DoneExams, RequiredCfu, Ordering) if
    cdl(Cdl, _, NoYears, _) and
    goal_cfu(Cdl, DoneExams, NoYears, 2, RequiredCfu, Ordering)
).

rule(goal_cfu(Cdl, DoneExams, SubYear, RequiredCfu, Ordering) if
    cdl(Cdl, _, _, _) and
    goal_cfu(Cdl, DoneExams, SubYear, 2, RequiredCfu, Ordering)
).

rule(goal_cfu(Cdl, DoneExams, SubYear, SubSemester, RequiredCfu, Ordering) if
    % check integrity of the parameters
    cdl(Cdl, _, NoYears, _) and
    callp(SubYear =< NoYears) and
    callp(SubSemester =< 2) and
    valid_teaching_list(DoneExams, Cdl, SubYear, SubSemester) and
    valid_cfu_number(DoneExams, Cdl, RequiredCfu) and
    % find all the teachings in the selected year and below
    callp(
        find_all(
            Cdl_Teaching,
            (
                teaching(Cdl_Teaching, _, _, false) and
                taught_in(Cdl_Teaching, Cdl, Year, Semester) and 
                callp(Year =< SubYear)
            ), Cdl_Teachings)
        ) and
    % find the teaching which are of a semester higher than the selected
    callp(
        find_all(
            Cdl_Teaching, 
            (taught_in(Cdl_Teaching, Cdl, Year, Semester) and callp(Year = SubYear) and callp(Semester > SubSemester)),
            To_Remove_Cdl_Teachings)
        ) and
    % remove teachings
    callp(subtract(Cdl_Teachings, To_Remove_Cdl_Teachings, Adjusted_Cdl_Teachings)) and
    % remove teachings which are already done
    callp(subtract(Adjusted_Cdl_Teachings, DoneExams, ToDoExams)) and
    (
        (
            callp(SubYear = NoYears) and
            callp(SubSemester = 2) and
            % if the last semester is reached, should add optional teachings
            callp(
                find_all( 
                    OptionalTeaching,
                    (
                        teaching(OptionalTeaching, _, _, true) and
                        taught_in(OptionalTeaching, Cdl, SubYear, SubSemester)
                    ),
                    OptionalTeachings
                )
            ) and
            callp(random_permutation(OptionalTeachings, [FirstOptionalExam, SecondOptionalExam|_])) and
            callp(append(ToDoExams, [FirstOptionalExam, SecondOptionalExam], ToShuffleExams))

        ) or
        (   
            callp(ToShuffleExams = ToDoExams)
        )
    ) and
    % random permute the exams
    callp(random_permutation(ToShuffleExams, ShuffledExams)) and
    % find an ordering which respects prerequisites
    cfu_ordering_(ShuffledExams, DoneExams, RequiredCfu, Cdl, Ordering)

).


% case no exams to do
rule(ordering([], _, _, []) if true).

% case no static prerequisite
rule(ordering([ToDoExam|ToDoExams], DoneExams, Cdl, Ordering) if
    % get the prerequisites of ToDoExam
    callp(find_all(TeachingName, is_prerequisite(TeachingName, ToDoExam), PrerequisiteTeachingNames)) and
    % some prerequisites could be already done, check if there are some
    % remove them from the prerequisite list
    callp(subtract(PrerequisiteTeachingNames, DoneExams, ToDoPrerequisites)) and
    % list is empty
    callp(ToDoPrerequisites = []) and
    % check dynamic prerequisites
    set_of_dynamic_prerequisites(ToDoExam, DoneExams, Cdl, DPrerequisites) and
    (
        (
            callp(DPrerequisites = []) and
            % the exam should be put in the ordering
            callp(Ordering = [ToDoExam|RecOrdering]) and
            % recursively call the ordering rule
            ordering(ToDoExams, [ToDoExam|DoneExams], Cdl, RecOrdering)
        ) or
        (
            pick_an_exam(DPrerequisites, DoneExams, Exam) and
            % remove exam from todo list
            callp(subtract(ToDoExams, [Exam], ToDoExamsWithoutNewExam)) and
            % if dynamic prerequisites are not satisfied, add a prerequisite exam to the todo list
            callp(append([Exam], [ToDoExam|ToDoExamsWithoutNewExam], NewToDoExams)) and
            % recursively call the ordering rule
            ordering(NewToDoExams, DoneExams, Cdl, Ordering)
        )
    )
).

% case prerequisite are not satisfied and some of them are in todo
rule(ordering([ToDoExam|ToDoExams], DoneExams, Cdl, Ordering) if
    % get the prerequisites of ToDoExam
    callp(find_all(TeachingName, is_prerequisite(TeachingName, ToDoExam), PrerequisiteTeachings)) and
    % some prerequisites could be already done, check if there are some
    % remove them from the prerequisite list
    callp(subtract(PrerequisiteTeachings, DoneExams, ToDoPrerequisites)) and
    % list is not empty
    callp(\+(ToDoPrerequisites = [])) and
    % if they are in ToDoExams
    callp(intersection(ToDoPrerequisites, ToDoExams, Intersection)) and
    callp(\+ (Intersection = [])) and
    % remove them from ToDoExams to bring them to the front
    callp(subtract(ToDoExams, Intersection, ToDoExamsReduced)) and
    % call the ordering rule with the prerequisites exams as first to do
    callp(append(ToDoPrerequisites, [ToDoExam|ToDoExamsReduced], NewToDoExams)) and
    ordering(NewToDoExams, DoneExams, Cdl, Ordering)
).

% case prerequisite are not satisfied and none of them are in todo
rule(ordering([ToDoExam|ToDoExams], DoneExams, Cdl, Ordering) if
    % get the prerequisites of ToDoExam
    callp(find_all(TeachingName, is_prerequisite(TeachingName, ToDoExam), PrerequisiteTeachings)) and
    % some prerequisites could be already done, check if there are some
    % remove them from the prerequisite list
    callp(subtract(PrerequisiteTeachings, DoneExams, ToDoPrerequisites)) and
    % list is not empty
    callp(\+(ToDoPrerequisites = [])) and
    % if they are not in ToDoExams
    callp(intersection(ToDoPrerequisites, ToDoExams, Intersection)) and
    callp(Intersection = []) and
    % call the ordering rule with the prerequisites exams as first to do
    callp(append(ToDoPrerequisites, [ToDoExam|ToDoExams], NewToDoExams)) and
    ordering(NewToDoExams, DoneExams, Cdl, Ordering)
).

rule(cfu_ordering_(ToDoExams, DoneExams, RequiredCfu, Cdl, Ordering) if 
    callp(\+ (ToDoExams = [])) and
    % sample an exam
    sample_exam(ToDoExams, Cdl, ToDoExam) and
    % remove it from ToDoExams
    callp(subtract(ToDoExams, [ToDoExam], ToDoExamsWithoutNewExam)) and
    % set sampled exam as first exam to do
    cfu_ordering([ToDoExam|ToDoExamsWithoutNewExam], DoneExams, RequiredCfu, Cdl, Ordering)
).

% case static prerequisites
rule(cfu_ordering([ToDoExam|ToDoExams], DoneExams, RequiredCfu, Cdl, Ordering) if
    % get the prerequisites of ToDoExam
    callp(find_all(TeachingName, is_prerequisite(TeachingName, ToDoExam), PrerequisiteTeachingNames)) and
    % some prerequisites could be already done, check if there are some
    % remove them from the prerequisite list
    callp(subtract(PrerequisiteTeachingNames, DoneExams, ToDoPrerequisites)) and
    % list is empty
    % case static prerequisites are NOT satisfied 
    callp(\+ ToDoPrerequisites = []) and
    % if they are in ToDoExams remove them from ToDoExams to avoid duplicates
    callp(subtract(ToDoExams, ToDoPrerequisites, ToDoExamsReduced)) and
    % call the ordering rule with the new prerequisites exams
    callp(append(ToDoPrerequisites, [ToDoExam|ToDoExamsReduced], NewToDoExams)) and
    cfu_ordering_(NewToDoExams, DoneExams, RequiredCfu, Cdl, Ordering)
).

% case no static prerequisite, but dynamic
rule(cfu_ordering([ToDoExam|ToDoExams], DoneExams, RequiredCfu, Cdl, Ordering) if
    % get the prerequisites of ToDoExam
    callp(find_all(TeachingName, is_prerequisite(TeachingName, ToDoExam), PrerequisiteTeachingNames)) and
    % some prerequisites could be already done, remove them from the prerequisite list
    callp(subtract(PrerequisiteTeachingNames, DoneExams, ToDoPrerequisites)) and
    % case static prerequisites are satisfied 
    callp(ToDoPrerequisites = []) and
    % check dynamic prerequisites
    set_of_dynamic_prerequisites(ToDoExam, DoneExams, Cdl, DPrerequisites) and
    % case dynamic prerequisites are not satisfied
    callp(\+DPrerequisites = []) and
    % pick an exam from the ones which can help satisfying prerequisites and it is not already done
    pick_an_exam(DPrerequisites, DoneExams, PrerequisiteExam) and
    % remove exam from todo list to avoid duplicates
    callp(subtract(ToDoExams, [PrerequisiteExam], ToDoExamsWithoutNewPrerequisite)) and
    % recursively call the ordering rule
    cfu_ordering_([PrerequisiteExam, ToDoExam|ToDoExamsWithoutNewPrerequisite], DoneExams, RequiredCfu, Cdl, Ordering)
).

% case no static prerequisite, no dynamic
rule(cfu_ordering([ToDoExam|ToDoExams], DoneExams, RequiredCfu, Cdl, Ordering) if
    % get the prerequisites of ToDoExam
    callp(find_all(TeachingName, is_prerequisite(TeachingName, ToDoExam), PrerequisiteTeachingNames)) and
    % some prerequisites could be already done, check if there are some
    % remove them from the prerequisite list
    callp(subtract(PrerequisiteTeachingNames, DoneExams, ToDoPrerequisites)) and
    % list is empty
    % case static prerequisites are satisfied 
    callp(ToDoPrerequisites = []) and
    % check dynamic prerequisites
    set_of_dynamic_prerequisites(ToDoExam, DoneExams, Cdl, DPrerequisites) and
    % case dynamic prerequisites are satisfied
    callp(DPrerequisites = []) and
    % the exam should be put in the ordering
    callp(Ordering = [ToDoExam|RecOrdering]) and
    % see if there are still required cfus
    teaching(ToDoExam, ExamCfu, _, _) and
    callp(NewRequiredCfu is (RequiredCfu - ExamCfu)) and
    % check if there are still required cfus or not
    (
        (   % case there are no more required cfus
            callp(NewRequiredCfu =< 0) and
            callp(Ordering = [ToDoExam])
        )
        or
        (   % case there are still required cfus
            callp(Ordering = [ToDoExam|RecOrdering]) and
            % recursively call the ordering rule
            cfu_ordering_(ToDoExams, [ToDoExam|DoneExams], NewRequiredCfu, Cdl, RecOrdering)
        )    
    )          
).

% case no exams to do
rule(cfu_ordering([], _, RequiredCfu, _, _) if
    callp(RequiredCfu =< 0)
).

rule(pick_an_exam(Prerequisites, DoneExams, Exam) if 
    callp(subtract(Prerequisites, DoneExams, NewPrerequisites)) and
    callp(random_permutation(NewPrerequisites, [Exam|_]))
).

rule(cfu_to_probability([Exam|Exams], Cdl, [P|Ps]) if 
    teaching(Exam, Cfu, _, _) and
    taught_in(Exam, Cdl, _, _) and
    cdl(Cdl, _, _, TotalExamsCfu) and
    callp(P is (Cfu/TotalExamsCfu)) and
    cfu_to_probability(Exams, Cdl, Ps)
).
rule(cfu_to_probability([], _, []) if true).

rule(cfu_to_probability([Exam|Exams], Cdl, TotalExamsCfu, [P|Ps]) if 
    teaching(Exam, Cfu, _, _) and
    taught_in(Exam, Cdl, _, _) and
    callp(P is (Cfu/TotalExamsCfu)) and
    cfu_to_probability(Exams, Cdl, TotalExamsCfu, Ps)
).
rule(cfu_to_probability([], _, _, []) if true).

rule(sum_to_one([P|Ps], NP) if 
    callp(list_sum([P|Ps], Sum)) and
    (   
        (
            callp(Sum is 1.00) and
            callp(NP = [P|Ps])
        )
        or
        (
            callp(Diff is 1.00 - Sum) and
            callp(F is P + Diff) and
            callp(NP = [F|Ps])
        )
    )
).

rule(sample_exam(ToDoExams, Cdl, Exam) if
     % sum the cfus in ToDoExams
     sum_cfu(ToDoExams, CfuSum) and
     % divide cfu by the sum
     cfu_to_probability(ToDoExams, Cdl, CfuSum, Probability) and
     % sample an exam
     callp(sample(ToDoExams, Probability, Exam))
).
