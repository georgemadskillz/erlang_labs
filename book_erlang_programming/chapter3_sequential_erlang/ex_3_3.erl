-module(ex_3_3).

-export([print_all/1]).
-export([print_even/1]).

% Write a function that prints out the integers between 1 and N.
print_all(N) when N < 1 ->
    {error, invalid_input};
print_all(N) ->
    do_print(N).

do_print(1) ->
    print_number(1);
do_print(N) ->
    print_number(N),
    do_print(N-1).

% Write a function that prints out the even integers between 1 and N.
print_even(N) when N < 1 ->
    {error, invalid_input};
print_even(N) ->
    do_print_even(N).

do_print_even(2) ->
    print_number(2);
do_print_even(N) when N rem 2 =:= 0 ->
    print_number(N),
    do_print_even(N-1).


%

print_number(N) ->
    io:format("Number:~p~n",[N]).
