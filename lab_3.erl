-module(lab_3).

-import(io,[format/2]).

%examples
-export([even/1, number/1]).
-export([sum/1, sum/2]).
-export([create/1, reverse_create/1]).
-export([write/1]).

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

%write(N) when N>0 -> format("Number:~p~n", []).






