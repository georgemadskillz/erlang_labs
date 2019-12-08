%%%-------------------------------------------------------------------
%% @doc erl_labs public API
%% @end
%%%-------------------------------------------------------------------

-module(erl_labs_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    erl_labs_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
