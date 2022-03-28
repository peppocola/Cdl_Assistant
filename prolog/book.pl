:- op(1100, xfx, if).
:- op(1000, xfy, or).
:- op(900, xfy, and).
:- multifile rule/1.
:- dynamic rule/1.
:- discontiguous book/3.
:- discontiguous suggested_for/2.

/*
book(N, I, A) -->
    N is the name of the book
    I is the ISBN of the book
    A is the author of the book

suggested_for(B, T) -->
    B is the book suggested for teaching T
    T is the teaching for which the book B is suggested 
*/

rule(book('architettura dei calcolatori. un approccio strutturale','978-8871929620', 'tanenbaum') if true).
rule(book('sistemi operativi concetti ed esempi','978-8891904553', 'silberschatz') if true).
rule(book('sistemi operativi','978-8825616576', 'stallings') if true).

rule(suggested_for('architettura dei calcolatori. un approccio strutturale', 'architettura degli elaboratori e sistemi operativi') if true).
rule(suggested_for('sistemi operativi concetti ed esempi', 'architettura degli elaboratori e sistemi operativi') if true).
rule(suggested_for('sistemi operativi', 'architettura degli elaboratori e sistemi operativi') if true).


rule(book('algebra e matematica discreta', '978-8808097392', 'facchini') if true).
rule(book('matematica discreta', '978-8808068132', 'piacentini cattaneo') if true).
rule(book('introduzione alla matematica discreta', '978-8838662294', 'bianchi') if true).
rule(book('discrete mathematics and its applications', '978-0073383095', 'rosen') if true).

rule(suggested_for('algebra e matematica discreta', 'matematica discreta') if true).
rule(suggested_for('matematica discreta', 'matematica discreta') if true).
rule(suggested_for('introduzione alla matematica discreta', 'matematica discreta') if true).
rule(suggested_for('discrete mathematics and its applications', 'matematica discreta') if true).


rule(book('il linguaggio c - fondamenti e tecniche di programmazione', '978-8891901651', 'deitel') if true).
rule(book('pensare in python', '978-8823822641', 'downey') if true).
rule(book('fondamenti di programmazione dei calcolatori elettronici', '978-8820438197', 'batini') if true).
rule(book('algoritmi fondamentali', '978-8870567380', 'dromey') if true).

rule(suggested_for('il linguaggio c - fondamenti e tecniche di programmazione', 'programmazione') if true).
rule(suggested_for('pensare in python', 'programmazione') if true).
rule(suggested_for('fondamenti di programmazione dei calcolatori elettronici', 'programmazione') if true).
rule(suggested_for('algoritmi fondamentali', 'programmazione') if true).


rule(book('analisi matematica 1', '978-8808064851', 'bramanti') if true).
rule(book('elementi di analisi matematica', '978-8808062550', 'barozzi') if true).
rule(book('esercitazioni di analisi matematica 1', '978-8874884445', 'bramanti') if true).

rule(suggested_for('analisi matematica 1', 'analisi matematica') if true).
rule(suggested_for('elementi di analisi matematica', 'analisi matematica') if true).
rule(suggested_for('esercitazioni di analisi matematica 1', 'analisi matematica') if true).


rule(book('elementi di teoria dei linguaggi formali', '0', 'semeraro') if true).
rule(book('linguaggi di programmazione, principi e paradigmi', '978-8838665738', 'gabbrielli') if true).

rule(sugggested_for('elementi di teoria dei linguaggi formali', 'linguaggi di programmazione') if true).
rule(sugggested_for('linguaggi di programmazione, principi e paradigmi', 'linguaggi di programmazione') if true).


rule(book('corso completo di programmazione', '978-8850329540', 'deitel') if true).
rule(book('il linguaggio c. principi di programmazione e manuale di riferimento.', '978-8838665738', 'kernighan') if true).

rule(suggested_for('il linguaggio c - fondamenti e tecniche di programmazione', 'laboratorio di programmazione') if true).
rule(suggested_for('pensare in python', 'laboratorio di programmazione') if true).
rule(suggested_for('corso completo di programmazione', 'laboratorio di programmazione') if true).
rule(suggested_for('il linguaggio c. principi di programmazione e manuale di riferimento.', 'laboratorio di programmazione') if true).


rule(book('english in computer science and mathematics', '978-8875220099', 'rudd') if true).

rule(suggested_for('english in computer science and mathematics', 'lingua inglese') if true).


rule(book('algoritmi e strutture di dati', '978-8825173956', 'bertossi') if true).
rule(book('fondamenti della progettazione dei programmi', '978-8825171617', 'cadoli') if true).
rule(book('algoritmi e strutture dati', '978-8838664687', 'demetrescu') if true).
rule(book('strutture di dati e algoritmi', '978-8871922737', 'crescenzi') if true).
rule(book('introduzione agli algoritmi e strutture dati', '978-8838665158', 'cormen') if true).
rule(book('data structures and algorithm analysis', '978-0486485829', 'clifford') if true).

rule(suggested_for('algoritmi e strutture di dati', 'algoritmi e strutture dati') if true).
rule(suggested_for('fondamenti della progettazione dei programmi', 'algoritmi e strutture dati') if true).
rule(suggested_for('algoritmi e strutture dati', 'algoritmi e strutture dati') if true).
rule(suggested_for('strutture di dati e algoritmi', 'algoritmi e strutture dati') if true).
rule(suggested_for('introduzione agli algoritmi e strutture dati', 'algoritmi e strutture dati') if true).
rule(suggested_for('data structures and algorithm analysis', 'algoritmi e strutture dati') if true).


rule(book('basi di dati', '978-8838668005', 'atzeni') if true).
rule(book('sistemi di basi di dati. fondamenti', '978-8871926285', 'elmasri') if true).
rule(book('mysql tutorial', '978-0672325847', 'welling') if true).

rule(suggested_for('basi di dati', 'basi di dati') if true).
rule(suggested_for('sistemi di basi di dati. fondamenti', 'basi di dati') if true).
rule(suggested_for('mysql tutorial', 'basi di dati') if true).


rule(book('intro to numerical analysis 2e','978-0471624899','atkinson') if true).
rule(book('calcolo scientifico. esercizi e problemi risolti con matlab e octave','978-8847039520','quarteroni') if true).

rule(suggested_for('intro to numerical analysis 2e','calcolo numerico') if true).
rule(suggested_for('calcolo scientifico. esercizi e problemi risolti con matlab e octave','calcolo numerico') if true).


rule(book('fondamenti di fisica', '978-8808182296', 'halliday') if true).

rule(suggested_for('fondamenti di fisica', 'fondamenti di fisica') if true).


rule(book('object-oriented software engineering using uml, patterns, and java', '978-0130471109', 'bruegge') if true).

rule(suggested_for('object-oriented software engineering using uml, patterns, and java', 'ingegneria del software') if true).


rule(book('linguaggi per la programmazione a oggetti', '978-8825603040', 'masini') if true).
rule(book('programming language concepts and paradigms', '978-0137288748', 'watt') if true).
rule(book('thinking in java', '978-0131872486', 'eckel') if true).
rule(book('programmazione di base e avanzata con java', '978-8865181904', 'savitch') if true).

rule(suggested_for('linguaggi per la programmazione a oggetti', 'metodi avanzati di programmazione') if true).
rule(suggested_for('programming language concepts and paradigms', 'metodi avanzati di programmazione') if true).
rule(suggested_for('thinking in java', 'metodi avanzati di programmazione') if true).
rule(suggested_for('programmazione di base e avanzata con java', 'metodi avanzati di programmazione') if true).


rule(book('calcolo delle probabilità', '978-8838666957', 'baldi') if true).
rule(book('probabilità e statistica per l\'ingegneria e le scienze', '978-8891609946', 'ross') if true).

rule(suggested_for('calcolo delle probabilità', 'calcolo delle probabilità e statistica') if true).
rule(suggested_for('probabilità e statistica per l\'ingegneria e le scienze', 'calcolo delle probabilità e statistica') if true).


rule(book('introduzione alla teoria della computazione', '978-8891616180', 'sipser') if true).
rule(book('linguaggi, modelli, complessità', '978-8891705532', 'ausiello') if true).

rule(suggested_for('introduzione alla teoria della computazione', 'calcolabilità e complessità') if true).
rule(suggested_for('linguaggi, modelli, complessità', 'calcolabilità e complessità') if true).


rule(book('reti di calcolatori e internet. un approccio top-down.', '978-8871929385', 'kurose') if true).
rule(book('tcp/ip sockets in c: practical guide for programmers.', '978-0123745408', 'donahoo') if true).

rule(suggested_for('reti di calcolatori e internet. un approccio top-down.', 'reti di calcolatori') if true).
rule(suggested_for('tcp/ip sockets in c: practical guide for programmers.', 'reti di calcolatori') if true).

rule(book('facile da usare. una moderna introduzione all\'ingegneria dell\'usabilità', '978-8850329236', 'polillo') if true).
rule(book('human-computer interaction. i fondamenti dell\'interazione tra persone e tecnologie', '978-8871927824', 'gamberini') if true).

rule(suggested_for('facile da usare. una moderna introduzione all\'ingegneria dell\'usabilità', 'interazione uomo-macchina') if true).
rule(suggested_for('human-computer interaction. i fondamenti dell\'interazione tra persone e tecnologie', 'interazione uomo-macchina') if true).


rule(book(' artificial intelligence: foundations of computational agents', '978-1107195394', 'poole') if true).
rule(book('artificial intelligence: a modern approach', '978-0136042594', 'russel') if true).

rule(suggested_for(' artificial intelligence: foundations of computational agents', 'ingegneria della conoscenza') if true).
rule(suggested_for('artificial intelligence: a modern approach', 'ingegneria della conoscenza') if true).


rule(book('modern information retrieval: the concepts and technology behind search', '978-0321416919', 'baeza-yates') if true).
rule(book('introduction to information retrieval', '978-0521865715', 'manning') if true).
rule(book('recommender systems: an introduction', '978-0521493369', 'jannach') if true).

rule(suggested_for('modern information retrieval: the concepts and technology behind search', 'metodi per il ritrovamento dell\'informazione') if true).
rule(suggested_for('introduction to information retrieval', 'metodi per il ritrovamento dell\'informazione') if true).
rule(suggested_for('recommender systems: an introduction', 'metodi per il ritrovamento dell\'informazione') if true).


rule(book('introduction to game development', '978-1584506799', 'rabin') if true).
rule(book('introduction to game design, prototyping, and development: from concept to playable game - with unity and c#', '978-0321933164', 'gibson') if true).

rule(suggested_for('introduction to game development', 'sviluppo di videogiochi') if true).
rule(suggested_for('introduction to game design, prototyping, and development: from concept to playable game - with unity and c#', 'sviluppo di videogiochi') if true).


rule(book('sistemi multimediali. dalla progettazione degli elementi all\'e-learning', '978-8854826908', 'dimauro') if true).

rule(suggested_for('sistemi multimediali. dalla progettazione degli elementi all\'e-learning', 'sistemi multimediali') if true).


rule(book('handbook of biometrics', '978-0387710402', 'jain') if true).
rule(book('biometric systems: technology, design and performance evaluation', '978-1849968867', 'wayman') if true).
rule(book('handbook of document image processing and recognition', '978-0857298607', 'doermann') if true).

rule(suggested_for('handbook of biometrics', 'modelli e metodi per la sicurezza delle applicazioni') if true).
rule(suggested_for('biometric systems: technology, design and performance evaluation', 'modelli e metodi per la sicurezza delle applicazioni') if true).
rule(suggested_for('handbook of document image processing and recognition', 'modelli e metodi per la sicurezza delle applicazioni') if true).


rule(suggested_for('artificial intelligence: a modern approach', 'sistemi ed agenti') if true).