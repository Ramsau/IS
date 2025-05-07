col(1..n).
row(1..n).

adjacent(R1,C1,R2,C2) :-
    row(R1), row(R2), col(C1), col(C2),
    R1 - R2 <= 1, R2 - R1<=1,
    C1 - C2 <=1, C2 - C1<=1.

cat(R, C) :- hidingspot(R, C), possiblepath(R, C).

possiblepath(R, C) :- brokenpot(R, C).
possiblepath(R, C) :-
    possiblepath(R1, C1) , adjacent(R1, C1, R, C),
    pawprint(R, C).
possiblepath(R, C) :-
    possiblepath(R1, C1) , adjacent(R1, C1, R, C),
    hidingspot(R, C).

#show cat/2.
