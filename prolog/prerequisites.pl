:- op(1100, xfx, if).
:- op(1000, xfy, and).
:- op(900, xfy, or).
:- multifile rule/1.
:- dynamic rule/1.

rule(is_prerequisite_ssd('programmazione', 'inf/01', 2, 1) if true).
rule(is_prerequisite_ssd('programmazione', 'inf/01', 2, 2) if true).
rule(is_prerequisite_ssd('programmazione', 'ing-inf/05', 2, 1) if true).
rule(is_prerequisite_ssd('programmazione', 'ing-inf/05', 2, 2) if true).
rule(is_prerequisite_ssd('architettura degli elaboratori e sistemi operativi', 'inf/01', 2, 1) if true).
rule(is_prerequisite_ssd('architettura degli elaboratori e sistemi operativi', 'inf/01', 2, 2) if true).
rule(is_prerequisite_ssd('architettura degli elaboratori e sistemi operativi', 'ing-inf/05', 2, 1) if true).
rule(is_prerequisite_ssd('architettura degli elaboratori e sistemi operativi', 'ing-inf/05', 2, 2) if true).
rule(is_prerequisite_ssd('laboratorio di informatica', 'ing-inf/05', 2, 2) if true).
rule(is_prerequisite(PExam, TExam) if 
        teaching(PExam, _, _, _) and
        teaching(TExam, _, Category, _) and
        taught_in(TExam, Cdl, Year, Semester) and
        taught_in(PExam, Cdl, _, _) and
        is_prerequisite_ssd(PExam, Category, Year, Semester) and
        callp(not(PExam = TExam))
    ).
rule(is_prerequisite('analisi matematica','calcolo numerico') if true).
rule(is_prerequisite('programmazione','basi di dati') if true).
rule(is_prerequisite('architettura degli elaboratori e sistemi operativi','basi di dati') if true).
rule(is_prerequisite('architettura degli elaboratori e sistemi operativi', 'reti di calcolatori') if true).
rule(is_prerequisite('programmazione', 'reti di calcolatori') if true).
rule(is_prerequisite('laboratorio di informatica', 'reti di calcolatori') if true).
rule(is_prerequisite('linguaggi di programmazione', 'reti di calcolatori') if true).
rule(is_prerequisite('linguaggi di programmazione', 'metodi per il ritrovamento dell\'informazione') if true).
rule(is_prerequisite('matematica discreta', 'metodi per il ritrovamento dell\'informazione') if true).
rule(is_prerequisite('calcolo delle probabilità e statistica', 'metodi per il ritrovamento dell\'informazione') if true).
rule(is_prerequisite('algoritmi e strutture dati', 'metodi per il ritrovamento dell\'informazione') if true).

rule(is_suggested_prerequisite('programmazione', 'linguaggi di programmazione') if true).
rule(is_suggested_prerequisite('matematica discreta', 'linguaggi di programmazione') if true).
rule(is_suggested_prerequisite('programmazione', 'laboratorio di informatica') if true).
rule(is_suggested_prerequisite('matematica discreta', 'basi di dati') if true).
rule(is_suggested_prerequisite('linguaggi di programmazione', 'basi di dati') if true).
rule(is_suggested_prerequisite('laboratorio di informatica', 'ingegneria del software') if true).
rule(is_suggested_prerequisite('linguaggi di programmazione', 'ingegneria del software') if true).

% third year prerequisite : do 6 exams of the first year
rule(third_year_prerequisite(DoneExams, 'informatica') if
    third_year_prerequisite_no(DoneExams, 'informatica', 6)).
rule(third_year_prerequisite_no(_, 'informatica', 0) if true).
rule(third_year_prerequisite_no([DoneExam|DoneExams], 'informatica', N) if 
        teaching(DoneExam, _, _, _) and
        taught_in(DoneExam, 'informatica', 1, _) and 
        callp(succ(Ne, N)) and
        third_year_prerequisite_no(DoneExams, 'informatica', Ne)
    ).
rule(third_year_prerequisite_no([_|DoneExams], 'informatica', N) if 
        third_year_prerequisite_no(DoneExams, 'informatica', N)).

% third year prerequisite : do 2 exams of the categories [inf/01, ing-inf/05]
rule(second_year_prerequisite(DoneExams, 'informatica') if
    second_year_prerequisite_no(DoneExams, 'informatica', 2)).
rule(second_year_prerequisite_no(_, 'informatica', 0) if true).
rule(second_year_prerequisite_no([DoneExam|DoneExams], 'informatica', N) if 
        teaching(DoneExam, _, Category, _) and
        taught_in(DoneExam, 'informatica', 1, _) and
        (
            callp(Category = 'inf/01') or
            callp(Category = 'ing-inf/05')
        ) and
        callp(succ(Ne, N)) and
        second_year_prerequisite_no(DoneExams, 'informatica', Ne)
    ).
rule(second_year_prerequisite_no([_|DoneExams], 'informatica', N) if 
        second_year_prerequisite_no(DoneExams, 'informatica', N)).

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


rule(get_standard_prerequisites(Exam, DoneExams, Prerequisites) if
    % get the prerequisites of ToDoExam
    callp(find_all(TeachingName, is_prerequisite(TeachingName, Exam), PrerequisiteTeachingNames)) and
    % some prerequisites could be already done, check if there are some
    % remove them from the prerequisite list
    callp(subtract(PrerequisiteTeachingNames, DoneExams, ToFilterPrerequisites)) and
    % remove duplicates
    callp(list_to_set(ToFilterPrerequisites, Prerequisites))
).

rule(get_math_prerequisites(_, Year, Prerequisites) if
    callp(Year = 1) and
    callp(Prerequisites = [])
).

rule(get_math_prerequisites(DoneExams, Year, Prerequisites) if
    callp(Year > 1) and
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

rule(get_year_prerequisites(_, Year, YearPrerequisites) if 
    callp(Year = 1) and
    callp(YearPrerequisites = [])
).

rule(get_year_prerequisites(DoneExams, Year, Prerequisites) if
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

rule(get_year_prerequisites(DoneExams, Year, Prerequisites) if
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

rule(pick_prerequisite(STPrerequisites, MathPrerequisites, YearPrerequisites, Prerequisites) if
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

rule(set_of_prioritized_prerequisites(Exam, DoneExam, 'informatica', Prerequisites) if
    taught_in(Exam, 'informatica', Year, _) and
    get_standard_prerequisites(Exam, DoneExam, STPrerequisites) and
    get_math_prerequisites(DoneExam, Year, MathPrerequisites) and
    get_year_prerequisites(DoneExam, Year, YearPrerequisites) and
    pick_prerequisite(STPrerequisites, MathPrerequisites, YearPrerequisites, Prerequisites)
).

rule(respects_prerequisites([OrderedExam], DoneExams, 'informatica') if 
    set_of_prioritized_prerequisites(OrderedExam, DoneExams, 'informatica', [])
).
rule(respects_prerequisites([OrderedExam|OrderedExams], DoneExams, 'informatica') if
    set_of_prioritized_prerequisites(OrderedExam, DoneExams, 'informatica', []) and
    respects_prerequisites(OrderedExams, [OrderedExam|DoneExams], 'informatica')
).

rule(set_of_suggested_prerequisites(Exam, SuggestedPrerequisites) if
    callp(find_all(TeachingName, is_suggested_prerequisite(TeachingName, Exam), SuggestedPrerequisites))
).