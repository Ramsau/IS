% locations
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

% only locations are connected
fof(locations_connected, axiom, (
    ! [LC1, LC2]: (
        connected(LC1, LC2) => (location(LC1) & location(LC2))
    )
)).

% distinctness of locations
fof(distinct_locations, axiom, (
    $distinct(1, 2, 3, 4, 5, 6, 7, 8, 9)
    )
).

% test
fof(con_check, conjecture, (
    ! [LT1]: connected(LT1, 1) <=> connected(1, LT1)
)).


