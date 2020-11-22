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
:- dynmaic(levelplayer/1)

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
:- discontiguous(char_id/0).b
:- discontiguous(charplayer/0).


charplayer :-
    playerLevel
    char_damage,
    char_defense,
    char_health,
    char_dodge,
    char_healthbase,
    char_id,
    char_jenis,
    char_milik,
    char_skill,
    char_player,
    weapon_type.

/*nama player*/
char_player :-
    asserta(player(Swordsman)),
    asserta(player(Archer)),
    asserta(player(Ninja)).

/* Level Player */
playerLevel :-
    assertz(levelplayer(Swordsman,1)),
    assertz(levelplayer(Archer,1)),
    assertz(levelplayer(Ninja,1)).

/*health base*/
char_healthbase :-
    asserta(healthbase(Swordsman, 850)), 
    asserta(healthbase(Archer, 670)),
    asserta(healthbase(Ninja, 700)).

/*health*/
char_health :-
    healthbase(Swordsman, X),
    healthbase(Archer, Y),
    healthbase(Ninja, Z),
    asserta(healthPlayer(Swordsman, X)),
    asserta(healthPlayer(Archer, Y)),
    asserta(healthPlayer(Ninja, Z)),

/*tipe*/
weapon_type :-
    asserta(type(Swordsman, Sword)),
    asserta(type(Archer, Bow)),
    asserta(type(Ninja, Kunai)).

/*normal attack*/
char_damage :-
    asserta(damage(Swordsman, 53)),
    asserta(damage(Archer, 60)),
    asserta(damage(Ninja, 58)).

/*normal defense*/
char_defense :-
    asserta(defense(Swordsman, 67)),
    asserta(defense(Archer, 45)),
    asserta(defense(Ninja, 55)).

/* Player Dodge */
char_dodge :-
    asserta(dodge(Swordsman, 1)),
    asserta(dodge(Archer, 1)),
    asserta(dodge(Ninja, 1)).


/*skill */
char_skill :-
    asserta(skill(Swordsman, 60)),
    asserta(skill(Archer, 60)),
    asserta(skill(Ninja, 60)).

/*kepemilikan*/
char_milik :-
    asserta(milik(Swordsman, 0)),
    asserta(milik(Archer, 0)),
    asserta(milik(Ninja, 0)),

/*id player*/
char_id :-
    asserta(id(Swordsman, 1)),
    asserta(id(Archer, 2)),
    asserta(id(Ninja, 3)).

updatelevel(player) :-
    levelplayer(player, levelP),
    Templevel is levelP + 1,
    healthbase(player, healthbase),
    Temphealthbase is healthbase+30,
    Tempnyawa is Temphealthbase,
    damage(player, serangan),
    Tempdamage is serangan+8,
    defense(player, tahanan),
    Temptahan is tahanan+5,
    retract(levelplayer(player,_)),
    retract(healthbase(player,_)),
    retract(health(player,_)),
    retract(damage(player,_)),
    retract(defense(player,_)),

    asserta(level(player,Templevel)),
    asserta(healthbase(player, Temphealthbase)),
    asserta(health(player, Tempnyawa)),
    asserta(damage(player, Tempserangan)),
    asserta(defense(player,Temptahanan)),!.

updateserangan(player) :-
    skill(player, X),
    damage(player, Y),
    Y is X,
    retract(damage(player,_)),

    asserta(damage(player,Y)).