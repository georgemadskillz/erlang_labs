-module(ex_3_6).

% Implement the following sort algorithms over lists:
%
% Quicksort
% 
% The head of the list is taken as the pivot; the list is then split according to those
% elements smaller than the pivot and the rest. These two lists are then recursively
% sorted by quicksort, and joined together, with the pivot between them.
%
% Merge sort
% 
% The list is split into two lists of (almost) equal length. These are then sorted separately
% and their results merged in order.

-export([quick_sort/1]).
-export([merge_sort/1]).
-export([merge/2]).

quick_sort([]) ->
    [];
quick_sort([Pivot|[]]) ->
    [Pivot];
quick_sort([Pivot|Rest]) ->
    {Low, High} = partition(Pivot, Rest),
    quick_sort(Low) ++ [Pivot|quick_sort(High)].

partition(Pivot, List) ->
    partition_(Pivot, List, {[],[]}).

partition_(Pivot, [H|[]], {Low, High}) when H < Pivot ->
    {[H|Low], High};
partition_(_Pivot, [H|[]], {Low,High}) ->
    {Low, [H|High]};
partition_(Pivot, [H|Rest], {Low, High}) when H < Pivot ->
    partition_(Pivot, Rest, {[H|Low], High});
partition_(Pivot, [H|Rest], {Low, High}) ->
    partition_(Pivot, Rest, {Low, [H|High]}).

merge_sort(_List) ->
    ok.

merge(Left, Right) ->
    merge_({Left, Right}, []).

merge_({Left, Right} = Parts, Acc) ->
    case Parts of
        {[L|LeftRest], [R|_RightRest]} when L > R ->
            merge_({LeftRest, Right}, [L|Acc]);
        {[_L|_LeftRest], [R|RightRest]} ->
            merge_({Left, RightRest}, [R|Acc]);
        {[], [R|RightRest]} ->
            merge_({[], RightRest}, [R|Acc]);
        {[L|LeftRest], []} ->
            merge_({[LeftRest],[]}, [L|Acc]);
        {[],[]} ->
            Acc
    end.


