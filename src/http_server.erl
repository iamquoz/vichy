-module(http_server).
-export([start/0]).

start() ->
    case application:ensure_all_started(cowboy) of
        {ok, _} ->
            io:format("Dependencies loaded successfully~n"),
            Dispatch = cowboy_router:compile([
                {'_', [
                    {"/tables", tables_handler, []}
                ]}
            ]),
            case cowboy:start_clear(http_listener, [{port, 8080}], #{env => #{dispatch => Dispatch}}) of
                {ok, _} ->
                    io:format("HTTP server started on port 8080~n");
                {error, Reason} ->
                    io:format("Failed to start HTTP server: ~p~n", [Reason])
            end;
        {error, Reason} ->
            io:format("Failed to start dependencies: ~p~n", [Reason]),
            {error, Reason}
    end.
