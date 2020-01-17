-module(user_interface).

-include_lib("./../api.hrl").

-export([insert_coin/1]).
-export([buy_coffe/1]).
-export([request_change/0]).

insert_coin(Coin) ->
	?SEND(#coff__insert_coin{coin=Coin}).

buy_coffe(CoffeType) ->
	?SEND(#coff__buy{type=CoffeType}).

request_change() ->
	?SEND(#coff__change{}).
