-module(coffe_machine).

-import(io, [format/1]).

-export([buy_coffe/0]).

buy_coffe() ->
	format("You just lost 0.50$!~n"),
	format("You got one coffe!~n").
