% locations
%fof(locations, axiom, (
%    ! [L] :
%        (
%            location(L) <=>
%            (
%                L = 1 |
%                L = 2 |
%                L = 3 |
%                L = 4 |
%                L = 5 |
%                L = 6 |
%                L = 7 |
%                L = 8 |
%                L = 9
%            )
%        )
%    )
%).

% connections
%fof(connections, axiom, (
%    ! [L2] :
%        (
%            (connected(1, L2) <=> (L2 = 2 | L2 = 3 | L2 = 4)) &
%            (connected(2, L2) <=> (L2 = 1 | L2 = 6)) &
%            (connected(3, L2) <=> (L2 = 1 | L2 = 6 | L2 = 7 | L2 = 8)) &
%            (connected(4, L2) <=> (L2 = 1 | L2 = 5 | L2 = 8 | L2 = 9)) &
%            (connected(5, L2) <=> (L2 = 4)) &
%            (connected(6, L2) <=> (L2 = 2 | L2 = 3)) &
%            (connected(7, L2) <=> (L2 = 3)) &
%            (connected(8, L2) <=> (L2 = 3 | L2 = 4)) &
%            (connected(9, L2) <=> (L2 = 4))
%        )
%    )
%).

% distinctness of locations and players
%fof(distinct_objects, axiom, (
%    $distinct(1, 2, 3, 4, 5, 6, 7, 8, 9, jane, hercule, x)
%    )
%).

% only locations are connected
fof(locations_connected, axiom, (
    ! [LC1, LC2]: (
        connected(LC1, LC2) => (location(LC1) & location(LC2))
    )
)).


% test; every connection is reversible
% fof(con_check, negated_conjecture, (
%     ? [LT1, LT2]: (
%         (connected(LT1, LT2) & ~connected(LT2, LT1)) |
%         (~connected(LT1, LT2) & connected(LT1, LT1))
%     )
% )).


% detectives and x
fof(detectives, axiom, (
    ! [D] : (
        detective(D) <=> (
            (D = jane) | (D = hercule)
        )
    )
)).

fof(players, axiom, (
    ! [P] : (
        player(P) <=> (detective(P) | P = x)
    )
)).

fof(unique_players, axiom, (
    $distinct(jane, hercule, x)
)).

fof(single_start_location, axiom, (
    ! [P, L1, L2] : (
        (player(P) & start(P, L1) & start(P, L2)) => (L1 = L2)
    )
)).

fof(start_players, axiom, (
    ! [P, L_start] : start(P, L_start) => player(P) & location(L_start)
)).

