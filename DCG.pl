%-----Reglas-----
s(s(NP, VP)) --> np(NP, Num), vp(VP, Num).

np(np(DET, N), Num) --> det(DET, Num), noun(N, Num).
np(np(DET, ADJ, N), Num) --> det(DET, Num), adj(ADJ) ,noun(N, Num).
np(np(DET, N, RC), Num) --> det(DET, Num), noun(N, Num), relCl(RC).
np(np(ADJ, N), Num) --> adj(ADJ), noun(N, Num).
np(np(ADJ, N, V), Num) --> adj(ADJ), noun(N, Num), vp(V, Num).

vp(vp(V), Num) --> verb(V, Num).
vp(vp(V, NP), Num) --> verb(V, Num), np(NP, _).
vp(vp(V, ADJ), Num) --> beVerb(V, Num), adj(ADJ).

relCl(rc(R, V)) --> rel(R), vp(V, _).



%-----Terminales-----
det(det(all), plural) --> [all].
det(det(some), _) --> [some].

noun(n(boy), singular) --> [boy].
noun(n(watermelon), singular) --> [watermelon].
noun(n(flavor), singular) --> [flavor].
noun(n(apple), singular) --> [apple].
noun(n(person), singular) --> [person].
noun(n(government), singular) --> [government].
    
noun(n(boys), plural) --> [boys].
noun(n(watermelons), plural) --> [watermelons].
noun(n(flavors), plural) --> [flavors].
noun(n(apples), plural) --> [apples].
noun(n(people), plural) --> [people].
noun(n(governments), plural) --> [governments].

verb(v(run), plural) --> [run].
verb(v(like), plural) --> [like].
verb(v(contain), plural) --> [contain].
verb(v(eat), plural) --> [eat].
verb(v(conscript), plural) --> [conscript].
    
verb(v(runs), singular) --> [runs].
verb(v(likes), singular) --> [likes].
verb(v(contains), singular) --> [contains].
verb(v(eats), singular) --> [eats].
verb(v(conscripts), singular) --> [conscripts].
    
beVerb(v(is), singular) --> [is].
beVerb(v(are), plural) --> [are].
    
adj(adj(divine)) --> [divine].
adj(adj(pacifist)) --> [pacifist].
adj(adj(evil)) --> [evil].
    
rel(r(that)) --> [that].



%-----Tokenizer-----
go(Out):-
    read(X), 
    name(X,L), 
    tokenize(L,Out). 

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
