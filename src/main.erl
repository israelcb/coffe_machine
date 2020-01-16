-module(main).

-export([start/0]).

start() ->
	coffe_machine:start(),
	user_interface:insert_coin(0.5),
	user_interface:insert_coin(0.5),
	user_interface:buy_coffe(americano).
