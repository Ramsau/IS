include('scotland-yard-board.p').

fof(detectives_catch, conjecture, (
    ? [J1, J2, H1, H2]: (
        is_at_1(jane, J1) & is_at_2(jane, J2) & is_at_1(hercule, H1) & is_at_2(hercule, H2) &
        ~(? [X1, X2]: (
            is_at_1(x, X1) & is_at_2(x, X2)
        ))
    )
)).

