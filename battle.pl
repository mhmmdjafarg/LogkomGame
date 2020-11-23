:- include('player.pl').
:- include('dungeon.pl').

/* fight, run, gagalrun, attack, skill, itung turn, levelup */

:- dynamic(inBattle/1).
:- dynamic(enemy/1). %menandakan musuhnya apa
:- dynamic(totalTurn/1). % menghitung jumlah turn pemain
:- dynamic(playing/1). %nanti pindahin buat ngetes doang

:- discontiguous(decide/0).
:- discontiguous(run/0).
:- discontiguous(fight/0).
:- discontiguous(cannotRun/0).
:- discontiguous(goRun/0).
:- discontiguous(updateHPPlayer/2).
:- discontiguous(updateHPMonster/2).


/* Pilih random enemy */
randomenemy :-
    % random untuk wolf slime goblin
    repeat,
        random(1,4, Id),
        idDungeon(EnemyType,Id),
        asserta(enemy(EnemyType)),!,
        printEnemyStats(EnemyType).


printEnemyStats(Enemy) :-
    level(Enemy, Level),
    attack(Enemy, Att),
    defence(Enemy, Def),
    baseHp(Enemy, BaseHp),
    write(Enemy), write(' appears'), nl,
    write('Level : '), write(Level), nl,
    write('Attack : '), write(Att), nl,
    write('Defence : '), write(Def), nl,
    write('base Hp : '), write(BaseHp), nl, !.


/* pertama kali bertemu dungeon */
decide :-
    asserta(inBattle(1)),
    write('Beast creature appears, prepare yourself!'), nl,
    randomenemy,
    write('fight or run? '), nl.
    

% kondisi sedang tidak bermain %
run :-
	\+playing(_), % ini ada di player.pl atau main.pl
    write('The game not started yet, type \'start.\' first'), nl,!.

% kondisi tidak sedang dalam battle
run :-
    playing(_),
	 \+inBattle(_),
    write('You are not in battle, run for what?'), nl,!.
  
run :-
    inBattle(_),
    random(1,8,Number),
    (Number =< 2 -> cannotRun; goRun).

cannotRun :-
    write('Too slow, he runs at you!'), nl,
    fight.

goRun :-
    write('Nice move, you escape!'), nl,
    retractall(inBattle(_)),
    retractall(enemy(_)).


% fight
fight :-
    \+playing(_),
    write('Its not started yet'),!.

fight :-
    playing(_), 
    \+inBattle(_),
    write('Are you mad? Go somewhere else to find monster!'), nl, !.

% fight :-
%     write("There's no time to think, attack now !")

% printFightCommand :-
%     wr
% updateHPPlayer(Player,Monster) :-
%     attack(Monster,X),
%     healthPlayer(Player, Y),
%     TempHpPlayer is Y - X,
%     retract(healthPlayer(Player,_)),
%     assertz(healthPlayer(Player, TempHp)),!.

% updateHPMonster (Player,Monster) :-
%     damage(Player, X),
%     health(Monster,Y),
%     TempHpMonster is Y - X,
%     retract(health(Monster,_)),
    
%     assertz(health(Monster, TempHpMonster)),!.