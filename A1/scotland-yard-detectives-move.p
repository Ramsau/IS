include('scotland-yard-board.p').

%fof(detective_location_test, conjecture, (
%    (is_at_1(jane, 2) | is_at_1(jane, 3)) &
%    (is_at_1(hercule, 3) | is_at_1(hercule, 4)) &
%    (is_at_2(jane, 6) | is_at_2(jane, 1) | is_at_2(jane, 7) | is_at_2(jane, 8)) &
%    (is_at_2(hercule, 8) | is_at_2(hercule, 7) | is_at_2(hercule, 1) | is_at_2(hercule, 9)  | is_at_2(hercule, 5)  | is_at_2(hercule, 6))
%)).

fof(detectives_move, conjecture, (
   ? [J1, J2, H1, H2]: (
       is_at_1(jane, J1) & is_at_2(jane, J2) & is_at_1(hercule, H1) & is_at_2(hercule, H2)
   )
)).
