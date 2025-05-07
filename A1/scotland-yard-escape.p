include('scotland-yard-board.p').
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
                L = 9 |
                L = 10
            )
        )
    )
).

% connections
fof(connections, axiom, (
    ! [L2] :
        (
            (connected(1, L2) <=> (L2 = 2 | L2 = 3 | L2 = 4 | L2 = 10)) &
            (connected(2, L2) <=> (L2 = 1 | L2 = 6 | L2 = 10)) &
            (connected(3, L2) <=> (L2 = 1 | L2 = 6 | L2 = 7 | L2 = 8 | L2 = 10)) &
            (connected(4, L2) <=> (L2 = 1 | L2 = 5 | L2 = 8 | L2 = 9 | L2 = 10)) &
            (connected(5, L2) <=> (L2 = 4 | L2 = 10)) &
            (connected(6, L2) <=> (L2 = 2 | L2 = 3 | L2 = 10)) &
            (connected(7, L2) <=> (L2 = 3 | L2 = 10)) &
            (connected(8, L2) <=> (L2 = 3 | L2 = 4 | L2 = 10)) &
            (connected(9, L2) <=> (L2 = 4 | L2 = 10)) &
            (connected(10, L2) <=> (L2 = 1 | L2 = 2 | L2 = 3 | L2 = 4 | L2 = 5 | L2 = 6 | L2 = 7 | L2 = 8 | L2 = 9))
        )
    )
).

% distinctness of locations and players
fof(distinct_objects, axiom, (
    $distinct(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, jane, hercule, x)
    )
).

% test; every connection is reversible
%fof(con_check, negated_conjecture, (
%    ? [LT1, LT2]: (
%        (connected(LT1, LT2) & ~connected(LT2, LT1)) |
%        (~connected(LT1, LT2) & connected(LT1, LT1))
%    )
%)).

fof(detectives_catch, conjecture, (
    ? [J1, J2, H1, H2]: (
        is_at_1(jane, J1) & is_at_2(jane, J2) & is_at_1(hercule, H1) & is_at_2(hercule, H2) &
        ~(? [X0, X1, X2]: (
            start(x, X0) & legal_move(x, X0, X1) & legal_move(x, X1, X2)
        ))
    )
)).


