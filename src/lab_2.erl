-module(lab_2).
-export([double/1]).
-export([b_not/1, b_and/2, b_or/2, b_nand/2]).

-import(math, [sqrt/1]).

%This is a comment

b_not(false) -> true;
b_not(true) -> false.

b_and(true, true) -> true;
b_and(false, false) -> false;
b_and(false, true) -> false;
b_and(true, false) -> false.

b_or(true, true) -> true;
b_or(false, false) -> false;
b_or(false, true) -> true;
b_or(true, false) -> true.

b_nand(A, B) ->
    b_not(b_and(A,B)).


double(Value) ->
    times(Value, 2).

times(X,Y) ->
    X*Y.

area({square, Side}) -> 
    Side*Side;
area({circle, Radius}) ->
    math:pi() * Radius * Radius;
area({triangle, A, B, C}) -> 
    S = (A+B+C)/2,
    math:sqrt(S*(S-A)*(S-B)*(S-C));
area(_Other) ->
    {error, invalid_object}.
