-module(coffe_machine).

-import(io, [format/1]).
-import(io, [format/2]).

-export([buy/2]).

buy(CoffeType, Coins) ->
	CoffePrice = coffe:price(CoffeType),
	CoinsValue = coins:total_value(Coins),
	buy(CoffeType, CoffePrice, CoinsValue).

buy(CoffeType, undefined, _) ->
	format("Sorry, coffe type '~w' doesn't exist!~n", [CoffeType]);
buy(_, _, undefined) ->
	format("Sorry, some of the provided coins doesn't exist!~n");
buy(CoffeType, CoffePrice, CoinsValue) when CoffePrice > CoinsValue ->
	format("Sorry, ~.2f$ already left to buy ~w~n",
	[CoffePrice - CoinsValue, CoffeType]);
buy(CoffeType, CoffePrice, _) ->
	format("You just lost ~.2f$!~n", [CoffePrice]),
	format("You got one ~w!~n", [CoffeType]).
