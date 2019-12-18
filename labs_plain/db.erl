-module(db).
-export([new/0]).
-export([destroy/1]).
-export([write/3]).
%-export([read/2]).
-export([delete/2]).
%-export([match/2]).

%using lists module

new() -> [].
destroy(_Db) -> ok.

write(Key, Element, Db) ->
    lists:append([{Key, Element}], Db).

delete(Key, Db) ->
    case lists:keyfind(Key,1,Db) of
        false ->
            Db;
        {_,_} ->    
            delete(Key, lists:keydelete(Key,1,Db));
        _ -> error
    end.

read(Key, Db) ->

%plain erlang

%new() -> [].
%destroy(_Db) -> ok.
%
%write(Key, Element, Db) ->
%    [{Key, Element} | Db]. 
%
%delete(_, []) ->
%    io:fwrite("delete IN= NULL~n"),
%    io:fwrite("delete OUT= NULL~n"),
%    [];
%delete(Key, [Head | Tail]) ->
%    io:fwrite("delete IN= ~p~n", [[Head | Tail]]),
%    case Head of
%        {Key, _} -> 
%            io:fwrite("delete OUT= ~p~n", [[Tail]]),
%            Tail;
%        _ ->
%            Tmp = delete(Key, Tail),
%            io:fwrite("delete OUT= ~p~n", [[Head | Tmp ]]),
%            [Head | Tmp ]
%    end.
%
%read(Key, []) ->
%    io:fwrite("key ~p NOT FOUND!~n", [Key]),
%    {error, instance};
%read(Key, [Head | Tail]) ->
%    io:fwrite("read IN= ~p~n", [[Head | Tail]]),
%    case Head of
%        {Key, Val} ->
%            io:fwrite("read FOUND= ~p~n", [Val]),
%            {ok, Val};
%        _ ->
%            read(Key, Tail)
%    end.
%
%match(_Element, []) ->
%    [];
%match(Element, Db) ->
%    matchAux([],Element,Db).
%
%matchAux(Result, Element, [{Key, Val} | Tail]) ->
%    io:fwrite("match AUX inpt ~p~n", [[{Key, Val} | Tail]]), 
%    io:fwrite("match AUX rslt ~p~n", [Result]),
%    case {Key, Val} of
%        {Key, Element} ->
%            io:fwrite("match MATCH rslt ~p~n", [[Key | Result]]),
%            matchAux([Key | Result], Element, Tail);
%        _ ->
%            if
%                Tail == [] ->
%                    io:fwrite("match NULL tail~n"),
%                    Result;
%                true -> matchAux(Result,Element,Tail)
%            end
%    end. 
%
%

