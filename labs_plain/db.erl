-module(db).
-export([new/0]).
-export([destroy/1]).
-export([write/3]).
-export([read/2]).
-export([delete/2]).
-export([match/2]).

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
    case lists:keyfind(Key,1,Db) of
        false ->
            {error, instance};
        {_,Val} ->
            {ok, Val}
    end.



match(Element, Db) ->
    matchAux([],Element,Db).

matchAux(Retval,Element,Db) ->
    case lists:keysearch(Element,2,Db) of
        {value,{Key,_Val}} ->
            matchAux([Key|Retval],Element,lists:keydelete(Key,1,Db));
        false ->
            Retval
    end.




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
%    case {Key, Val} of
%        {Key, Element} ->
%            matchAux([Key | Result], Element, Tail);
%        _ ->
%            if
%                Tail == [] ->
%                    Result;
%                true -> matchAux(Result,Element,Tail)
%            end
%    end. 
%
%

