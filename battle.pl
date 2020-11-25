:- include('player.pl').
:- include('dungeon.pl').

/* fight, run, gagalrun, attack, skill, itung turn, levelup */

:- dynamic(inBattle/1).
:- dynamic(enemy/1). % menandakan musuhnya apa
:- dynamic(totalTurn/1). % menghitung jumlah turn pemain
:- dynamic(playing/1). %nanti pindahin buat ngetes doang
:- dynamic(healed/1).
:- dynamic(totalDamage/1).
:- dynamic(totalDefense/1).
:- dynamic(attPotionEffect/1).
:- dynamic(defPotionEffect/1).
:- dynamic(potionCounterAtt/1).
:- dynamic(potionCounterDef/1).

:- discontiguous(decide/0).
:- discontiguous(run/0).
:- discontiguous(fight/0).
:- discontiguous(cannotRun/0).
:- discontiguous(goRun/0).
:- discontiguous(updateHPPlayer/1).
% :- discontiguous(updateHPMonster/0).
:- discontiguous(heal/0).
:- discontiguous(attackPotion/0).
:- discontiguous(defencePotion/0).
:- discontiguous(enemyAttack/0).
:- discontiguous(setBattleStats/0).

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
    setBattleStats,
    write('Beast creature appears, prepare yourself!'), nl,
    randomenemy,
    write('fight or run? '), nl.

setBattleStats :-
    char(Player),
    damage(Player, Dmg),
    equipment(weapon,_, WeaponDmg),
    TotalDmg is Dmg + WeaponDmg,
    assertz(totalDamage(TotalDmg)),
    defense(Player, Def),
    equipment(armor,_,ArmorDef),
    TotalDef is Def + ArmorDef,
    assertz(totalDefense(TotalDef)),!.

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
    retractall(totalTurn(_)),
    retractall(totalDamage(_)),
    retractall(totalDefense(_)),
    retractall(attPotionEffect(_)).

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

% Enemy attack - 12% defense
enemyAttack :-
    char(Karakter),
    defense(Karakter, Def),
    enemy(Enemy),
    write('attacked by '), write(Enemy), nl,
    dungeonDamage(Enemy, Dmg),
    TotalDmg is Dmg - (0.12*Def),
    (TotalDmg < 0 -> TotalDmg is 0;TotalDmg is TotalDmg),
    updateHPPlayer(TotalDmg), write('They got you, loss '), write(TotalDmg), write(' hp'),nl, printPlayerStats(Karakter),nl,fight,!.

attack :-
    \+playing(_),
    write('Its not started yet'),!.

attack :-
    playing(_), 
    \+inBattle(_),
    write('Are you mad? Go somewhere else to find monster!'), nl, !.


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
    Hp =:= Base, assertz(healed(1)), write('Youre fully healed, nothing to heal'),nl,fight,!.

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
    asserta(inventory(NewPotion, health_potion)), printPlayerStats(Karakter), %tambahin enemy attack
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

attackPotion :-
    \+playing(_),
    write('Its not started yet'),!.

attack_potion :-
    playing(_),
    \+inBattle(_),
    write('Youre not facing any enemy comrads, relax'),!.

attackPotion :-
    playing(_),
    inBattle(_),
    inventory(0, attack_potion),
    write('Nothing to consume, believe in your weapon commander!'),nl,fight,!.

attackPotion :-
    playing(_),
    inBattle(_),
    attPotionEffect(_),
    write('You cannot use attack potion more than once in the same time '),nl,fight,!.

attackPotion :-
    playing(_),
    inBattle(_),
    totalTurn(Count),
    C is Count + 3,
    asserta(potionCounterAtt(C)),
    inventory(X, attack_potion),
    X > 0, 
    %update jumlah turn
    totalTurn(N),
    N1 is N + 1,
    retractall(totalTurn(_)),
    asserta(totalTurn(N1)),
    asserta(attPotionEffect(1)),
    totalDamage(Dmg), NewDmg is Dmg + 100,
    retractall(totalDamage(_)), asserta(totalDamage(NewDmg)),!. %tambahin enemy attack


defencePotion :-
    \+playing(_),
    write('Its not started yet'),!.

defencePotion :-
    playing(_),
    \+inBattle(_),
    write('Youre not in a battle comrads, relax'),!.

defencePotion :-
    playing(_),
    inBattle(_),
    inventory(0, defence_potion),
    write('Nothing to consume, believe in your armor commander!'),nl,fight,!.

defencePotion :-
    playing(_),
    inBattle(_),
    defPotionEffect(_),
    write('You cannot use defence potion more than once in the same time '),nl,fight,!.

defencePotion :-
    playing(_),
    inBattle(_),
    totalTurn(Count),
    C is Count + 3,
    asserta(potionCounterDef(C)),
    inventory(X, defence_potion),
    X > 0, 
    %update jumlah turn
    totalTurn(N),
    N1 is N + 1,
    retractall(totalTurn(_)),
    asserta(totalTurn(N1)),
    asserta(defPotionEffect(1)),
    totalDefense(Def), NewDef is Def + 50,
    retractall(totalDefense(_)), asserta(totalDefense(NewDef)),!. %tambahin enemy attack


% Efek damage atau defense kembali normal tanpa potion
backNormal(Potion) :-
    totalDamage(X),
    totalDefense(Y),
    (Potion = att -> X1 is X - 100, retractall(totalDamage(_)), assertz(totalDamage(X1), retractall(potionCounterAtt(_))),!;
     Potion = def -> Y1 is Y - 50, retractall(totalDefense(_)), assertz(totalDefense(Y1)),retractall(potionCounterDef(_))),!.



updateHPPlayer(Damage) :-
    enemy(Enemy),
    char(Karakter),
    healthPlayer(Karakter, Hp),
    TempHpPlayer is Hp - Damage,
    (TempHpPlayer =< 0 -> 
        write('you lose to this ?'), 
        nl, 
        write('you not strong enough'),fail; 
        retractall(healthPlayer(Karakter,_)),
        asserta(healthPlayer(Karakter, TempHpPlayer)),!).