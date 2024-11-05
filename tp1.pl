%khenafif chaima+benaissa faiza
:- dynamic task/4.


create_task(ID, Description, Assignee) :-
    \+ task(ID, _, _, _),
    assertz(task(ID, Description, Assignee, false)),
    format('Task created: ~w.~n', [ID]).


assign_task(ID, NewAssignee) :-
    task(ID, Description, _, Status),
    retract(task(ID, Description, _, Status)),
    assertz(task(ID, Description, NewAssignee, Status)),
    format('Task ~w assigned to user: ~w.~n', [ID, NewAssignee]).


mark_completed(ID) :-
    task(ID, Description, Assignee, false),
    retract(task(ID, Description, Assignee, false)),
    assertz(task(ID, Description, Assignee, true)),
    format('Task ~w marked as completed.~n', [ID]).


display_tasks :-
    forall(task(ID, Description, Assignee, Status), (
        format('Task ~w:~n', [ID]),
        format('- Description: ~w~n', [Description]),
        format('- Assignee: ~w~n', [Assignee]),
        format('- Completion status: ~w~n', [Status])
    )).


display_tasks_assigned_to(User) :-
    format('Tasks assigned to ~w:~n', [User]),
    forall(task(ID, Description, User, Status), (
        format('Task ~w:~n', [ID]),
        format('- Description: ~w~n', [Description]),
        format('- Completion status: ~w~n', [Status])
    )).


display_completed_tasks :-
    format('Completed tasks:~n'),
    forall(task(ID, Description, Assignee, true), (
        format('Task ~w:~n', [ID]),
        format('- Description: ~w~n', [Description]),
        format('- Assignee: ~w~n', [Assignee])
    )).

