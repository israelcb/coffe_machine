-module(coffe_machine).

-import(io, [format/1]).
-import(io, [format/2]).

-export([start/0]).
-export([stop/0]).
-export([machine/0]).

start() ->
	register(machine, spawn(?MODULE, machine, [])),
	format("Coffe machine is now on!~n").

stop() ->
	machine ! {power_off}.

machine() ->
	machine([]).
	
machine(Coins) ->
	receive
		{insert_coin, Coin} ->
			machine(insert_coin(Coin, Coins));
		{buy, CoffeType} ->
			machine(buy(CoffeType, Coins));
		{power_off} -> 
			format("Coffe machine is now off!~n")
	end.

insert_coin(Coin, MachineCoins) ->
	case coin:exists(Coin) of
		true ->
			format(
				"Coin '~.2f$' successfully inserted~n",
				[Coin]),
			[Coin | MachineCoins];
		_ ->
			format(
				"Sorry, there is no coin '~.2f$' in the market!~n",
				[Coin]),
			MachineCoins
	end.

buy(CoffeType, MachineCoins) ->
	buy(
		CoffeType,
		coffe:price(CoffeType),
		coin:total_value(MachineCoins),
		MachineCoins).

buy(CoffeType, undefined, _, MachineCoins) ->
	format("Sorry, coffe type '~w' doesn't exist!~n", [CoffeType]),
	MachineCoins;
buy(CoffeType, CoffePrice, CoinsValue, MachineCoins)
when CoffePrice > CoinsValue ->
	format("Sorry, ~.2f$ already left to buy ~w~n",
	[CoffePrice - CoinsValue, CoffeType]),
	MachineCoins;
buy(CoffeType, CoffePrice, _, MachineCoins) ->
	format("You just lost ~.2f$!~n", [CoffePrice]),
	format("You got one ~w!~n", [CoffeType]),
	coin:subtract(MachineCoins, CoffePrice).
