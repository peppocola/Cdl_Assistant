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
    % remove duplicates if some
    callp(list_to_set(ShuffledExams, NewToDoExams)) and
    % find an ordering which respects prerequisites
    covers_ordering(NewToDoExams, DoneExams, Cdl, Ordering)
).

rule(covers_ordering(ToDoExams, DoneExams, Cdl, Ordering) if
    union_prerequisites(ToDoExams, DoneExams, Cdl, Prerequisites) and
    covers_ordering_(Prerequisites, ToDoExams, DoneExams, Cdl, Ordering)
).

rule(covers_ordering_(Prerequisites, ToDoExams, DoneExams, Cdl, Ordering) if
    split_exams(ToDoExams, DoneExams, Cdl, NoPrereqExams, _) and
    % all exams have prerequisites to do
    callp(NoPrereqExams = []) and
    % pick the exam which has the most standard prerequisites
    callp(random_permutation(Prerequisites, ShuffledPrerequisites)) and
    pick_multiple_priority_exam(ToDoExams, ShuffledPrerequisites, DoneExams, Cdl, ToDoPrerequisite) and
    % do exam if possible
    set_of_prioritized_prerequisites(ToDoPrerequisite, DoneExams, Cdl, PrioritizedPrerequisites) and
    (
        (
            callp(PrioritizedPrerequisites = []) and
            % update prerequisites
            union_prerequisites(ToDoExams, [ToDoPrerequisite | DoneExams], Cdl, NewPrerequisites) and
            % call recursively
            callp(Ordering = [ToDoPrerequisite | PartialOrdering]) and
            covers_ordering_(NewPrerequisites, ToDoExams, [ToDoPrerequisite | DoneExams], Cdl, PartialOrdering)
        ) or
        (
            covers_ordering_(PrioritizedPrerequisites, ToDoExams, DoneExams, Cdl, Ordering)        
        )  
    )
).
rule(covers_ordering_(Prerequisites, ToDoExams, DoneExams, Cdl, Ordering) if
    split_exams(ToDoExams, DoneExams, Cdl, NoPrereqExams, _) and
    % if some have no prerequisite, set as done
    callp(\+ NoPrereqExams = []) and
    callp(subtract(ToDoExams, NoPrereqExams, NewToDoExams)) and
    callp(append(DoneExams, NoPrereqExams, NewDoneExams)) and
    covers_ordering_(Prerequisites, NewToDoExams, NewDoneExams, Cdl, PartialOrdering) and
    callp(append(NoPrereqExams, PartialOrdering, Ordering))
).
rule(covers_ordering_(_, [], _, _, []) if true).


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
    % TODO : improve valid_cfu with subyear and subsemester
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
    cfu_ordering([PrerequisiteExam, ToDoExam|ToDoExamsWithoutNewPrerequisite], DoneExams, RequiredCfu, Cdl, Ordering)
).

% case prerequisites are satisfied
rule(cfu_ordering_([ToDoExam|ToDoExams], DoneExams, RequiredCfu, Cdl, Ordering) if
    % check prerequisites
    set_of_prioritized_prerequisites(ToDoExam, DoneExams, Cdl, Prerequisites) and
    % case prerequisites are satisfied
    callp(Prerequisites = []) and
    % the exam should be put in the ordering
    callp(Ordering = [ToDoExam|RecOrdering]) and
    % retrieve number of cfu of the exam
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
            cfu_ordering(ToDoExams, [ToDoExam|DoneExams], NewRequiredCfu, Cdl, RecOrdering)
        )    
    )          
).
% case no exams to do
rule(cfu_ordering_([], _, RequiredCfu, _, _) if
    callp(RequiredCfu =< 0)
).

% this is true if the adjusted ordering respects suggested prerequisites
rule(adjust_ordering(Ordering, 'informatica', AdjustedOrdering) if
    adjust_ordering_(Ordering, [], 'informatica', FirstAdjustedOrdering) and
    (
        (
            % if it is a fixed point, no need to adjust
            callp(Ordering = FirstAdjustedOrdering) and
            callp(AdjustedOrdering = FirstAdjustedOrdering)
        )
        or
        (   % if it is not a fixed point, call recursively
            adjust_ordering(FirstAdjustedOrdering, 'informatica', AdjustedOrdering) and
            % ensure that the adjusted ordering still respects prerequisites
            respects_prerequisites(AdjustedOrdering, [], 'informatica')
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
rule(adjust_ordering_([OrderedExam|OrderedExams], BeforeExams, 'informatica', AdjustedOrdering) if
    set_of_suggested_prerequisites(OrderedExam, 'informatica', SuggestedPrerequisites) and
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

rule(split_exams([Exam|Exams], DoneExams, Cdl, CanDoExams, CannotDoExams) if
    set_of_prioritized_prerequisites(Exam, DoneExams, Cdl, Prerequisites) and
    (
        (
            callp(Prerequisites = []) and
            callp(CanDoExams = [Exam|CanDoExamsRec]) and
            split_exams(Exams, DoneExams, Cdl, CanDoExamsRec, CannotDoExams)
        )
        or
        (
            callp(\+Prerequisites = []) and
            callp(CannotDoExams = [Exam|CannotDoExamsRec]) and
            split_exams(Exams, DoneExams, Cdl, CanDoExams, CannotDoExamsRec)
        )
    )
).
rule(split_exams([], _, _, [], []) if true).

rule(goal_cfu_backtrack(RequiredCfu, SubYear, SubSemester, Cdl, Ordering) if
    callp(find_all(AnOrdering, 
                    (goal_cfu_backtrack_([], RequiredCfu, SubYear, SubSemester, Cdl, AnOrdering)),
                    Orderings)) and
    callp(length(Orderings, N)) and
    callp(write('Number of possible orderings: ')) and
    callp(write(N)) and
    callp(random_permutation(Orderings, ShuffledOrderings)) and
    sum_multiple_cfu(ShuffledOrderings, CfuSum) and
    callp(min_l(ShuffledOrderings, CfuSum, Ordering, _))
).

rule(goal_cfu_backtrack_(PartialOrdering, RequiredCfu, SubYear, SubSemester, Cdl, Ordering) if
    taught_in(Exam, Cdl, _, _) and
    teaching(Exam, _, _, _) and
    callp(\+ member(Exam, PartialOrdering)) and
    callp(append(PartialOrdering, [Exam], NewOrdering)) and
    valid_teaching_list(NewOrdering, Cdl, SubYear, SubSemester) and
    respects_prerequisites([Exam], PartialOrdering, Cdl) and
    sum_cfu(NewOrdering, CfuSum) and 
    callp(CfuSum < RequiredCfu) and
    goal_cfu_backtrack_(NewOrdering, RequiredCfu, SubYear, SubSemester, Cdl, Ordering)
).

rule(goal_cfu_backtrack_(PartialOrdering, RequiredCfu, SubYear, SubSemester, Cdl, Ordering) if
    taught_in(Exam, Cdl, _, _) and
    teaching(Exam, _, _, _) and
    callp(\+ member(Exam, PartialOrdering)) and
    callp(append(PartialOrdering, [Exam], Ordering)) and
    valid_teaching_list(NewOrdering, Cdl, SubYear, SubSemester) and
    respects_prerequisites([Exam], PartialOrdering, Cdl) and
    sum_cfu(Ordering, CfuSum) and
    callp(CfuSum >= RequiredCfu)
).