-module(ex_3_4).

% db:new() ⇒ Db.
% db:destroy(Db) ⇒ ok.
% db:write(Key, Element, Db) ⇒ NewDb.
% db:delete(Key, Db) ⇒ NewDb.
% db:read(Key, Db) ⇒{ok, Element} | {error, instance}.
% db:match(Element, Db) ⇒ [Key1, ..., KeyN].

-export([db_new/0]).
-export([db_destroy/1]).
-export([db_write/3]).
-export([db_delete/2]).
-export([db_read/2]).
-export([db_match/2]).

db_new() ->
    [].

db_destroy(_Db) ->
    ok.

db_write(Key, Element, Db) ->
    [{Key, Element} | Db].

db_delete(Key, Db) ->
    db_delete_(Key, Db, []).

db_delete_(_, [], Acc) ->
    Acc;
db_delete_(Key, [{Key, _} | Rest] , Acc) ->
    db_delete_(Key, Rest, Acc);
db_delete_(Key, [Pair | Rest], Acc) ->
    db_delete_(Key, Rest, [Pair | Acc]).

db_read(_, []) ->
    {error, instance};
db_read(Key, [{Key, Element} | _]) ->
    {ok, Element};
db_read(Key, [_ | Rest]) ->
    db_read(Key, Rest).

db_match(Element, Db) ->
    db_match_(Element, Db, []).

db_match_(_, [], Acc) ->
    Acc;
db_match_(Element, [{Key, Element} | Rest], Acc) ->
    db_match_(Element, Rest, [Key | Acc]);
db_match_(Element, [_ | Rest], Acc) ->
    db_match_(Element, Rest, Acc).

%%