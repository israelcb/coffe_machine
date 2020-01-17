-define(COFF, machine).
-define(SEND(What), ?COFF ! What).

-record(coff__insert_coin, {coin}).
-record(coff__buy, {type}).
-record(coff__change, {}).
