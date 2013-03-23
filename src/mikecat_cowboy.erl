-module(mikecat_cowboy).

-export([start/0]).

-spec start() -> ok.
start() ->
    application:start(crypto),
    application:start(ranch),
    application:start(cowboy),
    Dispatch = cowboy_router:compile([
        {'_', [
			{"/", toppage_handler, []}
		]}
	]),
    {ok, _} = cowboy:start_http(http, 100, [{port, 8080}], [
		{env, [{dispatch, Dispatch}]}
	]),
    ok.
