include('scotland-yard-board.p').

fof(x_safe_test, conjecture, (
    safe_start(6)
    %safe_1(2) | safe_1(3)| safe_1(4)
    %~is_at_1(jane, 2) | ~is_at_1(jane, 3)
)).
