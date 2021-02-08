-module(ex_3_2).

-export([create/1]).
-export([reverse_create/1]).

% Write a function that returns a list of the format [1,2,..,N-1,N].

create(N) when N < 1 ->
    {error, invalid_input};
create(N) ->
    do_create(N, []).

do_create(0, Acc) ->
    Acc;
do_create(N, Acc) ->
    do_create(N-1, [N | Acc]).

% Write a function that returns a list of the format [N, N-1,..,2,1].

reverse_create(N) when N < 1 ->
    {error, invalid_input};
reverse_create(N) ->
    do_reverse_create(1, N, []).

do_reverse_create(Cnt, N, Acc) when Cnt =:= N ->
    [Cnt | Acc];
do_reverse_create(Cnt, N, Acc) ->
    do_reverse_create(Cnt+1, N, [Cnt | Acc]).

