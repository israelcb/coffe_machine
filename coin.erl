-module(coin).

-import(lists, [sort/1]).
-import(lists, [reverse/1]).

-export([exists/1]).
-export([total_value/1]).
-export([subtract/2]).

total_value(Coins) ->
	total_value(Coins, 0).

total_value([], CoinsValue) ->
	CoinsValue;
total_value([CoinValue | Coins], CoinsValue) ->
	total_value(Coins, CoinsValue + CoinValue).

exists(0.01) -> true;
exists(0.05) -> true;
exists(0.1) -> true;
exists(0.25) -> true;
exists(0.5) -> true;
exists(_) -> false.

subtract(Coins, CoffePrice) ->
	CoinsInDescOrder = reverse(sort(Coins)),
	subtract(CoinsInDescOrder, CoffePrice, []).

subtract([], 0.00, ResultCoins) ->
	ResultCoins;
subtract([FirstCoin | Coins], 0.00, ResultCoins) ->
	subtract(Coins, 0.00, [FirstCoin | ResultCoins]);
subtract([], CoffePrice, ResultCoins) ->
	subtract(ResultCoins, CoffePrice);
subtract([Coin | Coins], CoffePrice, ResultCoins)
when Coin =< CoffePrice ->
	subtract(Coins, CoffePrice - Coin, ResultCoins);
subtract([Coin | Coins], CoffePrice, ResultCoins) ->
	subtract(Coins, CoffePrice, [Coin | ResultCoins]).
