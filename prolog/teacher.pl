:- op(1100, xfx, if).
:- op(1000, xfy, or).
:- op(900, xfy, and).
:- multifile rule/1.
:- dynamic rule/1.
/*
teacher(N, M, P) --> 
    N is the name of the teacher
    M is the mail of the teacher
    P is the phone number of the teacher
*/

rule(teacher('giuseppe pirlo', 'giuseppe.pirlo@uniba.it', '+390805443295') if true).
rule(teacher('donato impedovo', 'donato.impedovo@uniba.it', '+390805442280') if true).
rule(teacher('luigia di terlizzi', 'luigia.diterlizzi@uniba.it', '+390805442694') if true).
rule(teacher('francesco bastianelli', 'francesco.bastianelli@uniba.it', '+390805442280') if true).
rule(teacher('fabio abbattista', 'fabio.abbattista@uniba.it', '+390805443298') if true).
rule(teacher('teresa roselli', 'teresa.roselli@uniba.it', '+390805443276') if true).
rule(teacher('marilena ligabò', 'marilena.ligabo@uniba.it', '+390805442695') if true).
rule(teacher('anna germinario', 'anna.germinario@uniba.it', '+390805442711') if true).
rule(teacher('giovanni semeraro', 'giovanni.semeraro@uniba.it', '+390805443298') if true).
rule(teacher('pasquale lops', 'pasquale.lops@uniba.it', '+390805442276') if true).
rule(teacher('veronica rossano', 'veronica.rossano@uniba.it', '+390805442477') if true).
rule(teacher('giovanni tucci', 'giovanni.tucci@uniba.it', '0') if true).
rule(teacher('nicola di mauro', 'nicola.dimauro@uniba.it', '+390805442297') if true).
rule(teacher('gianvito pio', 'gianvito.pio@uniba.it', '+390805442203') if true).
rule(teacher('paolo buono', 'paolo.buono@uniba.it', '+390805443281') if true).
rule(teacher('claudia d\'amato', 'claudia.damato@uniba.it', '+390805443142') if true).
rule(teacher('felice iavernaro', 'felice.iavernaro@uniba.it', '+390805442703') if true).
rule(teacher('alessandro pugliese', 'alessandro.pugliese@uniba.it', '+390805442689') if true).
rule(teacher('leonardo di venere', 'leonardo.divenere@uniba.it', '+390805443172') if true).
rule(teacher('francesco scattarella', 'francesco.scattarella@uniba.it', '+390805442369') if true).
rule(teacher('filippo lanubile', 'filippo.lanubile@uniba.it', '+390805443261') if true).
rule(teacher('annalisa appice', 'annalisa.appice@uniba.it', '+390805443262') if true).
rule(teacher('pierpaolo basile', 'pierpaolo.basile@uniba.it', '+390805442301') if true).
rule(teacher('stefano rossi', 'stefano.rossi@uniba.it', '+390805442663') if true).
rule(teacher('emanuele covino', 'emanuele.covino@uniba.it', '+390805442663') if true).
rule(teacher('nicole novielli', 'nicole.novielli@uniba.it', '+390805443261') if true).
rule(teacher('maria francesca costabile', 'maria.costabile@uniba.it', '+390805443300') if true).
rule(teacher('nicola fanizzi', 'nicola.fanizzi@uniba.it', '+390805442246') if true).
rule(teacher('giovanni dimauro', 'giovanni.dimauro@uniba.it', '+390805443294') if true).
rule(teacher('berardina de carolis', 'berardina.decarolis@uniba.it', '+390805443477') if true).