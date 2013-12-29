-module(erws_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

%% start(_StartType, _StartArgs) ->
    %% {Host, list({Path, Handler, Opts})}
%%   Dispatch = [{'_', [
%%        {'_', erws_handler, []}
%%    ]}],
    %% Name, NbAcceptors, Transport, TransOpts, Protocol, ProtoOpts
%%    cowboy:start_listener(ami_ws_dispatcher, 100,
%%        cowboy_tcp_transport, [{port, 10100}],
%%        cowboy_http_protocol, [{dispatch, Dispatch}]
%%    ),
%%    erws_sup:start_link().

%% stop(_State) ->
%%    ok.

start(_Type, _Args) ->
        Dispatch = cowboy_router:compile([
                {'_', [
                        {"/", cowboy_static, {priv_file, websocket, "index.html"}},
                        {"/websocket", ws_handler, []},
                        {"/static/[...]", cowboy_static, {priv_dir, websocket, "static"}}
                ]}
        ]),
        {ok, _} = cowboy:start_http(http, 100, [{port, 8080}],
                [{env, [{dispatch, Dispatch}]}]),
        websocket_sup:start_link().

stop(_State) ->
        ok.