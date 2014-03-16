-module(erws_handler).
-export([init/3]).
-export([websocket_init/3]).
-export([websocket_handle/3]).
-export([websocket_info/3]).
-export([websocket_terminate/3]).

init({tcp, http}, Req, _Opts) ->
	lager:debug("init Request: ~p", [Req]),
	{upgrade, protocol, cowboy_websocket}.

websocket_init(_TransportName, Req, _Opts) ->
	lager:debug("websocket_init Request: ~p", [Req]),
	erlang:start_timer(1000, self(), <<"Hello!">>),
	{ok, Req, undefined_state}.

websocket_handle({text, Msg}, Req, State) ->
	lager:debug("websocket_handle Request: ~p", [Req]),
	{reply, {text, << "That's what she said! ", Msg/binary >>}, Req, State};
	
websocket_handle(_Data, Req, State) ->
	lager:debug("websocket_handle unknown Request: ~p", [Req]),
	{ok, Req, State}.

websocket_info({timeout, _Ref, Msg}, Req, State) ->
	lager:debug("websocket_info Request: ~p", [Req]),
	erlang:start_timer(1000, self(), <<"How' you doin'?">>),
	{reply, {text, Msg}, Req, State};
	
websocket_info(_Info, Req, State) ->
	lager:debug("websocket_info unknown Request: ~p", [Req]),
	{ok, Req, State}.

websocket_terminate(_Reason, Req, _State) ->
	lager:debug("websocket_handle terminate: ~p", [Req]),
	ok.