%STORE
:- include('player.pl').

potion_choice(1):-
    add_inventory(health_potion).
potion_choice(2):-
    add_inventory(attack_potion).
potion_choice(3):-
    add_inventory(defence_potion).

ruby_check(Player_class,New_money):-
    New_money >= 0,
    retract(rubyplayer(Player_class,_)),
    assertz(rubyplayer(Player_class,New_money)),
    write('Heh heh, thank you!'),nl,
    write('Exiting store...'), nl.

ruby_check(_,New_money):-
    New_money < 0,
    write('Better you gain more rubies...'), nl,
    write('Exiting store...'), nl.


buy_choice(1,Player_money,Player_class):- %gacha
    add_inventory(gacha),
    New_money is Player_money - 150,
    ruby_check(Player_class,New_money).

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
    write('Welcome! What\'re ya buyin?'), nl,
    write('1. Gacha (150 Ruby)'), nl,
    write('2. Potion (50 Ruby)'), nl,
    write('Type 1 for Gacha and 2 for Potion.') , nl,
    read(Choice), nl,
    write('Ya sure?'), nl,
    write('Type 3 to proceed and other keys to exit'), nl,
    read(X), nl,
    cancel_verif(X,Choice,Player_money,Player_class).