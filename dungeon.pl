:- dynamic(idDungeon/2).
:- dynamic(dungeon/1).
:- dynamic(level/2).
:- dynamic(baseHp/2).
:- dynamic(health/2).
:- dynamic(dungeonDamage/2).
:- dynamic(defence/2).
:- dynamic(dungeonExp/2).
% enemy(ID, Name, Level, MaxHealth, Health, dungeonDamgae, Defence),

:- discontiguous(spawnDungeon/0).
:- discontiguous(initExpDungeon/0).
:- discontiguous(initDungeon/0).
:- discontiguous(initLevel/0).
:- discontiguous(initbaseHealth/0).
:- discontiguous(initHealth/0).
:- discontiguous(initAttack/0).
:- discontiguous(initDefence/0).
:- discontiguous(getlevel/1).
:- discontiguous(restoreHealth/1).
:- discontiguous(resetdungeon/0).

    
spawnDungeon :-
    initIdDungeon,
    initDungeon,
    initExpDungeon,
    initLevel,
    initbaseHealth,
    initHealth,
    initAttack,
    initDefence.

initIdDungeon :-
    assertz(idDungeon(goblin,1)),
    assertz(idDungeon(slime,2)),
    assertz(idDungeon(wolf,3)),
    assertz(idDungeon(underlord,4)),
    assertz(idDungeon(dungeonBoss,5)).

initDungeon :-
    assertz(dungeon(goblin)),
    assertz(dungeon(slime)),
    assertz(dungeon(wolf)),
    assertz(dungeon(underlord)),
    assertz(dungeon(dungeonBoss)).

initExpDungeon :-
    assertz(dungeonExp(goblin,25)),
    assertz(dungeonExp(slime,25)),
    assertz(dungeonExp(wolf,25)),
    assertz(dungeonExp(underlord,300)).

initLevel :-
    assertz(level(goblin,1)),
    assertz(level(slime,1)),
    assertz(level(wolf,1)),
    assertz(level(underlord,15)),
    assertz(level(dungeonBoss,25)).

initbaseHealth :-
    assertz(baseHp(goblin,400)),
    assertz(baseHp(slime,550)),
    assertz(baseHp(wolf,450)),
    assertz(baseHp(underlord,2000)),
    assertz(baseHp(dungeonBoss,3500)).

initHealth :-
    baseHp(goblin,X),
    baseHp(slime,Y),
    baseHp(wolf,Z),
    baseHp(underlord,W),
    baseHp(dungeonBoss,T),
    assertz(health(goblin, X)),
    assertz(health(slime, Y)),
    assertz(health(wolf, Z)),
    assertz(health(underlord, W)),
    assertz(health(dungeonBoss, T)),!.

initAttack :-
    assertz(dungeonDamage(goblin,40)),
    assertz(dungeonDamage(slime,30)),
    assertz(dungeonDamage(wolf,60)),
    assertz(dungeonDamage(underlord,180)),
    assertz(dungeonDamage(dungeonBoss,250)).

initDefence :-
    assertz(defence(goblin,30)),
    assertz(defence(slime,10)),
    assertz(defence(wolf,35)),
    assertz(defence(underlord,120)),
    assertz(defence(dungeonBoss,250)).

getlevel(Name) :-
    level(Name, Lvl),
    TempLvl is Lvl + 1,
    dungeonExp(Name, Exp),
    TempExp is Exp + 15,
    baseHp(Name, BaseHp),
    TempBaseHp is BaseHp+30,
    TempHp is TempBaseHp,
    dungeonDamage(Name, Att),
    TempAtt is Att+5,
    defence(Name, Def),
    TempDef is Def+5,
    retract(level(Name,_)),
    retract(dungeonExp(Name,_)),
    retract(baseHp(Name,_)),
    retract(health(Name,_)),
    retract(dungeonDamage(Name,_)),
    retract(defence(Name,_)),

    asserta(level(Name,TempLvl)),
    asserta(dungeonExp(Name, TempExp)),
    asserta(baseHp(Name, TempBaseHp)),
    asserta(health(Name, TempHp)),
    asserta(dungeonDamage(Name, TempAtt)),
    asserta(defence(Name,TempDef)),!.

restoreHealth(Name) :-
    retract(health(Name,_)),
    baseHp(Name, Base),
    asserta(health(Name, Base)), !.

resetdungeon :-
    retractall(idDungeon(_,_)),
    retractall(dungeon(_)),
    retractall(level(_,_)),
    retractall(baseHp(_,_)),
    retractall(health(_,_)),
    retractall(dungeonDamage(_,_)),
    retractall(defence(_,_)),
    retractall(dungeonExp(_,_)).