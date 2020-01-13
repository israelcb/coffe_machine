-module(coffe_machine).

-import(io, [format/2]).

-export([buy_coffe/2]).

buy_coffe(CoffeType, CoinsValue) ->
	CoffePrice = coffe_price(CoffeType),
	buy_coffe(CoffeType, CoffePrice, CoinsValue).

buy_coffe(CoffeType, undefined, _) ->
	format("Sorry, coffe type '~w' doesn't exist!~n", [CoffeType]);
buy_coffe(CoffeType, CoffePrice, CoinsValue)
when CoffePrice > CoinsValue ->
	format("Sorry, ~.2f$ already left to buy ~w~n",
	[CoffePrice - CoinsValue, CoffeType]);
buy_coffe(CoffeType, CoffePrice, _) ->
	format("You just lost ~.2f$!~n", [CoffePrice]),
	format("You got one ~w!~n", [CoffeType]).

coffe_price(espresso) -> 0.50;
coffe_price(espresso_macchiato) -> 1.50;
coffe_price(espresso_con_panna) -> 2.00;
coffe_price(coffe_latte) -> 3.50;
coffe_price(flat_white) -> 2.50;
coffe_price(caffe_breve) -> 3.00;
coffe_price(cappuccino) -> 2.50;
coffe_price(caffe_mocha) -> 3.75;
coffe_price(americano) -> 0.75;
coffe_price(latte_machiato) -> 1.50;
coffe_price(red_eye) -> 2.00;
coffe_price(cafe_au_lait) -> 1.50;
coffe_price(_) -> undefined.
