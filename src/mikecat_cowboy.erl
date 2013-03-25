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
    {ok, Data} = yaml:load_file("priv/application.yaml"),
    [[{_,[{_, Port}]}]] = Data,
    {ok, _} = cowboy:start_http(http, 100, [{port, Port}], [
		{env, [{dispatch, Dispatch}]}
	]),
    ok.
