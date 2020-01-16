-module(coin).

-define(COIN_VALUES,
	[0.01, 0.05, 0.1, 0.25, 0.5]).

-import(lists, [member/2]).
-import(lists, [sort/1]).
-import(lists, [reverse/1]).
-import(lists, [search/2]).
-import(lists, [merge/2]).
-import(lists, [map/2]).

-export([exists/1]).
-export([total_value/1]).
-export([subtract/2]).

exists(Coin) ->
	member(Coin, ?COIN_VALUES).

total_value(Coins) ->
	total_value(Coins, 0).

total_value([], CoinsValue) ->
	CoinsValue;
total_value([CoinValue | Coins], CoinsValue) ->
	total_value(Coins, CoinsValue + CoinValue).

subtract(Coins, CoffePrice) ->
	CoinsInDescOrder = reverse(sort(Coins)),
	subtract(CoinsInDescOrder, CoffePrice, []).

subtract([], 0.00, ResultCoins) ->
	ResultCoins;
subtract([FirstCoin | Coins], 0.00, ResultCoins) ->
	subtract(Coins, 0.00, [FirstCoin | ResultCoins]);
subtract([], CoffePrice, ResultCoins) ->
	subtract(exchange_first_coin(ResultCoins), CoffePrice, []);
subtract([Coin | Coins], CoffePrice, ResultCoins)
when Coin =< CoffePrice ->
	subtract(Coins, CoffePrice - Coin, ResultCoins);
subtract([Coin | Coins], CoffePrice, ResultCoins) ->
	subtract(Coins, CoffePrice, [Coin | ResultCoins]).

exchange_first_coin([]) ->
	[];
exchange_first_coin([Coin | Coins]) ->
	merge(exchange_coin(Coin), Coins).

exchange_coin(Coin) ->
	CoinRoundedValue = round(Coin * 100),
	{value, MaxCoinValue} = search(
		fun(C) -> C < CoinRoundedValue andalso CoinRoundedValue rem C == 0 end,
		reverse(sort(map(fun(C) -> round(C * 100) end, ?COIN_VALUES)))),
	exchange_coin(MaxCoinValue / 100, round(Coin / (MaxCoinValue / 100)), []).

exchange_coin(_, 0, Coins) ->
	Coins;
exchange_coin(CoinValue, RemainingCoins, Coins) ->
	exchange_coin(CoinValue, RemainingCoins - 1, [CoinValue | Coins]).
