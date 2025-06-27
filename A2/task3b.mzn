int: maxSteps = 25;
var int: stepsNeeded;

enum Location;
enum Action = {Done, Move, Pickup, Putdown};


int: numPackages;
int: numLocations;
int: capacity; 

array[1..numPackages] of int: weights;

array[1..numLocations, 1..numLocations] of bool: connections;

array [1..maxSteps] of var Location: robotLocation;
array [1..maxSteps, 1..numPackages] of var Location: packageLocation;
array [1..maxSteps, 1..numPackages] of var bool: robotCarries;
array[1..maxSteps] of var Action: actions;
array[1..maxSteps] of var int: load;


% robot stays in place unless it moves
constraint forall (step in 2..maxSteps, location in Location)(
  robotLocation[step] = robotLocation[step-1] \/
  (connections[enum2int(robotLocation[step]), enum2int(robotLocation[step-1])] /\ 
  actions[step-1] = Move)
);

% package stays in place unless it moves
constraint forall (step in 2..maxSteps, package in 1..numPackages) (
  packageLocation[step, package] = packageLocation[step-1, package] \/
  (robotCarries[step-1, package] /\ packageLocation[step, package] = robotLocation[step])
);

% robot can pick up package
constraint forall (step in 2..maxSteps, package in 1..numPackages) (
  (robotCarries[step, package] = robotCarries[step-1, package]) \/
  (not robotCarries[step-1, package] /\ robotCarries[step, package] /\ robotLocation[step-1] = packageLocation[step-1, package] /\ robotLocation[step] = robotLocation[step-1] /\ actions[step-1] = Pickup) \/
  (robotCarries[step-1, package] /\ not robotCarries[step, package] /\ robotLocation[step] = packageLocation[step, package]  /\ robotLocation[step] = robotLocation[step-1] /\ actions[step-1] = Putdown)
);

% load is sum of packages, must be at or below capacity
constraint forall (step in 1..maxSteps) (
  load[step] = sum(p in 1..numPackages where robotCarries[step, p] = true)(weights[p]) 
  /\
  load[step] <= capacity
);


% problem instance
numPackages = 3;
numLocations = 9;
Location = {A, B, C, D, E, F, G, H, I};
connections = 
% A      B      C      D      E      F      G      H      I
[|true,  true,  false, true,  false, false, false, false, false, %A
 |true,  true,  true,  true,  false, false, false, false, false, %B
 |false, true,  true,  false, true,  false, false, false, false, %C
 |true,  true,  false, true,  true,  true,  false, false, false, %D
 |false, false, true,  true,  true,  false, false, false, false, %E
 |false, false, false, true,  false, true,  false, true,  false, %F
 |false, false, false, false, false, false, true,  true,  false, %G
 |false, false, false, false, false, true,  true,  true,  true,  %H
 |false, false, false, false, false, false, false, true,  true,  %H
 |];
capacity = 50;
weights = [20, 10, 50];
constraint(robotLocation[1] = A);
constraint(packageLocation[1, 1] = F);
constraint(packageLocation[1, 2] = E);
constraint(packageLocation[1, 3] = G);
constraint(load[1] = 0);
constraint(robotLocation[stepsNeeded] = A);
constraint(packageLocation[stepsNeeded, 1] = H);
constraint(packageLocation[stepsNeeded, 2] = H);
constraint(packageLocation[stepsNeeded, 3] = B);

solve minimize stepsNeeded;



