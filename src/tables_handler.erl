-module(tables_handler).
-include("test_table.hrl").

-export([init/2]).

init(Req0, State) ->
    TableInfo = mnesia:table_info(test_table, all),
    Body = io_lib:format("<html><body><h1>Table Info</h1><pre>~p</pre></body></html>", [TableInfo]),
    Req = cowboy_req:reply(200, 
		#{<<"content-type">> => <<"text/html">>}, 
		Body, 
		Req0),
    {ok, Req, State}.
