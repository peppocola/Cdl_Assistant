:- op(1100, xfx, if).
:- op(1000, xfy, or).
:- op(900, xfy, and).
:- multifile rule/1.
:- dynamic rule/1.

/*
covers(T, O) --> 
    T is the name of the teaching
    O is the topic covered by the teaching
*/

rule(covers('architettura degli elaboratori e sistemi operativi','organizzazione dei sistemi di calcolo') if true).
rule(covers('architettura degli elaboratori e sistemi operativi','livello logico digitale') if true).
rule(covers('architettura degli elaboratori e sistemi operativi','livello di microarchitettura e architettura') if true).
rule(covers('architettura degli elaboratori e sistemi operativi','sistemi operativi') if true).
rule(covers('architettura degli elaboratori e sistemi operativi','controllo dei processi') if true).
rule(covers('architettura degli elaboratori e sistemi operativi','thread') if true).
rule(covers('architettura degli elaboratori e sistemi operativi','smp') if true).
rule(covers('architettura degli elaboratori e sistemi operativi','microkernel') if true).
rule(covers('architettura degli elaboratori e sistemi operativi','concorrenza') if true).
rule(covers('architettura degli elaboratori e sistemi operativi','gestione della memoria') if true).
rule(covers('architettura degli elaboratori e sistemi operativi','memoria virtuale') if true).
rule(covers('architettura degli elaboratori e sistemi operativi','file system') if true).

rule(covers('matematica discreta','logica') if true).
rule(covers('matematica discreta','teoria degli insiemi') if true).
rule(covers('matematica discreta','numeri naturali ed interi') if true).
rule(covers('matematica discreta','relazioni funzionali') if true).
rule(covers('matematica discreta','relazioni di equivalenza') if true).
rule(covers('matematica discreta','relazioni di ordine') if true).
rule(covers('matematica discreta','calcolo combinatorio') if true).
rule(covers('matematica discreta','monoidi') if true).
rule(covers('matematica discreta','gruppi') if true).
rule(covers('matematica discreta','anelli') if true).
rule(covers('matematica discreta','campi') if true).
rule(covers('matematica discreta','matrici') if true).
rule(covers('matematica discreta','grafi') if true).


rule(covers('programmazione','problem solving') if true).
rule(covers('programmazione','linguaggi di programmazione') if true).
rule(covers('programmazione','metodologie di programmazione') if true).
rule(covers('programmazione','rappresentazione di algoritmi') if true).
rule(covers('programmazione','algoritmi fondamentali') if true).
rule(covers('programmazione','linguaggio c') if true).
rule(covers('programmazione','progettazione del software') if true).
rule(covers('programmazione','file') if true).


rule(covers('analisi matematica','insiemi numerici') if true).
rule(covers('analisi matematica','funzioni lineari') if true).
rule(covers('analisi matematica','calcolo differenziale') if true).
rule(covers('analisi matematica','approssimazione locale di funzioni') if true).
rule(covers('analisi matematica','serie numeriche') if true).
rule(covers('analisi matematica','calcolo integrale') if true).


rule(covers('linguaggi di programmazione','linguaggi di programmazione') if true).
rule(covers('linguaggi di programmazione','linguaggi formali') if true).
rule(covers('linguaggi di programmazione','grammatiche generative') if true).
rule(covers('linguaggi di programmazione','linguaggi liberi da contesto') if true).
rule(covers('linguaggi di programmazione','linguaggi dipendenti da contesto') if true).
rule(covers('linguaggi di programmazione','automi') if true).
rule(covers('linguaggi di programmazione','linguaggi regolari') if true).
rule(covers('linguaggi di programmazione','espressioni regolari') if true).
rule(covers('linguaggi di programmazione','modello del compilatore') if true).


rule(covers('laboratorio di informatica','stili di programmazione') if true).
rule(covers('laboratorio di informatica','testing') if true).
rule(covers('laboratorio di informatica','debugging') if true).
rule(covers('laboratorio di informatica','programmazione modulare') if true).
rule(covers('laboratorio di informatica','documentazione del codice') if true).
rule(covers('laboratorio di informatica','puntatori') if true).
rule(covers('laboratorio di informatica','algoritmi fondamentali') if true).


rule(covers('lingua inglese','intermediate language practice') if true).
rule(covers('lingua inglese','professional language') if true).


rule(covers('algoritmi e strutture dati','algoritmi e programmi') if true).
rule(covers('algoritmi e strutture dati','algebre di dati') if true).
rule(covers('algoritmi e strutture dati','insiemi') if true).
rule(covers('algoritmi e strutture dati','dizionari') if true).
rule(covers('algoritmi e strutture dati','strutture non lineari di dati') if true).
rule(covers('algoritmi e strutture dati','alberi binari') if true).
rule(covers('algoritmi e strutture dati','alberi n-ari') if true).
rule(covers('algoritmi e strutture dati','alberi di ricerca') if true).
rule(covers('algoritmi e strutture dati','code con priorità') if true).
rule(covers('algoritmi e strutture dati','grafi') if true).
rule(covers('algoritmi e strutture dati','pile') if true).
rule(covers('algoritmi e strutture dati','complessità di calcolo') if true).
rule(covers('algoritmi e strutture dati','tecniche algoritmiche') if true).


rule(covers('basi di dati','sistemi di basi di dati') if true).
rule(covers('basi di dati','basi di dati relazionali') if true).
rule(covers('basi di dati','progettazione di basi di dati') if true).
rule(covers('basi di dati','tecnologie delle basi di dati') if true).


rule(covers('calcolo numerico','analisi dell\'errore') if true).
rule(covers('calcolo numerico','aritmetica di macchina') if true).
rule(covers('calcolo numerico','zeri di funzione') if true).
rule(covers('calcolo numerico','algebra lineare') if true).
rule(covers('calcolo numerico','risoluzione di sistemi lineari') if true).
rule(covers('calcolo numerico','interpolazione') if true).
rule(covers('calcolo numerico','approssimazione') if true).
rule(covers('calcolo numerico','spazi vettoriali') if true).
rule(covers('calcolo numerico','ambienti per il calcolo scientifico') if true).
rule(covers('calcolo numerico','python') if true).
rule(covers('calcolo numerico','matlab') if true).

rule(covers('fondamenti di fisica','cinematica del punto materiale') if true).
rule(covers('fondamenti di fisica','dinamica del punto materiale') if true).
rule(covers('fondamenti di fisica','dinamica dei sistemi di punti materiali e corpo rigido') if true).
rule(covers('fondamenti di fisica','termologia') if true).
rule(covers('fondamenti di fisica','elettricità') if true).
rule(covers('fondamenti di fisica','elettromagnetismo') if true).


rule(covers('ingegneria del software','processi software') if true).
rule(covers('ingegneria del software','sviluppo agile') if true).
rule(covers('ingegneria del software','scrum') if true).
rule(covers('ingegneria del software','controllo di versione') if true).
rule(covers('ingegneria del software','automazione dello sviluppo') if true).
rule(covers('ingegneria del software','automazione del rilascio') if true).
rule(covers('ingegneria del software','modellazione uml') if true).
rule(covers('ingegneria del software','analisi dei requisiti') if true).
rule(covers('ingegneria del software','stili architetturali') if true).
rule(covers('ingegneria del software','object oriented design') if true).
rule(covers('ingegneria del software','testing') if true).
rule(covers('ingegneria del software','manutenzione') if true).


rule(covers('metodi avanzati di programmazione','paradigmi di programmazione') if true).
rule(covers('metodi avanzati di programmazione','astrazione nella programmazione') if true).
rule(covers('metodi avanzati di programmazione','programmazione orientata agli oggetti') if true).
rule(covers('metodi avanzati di programmazione','java') if true).


rule(covers('calcolo delle probabilità e statistica','probabilità elementare') if true).
rule(covers('calcolo delle probabilità e statistica','eventi condizionati e indipendenti') if true).
rule(covers('calcolo delle probabilità e statistica','variabili aleatorie') if true).
rule(covers('calcolo delle probabilità e statistica','test statistici') if true).
rule(covers('calcolo delle probabilità e statistica','quantili') if true).
rule(covers('calcolo delle probabilità e statistica','media') if true).
rule(covers('calcolo delle probabilità e statistica','varianza') if true).
rule(covers('calcolo delle probabilità e statistica','covarianza') if true).
rule(covers('calcolo delle probabilità e statistica','distribuzioni congiunte') if true).
rule(covers('calcolo delle probabilità e statistica','distribuzioni marginali') if true).
rule(covers('calcolo delle probabilità e statistica','distribuzioni condizionate') if true).
rule(covers('calcolo delle probabilità e statistica','legge dei grandi numeri') if true).
rule(covers('calcolo delle probabilità e statistica','teorema del limite centrale') if true).
rule(covers('calcolo delle probabilità e statistica','campionamento') if true).
rule(covers('calcolo delle probabilità e statistica','stimatori puntuali') if true).


rule(covers('calcolabilità e complessità','automi e linguaggi') if true).
rule(covers('calcolabilità e complessità','linguaggi regolari') if true).
rule(covers('calcolabilità e complessità','linguaggi context-free') if true).
rule(covers('calcolabilità e complessità','teoria della calcolabilità') if true).
rule(covers('calcolabilità e complessità','la tesi di church-turing') if true).
rule(covers('calcolabilità e complessità','decidibilità') if true).
rule(covers('calcolabilità e complessità','teorema della ricorsione') if true).
rule(covers('calcolabilità e complessità','teoria della complessità') if true).
rule(covers('calcolabilità e complessità','complessità temporale') if true).
rule(covers('calcolabilità e complessità','complessità spaziale') if true).


rule(covers('reti di calcolatori','fondamenti di reti di calcolatori') if true).
rule(covers('reti di calcolatori','architetture a livelli') if true).
rule(covers('reti di calcolatori','servizi e protocolli per applicazioni di rete') if true).
rule(covers('reti di calcolatori','modello client-server') if true).
rule(covers('reti di calcolatori','modello peer-to-peer') if true).
rule(covers('reti di calcolatori','socket api') if true).
rule(covers('reti di calcolatori','web') if true).
rule(covers('reti di calcolatori','dns') if true).
rule(covers('reti di calcolatori','programmazione delle socket') if true).
rule(covers('reti di calcolatori','trasporto in internet') if true).
rule(covers('reti di calcolatori','tcp') if true).
rule(covers('reti di calcolatori','udp') if true).
rule(covers('reti di calcolatori','instradamento in internet') if true).
rule(covers('reti di calcolatori','indirizzamento in internet') if true).
rule(covers('reti di calcolatori','ipv4') if true).
rule(covers('reti di calcolatori','ipv6') if true).
rule(covers('reti di calcolatori','sicurezza di rete') if true).
rule(covers('reti di calcolatori','attacchi alla sicurezza') if true).
rule(covers('reti di calcolatori','firewall') if true).
rule(covers('reti di calcolatori','principi di crittografia') if true).
rule(covers('reti di calcolatori','funzioni hash crittografiche') if true).
rule(covers('reti di calcolatori','autenticazione end-to-end') if true).
rule(covers('reti di calcolatori','funzioni hash') if true).


rule(covers('interazione uomo-macchina','interfacce utente') if true).
rule(covers('interazione uomo-macchina','usabilità') if true).
rule(covers('interazione uomo-macchina','leggi della gestalt') if true).
rule(covers('interazione uomo-macchina','progettazione centrata sull\'utente') if true).
rule(covers('interazione uomo-macchina','prototipi') if true).
rule(covers('interazione uomo-macchina','valutazione') if true).
rule(covers('interazione uomo-macchina','metodi di ispezione') if true).
rule(covers('interazione uomo-macchina','valutazione euristica') if true).
rule(covers('interazione uomo-macchina','test con utenti') if true).
rule(covers('interazione uomo-macchina','accessibilità') if true).
rule(covers('interazione uomo-macchina','programmazione per il web') if true).


rule(covers('ingegneria della conoscenza','sistemi intelligenti basati su conoscenza') if true).
rule(covers('ingegneria della conoscenza','rappresentazione della conoscenza') if true).
rule(covers('ingegneria della conoscenza','logica proposizionale') if true).
rule(covers('ingegneria della conoscenza','ragionamento automatico') if true).
rule(covers('ingegneria della conoscenza','deduzione') if true).
rule(covers('ingegneria della conoscenza','abduzione') if true).
rule(covers('ingegneria della conoscenza','induzione') if true).
rule(covers('ingegneria della conoscenza','ragionamento con incertezza') if true).
rule(covers('ingegneria della conoscenza','acquisizione della conoscenza') if true).
rule(covers('ingegneria della conoscenza','modelli di classificazione') if true).
rule(covers('ingegneria della conoscenza','modelli probabilistici') if true).


rule(covers('metodi per il ritrovamento dell\'informazione','text mining') if true).
rule(covers('metodi per il ritrovamento dell\'informazione','elaborazione del linguaggio naturale') if true).
rule(covers('metodi per il ritrovamento dell\'informazione','information retrieval') if true).
rule(covers('metodi per il ritrovamento dell\'informazione','valutazione di sistemi di information retrieval') if true).
rule(covers('metodi per il ritrovamento dell\'informazione','text categorization') if true).
rule(covers('metodi per il ritrovamento dell\'informazione','information filtering') if true).
rule(covers('metodi per il ritrovamento dell\'informazione','recommender systems') if true).


rule(covers('sviluppo di videogiochi','storia dei videogiochi') if true).
rule(covers('sviluppo di videogiochi','generi e tipologie di videogiochi') if true).
rule(covers('sviluppo di videogiochi','progettazione di videogiochi') if true).
rule(covers('sviluppo di videogiochi','prototipazione di videogiochi') if true).
rule(covers('sviluppo di videogiochi','sviluppo di videogiochi') if true).


rule(covers('sistemi multimediali','intelligenza artificiale in healthcare') if true).
rule(covers('sistemi multimediali','metodi di osservazione e studio di fenomeni') if true).
rule(covers('sistemi multimediali','deep learning') if true).
rule(covers('sistemi multimediali','biomedical engineering') if true).
rule(covers('sistemi multimediali','bioinformatica') if true).
rule(covers('sistemi multimediali','suono e audio') if true).
rule(covers('sistemi multimediali','immagini') if true).
rule(covers('sistemi multimediali','video') if true).
rule(covers('sistemi multimediali','formati digitali') if true).


rule(covers('modelli e metodi per la sicurezza delle applicazioni', 'sistemi biometrici per la sicurezza') if true).
rule(covers('modelli e metodi per la sicurezza delle applicazioni', 'automatic signature verification') if true).
rule(covers('modelli e metodi per la sicurezza delle applicazioni', 'speaker verification') if true).
rule(covers('modelli e metodi per la sicurezza delle applicazioni', 'riconoscimento dell\'iride') if true).
rule(covers('modelli e metodi per la sicurezza delle applicazioni', 'sistemi multi-biometrici') if true).
rule(covers('modelli e metodi per la sicurezza delle applicazioni', 'sistemi di sicurezza ibridi') if true).
rule(covers('modelli e metodi per la sicurezza delle applicazioni', 'liveness detection e spoofing') if true).
rule(covers('modelli e metodi per la sicurezza delle applicazioni', 'valutazione delle performance di un sistema biometrico') if true).
rule(covers('modelli e metodi per la sicurezza delle applicazioni', 'aspetti normativi') if true).


rule(covers('sistemi ad agenti','agenti') if true).
rule(covers('sistemi ad agenti','sistemi multiagente') if true).
rule(covers('sistemi ad agenti','jade') if true).
rule(covers('sistemi ad agenti','agenti conversazionali') if true).
rule(covers('sistemi ad agenti','computer vision') if true).
rule(covers('sistemi ad agenti','machine learning') if true).
rule(covers('sistemi ad agenti','social robots') if true).
rule(covers('sistemi ad agenti','smart objects') if true).