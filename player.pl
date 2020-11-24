/* File : player.pl */
:- dynamic(player/1).
:- dynamic(healthPlayer/2).
:- dynamic(healthbase/2).
:- dynamic(damage/2).
:- dynamic(defense/2).
:- dynamic(skill/2).
:- dynamic(ulti/2).
:- dynamic(typeweapon/2).
:- dynamic(damageweapon/2).
:- dynamic(typearmor/2).
:- dynamic(kerasarmor/2).
:- dynamic(levelplayer/1).
:- dynamic(rubyplayer/2).
:- dynamic(expplayerbase/2).
:- dynamic(expplayer/2).
:- dynamic(inventory/2).

:- discontiguous(playerLevel/0).
:- discontiguous(char_player/0).
:- discontiguous(char_health/0).
:- discontiguous(char_damage/0).
:- discontiguous(char_defense/0).
:- discontiguous(char_healthbase/0).
:- discontiguous(char_skill/0).
:- discontiguous(weapon_type/0).
:- discontiguous(charplayer/0).
:- discontiguous(charRuby/0).
:- discontiguous(char_expbase/0).
:- discontiguous(char_exp/0).
:- discontiguous(updatelevel/1).
:- discontiguous(updateruby/1).
:- discontiguous(printPlayerStats/1).
:- discontiguous(weapon_damage/0).
:- discontiguous(armor_type/0).
:- discontiguous(armor/0).
:- discontiguous(charInventory/0).


charplayer :-
    playerLevel,
    char_damage,
    char_player,
    char_defense,
    char_healthbase,
    char_health,
    char_skill,
    weapon_type,
    char_expbase,
    char_exp,
    charRuby,
    weapon_damage,
    armor_type,
    armor,
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
    assertz(typeweapon(swordsman, sword_of_eventide)),
    assertz(typeweapon(swordsman, small_sword)),
    assertz(typeweapon(swordsman, dark_rapulser)),
    assertz(typeweapon(swordsman, sword_excalibur)),
    assertz(typeweapon(swordsman, night_sky_sword)),
    assertz(typeweapon(swordsman, common_sword)),
    assertz(typeweapon(archer, amos_bow)),
    assertz(typeweapon(archer, common_bow)),
    assertz(typeweapon(archer, the_viridescent_hunt)),
    assertz(typeweapon(archer, the_stringles_bow)),
    assertz(typeweapon(archer, skyward_harp)),
    assertz(typeweapon(archer, blackcliff_warbow)),
    assertz(typeweapon(ninja, kunai)),
    assertz(typeweapon(ninja, shuriken)),
    assertz(typeweapon(ninja, katana)),
    assertz(typeweapon(ninja, tekko_kagi)),
    assertz(typeweapon(ninja, kusarigisama)),
    assertz(typeweapon(ninja, kakute)).

weapon_damage :-
    assertz(damageweapon(sword_of_eventide, 85)),
    assertz(damageweapon(small_sword,60)),
    assertz(damageweapon(dark_rapulser,75)),
    assertz(damageweapon(sword_excalibur,100)),
    assertz(damageweapon(night_sky_sword,80)),
    assertz(damageweapon(common_sword,12)),
    assertz(damageweapon(amos_bow, 85)),
    assertz(damageweapon(common_bow,15)),
    assertz(damageweapon(the_viridescent_hunt,75)),
    assertz(damageweapon(the_stringles_bow,60)),
    assertz(damageweapon(skyward_harp,80)),
    assertz(damageweapon(blackangels_warbow,100)),
    assertz(damageweapon(shuriken,13)),
    assertz(damageweapon(kunai,85)),
    assertz(damageweapon(katana,100)),
    assertz(damageweapon(tekko_kagi,70)),
    assertz(damageweapon(kusarigisama,80)),
    assertz(damageweapon(kakute,60)).

armor_type :-
    assertz(typearmor(swordsman, metal_armor)),
    assertz(typearmor(swordsman, nanosuit)),
    assertz(typearmor(swordsman, wood_armor)),
    assertz(typearmor(swordsman, ultimate_armor)),
    assertz(typearmor(swordsman, elite_advanced_suit)),
    assertz(typearmor(archer, metal_armor)),
    assertz(typearmor(archer, nanosuit)),
    assertz(typearmor(archer, wood_armor)),
    assertz(typearmor(archer, ultimate_armor)),
    assertz(typearmor(archer, elite_advanced_suit)),
    assertz(typearmor(ninja, metal_armor)),
    assertz(typearmor(ninja, nanosuit)),
    assertz(typearmor(ninja, wood_armor)),
    assertz(typearmor(ninja, ultimate_armor)),
    assertz(typearmor(swordsman, common_armor)),
    assertz(typearmor(archer, common_armor)),
    assertz(typearmor(ninja, common_armor)),
    assertz(typearmor(ninja, elite_advanced_suit)).

armor :-
    assertz(kerasarmor(metal_armor, 20)),
    assertz(kerasarmor(common_armor, 5)),
    assertz(kerasarmor(nanosuit,40)),
    assertz(kerasarmor(wood_armor,10)),
    assertz(kerasarmor(ultimate_armor,50)),
    assertz(kerasarmor(elite_advanced_suit,30)).

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


/*skill */
char_skill :-
    assertz(skill(swordsman, 200)),
    assertz(skill(archer, 200)),
    assertz(skill(ninja, 200)).

/* Ruby player */
charRuby :-
    assertz(rubyplayer(swordsman, 200)),
    assertz(rubyplayer(archer, 200)),
    assertz(rubyplayer(ninja, 200)).

/* Inventory Player*/
charInventory :-
    assertz(inventory(0,attack_potion)),
    assertz(inventory(0,health_potion)),
    assertz(inventory(0,defence_potion)),
    assertz(inventory(0,metal_armor)),
    assertz(inventory(0,nanosuit)),
    assertz(inventory(0,wood_armor)),
    assertz(inventory(0,ultimate_armor)),
    assertz(inventory(0,elite_advanced_suit)),
    assertz(inventory(0,sword_of_eventide)),
    assertz(inventory(0,small_sword)),
    assertz(inventory(0,dark_rapulser)),
    assertz(inventory(0,sword_excalibur)),
    assertz(inventory(0,night_sky_sword)),
    assertz(inventory(0,amos_bow)),
    assertz(inventory(0,the_viridescent_hunt)),
    assertz(inventory(0,the_stringles_bow)),
    assertz(inventory(0,skyward_harp)),
    assertz(inventory(0,blackcliff_warbow)),
    assertz(inventory(0,kunai)),
    assertz(inventory(0,katana)),
    assertz(inventory(0,tekko_kagi)),
    assertz(inventory(0,kusarigisama)),
    assertz(inventory(0,common_sword),
    assertz(inventory(0,common_bow)),
    assertz(inventory(0,common_armor)),
    assertz(inventory(0,shuriken)),
    assertz(inventory(0,kakute)).

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
    retract(damage(Player,_)),
    retract(defense(Player,_)),
    retract(expplayerbase(Player,_)),
    retract(expplayer(Player,_)),

    assertz(levelplayer(Player,Templevel)),
    assertz(healthbase(Player, Tempnyawa)),
    assertz(damage(Player, Tempdamage)),
    assertz(expplayerbase(Player, TempExp)),
    assertz(expplayer(Player, Expskrg)),
    assertz(defense(Player,Temptahan)),!.

updateruby(Player) :-
    rubyplayer(Player, X),
    Tempruby is X + 8 ,
    Rubyasli is Tempruby,
    retract(rubyplayer(Player,_)),

    assertz(rubyplayer(Player,Rubyasli)),!.
