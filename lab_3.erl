-module(lab_3).

-import(io,[format/1, format/2]).

%examples
-export([even/1, number/1]).
-export([sum/1, sum/2]).
-export([create/1, reverse_create/1]).
-export([write/1]).
-export([filter/2, reverse/1, concatenate/1]).

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



