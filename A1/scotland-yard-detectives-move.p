include('scotland-yard-board.p').

fof(detectives_move, conjecture, (
    %? [J1, J2, H1, H2]: (
    %    is_at_1(jane, J1)
    %)
    legal_move(jane, 6, 2) & start(jane, 6) &
)).


