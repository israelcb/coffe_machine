-module(coins).

-export([total_value/1]).

total_value(Coins) ->
	total_value(Coins, 0).

total_value([], CoinsValue) ->
	CoinsValue;
total_value([CoinValue | Coins], CoinsValue) ->
	case exists(CoinValue) of
		true -> total_value(Coins, CoinsValue + CoinValue);
		_ -> undefined
	end.

exists(0.01) -> true;
exists(0.05) -> true;
exists(0.1) -> true;
exists(0.25) -> true;
exists(0.5) -> true;
exists(_) -> false.
