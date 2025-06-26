int: num_tasks;
int: num_agents;

array[1..num_tasks] of int: task_duration;
array[1..num_agents] of int: agent_resources;
array[1..num_agents] of var int: agent_resources_used;
array[1..num_tasks] of var int: task_assignment;

% assign tasks to agents
constraint forall(t in 1..num_tasks) (task_assignment[t] in 1..num_agents);

% sum agent resources used, check that limit is not exceeded
constraint forall(a in 1..num_agents) (
    agent_resources_used[a] = sum(t in 1..num_tasks where task_assignment[t] = a)(task_duration[t]) /\
    agent_resources_used[a] < agent_resources[a]
);


% problem instance
num_tasks = 6;
num_agents = 4;
task_duration = [37, 78, 11, 56, 90, 43];
agent_resources = [123, 103, 67, 55];

solve satisfy;