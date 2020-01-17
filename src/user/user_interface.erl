-module(user_interface).

-export([insert_coin/1]).
-export([buy_coffe/1]).
-export([request_change/0]).

insert_coin(Coin) ->
	machine ! {insert_coin, Coin}.

buy_coffe(CoffeType) ->
	machine ! {buy, CoffeType}.

request_change() ->
	machine ! {change}.
