:- op(1100, xfx, if).
:- op(1000, xfy, or).
:- op(900, xfy, and).
:- multifile rule/1.
:- dynamic rule/1.

/*
teaching(N, C, S, O) --> 
    N is the name of the teaching
    C is the number of cfu
    S is the ssd code of the teaching
    O is boolean, true if the teaching is optional

taught_by(T, V, N) --> 
    T is the name of the teaching
    V is the version of the teaching
    N is the name of the teacher

taught_in(T, C, Y, S) --> 
    T is the name of the teaching
    C is the cdl name
    Y is the year of the cdl in which the teaching is taught
    S is the semester in which the teaching is taught

credit_split(T, F, E, P) --> 
    T is the name of the teaching
    F is the number of credits for frontal teaching
    E is the number of credits for practical activities and exercises
    P is the number of credits for project
*/

/*
teachings for cdl(informatica, L_31).
*/

/*
first year of informatica
*/

rule(teaching('architettura degli elaboratori e sistemi operativi',9,'ing-inf/05',false) if true).
rule(taught_by('architettura degli elaboratori e sistemi operativi', 'a', 'giuseppe pirlo') if true).
rule(taught_by('architettura degli elaboratori e sistemi operativi', 'b', 'donato impedovo') if true).
rule(taught_in('architettura degli elaboratori e sistemi operativi', 'informatica', 1, 1) if true).
rule(credit_split('architettura degli elaboratori e sistemi operativi', 7, 2, 0) if true).

rule(teaching('matematica discreta',9,'mat/03',false) if true).
rule(taught_by('matematica discreta', 'a', 'luigia di terlizzi') if true).
rule(taught_by('matematica discreta', 'b', 'francesco bastianelli') if true).
rule(taught_in('matematica discreta', 'informatica', 1, 1) if true).
rule(credit_split('matematica discreta', 7, 2, 0) if true).


rule(teaching('programmazione',12,'inf/01',false) if true).
rule(taught_by('programmazione', 'a', 'fabio abbattista') if true).
rule(taught_by('programmazione', 'b', 'teresa roselli') if true).
rule(taught_in('programmazione', 'informatica', 1, 1) if true).
rule(credit_split('programmazione', 9, 3, 0) if true).


rule(teaching('analisi matematica',9,'mat/05',false) if true).
rule(taught_by('analisi matematica', 'a', 'marilena ligabò') if true).
rule(taught_by('analisi matematica', 'b', 'anna germinario') if true).
rule(taught_in('analisi matematica', 'informatica', 1, 2) if true).
rule(credit_split('analisi matematica', 7, 2, 0) if true).


rule(teaching('linguaggi di programmazione',9,'inf/01',false) if true).
rule(taught_by('linguaggi di programmazione', 'a', 'giovanni semeraro') if true).
rule(taught_by('linguaggi di programmazione', 'b', 'pasquale lops') if true).
rule(taught_in('linguaggi di programmazione', 'informatica', 1, 2) if true).
rule(credit_split('linguaggi di programmazione', 7, 2, 0) if true).


rule(teaching('laboratorio di informatica',6,'inf/01',false) if true).
rule(taught_by('laboratorio di informatica', 'a', 'fabio abbattista') if true).
rule(taught_by('laboratorio di informatica', 'b', 'veronica rossano') if true).
rule(taught_in('laboratorio di informatica', 'informatica', 1, 2) if true).
rule(credit_split('laboratorio di informatica', 3, 3, 0) if true).


rule(teaching('lingua inglese',6,'l-lin/12',false) if true).
rule(taught_by('lingua inglese', 'a', 'giovanni tucci') if true).
rule(taught_by('lingua inglese', 'b', 'giovanni tucci') if true).
rule(taught_in('lingua inglese', 'informatica', 1, 2) if true).
rule(credit_split('lingua inglese', 3, 3, 0) if true).


/*
second year of informatica
*/

rule(teaching('algoritmi e strutture dati',9,'inf/01',false) if true).
rule(taught_by('algoritmi e strutture dati', 'a', 'nicola di mauro') if true).
rule(taught_by('algoritmi e strutture dati', 'b', 'gianvito pio') if true).
rule(taught_in('algoritmi e strutture dati', 'informatica', 2, 1) if true).
rule(credit_split('algoritmi e strutture dati', 7, 2, 0) if true).


rule(teaching('basi di dati',9,'inf/01',false) if true).
rule(taught_by('basi di dati', 'a', 'paolo buono') if true).
rule(taught_by('basi di dati', 'b', 'claudia d\'amato') if true).
rule(taught_in('basi di dati', 'informatica', 2, 1) if true).
rule(credit_split('basi di dati', 7, 2, 0) if true).


rule(teaching('calcolo numerico',6,'mat/08',false) if true).
rule(taught_by('calcolo numerico', 'a', 'felice iavernaro') if true).
rule(taught_by('calcolo numerico', 'b', 'alessandro pugliese') if true).
rule(taught_in('calcolo numerico', 'informatica', 2, 1) if true).
rule(credit_split('calcolo numerico', 4, 2, 0) if true).


rule(teaching('fondamenti di fisica',6,'fis/07',false) if true).
rule(taught_by('fondamenti di fisica', 'a', 'leonardo di venere') if true).
rule(taught_by('fondamenti di fisica', 'b', 'francesco scattarella') if true).
rule(taught_in('fondamenti di fisica', 'informatica', 2, 1) if true).
rule(credit_split('fondamenti di fisica', 4, 2, 0) if true).


rule(teaching('ingegneria del software',9,'inf/01',false) if true).
rule(taught_by('ingegneria del software', 'a', 'filippo lanubile') if true).
rule(taught_by('ingegneria del software', 'b', 'filippo lanubile') if true).
rule(taught_in('ingegneria del software', 'informatica', 2, 2) if true).
rule(credit_split('ingegneria del software', 7, 2, 0) if true).


rule(teaching('metodi avanzati di programmazione',9,'ing-inf/05',false) if true).
rule(taught_by('metodi avanzati di programmazione', 'a', 'annalisa appice') if true).
rule(taught_by('metodi avanzati di programmazione', 'b', 'pierpaolo basile') if true).
rule(taught_in('metodi avanzati di programmazione', 'informatica', 2, 2) if true).
rule(credit_split('metodi avanzati di programmazione', 7, 2, 0) if true).


rule(teaching('calcolo delle probabilità e statistica',6,'mat/06',false) if true).
rule(taught_by('calcolo delle probabilità e statistica', 'a', 'stefano rossi') if true).
rule(taught_by('calcolo delle probabilità e statistica', 'b', 'stefano rossi') if true).
rule(taught_in('calcolo delle probabilità e statistica', 'informatica', 2, 2) if true).
rule(credit_split('calcolo delle probabilità e statistica', 4, 2, 0) if true).


rule(teaching('calcolabilità e complessità',6,'inf/01',false) if true).
rule(taught_by('calcolabilità e complessità', 'a', 'emanuele covino') if true).
rule(taught_by('calcolabilità e complessità', 'b', 'emanuele covino') if true).
rule(taught_in('calcolabilità e complessità', 'informatica', 2, 2) if true).
rule(credit_split('calcolabilità e complessità', 4, 2, 0) if true).

/*
third year of informatica
*/

rule(teaching('reti di calcolatori',9,'ing-inf/05',false) if true).
rule(taught_by('reti di calcolatori', 'a', 'nicole novielli') if true).
rule(taught_in('reti di calcolatori', 'informatica', 3, 1) if true).
rule(credit_split('reti di calcolatori', 7, 2, 0) if true).


rule(teaching('interazione uomo-macchina',6,'inf/01',false) if true).
rule(taught_by('interazione uomo-macchina', 'a', 'maria francesca costabile') if true).
rule(taught_in('interazione uomo-macchina', 'informatica', 3, 1) if true).
rule(credit_split('interazione uomo-macchina', 4, 2, 0) if true).


rule(teaching('ingegneria della conoscenza',6,'ing-inf/05',false) if true).
rule(taught_by('ingegneria della conoscenza', 'a', 'nicola fanizzi') if true).
rule(taught_in('ingegneria della conoscenza', 'informatica', 3, 1) if true).
rule(credit_split('ingegneria della conoscenza', 4, 1, 1) if true).


rule(teaching('metodi per il ritrovamento dell\'informazione',9,'ing-inf/05',false) if true).
rule(taught_by('metodi per il ritrovamento dell\'informazione', 'a', 'pasquale lops') if true).
rule(taught_in('metodi per il ritrovamento dell\'informazione', 'informatica', 3, 1) if true).
rule(credit_split('metodi per il ritrovamento dell\'informazione', 7, 2, 0) if true).


/*
optional teaching rules
*/

rule(teaching('sviluppo di videogiochi',6,'inf/01',true) if true).
rule(taught_by('sviluppo di videogiochi', 'a', 'pierpaolo basile') if true).
rule(taught_in('sviluppo di videogiochi', 'informatica', 3, 2) if true).
rule(credit_split('sviluppo di videogiochi', 4, 2, 0) if true).


rule(teaching('sistemi multimediali',6,'ing-inf/05',true) if true).
rule(taught_by('sistemi multimediali', 'a', 'giovanni dimauro') if true).
rule(taught_in('sistemi multimediali', 'informatica', 3, 2) if true).
rule(credit_split('sistemi multimediali', 4, 2, 0) if true).


rule(teaching('modelli e metodi per la sicurezza delle applicazioni',6,'inf/01',true) if true).
rule(taught_by('modelli e metodi per la sicurezza delle applicazioni', 'a', 'donato impedovo') if true).
rule(taught_in('modelli e metodi per la sicurezza delle applicazioni', 'informatica', 3, 2) if true).
rule(credit_split('modelli e metodi per la sicurezza delle applicazioni', 4, 2, 0) if true).


rule(teaching('sistemi ed agenti',6,'inf/01',true) if true).
rule(taught_by('sistemi ed agenti', 'a', 'berardina de carolis') if true).
rule(taught_in('sistemi ed agenti', 'informatica', 3, 2) if true).
rule(credit_split('sistemi ed agenti', 4, 0, 2) if true).