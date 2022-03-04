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
rule(is_suggested_prerequisite('programmazione', 'ingegneria del software') if true).
rule(is_suggested_prerequisite('programmazione', 'ingegneria del software') if true).
rule(is_suggested_prerequisite('laboratorio di informatica', 'ingegneria del software') if true).
rule(is_suggested_prerequisite('linguaggi di programmazione', 'ingegneria del software') if true).

% Dynamic prerequisites

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

rule(math_prerequisite([DoneExam|DoneExams], 'informatica') if
        teaching(DoneExam, _, Category, _) and
        (
            (
                taught_in(DoneExam, 'informatica', 1, _) and
                callp(sub_string(Category, _, _, _, 'mat/'))
            ) or 
            math_prerequisite(DoneExams, 'informatica')
        )
    ).

rule(dynamic_prerequisites(ToDoExam, _, 'informatica') if
    taught_in(ToDoExam, 'informatica', 1, _)
).

rule(dynamic_prerequisites(ToDoExam, DoneExams, 'informatica') if
    taught_in(ToDoExam, 'informatica', 2, _) and
    math_prerequisite(DoneExams, 'informatica') and
    second_year_prerequisite(DoneExams, 'informatica')
).

rule(dynamic_prerequisites(ToDoExam, DoneExams, 'informatica') if
    taught_in(ToDoExam, 'informatica', 3, _) and
    math_prerequisite(DoneExams, 'informatica') and
    third_year_prerequisite(DoneExams, 'informatica')
).

rule(set_of_dynamic_prerequisites(Exam, _, 'informatica', Prerequisites) if
    taught_in(Exam, 'informatica', 1, _) and
    callp(Prerequisites=[])
).

rule(set_of_dynamic_prerequisites(Exam, DoneExams, 'informatica', Prerequisites) if
    taught_in(Exam, 'informatica', 2, _) and
    % check math prerequisite
    (
        (
            % if math prerequisite is satisfied -- []
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
        
    ) and
    % check second year prerequisite
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
    ) and
    % concatenate found prerequisites
    callp(append(MathPrerequisites, SYPrerequisites, Prerequisites))
).

rule(set_of_dynamic_prerequisites(Exam, DoneExams, 'informatica', Prerequisites) if
    % remove from DoneExams from Prerequisites
    taught_in(Exam, 'informatica', 3, _) and
    % check math prerequisite
    (
        (
            % if math prerequisite is satisfied -- []
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
                    callp(sub_string(Category, _, _, _, 'MAT/'))
                ), MathPrerequisites))
        )
        
    ) and
    % check third year prerequisite
    (
        (
            % if third year prerequisite is satisfied -- []
            third_year_prerequisite(DoneExams, 'informatica') and
            callp(TYPrerequisites = [])
        )
        or
        (
            % if not take all exams that can help satisfy prerequisite
            callp(find_all(Teaching, taught_in(Teaching, 'informatica', 1, _), TYPrerequisites))
        ) 
    ) and
    % concatenate found prerequisites
    callp(append(MathPrerequisites, TYPrerequisites, PartialPrerequisites)) and
    callp(subtract(PartialPrerequisites, DoneExams, Prerequisites))
).