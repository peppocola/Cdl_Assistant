:- op(1100, xfx, if).
:- op(1000, xfy, and).
:- op(900, xfy, or).
:- multifile rule/1.
:- dynamic rule/1.

rule(is_prerequisite_ssd('programmazione', 'inf/01', 2, 1, 'informatica') if true).
rule(is_prerequisite_ssd('programmazione', 'inf/01', 2, 2, 'informatica') if true).
rule(is_prerequisite_ssd('programmazione', 'ing-inf/05', 2, 1, 'informatica') if true).
rule(is_prerequisite_ssd('programmazione', 'ing-inf/05', 2, 2, 'informatica') if true).
rule(is_prerequisite_ssd('architettura degli elaboratori e sistemi operativi', 'inf/01', 2, 1, 'informatica') if true).
rule(is_prerequisite_ssd('architettura degli elaboratori e sistemi operativi', 'inf/01', 2, 2, 'informatica') if true).
rule(is_prerequisite_ssd('architettura degli elaboratori e sistemi operativi', 'ing-inf/05', 2, 1, 'informatica') if true).
rule(is_prerequisite_ssd('architettura degli elaboratori e sistemi operativi', 'ing-inf/05', 2, 2, 'informatica') if true).
rule(is_prerequisite_ssd('laboratorio di informatica', 'ing-inf/05', 2, 2, 'informatica') if true).
rule(is_prerequisite(PExam, TExam, 'informatica') if 
        teaching(PExam, _, _, _) and
        teaching(TExam, _, Category, _) and
        taught_in(TExam, 'informatica', Year, Semester) and
        taught_in(PExam, 'informatica', _, _) and
        is_prerequisite_ssd(PExam, Category, Year, Semester, 'informatica') and
        callp(not(PExam = TExam))
    ).
rule(is_prerequisite('analisi matematica','calcolo numerico', 'informatica') if true).
rule(is_prerequisite('programmazione','basi di dati', 'informatica') if true).
rule(is_prerequisite('architettura degli elaboratori e sistemi operativi','basi di dati', 'informatica') if true).
rule(is_prerequisite('architettura degli elaboratori e sistemi operativi', 'reti di calcolatori', 'informatica') if true).
rule(is_prerequisite('programmazione', 'reti di calcolatori', 'informatica') if true).
rule(is_prerequisite('laboratorio di informatica', 'reti di calcolatori', 'informatica') if true).
rule(is_prerequisite('linguaggi di programmazione', 'reti di calcolatori', 'informatica') if true).
rule(is_prerequisite('linguaggi di programmazione', 'metodi per il ritrovamento dell\'informazione', 'informatica') if true).
rule(is_prerequisite('matematica discreta', 'metodi per il ritrovamento dell\'informazione', 'informatica') if true).
rule(is_prerequisite('calcolo delle probabilità e statistica', 'metodi per il ritrovamento dell\'informazione', 'informatica') if true).
rule(is_prerequisite('algoritmi e strutture dati', 'metodi per il ritrovamento dell\'informazione', 'informatica') if true).

rule(is_suggested_prerequisite('programmazione', 'linguaggi di programmazione', 'informatica') if true).
rule(is_suggested_prerequisite('matematica discreta', 'linguaggi di programmazione', 'informatica') if true).
rule(is_suggested_prerequisite('programmazione', 'laboratorio di informatica', 'informatica') if true).
rule(is_suggested_prerequisite('matematica discreta', 'basi di dati', 'informatica') if true).
rule(is_suggested_prerequisite('linguaggi di programmazione', 'basi di dati', 'informatica') if true).
rule(is_suggested_prerequisite('laboratorio di informatica', 'ingegneria del software', 'informatica') if true).
rule(is_suggested_prerequisite('linguaggi di programmazione', 'ingegneria del software', 'informatica') if true).

% third year prerequisite : do 6 exams of the first year
rule(third_year_prerequisite(DoneExams, 'informatica') if
    third_year_prerequisite_no(DoneExams, 'informatica', N) and
    callp(N >= 6)
).

rule(third_year_prerequisite_no([], 'informatica', 0) if true).
rule(third_year_prerequisite_no([DoneExam|DoneExams], 'informatica', N) if 
        teaching(DoneExam, _, _, _) and
        (
            (
                third_year_prerequisite_no(DoneExams, 'informatica', Ne) and
                taught_in(DoneExam, 'informatica', 1, _) and
                callp(N is Ne + 1)
            )or
            (
                third_year_prerequisite_no(DoneExams, 'informatica', N)
            )
        )
).
        
% second year prerequisite : do 2 exams of the categories [inf/01, ing-inf/05]
rule(second_year_prerequisite(DoneExams, 'informatica') if
    second_year_prerequisite_no(DoneExams, 'informatica', N) and
    callp(N >= 2)
).
rule(second_year_prerequisite_no([], 'informatica', 0) if true).
rule(second_year_prerequisite_no([DoneExam|DoneExams], 'informatica', N) if 
    (
        (
            second_year_prerequisite_no(DoneExams, 'informatica', Ne) and
            teaching(DoneExam, _, Category, _) and
            taught_in(DoneExam, 'informatica', 1, _) and
            (
                callp(Category = 'inf/01') or
                callp(Category = 'ing-inf/05')
            ) and
            callp(N is Ne + 1)
        )
        or
        (
            second_year_prerequisite_no(DoneExams, 'informatica', N)
        )
    )
).
        

% math prerequisite : do a math exam or do admission test
rule(math_prerequisite([DoneExam|DoneExams], 'informatica') if
    teaching(DoneExam, _, Category, _) and
        (
            callp(DoneExam = 'test di ammissione')
            or
            (
                taught_in(DoneExam, 'informatica', 1, _) and
                callp(sub_string(Category, _, _, _, 'mat/'))
            ) 
            or 
            math_prerequisite(DoneExams, 'informatica')
        )
).


rule(get_standard_prerequisites(Exam, DoneExams, 'informatica', Prerequisites) if
    % get the prerequisites of ToDoExam
    callp(find_all(TeachingName, is_prerequisite(TeachingName, Exam, 'informatica'), PrerequisiteTeachingNames)) and
    % some prerequisites could be already done, check if there are some
    % remove them from the prerequisite list
    callp(subtract(PrerequisiteTeachingNames, DoneExams, ToFilterPrerequisites)) and
    % remove duplicates
    callp(list_to_set(ToFilterPrerequisites, Prerequisites))
).

rule(get_math_prerequisites(_, Year, 'informatica', Prerequisites) if
    (
        callp(Year = 1) or
        callp(Year = 3)
    )and 
    callp(Prerequisites = [])
).

rule(get_math_prerequisites(DoneExams, Year, 'informatica', Prerequisites) if
    callp(Year = 2) and
    (
        (   % if math prerequisite is satisfied, no math prerequisites
            math_prerequisite(DoneExams, 'informatica') and
            callp(MathPrerequisites = [])
        )
        or
        (
            % if not take all exams that can help satisfy prerequisite
            callp(find_all(Teaching,
                (
                    teaching(Teaching, _, Category, _) and
                    taught_in(Teaching, 'informatica', 1, _) and
                    callp(sub_string(Category, _, _, _, 'mat/'))
                ), MathPrerequisites))
        )
    )and
    callp(subtract(MathPrerequisites, DoneExams, Prerequisites))
).

rule(get_year_prerequisites(_, Year, 'informatica', YearPrerequisites) if 
    callp(Year = 1) and
    callp(YearPrerequisites = [])
).

rule(get_year_prerequisites(DoneExams, Year, 'informatica', Prerequisites) if
    callp(Year = 2) and
    (
        (
            % if second year prerequisite is satisfied
            second_year_prerequisite(DoneExams, 'informatica') and
            callp(SYPrerequisites = [])
        )
        or
        (
            % if not take all exams that can help satisfy prerequisite
            callp(find_all(Teaching, 
                (
                    teaching(Teaching, _, Category, _) and
                    taught_in(Teaching, 'informatica', 1, _) and
                    (
                        callp(Category = 'inf/01') or
                        ( 
                            callp(\+(Category = 'inf/01')) and
                            callp(Category = 'ing-inf/05')
                        )
                    )
                ), SYPrerequisites))
        ) 
    )and
    callp(subtract(SYPrerequisites, DoneExams, Prerequisites))
).

rule(get_year_prerequisites(DoneExams, Year, 'informatica', Prerequisites) if
    callp(Year = 3) and
    (
        (   % if third year prerequisite is satisfied
            third_year_prerequisite(DoneExams, 'informatica') and
            callp(TYPrerequisites = [])
        )
        or
        (   % if not take all exams that can help satisfy prerequisite
            callp(find_all(Teaching, taught_in(Teaching, 'informatica', 1, _), TYPrerequisites))
        )
    )and
    callp(subtract(TYPrerequisites, DoneExams, Prerequisites))
).

rule(pick_prerequisites(STPrerequisites, MathPrerequisites, YearPrerequisites, Prerequisites) if
    callp(intersection(STPrerequisites, MathPrerequisites, ST_M_Intersection)) and
    callp(intersection(ST_M_Intersection, YearPrerequisites, Intersection)) and
    (
        (   % if there are exams that can satisfy all prerequisites, prioritize them
            callp(\+ Intersection = []) and
            callp(Prerequisites = Intersection)
        )
        or
        (   % if there are exams that can satisfy two kind of prerequisites, prioritize them
            callp(intersection(YearPrerequisites, MathPrerequisites, Y_M_Intersection)) and
            callp(intersection(STPrerequisites, YearPrerequisites, ST_YIntersection)) and
            callp(union(Y_M_Intersection, ST_YIntersection, PartialUnion)) and
            callp(union(PartialUnion, ST_M_Intersection, Union)) and
            % union contains exam that can help satisfying two kind of prerequisites
            (
                (
                    callp(\+ Union = []) and
                    callp(Prerequisites = Union)
                )
            or
                (   % else take the exams that can help satisfying one kind of prerequisites
                    callp(append(STPrerequisites, MathPrerequisites, PartialPrerequisites)) and
                    callp(append(PartialPrerequisites, YearPrerequisites, Prerequisites))
                )
            )
        )
    )
).

rule(set_of_prioritized_prerequisites(Exam, DoneExams, 'informatica', Prerequisites) if
    taught_in(Exam, 'informatica', Year, _) and
    get_standard_prerequisites(Exam, DoneExams, 'informatica', STPrerequisites) and
    get_math_prerequisites(DoneExams, Year, 'informatica', MathPrerequisites) and
    get_year_prerequisites(DoneExams, Year, 'informatica', YearPrerequisites) and
    pick_prerequisites(STPrerequisites, MathPrerequisites, YearPrerequisites, Prerequisites)
).

rule(pick_multiple_priority_exam(SetExams, CompareExams, DoneExams, 'informatica', Exam) if
    count_multiple_prerequisites(SetExams, CompareExams, DoneExams, 'informatica', Lens) and
    callp(min_l(CompareExams, Lens, Exam, _))
).

rule(count_multiple_prerequisites(SetExams, [CompareExam|CompareExams], DoneExams, 'informatica', [Count|Counts]) if
    count_prerequisites_list(SetExams, [CompareExam|DoneExams], 'informatica', Len) and
    callp(sum_list(Len, Count)) and
    count_multiple_prerequisites(SetExams, CompareExams, DoneExams, 'informatica', Counts)
).
rule(count_multiple_prerequisites(_, [], _, _, []) if true).

rule(count_prerequisites_list([Exam|Exams], DoneExams, 'informatica', [Len|Lens]) if
    count_prerequisites(Exam, DoneExams, 'informatica', Len) and
    count_prerequisites_list(Exams, DoneExams, 'informatica', Lens)
).
rule(count_prerequisites_list([], _, _, []) if true).

rule(count_prerequisites(Exam, DoneExams, 'informatica', Len) if
    taught_in(Exam, 'informatica', Year, _) and
    get_standard_prerequisites(Exam, DoneExams, 'informatica', STPrerequisites) and
    get_math_prerequisites(DoneExams, Year, 'informatica', MathPrerequisites) and
    get_year_prerequisites(DoneExams, Year, 'informatica', YearPrerequisites) and
    callp(length(STPrerequisites, L1)) and
    callp(length(MathPrerequisites, L2)) and
    callp(length(YearPrerequisites, L3)) and
    callp(Len is L1 + L2 + L3)
).

rule(respects_prerequisites([OrderedExam], DoneExams, 'informatica') if 
    set_of_prioritized_prerequisites(OrderedExam, DoneExams, 'informatica', [])
).
rule(respects_prerequisites([OrderedExam|OrderedExams], DoneExams, 'informatica') if
    set_of_prioritized_prerequisites(OrderedExam, DoneExams, 'informatica', []) and
    respects_prerequisites(OrderedExams, [OrderedExam|DoneExams], 'informatica')
).

rule(set_of_suggested_prerequisites(Exam, 'informatica', SuggestedPrerequisites) if
    callp(find_all(TeachingName, is_suggested_prerequisite(TeachingName, Exam), SuggestedPrerequisites))
).

% this aims to pick the exam which satisfies more prerequisites
rule(pick_priority_exam(Exams, DoneExams, 'informatica', Exam) if
    count_prerequisites_list(Exams, DoneExams, 'informatica', Lens) and
    callp(min_l(Exams, Lens, Exam, _))
).

% this aims to pick the exam which has more standard prerequisites
rule(pick_standard_priority_exam(Exams, DoneExams, 'informatica', Exam) if 
    count_standard_prerequisites(Exams, DoneExams, 'informatica', Lens) and
    callp(max_l(Exams, Lens, Exam, _))
).

rule(count_standard_prerequisites([Exam|Exams], DoneExams, 'informatica', [Len|Lens]) if
    get_standard_prerequisites(Exam, DoneExams, 'informatica', STPrerequisites) and
    callp(length(STPrerequisites, Len)) and
    count_standard_prerequisites(Exams, DoneExams, 'informatica', Lens)
).
rule(count_standard_prerequisites([], _, _, []) if true).

rule(union_prerequisites([Exam|Exams], DoneExams, Cdl, UnionPrerequisites) if
    set_of_prioritized_prerequisites(Exam, DoneExams, Cdl, Prerequisites) and
    union_prerequisites(Exams, DoneExams, Cdl, OtherPrerequisites) and
    callp(union(Prerequisites, OtherPrerequisites, UnionPrerequisites))
).
rule(union_prerequisites([], _, _, []) if true).