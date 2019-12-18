-module(test_gen).

-behaviour(gen_server).

-export([what_is_start_int/0]).
-export([inc_start_int/0]).


-export([start_link/1, stop/0]).
-export([init/1, terminate/2, handle_call/3, handle_cast/2]).

-type start_int() :: integer().
-type state() :: #{
    start_int := start_int()
}.

-type call() :: get_int | inc_int.

%% API

-spec what_is_start_int() -> 
    {ok, start_int()}.

what_is_start_int() ->
    gen_server:call(?MODULE, get_int).

-spec inc_start_int() -> 
    {ok, start_int()}.

inc_start_int() ->
    gen_server:call(?MODULE, inc_int).  

%%

-spec start_link(start_int()) -> ignore | {error, _} | {ok, pid()}.
start_link(TestInt) ->
    io:format("[test_gen][start_link] Hello from test_gen ~p~n!", [TestInt]),
    gen_server:start_link({local, ?MODULE}, ?MODULE, TestInt, []).

-spec stop() -> ok.

stop() -> gen_server:cast(self(), stop).

%% Callback Functions
-spec init(start_int()) -> 
    {ok, state()}.

init(TestInt) ->
    io:format("[test_gen][init] Hello from test_gen ~p~n!", [TestInt]),
    {ok, #{start_int => TestInt}}.

-spec terminate(_, state()) -> 
    ok.

terminate(_Reason, _State) ->
    ok.

-spec handle_cast(stop, state()) ->
    {noreply, state()} | {stop, normal, state()}.

handle_cast(stop, State) -> 
    {stop, normal, State}.

-spec handle_call
    (inc_int, _, state()) -> 
        {reply, {ok, _} | {error, _}, state()};
    (get_int, _, state()) -> 
        {reply, {ok, _} | {error, _}, state()}.

handle_call(inc_int, _From, #{start_int := TestInt}) ->
    NewTestInt = TestInt + 1,
    io:format("[test_gen][handle_call][inc_int] Hello from test_gen ~p~n!", [NewTestInt]),
    {reply, {ok, NewTestInt}, #{start_int => NewTestInt}};
handle_call(get_int, _From, #{start_int := TestInt} = State) ->
    io:format("[test_gen][handle_call][get_int] Hello from test_gen ~p~n!", [TestInt]),
    {reply, {ok, TestInt}, State}.
