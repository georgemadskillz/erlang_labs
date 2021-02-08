-module(ex_3_1).

-export([sum/1, sum/2]).
% Write a function sum/1 which, given a positive integer N will return
% the sum of all the integers between 1 and N.

sum(N) when N =< 0 ->
    {error, invalid_input};
sum(N) ->
 calc_sum1(N, 0).

calc_sum1(1, Acc) ->
    Acc+1;
calc_sum1(N, Acc) ->
    calc_sum1(N-1, Acc+N).

% Write a function sum/2 which, given two integers N and M, where N =< M, will return
% the sum of the interval between N and M. If N > M, you want your process to terminate
% abnormally.

sum(N, M) when N =< M ->
    calc_sum2(N, M, 0).

calc_sum2(N, M, Acc) when N =:= M ->
    Acc + M;
calc_sum2(N, M, Acc) ->
    calc_sum2(N+1, M, Acc+N).
