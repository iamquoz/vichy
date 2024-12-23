FROM erlang:latest

WORKDIR /app


COPY . /app/

RUN apt-get update && \
    apt-get install -y wget && \
    wget https://s3.amazonaws.com/rebar3/rebar3 && \
    chmod +x rebar3 && \
    mv rebar3 /usr/local/bin/rebar3


RUN rebar3 get-deps && \
    rebar3 compile && \
    ls -la /app/_build/default/lib/*/ebin

CMD ["sh", "-c", "mkdir -p /app/logs && touch /app/logs/erlang.log && tail -f /app/logs/erlang.log & erl -sname node@$(hostname) -setcookie mycookie -pa /app/_build/default/lib/*/ebin -run mnesia_setup setup -run http_server start -noshell > /app/logs/erlang.log 2>&1"]
