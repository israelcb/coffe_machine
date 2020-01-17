-module(coffe_machine).

-include_lib("./../api.hrl").

-import(io, [format/1]).
-import(io, [format/2]).

-record(coff__power_off, {}).

-export([start/0]).
-export([stop/0]).
-export([machine/0]).

start() ->
	register(machine, spawn(?MODULE, machine, [])),
	format("Coffe machine is now on!~n").

stop() ->
	?SEND(#coff__power_off{}).

machine() ->
	machine([]).
	
machine(Coins) ->
	receive
		#coff__insert_coin{coin=Coin} ->
			machine(insert_coin(Coin, Coins));
		#coff__buy{type=CoffeType} ->
			machine(buy(CoffeType, Coins));
		#coff__change{} ->
			format(
				"You received a ~.2f$ change~n",
				[coin:total_value(Coins)]),
			machine([]);
		#coff__power_off{} -> 
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
