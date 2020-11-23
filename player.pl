/* File : player.pl */

:- dynamic(player/1).
:- dynamic(healthPlayer/2).
:- dynamic(milik/2).
:- dynamic(healthbase/2).
:- dynamic(damage/2).
:- dynamic(defense/2).
:- dynamic(dodge/2).
:- dynamic(skill/2).
:- dynamic(ulti/2).
:- dynamic(type/2).
:- dynamic(id/2).
:- dynamic(levelplayer/1).
:- dynamic(rubyplayer/2).
:- dynamic(expplayerbase/2).
:- dynamic(expplayer/2).
:- dynamic(inventory/2).

:- discontiguous(playerLevel/0).
:- discontiguous(char_player/0).
:- discontiguous(char_health/0).
:- discontiguous(char_milik/0).
:- discontiguous(char_damage/0).
:- discontiguous(char_defense/0).
:- discontiguous(char_dodge/0).
:- discontiguous(char_healthbase/0).
:- discontiguous(char_skill/0).
:- discontiguous(weapon_type/0).
:- discontiguous(char_id/0).
:- discontiguous(charplayer/0).
:- discontiguous(charRuby/0).
:- discontiguous(char_expbase/0).
:- discontiguous(char_exp/0).
:- discontiguous(updatelevel/1).
:- discontiguous(updateruby/1).
:- discontiguous(printPlayerStats/1).
:- discontiguous(charInventory/0).


charplayer :-
    playerLevel,
    char_damage,
    char_player,
    char_defense,
    char_dodge,
    char_healthbase,
    char_health,
    char_id,
    char_milik,
    char_skill,
    weapon_type,
    char_expbase,
    char_exp,
    charRuby,
    charInventory.

/*ngurusin add inventory*/
max_capacity(100).

total_capacity(0,[]).

total_capacity(Length,[H|T]):-
    total_capacity(Prev_length,T),
    inventory(Quantity,H),
    Length is Prev_length + Quantity.

check_capacity(Length):-
    findall(Item,inventory(_,Item),List),
    total_capacity(Length,List).

is_full:-
    check_capacity(Length),
    Length >= 100.

add_inventory(_):-
    is_full,
    write('Inventory full!').

add_inventory(Item):-
    inventory(Quantity,Item),
    New_quantity is Quantity + 1,
    retract(inventory(Quantity,Item)),
    assertz(inventory(New_quantity,Item)).

/*nama player*/
char_player :-
    assertz(player(swordsman)),
    assertz(player(archer)),
    assertz(player(ninja)).

/* Level Player */
playerLevel :-
    assertz(levelplayer(swordsman,1)),
    assertz(levelplayer(archer,1)),
    assertz(levelplayer(ninja,1)).

/*health base*/
char_healthbase :-
    assertz(healthbase(swordsman, 850)), 
    assertz(healthbase(archer, 670)),
    assertz(healthbase(ninja, 700)).

/*health*/
char_health :-
    healthbase(swordsman, X),
    healthbase(archer, Y),
    healthbase(ninja, Z),
    assertz(healthPlayer(swordsman, X)),
    assertz(healthPlayer(archer, Y)),
    assertz(healthPlayer(ninja, Z)).

/*tipe*/
weapon_type :-
    assertz(type(swordsman, sword)),
    assertz(type(archer, bow)),
    assertz(type(ninja, kunai)).

/*normal attack*/
char_damage :-
    assertz(damage(swordsman, 53)),
    assertz(damage(archer, 60)),
    assertz(damage(ninja, 58)).

/*normal defense*/
char_defense :-
    assertz(defense(swordsman, 67)),
    assertz(defense(archer, 45)),
    assertz(defense(ninja, 55)).

/* Player Dodge */
char_dodge :-
    assertz(dodge(swordsman, 1)),
    assertz(dodge(archer, 1)),
    assertz(dodge(ninja, 1)).


/*skill */
char_skill :-
    assertz(skill(swordsman, 200)),
    assertz(skill(archer, 200)),
    assertz(skill(ninja, 200)).

/*kepemilikan*/
char_milik :-
    assertz(milik(swordsman, 0)),
    assertz(milik(archer, 0)),
    assertz(milik(ninja, 0)).

/*id player*/
char_id :-
    assertz(id(swordsman, 1)),
    assertz(id(archer, 2)),
    assertz(id(ninja, 3)).

/* Ruby player */
charRuby :-
    assertz(rubyplayer(swordsman, 0)),
    assertz(rubyplayer(archer, 0)),
    assertz(rubyplayer(ninja, 0)).

/* Inventory Player*/
charInventory :-
    assertz(inventory(0,attack_potion)),
    assertz(inventory(0,health_potion)),
    assertz(inventory(0,defence_potion)),
    % assertz(inventory(0,health_potion)),
    assertz(inventory(0,armor)),
    assertz(inventory(0,boots)),
    assertz(inventory(0,sword)),
    assertz(inventory(0,bow)),
    assertz(inventory(0,kunai)).

/* Exp player base level */
char_expbase :-
    assertz(expplayerbase(swordsman,50)),
    assertz(expplayerbase(archer,50)),
    assertz(expplayerbase(ninja,50)).

/* Exp player base level */
char_exp :-
    assertz(expplayer(swordsman,0)),
    assertz(expplayer(archer,0)),
    assertz(expplayer(ninja,0)).

printPlayerStats(Player) :-
    levelplayer(Player, LevelPlayer),
    damage(Player, Serang),
    defense(Player, Tahan),
    healthPlayer(Player, Hp),
    write('Player'), write(' Status'), nl,
    write('Character : '), write(Player), nl,
    write('Level     : '), write(LevelPlayer), nl,
    write('Attack    : '), write(Serang), nl,
    write('Defense   : '), write(Tahan), nl,
    write('Hp        : '), write(Hp), nl, !.

updatelevel(Player) :-
    levelplayer(Player, LevelP),
    Templevel is LevelP + 1,
    healthbase(Player, Healthbase),
    Temphealthbase is Healthbase+30,
    Tempnyawa is Temphealthbase,
    damage(Player, Serangan),
    Tempdamage is Serangan+8,
    defense(Player, Tahanan),
    Temptahan is Tahanan+5,
    expplayerbase(Player,Exp),
    TempExp is Exp + 50,
    expplayer(Player,Expskrg),
    Expskrg is 0,

    retract(levelplayer(Player,_)),
    retract(healthbase(Player,_)),
    retract(healthPlayer(Player,_)),
    retract(damage(Player,_)),
    retract(defense(Player,_)),
    retract(expplayerbase(Player,_)),
    retract(expplayer(Player,_)),

    assertz(level(Player,Templevel)),
    assertz(healthbase(Player, Temphealthbase)),
    assertz(healthPlayer(Player, Tempnyawa)),
    assertz(damage(Player, Tempdamage)),
    assertz(expplayerbase(Player, TempExp)),
    assertz(expplayerbase(Player, Expskrg)),
    assertz(defense(Player,Temptahan)),!.

updateruby(Player) :-
    rubyplayer(Player, X),
    Tempruby is X + 8 ,
    Rubyasli is Tempruby,
    retract(rubyplayer(Player,_)),

    assertz(rubyplayer(Player,Rubyasli)),!.
