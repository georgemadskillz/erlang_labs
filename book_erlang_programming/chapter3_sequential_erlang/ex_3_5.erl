-module(ex_3_5).

% Write a function that, given a list of integers and an integer, will return all integers
% smaller than or equal to that integer.
% Example:
% filter([1,2,3,4,5], 3) ⇒ [1,2,3].
% Write a function that, given a list, will reverse the order of the elements.
% Example:
% reverse([1,2,3]) ⇒ [3,2,1].
% Write a function that, given a list of lists, will concatenate them.
% Example:
% concatenate([[1,2,3], [], [4, five]]) ⇒ [1,2,3,4,five].
% Hint: you will have to use a help function and concatenate the lists in several steps.
% Write a function that, given a list of nested lists, will return a flat list.
% Example:
% flatten([[1,[2,[3],[]]], [[[4]]], [5,6]]) ⇒ [1,2,3,4,5,6].
% Hint: use concatenate to solve flatten.

% [ [1,[2,[3],[]]], [[[4]]], [5,6] ]
% [ 1, [2,[3],[]], [[4]], 5, 6 ]
% [ 1, 2, [3], [], [4], 5, 6 ]
% [ 1, 2, 3, 4, 5, 6 ]

-export([filter/2]).
-export([reverse/1]).
-export([concatenate/1]).
-export([flatten/1]).

filter(List, P) ->
    filter_(List, P, []).

filter_([], _, Acc) ->
    reverse(Acc);
filter_([Element | Rest], P, Acc) when Element =< P ->
    filter_(Rest, P, [Element | Acc]);
filter_([_ | Rest], P, Acc) ->
    filter_(Rest, P, Acc).

reverse(List) ->
    reverse_(List, []).

reverse_([], Acc) ->
    Acc;
reverse_([H|T], Acc) ->
    reverse_(T, [H | Acc]).

concatenate(ListOfLists) ->
    concatenate_(reverse(ListOfLists), []).

concatenate_([], Acc) ->
    Acc;
concatenate_([H|T], Acc) ->
    concatenate_(T, concatenate_simple(H, Acc)).

concatenate_simple(List1, List2) ->
    concatenate_simple_(reverse(List1), List2).

concatenate_simple_([], Acc) ->
    Acc;
concatenate_simple_([H|T], Acc) ->
    concatenate_simple_(T, [H|Acc]).

flatten(ListOfNestedLists) ->
    io:format("flatten: IN=~p~n",[ListOfNestedLists]),
    flatten_(ListOfNestedLists, []).

flatten_([], Acc) ->
    io:format("flatten_[]: IN=~p, OUT=~p~n",[[], Acc]),
    Acc;
flatten_([[]|T], Acc) ->
    io:format("flatten_[[]|T]: IN=~p~n",[[[]|T]]),
    FlattenT = flatten([T]),
    Res = concatenate([FlattenT, Acc]),
    io:format("flatten_[[]|T]: OUT=~p~n",[Res]),
    Res;
flatten_([H|T], Acc) when is_list(H) ->
    io:format("flatten_[List|T]: IN=~p~n",[[H|T]]),
    FlattenH = flatten(H),
    FlattenT = flatten(T),
    Flattened = concatenate([FlattenH, FlattenT]),
    Res = concatenate([Flattened, Acc]),
    io:format("flatten_[List|T]: OUT=~p~n",[Res]),
    Res;
flatten_([H|T], Acc) ->
    io:format("flatten_[H|T]: IN=~p~n",[[H|T]]),
    FlattenT = flatten(T),
    Flattened = concatenate([[H], FlattenT]),
    Res = concatenate([Flattened, Acc]),
    io:format("flatten_[H|T]: OUT=~p~n",[Res]),
    Res.

% [ [1,[2,[3],[]]], [[[4]]], [5,6] ]
% [ 1, [2,[3],[]], [[4]], 5, 6 ]
% [ 1, 2, [3], [], [4], 5, 6 ]
% [ 1, 2, 3, 4, 5, 6 ]


% flatten_([], Acc) ->
%     Acc;
% flatten_([[]|T], Acc) ->
%     flatten_(T, Acc);
% flatten_([[H]|T], Acc) ->
%     flatten_(T, concatenate_(flatten_([H], []), Acc));
% flatten_([H|T], Acc) ->
%     flatten_(T, [H|Acc]).


