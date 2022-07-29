%----------Operadores---------
:- op(500,xfy,&).
:- op(600,xfy,->).



%-----------Inicio------------
translate(Out):-
    read(X),
    name(X,L),
    tokenize(L,Arr),
    sentence(Out, Arr, []).



%-----------Reglas-------------
sentence(P) --> 
    noun_phrase(Num, X, P1, P), 
    verb_phrase(Num, X, P1).

noun_phrase(Num, X, P1, P) --> 
    determiner(Num, X, P2, P1, P), 
    noun(Num, X, P3), 
    rel_clause(Num, X, P3, P2).

noun_phrase(Num, X, P1, P) --> 
    determiner(Num, X, P2, P3, P1, P), 
    adj(X, P3),
    noun(Num, X, P4), 
    rel_clause(Num, X, P4, P2).

verb_phrase(Num, X, P) --> 
    trans_verb(Num, X, Y, P1), 
    noun_phrase(_, Y, P1, P).

verb_phrase(Num, X, P) --> 
    intrans_verb(Num, X, P).

verb_phrase(Num, X, P) --> 
    be_verb(Num),
    adj(X, P).

rel_clause(Num, X, P1, (P1&P2)) --> 
    [that], 
    verb_phrase(Num, X, P2).

rel_clause(_, _, P, P) --> [].



%---------Terminales------------
determiner(plural, X, P1, P2, all(X, (P1 -> P2))) --> [all].
determiner(plural, X, P1, P2, all(X, (P1 -> P2))) --> ['All'].

determiner(_, X, P1, P2, exists(X, (P1 & P2))) --> [some].
determiner(_, X, P1, P2, exists(X, (P1 & P2))) --> ['Some'].

determiner(_, X, P1, P2, P3, exists(X, (P1 & P2 & P3))) --> [some].
determiner(_, X, P1, P2, P3, exists(X, (P1 & P2 & P3))) --> ['Some'].

determiner(_, X, P1, P2, P3, exists(X, (P1 & P2 & P3))) --> [].

noun(singular, X, boy(X)) --> [boy].
noun(singular, X, watermelon(X)) --> [watermelon].
noun(singular, X, flavor(X)) --> [flavor].
noun(singular, X, apple(X)) --> [apple].
noun(singular, X, person(X)) --> [person].
noun(singular, X, government(X)) --> [government].

noun(plural, X, boy(X)) --> [boys].
noun(plural, X, watermelon(X)) --> [watermelons].
noun(plural, X, flavor(X)) --> [flavors].
noun(plural, X, apple(X)) --> [apples].
noun(plural, X, people(X)) --> [people].
noun(plural, X, government(X)) --> [governments].

trans_verb(singular, X, Y, like(X, Y)) --> [likes].
trans_verb(singular, X, Y, contain(X, Y)) --> [contains].
trans_verb(singular, X, Y, eat(X, Y)) --> [eats].
trans_verb(singular, X, Y, conscript(X, Y)) --> [conscripts].

trans_verb(plural, X, Y, like(X, Y)) --> [like].
trans_verb(plural, X, Y, contain(X, Y)) --> [contain].
trans_verb(plural, X, Y, eat(X, Y)) --> [eat].
trans_verb(plural, X, Y, conscript(X, Y)) --> [conscript].

intrans_verb(singular, X, runs(X)) --> [runs].
intrans_verb(plural, X, run(X)) --> [run].

be_verb(singular) --> [is].
be_verb(plural) --> [are].

adj(X, divine(X)) --> [divine].
adj(X, pacifist(X)) --> [pacifist].
adj(X, evil(X)) --> [evil].
adj(_, _) --> [].



%---------Tokenizer---------
tokenize([],[]):-!.

tokenize(L,[Word|Out]):-
    L\==[],
    tokenize(L,Rest,WordChs),
    name(Word,WordChs),
    tokenize(Rest,Out).

tokenize([],[],[]):- !.
tokenize([46|_],[],[]):- !.
tokenize([32|T],T,[]):- !.

tokenize([H|T],Rest,[H|List]):-
    tokenize(T,Rest,List).



%---------Casos de prueba---------
% 'All boys run'.
% 'All boys like all watermelons that contain some divine flavor'.
% 'Some boy eats some apple'.
% 'Some government conscripts some pacifist people'.
% 'All governments that conscript pacifist people are evil'.