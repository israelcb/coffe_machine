-module(coffe).

-export([price/1]).

price(espresso) -> 0.50;
price(espresso_macchiato) -> 1.50;
price(espresso_con_panna) -> 2.00;
price(coffe_latte) -> 3.50;
price(flat_white) -> 2.50;
price(caffe_breve) -> 3.00;
price(cappuccino) -> 2.50;
price(caffe_mocha) -> 3.75;
price(americano) -> 0.75;
price(latte_machiato) -> 1.50;
price(red_eye) -> 2.00;
price(cafe_au_lait) -> 1.50;
price(_) -> undefined.
