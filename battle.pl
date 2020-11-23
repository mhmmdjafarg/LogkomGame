:- include('player.pl').
:- include('dungeon.pl').

/* fight, run, gagalrun, attack, skill, itung turn, levelup */

:- dynamic(inBattle/1).
:- dynamic(enemy/1). % menandakan musuhnya apa
:- dynamic(totalTurn/1). % menghitung jumlah turn pemain
:- dynamic(playing/1). %nanti pindahin buat ngetes doang
:- dynamic(enemyKilled/1).
:- dynamic(healed/1).
:- dynamic(totalDamage/1).
:- dynamic(totalDefense/1).

:- discontiguous(decide/0).
:- discontiguous(run/0).
:- discontiguous(fight/0).
:- discontiguous(cannotRun/0).
:- discontiguous(goRun/0).
:- discontiguous(updateHPPlayer/1).
% :- discontiguous(updateHPMonster/0).
:- discontiguous(isenemyKilled/0).
:- discontiguous(heal/0).
:- discontiguous(attackPotion/0).
:- discontiguous(enemyAttack/0).


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
    dungeonDamage(Enemy, Att),
    defence(Enemy, Def),
    baseHp(Enemy, BaseHp),nl,
    write('Type : '), write(Enemy), nl,
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
    repeat,
        random(10,40,Number),
        (Number =< 20 -> cannotRun; goRun),!.

cannotRun :-
    write('Too slow, he runs at you!'), nl,
    fight.

goRun :-
    write('Nice move, you escape!'), nl,
    retractall(inBattle(_)),
    retractall(enemy(_)),
    retractall(enemyKilled(_)),
    retractall(totalTurn(_)),
    retractall(totalDamage(_)),
    retractall(totalDefense(_)).

% fight
fight :-
    \+playing(_),
    write('Its not started yet'),!.

fight :-
    playing(_), 
    \+inBattle(_),
    write('Are you mad? Go somewhere else to find monster!'), nl, !.

fight :-
    playing(_), 
    inBattle(_),
    write('What are you gonna do ?'), nl,
    printFightCommand,
    asserta(totalTurn(0)),!.

printFightCommand :-
    write('1. attack'), nl,
    write('2. skill'), nl,
    write('3. heal'), nl,
    write('4. attackPotion'), nl,
    write('5. defencePotion'), nl,!,
    write('6. run').

% Enemy attack - 30% defense
enemyAttack :-
    char(Karakter),
    defense(Karakter, Def),
    enemy(Enemy),
    write('attacked by '), write(Enemy), nl,
    dungeonDamage(Enemy, Dmg),
    TotalDmg is Dmg - (0.3*Def),
    updateHPPlayer(TotalDmg), write('You loss '), write(TotalDmg), write(' hp'),nl, !.

attack :-
    \+playing(_),
    write('Its not started yet'),!.

attack :-
    playing(_), 
    \+inBattle(_),
    write('Are you mad? Go somewhere else to find monster!'), nl, !.

isenemyKilled :-
    enemy(Type),
    health(Type, Hp),
    (Hp =:= 0 -> asserta(enemyKilled(1))),!.

heal :-
    \+playing(_),
    write('Its not started yet'),!.

heal :-
    playing(_), 
    inventory(0, health_potion),
    write('Nothing to consume, stay alive commander!'),!.

heal :-
    playing(_),
    \+inBattle(_), 
    char(Karakter),
    totalTurn(N),
    N1 is N + 1,
    %update jumlah turn
    retractall(totalTurn(_)),
    asserta(totalTurn(N1)),
    healthPlayer(Karakter, Hp),
    healthbase(Karakter, Base),
    Hp =:= Base, assertz(healed(1)), write('Youre fully healed, nothing to heal'),!.

heal :-
    playing(_),
    inBattle(_), 
    char(Karakter),
    totalTurn(N),
    N1 is N + 1,
    %update jumlah turn
    retractall(totalTurn(_)),
    asserta(totalTurn(N1)),
    healthPlayer(Karakter, Hp),
    healthbase(Karakter, Base),
    Hp =:= Base, assertz(healed(1)), write('Youre fully healed, nothing to heal'),!.

heal :-
    playing(_),
    \+inBattle(_),
    char(Karakter),
    healthPlayer(Karakter, Hp),
    healthbase(Karakter, Base),
    Hp < Base, inventory(NumPotion, health_potion), NumPotion > 0,
    NewHp is Hp + 200,
    retractall(healthPlayer(Karakter, _ )),
    (NewHp >= Base -> asserta(healthPlayer(Karakter, Base)); 
    asserta(healthPlayer(Karakter, NewHp))),
    write('Feeling better comrads ?'), inventory(X, health_potion),
    NewPotion is X - 1, retractall(inventory(_,health_potion)),
    asserta(inventory(NewPotion, health_potion)), printPlayerStats(Karakter),
    !.

heal :-
    playing(_),
    inBattle(_),
    totalTurn(N),
    N1 is N + 1,
    %update jumlah turn
    retractall(totalTurn(_)),
    asserta(totalTurn(N1)),
    char(Karakter),
    healthPlayer(Karakter, Hp),
    healthbase(Karakter, Base),
    Hp < Base, inventory(NumPotion, health_potion), NumPotion > 0,
    NewHp is Hp + 200,
    retractall(healthPlayer(Karakter, _ )),
    (NewHp >= Base -> asserta(healthPlayer(Karakter, Base)); 
    asserta(healthPlayer(Karakter, NewHp))),
    write('Feeling better comrads ?'), inventory(X, health_potion),
    NewPotion is X - 1, retractall(inventory(_,health_potion)),
    asserta(inventory(NewPotion, health_potion)), printPlayerStats(Karakter), !.
    %tambahin enemy attack di akhir turn

updateHPPlayer(Damage) :-
    enemy(Enemy),
    char(Karakter),
    healthPlayer(Karakter, Hp),
    TempHpPlayer is Hp - Damage,
    (TempHpPlayer =< 0 -> 
        write('you lose to this ?'), 
        nl, 
        write('you not strong enough'),
        nl,
        halt; 
        retractall(healthPlayer(Karakter,_)),
        asserta(healthPlayer(Karakter, TempHpPlayer)),!).
    
% attackPotion :-
%     \+playing(_),
%     write('Its not started yet'),!.

% attack_potion :-
%     playing(_),
%     \+inBattle(_),
%     write('You're not facing any enemy comrads, relax'),!.

% attackPotion :-
%     playing(_),
%     inBattle(_),
%     inventory(0, attack_potion),
%     write('Nothing to consume, believe in your weapon commander!'),!.

% attackPotion :-
%     playing(_),
%     inBattle(_),
%     totalTurn(N),
%     N1 is N + 1,
%     %update jumlah turn
%     retractall(totalTurn(_)),
%     asserta(totalTurn(N1)),
%     inventory(X, attack_potion),
%     X > 0, 
%     char(Karakter),

    %tambahin enemy attack di akhir turn

