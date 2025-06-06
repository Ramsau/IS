include('scotland-yard-board.p').

% have to define the board here because i overwrite it in task 1.5
fof(locations, axiom, (
    ! [L] :
        (
            location(L) <=>
            (
                L = 1 |
                L = 2 |
                L = 3 |
                L = 4 |
                L = 5 |
                L = 6 |
                L = 7 |
                L = 8 |
                L = 9
            )
        )
    )
).

% connections
fof(connections, axiom, (
    ! [L2] :
        (
            (connected(1, L2) <=> (L2 = 2 | L2 = 3 | L2 = 4)) &
            (connected(2, L2) <=> (L2 = 1 | L2 = 6)) &
            (connected(3, L2) <=> (L2 = 1 | L2 = 6 | L2 = 7 | L2 = 8)) &
            (connected(4, L2) <=> (L2 = 1 | L2 = 5 | L2 = 8 | L2 = 9)) &
            (connected(5, L2) <=> (L2 = 4)) &
            (connected(6, L2) <=> (L2 = 2 | L2 = 3)) &
            (connected(7, L2) <=> (L2 = 3)) &
            (connected(8, L2) <=> (L2 = 3 | L2 = 4)) &
            (connected(9, L2) <=> (L2 = 4))
        )
    )
).

% distinctness of locations and players
fof(distinct_objects, axiom, (
    $distinct(1, 2, 3, 4, 5, 6, 7, 8, 9, jane, hercule, x)
    )
).

% starting locations
fof(start_locations, axiom, (
    start(jane, 6) & start(hercule, 8) & start(x, 1)
)).


fof(detectives_catch, conjecture, (
    ? [J0, J1, J2, J3, H0, H1, H2, H3]: (
        start(jane, J0) & connected(J0, J1) & connected(J1, J2) & connected(J2, J3) &
        start(hercule, H0) & connected(H0, H1) & connected(H1, H2) & connected(H2, H3) &
        ~( ?[X0, X1, X2, X3] : (
            start(x, X0) & connected(X0, X1) & connected(X1, X2) & connected(X2, X3) &
            ~(
                (X1 = J0) | (X1 = J1) | (X1 = H0) | (X1 = H1) |
                (X2 = J1) | (X2 = J2) | (X2 = H1) | (X2 = H2) |
                (X3 = J2) | (X3 = J3) | (X3 = H2) | (X3 = H3)
            )
        ))
    )
)).

