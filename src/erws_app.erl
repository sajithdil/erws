-module(erws_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1, start_link/2]).

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
                        {"/", cowboy_static, {priv_file, erws, "index.html"}},
                        {"/websocket", erws_handler, []},
                        {"/static/[...]", cowboy_static, {priv_dir, erws, "static"}}
                ]}
        ]),
		% Dispatch = cowboy_router:compile([
                % {'_', [
                        % {"/websocket", erws_handler, []}
                        
                % ]}
        % ]),
        {ok, _} = cowboy:start_http(http, 100, [{port, 9318}],
                [{env, [{dispatch, Dispatch}]}]),
        erws_sup:start_link().		

start_link(_Type, _Args) ->
        Dispatch = cowboy_router:compile([
                {'_', [
                        {"/", cowboy_static, {priv_file, erws, "index.html"}},
                        {"/websocket", erws_handler, []},
                        {"/static/[...]", cowboy_static, {priv_dir, erws, "static"}}
                ]}
        ]),
		% Dispatch = cowboy_router:compile([
                % {'_', [
                        % {"/websocket", erws_handler, []}
                        
                % ]}
        % ]),
        {ok, _} = cowboy:start_http(http, 100, [{port, 9318}],
                [{env, [{dispatch, Dispatch}]}]),
        erws_sup:start_link().

stop(_State) ->
        ok.