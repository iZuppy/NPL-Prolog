%-----Reglas-----
S --> NP,VP.
NP --> Det,Noun.
NP --> Det,Noun,RelCl.
NP --> Noun.
VP --> Verb.
VP --> Verb,NP.
VP --> BeVerb,Adj.
RelCl --> Rel,VP.
RelCl --> Rel,NP,Verb.



%-----Terminales-----
Det(plural) --> [all].
Det(_) --> [some].
    
Noun(singular) --> [boy].
Noun(plural) --> [boys].
Noun(singular) --> [watermelon].
Noun(plural) --> [watermelons].
Noun(singular) --> [flavor].
Noun(plural) --> [flavors].
Noun(singular) --> [apple].
Noun(plural) --> [apples].
Noun(singular) --> [person].
Noun(plural) --> [people].
Noun(singular) --> [government].
Noun(plural) --> [governments].
    
Verb(singular) --> [run].
Verb(plural) --> [runs].
Verb(singular) --> [like].
Verb(plural) --> [likes].
Verb(singular) --> [contain].
Verb(plural) --> [contains].
Verb(singular) --> [eat].
Verb(plural) --> [eats].
Verb(singular) --> [conscript].
Verb(plural) --> [conscripts].
    
BeVerb(singular) --> [is].
BeVerb(plural) --> [are].
    
Adj --> [divine].
Adj --> [pacifist].
Adj --> [evil].
    
Rel --> [that].



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
