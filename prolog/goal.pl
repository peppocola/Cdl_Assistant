:- op(1100, xfx, if).
:- op(1000, xfy, or).
:- op(900, xfy, and).
:- multifile rule/1.
:- dynamic rule/1.


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
    cdl_teachings(Cdl, SubYear, SubSemester, Teachings) and
    % remove teachings which are already done
    callp(subtract(Teachings, DoneExams, ToDoExams)) and
    % if necessary, add the optional exams
    add_optional_exams(ToDoExams, Cdl, NoYears, SubYear, SubSemester, ToShuffleExams) and
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
    covers_teachings(Cdl, Topics, SubYear, SubSemester, Teachings) and
    % remove teachings which are already done
    callp(subtract(Teachings, DoneExams, ToDoExams)) and
    % random permute the exams
    callp(random_permutation(ToDoExams, ShuffledExams)) and
    % get all standard prerequisites
    get_all_standard_prerequisites(ShuffledExams, DoneExams, STPrerequisites) and
    % create todo exams list
    callp(append(STPrerequisites, ShuffledExams, ListToDoExams)) and
    callp(list_to_set(ListToDoExams, NewToDoExams)) and
    % find an ordering which respects prerequisites
    ordering(NewToDoExams, DoneExams, Cdl, Ordering)
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
    cdl_teachings(Cdl, SubYear, SubSemester, Teachings) and
    % remove teachings which are already done
    callp(subtract(Teachings, DoneExams, ToDoExams)) and
    add_optional_exams(ToDoExams, Cdl, NoYears, SubYear, SubSemester, ToShuffleExams) and
    % random permute the exams
    callp(random_permutation(ToShuffleExams, ShuffledExams)) and
    % find an ordering which respects prerequisites
    cfu_ordering(ShuffledExams, DoneExams, RequiredCfu, Cdl, Ordering)
).

rule(ordering([], _, _, []) if true).

rule(ordering([ToDoExam|ToDoExams], DoneExams, Cdl, Ordering) if
    % check prerequisites
    set_of_prioritized_prerequisites(ToDoExam, DoneExams, Cdl, Prerequisites) and
    (
        (
            callp(Prerequisites = []) and
            % the exam should be put in the ordering
            callp(Ordering = [ToDoExam|RecOrdering]) and
            % recursively call the ordering rule
            ordering(ToDoExams, [ToDoExam|DoneExams], Cdl, RecOrdering)
        ) or
        (
            pick_an_exam(Prerequisites, Exam) and
            % remove exam from todo list
            callp(subtract(ToDoExams, [Exam], ToDoExamsWithoutNewExam)) and
            % recursively call the ordering rule
            ordering([Exam, ToDoExam|ToDoExamsWithoutNewExam], DoneExams, Cdl, Ordering)
        )
    )
).

% sample an exam and call cfu_ordering_
rule(cfu_ordering(ToDoExams, DoneExams, RequiredCfu, Cdl, Ordering) if 
    callp(\+ (ToDoExams = [])) and
    % sample an exam
    sample_exam(ToDoExams, Cdl, ToDoExam) and
    % remove it from ToDoExams
    callp(subtract(ToDoExams, [ToDoExam], ToDoExamsWithoutNewExam)) and
    % set sampled exam as first exam to do
    cfu_ordering_([ToDoExam|ToDoExamsWithoutNewExam], DoneExams, RequiredCfu, Cdl, Ordering)
).


% case prerequisites are not satisfied
rule(cfu_ordering_([ToDoExam|ToDoExams], DoneExams, RequiredCfu, Cdl, Ordering) if
    % check prerequisites
    set_of_prioritized_prerequisites(ToDoExam, DoneExams, Cdl, Prerequisites) and
    % case prerequisites are not satisfied
    callp(\+Prerequisites = []) and
    % pick an exam from the ones which can help satisfying prerequisites
    pick_an_exam(Prerequisites, PrerequisiteExam) and
    % remove exam from todo list to avoid duplicates
    callp(subtract(ToDoExams, [PrerequisiteExam], ToDoExamsWithoutNewPrerequisite)) and
    % recursively call the ordering rule
    cfu_ordering_([PrerequisiteExam, ToDoExam|ToDoExamsWithoutNewPrerequisite], DoneExams, RequiredCfu, Cdl, Ordering)
).

% case prerequisites are satisfied
rule(cfu_ordering_([ToDoExam|ToDoExams], DoneExams, RequiredCfu, Cdl, Ordering) if
    % check prerequisites
    set_of_prioritized_prerequisites(ToDoExam, DoneExams, Cdl, Prerequisites) and
    % case prerequisites are satisfied
    callp(Prerequisites = []) and
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
rule(cfu_ordering_([], _, RequiredCfu, _, _) if
    callp(RequiredCfu =< 0)
).

% this is true if the adjusted ordering respects suggested prerequisites
rule(adjust_ordering(Ordering, Cdl, AdjustedOrdering) if
    adjust_ordering_(Ordering, [], FirstAdjustedOrdering) and
    (
        (
            % if it is a fixed point, no need to adjust
            callp(Ordering = FirstAdjustedOrdering) and
            callp(AdjustedOrdering = FirstAdjustedOrdering)
        )
        or
        (   % if it is not a fixed point, call recursively
            adjust_ordering(FirstAdjustedOrdering, Cdl, AdjustedOrdering) and
            % ensure that the adjusted ordering still respects prerequisites
            respects_prerequisites(AdjustedOrdering, [], Cdl)
        )
        or
        (
            % if it doesn't respect the prerequisites, adjusting is breaking something.
            callp(AdjustedOrdering = Ordering)
            % this is not happening, but is here for completeness
        )    
    )
).

% this is true if the adjusted ordering respects suggested prerequisites of the first exam in the ordering which has some
rule(adjust_ordering_([OrderedExam|OrderedExams], BeforeExams, AdjustedOrdering) if
    set_of_suggested_prerequisites(OrderedExam, SuggestedPrerequisites) and
    (
        (   % if it is a subset, suggested prerequisites have been already done
            callp(subset(SuggestedPrerequisites, BeforeExams)) and
            % set the fisrt exam as checked
            callp(append(BeforeExams, [OrderedExam], BeforeExamsWithOrderedExam)) and
            % recursively call the adjusting rule
            adjust_ordering_(OrderedExams, BeforeExamsWithOrderedExam, AdjustedOrdering)
        )
        or
        (   % if it is not a subset, some suggested prerequisites have not been done yet
            % remove the ones already done
            callp(subtract(SuggestedPrerequisites, BeforeExams, RemainingPrerequisites)) and
            % remove the suggested prerequisites from the exams in the ordering to avoid duplicates
            callp(subtract(OrderedExams, RemainingPrerequisites, OrderedExamsWithoutPrerequisites)) and
            % set the suggested prerequisites as first in the ordering
            callp(append(BeforeExams, RemainingPrerequisites, BeforeExamsWithPrerequisites)) and
            callp(append(BeforeExamsWithPrerequisites, [OrderedExam|OrderedExamsWithoutPrerequisites], AdjustedOrdering))
        )
    )   
).
rule(adjust_ordering_([], BeforeExams, _, BeforeExams) if true).

rule(cdl_teachings(Cdl, SubYear, SubSemester, Teachings) if
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
    callp(subtract(Cdl_Teachings, To_Remove_Cdl_Teachings, Teachings))
).

rule(add_optional_exams(ToDoExams, Cdl, NoYears, SubYear, SubSemester, ToDoExamWithOptional) if
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
        callp(append(ToDoExams, [FirstOptionalExam, SecondOptionalExam], ToDoExamWithOptional))
    ) 
    or
    (   
        callp(ToDoExamWithOptional = ToDoExams)
    )

).

rule(covers_teachings(Cdl, Topics, SubYear, SubSemester, Teachings) if 
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
    callp(subtract(Cdl_Teachings, To_Remove_Cdl_Teachings, Teachings))
).

rule(pick_an_exam(Exams, Exam) if 
    callp(random_permutation(Exams, [Exam|_]))
).

% this aims to pick the exam which has more standard prerequisites
rule(pick_priority_exam(Exams, DoneExams, Exam) if 
    count_standard_prerequisites(Exams, DoneExams, Lens) and
    callp(max_l(Exams, Lens, Exam, _))
).

rule(count_standard_prerequisites([Exam|Exams], DoneExams, [Len|Lens]) if
    get_standard_prerequisites(Exam, DoneExams, STPrerequisites) and
    callp(length(STPrerequisites, Len)) and
    count_standard_prerequisites(Exams, DoneExams, Lens)
).
rule(count_standard_prerequisites([], _, []) if true).

rule(get_all_standard_prerequisites(Exams, DoneExams, Prerequisites) if
    get_all_standard_prerequisites_(Exams, DoneExams, ListPrerequisites) and
    callp(list_to_set(ListPrerequisites, Prerequisites))
).

rule(get_all_standard_prerequisites_([Exam|Exams], DoneExams, Prerequisites) if
    get_standard_prerequisites(Exam, DoneExams, STPrerequisites) and
    get_all_standard_prerequisites_(Exams, DoneExams, OtherSTPrerequisites) and
    callp(append(STPrerequisites, OtherSTPrerequisites, Prerequisites))
).
rule(get_all_standard_prerequisites_([], _, []) if true).

% generate a list of probabilities for each exam, which is cfu/total cfus
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

rule(sample_exam(ToDoExams, Cdl, Exam) if
     % sum the cfus in ToDoExams
     sum_cfu(ToDoExams, CfuSum) and
     % divide cfu by the sum
     cfu_to_probability(ToDoExams, Cdl, CfuSum, Probability) and
     % sample an exam
     callp(sample(ToDoExams, Probability, Exam))
).