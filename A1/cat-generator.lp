#const n=5.
#const hidingspots=3.

col(1..n).
row(1..n).

adjacent(R1,C1,R2,C2) :-
    row(R1), row(R2), col(C1), col(C2),
    R1 - R2 <= 1, R2 - R1<=1,
    C1 - C2 <=1, C2 - C1<=1.


possiblepath(R, C) :- brokenpot(R, C).
possiblepath(R, C) :-
    possiblepath(R1, C1) , adjacent(R1, C1, R, C),
    pawprint(R, C).
possiblepath(R, C) :-
    possiblepath(R1, C1) , adjacent(R1, C1, R, C),
    hidingspot(R, C).
possiblepath(R, C) :-
    possiblepath(R1, C1), adjacent(R1, C1, R, C),
    jump(R, C).


cat(R, C) :- hidingspot(R, C), possiblepath(R, C),
    noise(R1, C1), adjacent(R1, C1, R, C).

1 {brokenpot(R, C): row(R), col(C) } 1.
1 {cat(R, C): row(R), col(C), hidingspot(R, C), possiblepath(R, C) } 1.
1 {hidingspot(R, C): row(R), col(C), not brokenpot(R, C) } X :- X = hidingspots.
0 {pawprint(R, C): row(R), col(C), not brokenpot(R, C), not hidingspot(R, C) } X :- X = n*n.
1 {noise(R, C): row(R), col(C), adjacent(R1, C1, R, C), cat(R1, C1) } 1.
1 { jump(R, C): possiblepath(R1, C1), adjacent(R1, C1, R, C) } 1.



#show brokenpot/2.
#show pawprint/2.
#show hidingspot/2.
#show cat/2.
