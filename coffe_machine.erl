-module(coffe_machine).

-import(io, [format/2]).

-export([buy_coffe/1]).

buy_coffe(CoffeType) ->
	CoffePrice = coffe_price(CoffeType),
	buy_coffe(CoffeType, CoffePrice).

buy_coffe(CoffeType, undefined) ->
	format("Sorry, coffe type '~w' doesn't exist!~n", [CoffeType]);
buy_coffe(CoffeType, CoffePrice) ->
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
