%STORE
%:- use_module(library(random)).
:- dynamic(inventory/1).
:- dynamic(money/1).

%list_of_potion([attack_potion,health_potion,defence_potion]).

%weapon_combination(archer,bow).
%weapon_combination(swordsman,sword).
%weapon_combination(ninja,kunai).

%potion_gacha(Potion):-
%    list_of_potion(L),
%    random_member(Potion,L).

%gacha_goods([Weapon,armor,boots,Potion],Player_class):-
%    weapon_combination(Player_class,Weapon),
%    potion_gacha(Potion).

%gacha_random(Player_class,Goods):-
%    gacha_goods(List,Player_class),
%    random_member(Goods,List).

minus(X,Y):- Y is X - 50.

add_inventory(Item):-
    assertz(inventory(Item)).

potion_choice(1):-
    add_inventory(health_potion).
potion_choice(2):-
    add_inventory(attack_potion).
potion_choice(3):-
    add_inventory(defence_potion).

buy_choice(1,Player_money,New_money):- %gacha
    add_inventory(gacha),
    New_money is Player_money - 150.

buy_choice(2,Player_money,New_money):-
    write('What kinda potion you wanna buy?'), nl, %potion
    write('1. Health Potion'), nl,
    write('2. Attack Potion'), nl,
    write('3. Defence Potion'), nl,
    read(Choice_potion),
    potion_choice(Choice_potion),
    New_money is Player_money - 50. %error disini

cancel_verif(3):- write('Exiting shop...'),!.
cancel_verif(4).

shop(Player_money,New_money):-
    write('Welcome! What\'re ya buyin?'), nl,
    write('1. Gacha (150 Ruby)'), nl,
    write('2. Potion (50 Ruby)'), nl,
    write('Type 1 for Gacha and 2 for Potion.') , nl,
    read(Choice),
    write('Ya sure?'), nl,
    write('Type 3 to cancel the transaction and 4 to proceed.'), nl,
    read(X), nl,
    New_money is Player_money,
    cancel_verif(X),
    buy_choice(Choice,Player_money,New_money),
    write('Heh heh, thank you!'),!.


test:-
    money(Player_money),
    Player_money is 1500,
    shop(Player_money,New_money),
    retract(money(Player_money))
    write(Player_money),
    write(New_money).