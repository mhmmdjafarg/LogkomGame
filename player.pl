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
    weapon_type.

/*nama player*/
char_player :-
    asserta(player(swordsman)),
    asserta(player(archer)),
    asserta(player(ninja)).

/* Level Player */
playerLevel :-
    assertz(levelplayer(swordsman,1)),
    assertz(levelplayer(archer,1)),
    assertz(levelplayer(ninja,1)).

/*health base*/
char_healthbase :-
    asserta(healthbase(swordsman, 850)), 
    asserta(healthbase(archer, 670)),
    asserta(healthbase(ninja, 700)).

/*health*/
char_health :-
    healthbase(swordsman, X),
    healthbase(archer, Y),
    healthbase(ninja, Z),
    asserta(healthPlayer(swordsman, X)),
    asserta(healthPlayer(archer, Y)),
    asserta(healthPlayer(ninja, Z)).

/*tipe*/
weapon_type :-
    asserta(type(swordsman, Sword)),
    asserta(type(archer, Bow)),
    asserta(type(ninja, Kunai)).

/*normal attack*/
char_damage :-
    asserta(damage(swordsman, 53)),
    asserta(damage(archer, 60)),
    asserta(damage(ninja, 58)).

/*normal defense*/
char_defense :-
    asserta(defense(swordsman, 67)),
    asserta(defense(archer, 45)),
    asserta(defense(ninja, 55)).

/* Player Dodge */
char_dodge :-
    asserta(dodge(swordsman, 1)),
    asserta(dodge(archer, 1)),
    asserta(dodge(ninja, 1)).


/*skill */
char_skill :-
    asserta(skill(swordsman, 200)),
    asserta(skill(archer, 200)),
    asserta(skill(ninja, 200)).

/*kepemilikan*/
char_milik :-
    asserta(milik(swordsman, 0)),
    asserta(milik(archer, 0)),
    asserta(milik(ninja, 0)).

/*id player*/
char_id :-
    asserta(id(swordsman, 1)),
    asserta(id(archer, 2)),
    asserta(id(ninja, 3)).

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

    retract(levelplayer(Player,_)),
    retract(healthbase(Player,_)),
    retract(healthPlayer(Player,_)),
    retract(damage(Player,_)),
    retract(defense(Player,_)),

    asserta(level(Player,Templevel)),
    asserta(healthbase(Player, Temphealthbase)),
    asserta(healthPlayer(Player, Tempnyawa)),
    asserta(damage(Player, Tempdamage)),
    asserta(defense(Player,Temptahan)),!.

updateserangan(player) :-
    skill(player, X),
    damage(player, Y),
    Y is X,
    retract(damage(player,_)),

    asserta(damage(player,Y)).