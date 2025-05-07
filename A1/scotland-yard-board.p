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

% only locations are connected
fof(locations_connected, axiom, (
    ! [LC1, LC2]: (
        connected(LC1, LC2) => (location(LC1) & location(LC2))
    )
)).

% distinctness of locations and players
%fof(distinct_objects, axiom, (
%    $distinct(1, 2, 3, 4, 5, 6, 7, 8, 9, jane, hercule, x)
%    )
%).

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

% starting locations
fof(start_locations, axiom, (
    start(jane, 6) & start(hercule, 8) & start(x, 1)
)).

fof(single_start_location, axiom, (
    ! [P, L1, L2] : (
        (player(P) & start(P, L1) & start(P, L2)) => (L1 = L2)
    )
)).

fof(start_players, axiom, (
    ! [P, L_start] : start(P, L_start) => player(P) & location(L_start)
)).

% legal moves
fof(detective_moves, axiom, (
    ! [D, L, L_next] : (
        legal_move_detective(D, L, L_next) <=> (
            detective(D) & location(L) & location(L_next) & connected(L, L_next)
        )
    )
)).

fof(x_moves, axiom, (
    ! [P, L, L_next] : (
        legal_move_x(P, L, L_next) => (
            (P = x) & location(L) & location(L_next) & connected(L, L_next) & (
                (start(x, L) & ~start(jane, L_next) & ~is_at_1(jane, L_next) & ~start(hercule, L_next) & ~is_at_1(hercule, L_next)) %|
                % ( ?[L_start]: (
                %     location(L_start) & ~(L_start = L) & start(x, L_start) &
                %     ~start(jane, L) & ~is_at_1(jane, L) & ~start(hercule, L) & ~is_at_1(hercule, L) &
                %     connected(L_start, L) & ~is_at_1(jane, L_next) & ~is_at_2(jane, L_next) & ~is_at_1(hercule, L_next) & ~is_at_2(hercule, L_next)
                % ))
            )
        )
    )
)).

fof(player_moves, axiom, (
    ! [P, L, L_next] : (
        legal_move(P, L, L_next) <=> (legal_move_detective(P, L, L_next) | legal_move_x(P, L, L_next))
    )
)).

% move 1
fof(player_at_location_1, axiom, (
    ! [D, L1]: (
        is_at_1(D, L1) => (
            ? [Lstart]: (
                player(D) & location(L1) & location(Lstart) &
                start(D, Lstart) & legal_move(D, Lstart, L1)
            )
        )
    )
)).

fof(player_not_at_location_1, axiom, (
    ! [D, L1, Lstart]: (
        (
            (player(D) & location(L1) & location(Lstart) & start(D, Lstart) & ~legal_move(D, Lstart, L1))
        ) => ~is_at_1(D, L1)
    )
)).

fof(player_has_location_1, axiom, (
    ! [D] : (
        detective(D) => ? [L1] : is_at_1(D, L1)
    )
)).

fof(single_location_1, axiom, (
    ! [D, L1, L2] : (
        (is_at_1(D, L1) & is_at_1(D, L2)) => (L1 = L2)
    )
)).

% move 2
fof(player_at_location_2, axiom, (
    ! [D, L2]: (
        is_at_2(D, L2) => (
            ? [L1]: (
                player(D) & location(L2) & location(L1) &
                is_at_1(D, L1) & legal_move(D, L1, L2)
            )
        )
    )
)).

fof(player_not_at_location_2, axiom, (
    ! [D, L1, L2]: (
        (
            (player(D) & location(L1) & location(L2) & is_at_1(D, L1) & ~legal_move(D, L1, L2))
        ) => ~is_at_2(D, L2)
    )
)).

fof(detective_has_location_2, axiom, (
    ! [D] : (
        detective(D) => ? [L2] : is_at_2(D, L2)
    )
)).

fof(single_location_2, axiom, (
    ! [D, L1, L2] : (
        (is_at_2(D, L1) & is_at_2(D, L2)) => (L1 = L2)
    )
)).

% move 3
fof(player_at_location_3, axiom, (
    ! [D, L3]: (
        is_at_3(D, L3) => (
            ? [L2]: (
                player(D) & location(L2) & location(L3) &
                is_at_2(D, L2) & legal_move(D, L2, L3)
            )
        )
    )
)).

fof(player_not_at_location_3, axiom, (
    ! [D, L3, L2]: (
        (
            (player(D) & location(L3) & location(L2) & is_at_2(D, L2) & ~legal_move(D, L2, L3))
        ) => ~is_at_3(D, L3)
    )
)).

fof(detective_has_location_3, axiom, (
    ! [D] : (
        detective(D) => ? [L3] : is_at_3(D, L3)
    )
)).

fof(single_location_3, axiom, (
    ! [D, L1, L2] : (
        (is_at_3(D, L1) & is_at_3(D, L2)) => (L1 = L2)
    )
)).

% x safe zones
%fof(safe_locations_start, axiom, (
%    ![Lstart] : (
%        (
%            safe_start(Lstart) <=> (
%                location(Lstart) & ~start(jane, Lstart) & ~start(hercule, Lstart)
%            )
%        )
%    )
%)).
%
%
%fof(safe_locations_1, axiom, (
%    ![L] : (
%        (
%            safe_1(L) <=> (
%                location(L) & ~is_at_1(jane, L) & ~is_at_1(hercule, L)
%            )
%        )
%    )
%)).
%
%fof(safe_locations_2, axiom, (
%    ![L] : (
%        (
%            safe_2(L) <=> (
%                location(L) & ~is_at_2(jane, L) & ~is_at_2(hercule, L)
%            )
%        )
%    )
%)).
%fof(safe_locations_3, axiom, (
%    ![L] : (
%        (
%            safe_3(L) <=> (
%                location(L) & ~is_at_3(jane, L) & ~is_at_3(hercule, L)
%            )
%        )
%    )
%)).
