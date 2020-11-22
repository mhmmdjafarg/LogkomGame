:- dynamic(idDungeon/2).
:- dynamic(dungeon/1).
:- dynamic(level/2).
:- dynamic(baseHp/2).
:- dynamic(health/2).
:- dynamic(attack/2).
:- dynamic(defence/2).
% enemy(ID, Name, Level, MaxHealth, Health, Attack, Defence),

:- discontiguous(spawnDungeon/0).
:- discontiguous(initDungeon/0).
:- discontiguous(initLevel/0).
:- discontiguous(initbaseHealth/0).
:- discontiguous(initHealth/0).
:- discontiguous(initAttack/0).
:- discontiguous(initDefence/0).
:- discontiguous(getlevel/1).
:- discontiguous(restoreHealth/1).

spawnDungeon :-
    initId,
    initDungeon,
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
    assertz(baseHp(underlord,3000)),
    assertz(baseHp(dungeonBoss,5000)).

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
    assertz(attack(goblin,30)),
    assertz(attack(slime,15)),
    assertz(attack(wolf,45)),
    assertz(attack(underlord,120)),
    assertz(attack(dungeonBoss,200)).

initDefence :-
    assertz(defence(goblin,20)),
    assertz(defence(slime,0)),
    assertz(defence(wolf,30)),
    assertz(defence(underlord,100)),
    assertz(defence(dungeonBoss,200)).

getlevel(Name) :-
    level(Name, Lvl),
    TempLvl is Lvl + 1,
    baseHp(Name, BaseHp),
    TempBaseHp is BaseHp+30,
    TempHp is TempBaseHp,
    attack(Name, Att),
    TempAtt is Att+5,
    defence(Name, Def),
    TempDef is Def+5,
    retract(level(Name,_)),
    retract(baseHp(Name,_)),
    retract(health(Name,_)),
    retract(attack(Name,_)),
    retract(defence(Name,_)),

    asserta(level(Name,TempLvl)),
    asserta(baseHp(Name, TempBaseHp)),
    asserta(health(Name, TempHp)),
    asserta(attack(Name, TempAtt)),
    asserta(defence(Name,TempDef)),!.

restoreHealth(Name) :-
    retract(health(Name,_)),
    baseHp(Name, Base),
    asserta(health(Name, Base)), !.

