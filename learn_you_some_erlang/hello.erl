-module(hello).

-export([hello/0]).
-export([add/2]).

hello() ->
    io:format("Hello, world!~n").

add(A,B) ->
    A + B.



