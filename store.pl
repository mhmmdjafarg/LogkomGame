%STORE
:- include('player.pl').

potion_choice(1):-
    add_inventory(health_potion),
    write('You receive Health Potion x 1'),nl.
potion_choice(2):-
    add_inventory(attack_potion),
     write('You receive Attack Potion x 1'),nl.
potion_choice(3):-
    add_inventory(defence_potion),
     write('You receive Defence Potion x 1'),nl.

weapon_prize(1,sword_of_eventide):- write('Congratulations, You get Sword of Eventide !'), nl.
weapon_prize(2,small_sword):- write('Congratulations, You get Small Sword !'), nl.
weapon_prize(3,dark_rapulser):- write('Congratulations, You get Dark Rapulser !'), nl.
weapon_prize(4,sword_excalibur):- write('Congratulations, You get Sword Excalibur !'), nl.
weapon_prize(5,night_sky_sword):- write('Congratulations, You get Night Sky Sword !'), nl.

weapon_prize(1,amos_bow):- write('Congratulations, You get Amos Bow !'), nl.
weapon_prize(2,the_viridescent_hunt):- write('Congratulations, You get The Viridescent Hunt !'), nl.
weapon_prize(3,the_stringles_bow):- write('Congratulations, You get The Stringles Bow !'), nl.
weapon_prize(4,skyward_harp):- write('Congratulations, You get Skyward Harp !'), nl.
weapon_prize(5,blackcliff_warbow):- write('Congratulations, You get Black Cliff War Bow !'), nl.

weapon_prize(1,kunai):- write('Congratulations, You get Kunai !'), nl.
weapon_prize(2,katana):- write('Congratulations, You get Katana !'), nl.
weapon_prize(3,tekko_kagi):- write('Congratulations, You get Tekko Kagi !'), nl.
weapon_prize(4,kusarigisama):- write('Congratulations, You get Kusarigisama !'), nl.
weapon_prize(5,kakute):- write('Congratulations, You get Kakute !'), nl.

weapon_randomizer(Class,Weapon):-
    random(1,6,X),
    typeweapon(Class,Weapon),
    weapon_prize(X,Weapon),!.

armor_prize(1,metal_armor):- write('Congratulations, You get Metal Armor !'), nl.
armor_prize(2,nanosuit):- write('Congratulations, You get Nano Suit !'), nl.
armor_prize(3,wood_armor):- write('Congratulations, You get Wood Armor !'), nl.
armor_prize(4,ultimate_armor):- write('Congratulations, You get Ultimate Armor !'), nl.
armor_prize(5,elite_advanced_suit):- write('Congratulations, You get Elite Advanced Suit !'), nl.

armor_randomizer(Armor):-
    random(1,6,X),
    armor_prize(X,Armor),!.


gacha_list(X,Weapon,Class):-
    X >= 80, X < 101,
    weapon_randomizer(Class,Weapon).

gacha_list(X,Armor,_):-
    X >= 60, X < 80,
    armor_randomizer(Armor).

gacha_list(X,health_potion,_):- X < 40, write('Congratulations, You get Health Potion x 1 !'), nl.
gacha_list(X,defence_potion,_):- X >= 40 , X < 50 , write('Congratulations, You get Defence Potion x 1 !'), nl.
gacha_list(X,attack_potion,_):- X >= 50, X < 60, write('Congratulations, You get Attack Potion x 1 !'), nl.

ruby_check(Player_class,New_money):-
    New_money >= 0,
    retract(rubyplayer(Player_class,_)),
    assertz(rubyplayer(Player_class,New_money)),nl,
    write('Heh heh, thank you!'),nl,nl,
    write('Exiting store...'), nl.

ruby_check(_,New_money):-
    New_money < 0,
    write('Better you gain more rubies...'), nl,
    write('Exiting store...'), nl.

open_gacha(_,New_money):-
    New_money < 0,
    ruby_check(_,New_money).

open_gacha(Class,New_money):-
    New_money >= 0,
    random(1,101,X),
    gacha_list(X,Item,Class),
    add_inventory(Item),
    ruby_check(Class,New_money),!.


buy_choice(1,Player_money,Player_class):- %gacha
    New_money is Player_money - 150,
    open_gacha(Player_class,New_money).

buy_choice(2,Player_money,Player_class) :-
    write('What kinda potion you wanna buy?'), nl, %potion
    write('1. Health Potion'), nl,
    write('2. Attack Potion'), nl,
    write('3. Defence Potion'), nl,
    read(Choice_potion),
    potion_choice(Choice_potion),
    New_money is Player_money - 50,
    ruby_check(Player_class,New_money).

cancel_verif(3,_,_,_):-
    is_full,
    write('Your inventory is full!').

cancel_verif(3,Choice,Player_money,Player_class):-
    buy_choice(Choice,Player_money,Player_class).

cancel_verif(X,_,_,_):-
    X =\= 3, write('Waste my time... Better buyin somethin next time').

shop(Player_money,Player_class):-
    char(Player_class),
    write('Welcome! What\'re ya buyin?'), nl,
    write('1. Gacha (150 Ruby)'), nl,
    write('2. Potion (50 Ruby)'), nl,
    write('Type 1 for Gacha and 2 for Potion.') , nl,
    read(Choice), nl,
    write('Ya sure?'), nl,
    write('Type 3 to proceed and other keys to exit'), nl,
    read(X), nl,
    cancel_verif(X,Choice,Player_money,Player_class),!.