-module(lab_3).

-import(io,[format/1, format/2]).

%examples
-export([even/1, number/1]).
-export([sum/1, sum/2]).
-export([create/1, reverse_create/1]).
-export([write/1]).
-export([filter/2, reverse/1, concatenate/1, flatten/1]).
-export([test/1]).

-export([quick_sort/1,merge_sort/1]).

% Tests
-export([testFlatten/0]).

even(Int) when Int rem 2 == 0 -> true;
even(Int) when Int rem 2 == 1 -> false.

number(Num) when is_integer(Num)    -> integer;
number(Num) when is_float(Num)      -> float;
number(_Other)                      ->false. 


% ex3-1
sum(N)      when N>0    -> sum_acc(N,0,0);
sum(N)      when N>=0   -> error.
sum(N,M)    when N=<M   -> sum_acc(M,N,0);
sum(N,M)    when N>M    -> error.

sum_acc(Top, Bottom, Sum) ->
    if
        Top == Bottom -> Sum+Top;
        Top > Bottom -> sum_acc(Top-1, Bottom, Sum+Top)
    end.
    
% ex3-2
% create возвращает примерно такое: [[[[[[]|1]|2]|3]|4]|5]
% считается ли это прваильно? в учебнике написано это эквивалетно [1,2,3,4,5]
create(0) -> [];
create(N) when N>0 -> createPart([],N).

createPart(List, Iter) ->
    if
        Iter > 0 -> [createPart(List, Iter-1) | Iter];
        true -> List
    end.
         
reverse_create(0) -> [];
reverse_create(N) when N>0 -> reverse_createPart([],N).

reverse_createPart(List, Iter) ->
    if
        Iter > 0 -> [Iter | reverse_createPart(List, Iter-1)]; 
        true -> List
    end.

% ex3-3
% Какое обычно принято название для итераторов? в Си это i,j,k, а тут?

write(N) when N>0 ->
    format("Number: "),
    fmt(1,N).

fmt(Iter, N) ->
    if
        Iter =< N   -> format("~p ", [Iter]), fmt(Iter+1, N);
        true        -> format("~n")
    end.
    
% ex3-4
% filter
% получилось криво, потому что на выходе вложенные листы
% как сделать сразу не вложенно пока хз,
% пока что в голову приходит сделать не вложенное но в обратном порядке,
% а на выходе реверс.. или сделать вложенное в прямом порядке, а на выходе
% вызвать flatten, но так как это не входит в задание, то скорее всего надо
% обойтись без этих функций
filter(List, Max) ->
    filterAux([], List, Max).

filterAux(Result, [_ | []], _) ->
    Result;
filterAux(Result, [Head | Tail], Max) ->
    io:fwrite("INP: ~p~n", [[Head | Tail]]),
    if
        Head =< Max ->
            io:fwrite("OUT: ~p~n", [Tail]),
            filterAux([Result | Head ], Tail, Max);
        true ->
            filterAux(Result, Tail, Max)   
    end.
%ex3-5 manipulating lists
%reverse
reverse(List) ->
    reverseAux([], List).

reverseAux(Result, []) ->
%    io:fwrite("INP: NULL~n"),
%    io:fwrite("OUT: ~p~n", [Result]),
    Result;
reverseAux(Result, [Head | Tail]) ->
%    io:fwrite("INP: ~p ~p~n", [[Head | Tail], Result]),
%    io:fwrite("OUT ~p~n", [Result]),
    reverseAux([Head | Result], Tail).

%concatenate
concatenate(ListOfLists) ->
    concatAux([], ListOfLists).

concatAux(Result, []) ->
    Result;
concatAux(Result, [Head | Tail]) ->
   concatAux(concatTwo(Result, Head), Tail). 

concatTwo(List1, List2) ->
    concatTwoAux(reverse(List1), List2).
concatTwoAux([], Concatenated) ->
    Concatenated; 
concatTwoAux([Head | Tail], Concatenated) ->
    concatTwoAux(Tail, [Head | Concatenated]). 
    
%flatten
% ([[1,[2,[3],[]]], [[[4]]], [5,6]]) => [1,2,3,4,5,6].

% [1,[2,[3],[]],[[4]],5,6]
% [1,2,[3],[],[4],5,6]
% [1,2,3,4,5,6]

flatten([])     -> 
    [];
flatten([H|T]) when is_list(H)  ->
   flatten( flatten(H) ++ T);
flatten([H|T])  ->
    [H | flatten(T)].

testFlatten() ->
    io:fwrite("Start test..~n"),
    Test = [{1,abc,lalala},[1,[2,[3],[]]], [[[4]]], [5,6],[],[],[],[[[[[]]]]]],
    %Test = [1,2,3],
    io:fwrite("input: ~p~n", [Test]),
    Result = flatten(Test),
    io:fwrite("flatten result: ~p~n", [Result]),
    testFlatten_ok.
   
test([Var]) -> [Var].

%ex3-6 sorting lists
%quicksort
quick_sort([]) ->
    [];
quick_sort([H|T]) ->
    Left = quick_sort(qs_check(left,H,T,[])),
    Right = quick_sort(qs_check(right,H,T,[])),
    flatten([[Left] ++ [H] ++ [Right]]).

qs_check(left, _, [], Acc) ->
    Acc;
qs_check(right, _, [], Acc) ->
    Acc;
qs_check(left, Pivot, [H|T], Acc) ->
    if
        H < Pivot ->
            qs_check(left,Pivot,T,[H|Acc]);
        true ->
            qs_check(left,Pivot,T,Acc)
    end;
qs_check(right, Pivot, [H|T], Acc) ->
    if
        H >= Pivot ->
            qs_check(right,Pivot,T,[H|Acc]);
        true ->
            qs_check(right,Pivot,T,Acc)
    end.

%mergesort
% TOD: станешь поумнее, допили нормально без использования стандартных библиотек
merge_sort([L]) -> [L]; 
merge_sort(L) ->
    {L1, L2} = lists:split(length(L) div 2, L),
    lists:merge(merge_sort(L1), merge_sort(L2)).

% ex3-8


