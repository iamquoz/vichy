-module(mnesia_setup).
-include("test_table.hrl").

-export([setup/0]).

setup() ->
    Nodes = [node() | mnesia:system_info(running_db_nodes)],
    mnesia:create_schema(Nodes),
    mnesia:start(),
    case mnesia:create_table(test_table, [{disc_copies, Nodes}, {attributes, record_info(fields, test_table)}]) of
        {atomic, ok} ->
            io:format("Mnesia setup completed and table created~n");
        {aborted, {already_exists, test_table}} ->
            io:format("Mnesia setup completed, table already exists~n")
    end.
