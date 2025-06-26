int: size_x;
int: size_y;

enum tile = {TR, RB, BL, LT, LR, TB, CC};
set of tile: tile_playable;

array[1..size_y, 1..size_x] of var tile: board;
array[1..size_y, 1..size_x] of bool: board_predefined;

% predefined tiles
constraint forall(x in 1..size_x, y in 1..size_y) (
  not board_predefined[y, x] -> board[y, x] in tile_playable
);

% left-right neighbors
constraint forall(x in 1..size_x-1, y in 1..size_y)(
    board[y, x] in {TR, RB, LR, CC} <-> board[y, x+1] in {BL, LT, LR, CC}
);

% top-bottom neighbors
constraint forall(x in 1..size_x, y in 1..size_y-1)(
    board[y, x] in {RB, BL, TB, CC} <-> board[y+1, x] in {TR, LT, TB, CC}
);

% left and right edges
constraint forall(y in 1..size_y)(
    not(board[y, 1]  in {BL, LT, LR, CC})
    /\
    not(board[y, size_x] in {TR, RB, LR, CC})
);

% bottom and top edges
constraint forall(x in 1..size_x)(
    not(board[1, x] in {TR, LT, TB, CC})
    /\
    not(board[size_y, x] in {RB, BL, TB, CC})
);



% problem instance
size_x = 6;
size_y = 5;
tile_playable = {TR, RB, BL, LT, LR, TB};
board_predefined =   
[|true,  false, false, false, false, false,
 |false, false, true,  false, false, true,
 |false, true,  false, false, true,  false,
 |false, false, false, false, false, false,
 |false, false, true,  false, true,  false
 |];
constraint board[1, 1] = RB;
constraint board[2, 3] = CC;
constraint board[2, 6] = LT;
constraint board[3, 2] = RB;
constraint board[3, 5] = CC;
constraint board[5, 3] = LT;
constraint board[5, 5] = LR;
solve satisfy;