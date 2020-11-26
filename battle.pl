:- include('player.pl').
:- include('dungeon.pl').
:- include('quest.pl').
:- include('gambar.pl').
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
:- dynamic(skillCounter/1).
:- dynamic(fightBoss/1).

:- discontiguous(decide/0).
:- discontiguous(run/0).
:- discontiguous(fight/0).
:- discontiguous(cannotRun/0).
:- discontiguous(goRun/0).
:- discontiguous(updateHPPlayer/1).
:- discontiguous(updateHPMonster/1).
:- discontiguous(heal/0).
:- discontiguous(attackPotion/0).
:- discontiguous(defencePotion/0).
:- discontiguous(enemyAttack/0).
:- discontiguous(setBattleStats/0).
:- discontiguous(updateBattleStats/0).
:- discontiguous(updateTurn/0).
:- discontiguous(decrementInventory/1).
:- discontiguous(enemykilled/0).
:- discontiguous(updateskillCounter/1).


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
    health(Enemy, Hp),nl,
    (Enemy == goblin -> printgoblin; Enemy == slime -> printslime; Enemy == wolf -> printwolf;Enemy == underlord -> printsecretboss;Enemy == dungeonBoss -> printdragon),
    write('Type         : '), write(Enemy), nl,
    write('Level        : '), write(Level), nl,
    write('Attack       : '), write(Att), nl,
    write('Defence      : '), write(Def), nl,
    write('Health point : '), write(Hp), nl, !.


/* pertama kali bertemu dungeon */
decide :-
    asserta(inBattle(1)),
    setBattleStats,
    asserta(totalTurn(0)),
    updateskillCounter(0),
    write('Beast creature appears, prepare yourself!'), nl,
    randomenemy,
    write('fight or run? '), nl.

decideBoss :-
    asserta(inBattle(1)),
    asserta(fightBoss(1)),
    setBattleStats,
    asserta(totalTurn(0)),
    updateskillCounter(0),
    write('This is your last fight!, Good luck!'), nl,
    asserta(enemy(dungeonBoss)),
    printEnemyStats(dungeonBoss),fight,!.

decideSecretBoss :-
    asserta(inBattle(1)),
    setBattleStats,
    asserta(totalTurn(0)),
    updateskillCounter(0),
    write('Fight the underlord, be careful, he used to be your friend ....'), nl,
    asserta(enemy(underlord)),
    printEnemyStats(underlord),fight,!.

updateTurn :-
    totalTurn(N),
    N1 is N + 1,
    %update jumlah turn
    retractall(totalTurn(_)),
    asserta(totalTurn(N1)),
    incSkillCounter,!.

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

updateBattleStats :-
    char(Player),
    damage(Player, Dmg),
    equipment(weapon,_, WeaponDmg),
    (attPotionEffect(_) -> TotalDmg is Dmg + WeaponDmg + 100; TotalDmg is Dmg+WeaponDmg),
    retractall(totalDamage(_)),
    assertz(totalDamage(TotalDmg)),
    defense(Player, Def),
    equipment(armor,_,ArmorDef),
    (defPotionEffect(_) -> TotalDef is Def + ArmorDef + 50; TotalDef is Def+ArmorDef),
    retractall(totalDefense(_)),
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
    \+fightBoss(_),
    repeat,
        random(10,40,Number),
        (Number =< 20 -> cannotRun; goRun),!.
run :-
    inBattle(_),
    fightBoss(_),
    write('You cannot run from dungeon Boss, pray for yourself '), nl, fight,!.

cannotRun :-
    write('Too slow, he runs at you!'), nl,
    fight.

goRun :-
    write('Nice move, you escape!'), nl,
    enemy(Enemy),
    restoreHealth(Enemy),
    printmap,
    retractall(inBattle(_)),
    retractall(enemy(_)),
    retractall(totalTurn(_)),
    retractall(totalDamage(_)),
    retractall(totalDefense(_)),
    retractall(attPotionEffect(_)),
    retractall(defPotionEffect(_)),
    retractall(potionCounterAtt(_)),
    retractall(potionCounterDef(_)),
    retractall(skillCounter(_)),!.

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
    \+potionCounterAtt(_),
    \+potionCounterDef(_),
    printplayer,
    write('What are you gonna do ?'), nl,
    enemy(Enemy),
    (Enemy == dungeonBoss -> printFightCommandBoss; printFightCommand),!.

fight :-
    playing(_), 
    inBattle(_),
    write('What are you gonna do ?'), nl,
    enemy(Enemy),
    (Enemy == dungeonBoss -> printFightCommandBoss; printFightCommand),
    totalTurn(X),
    (potionCounterAtt(Y), X =:= Y -> backNormal(att); nl),
    (potionCounterDef(Z),X =:= Z -> backNormal(def); nl),!.

printFightCommand :-
    skillCounter(X),
    (X >= 3 -> write('skill ready !'),nl; nl),
    write('1. attack'), nl,
    write('2. skill '), write(X), write('/3'), nl,
    write('3. heal'), nl,
    write('4. attackPotion'), nl,
    write('5. defencePotion'), nl,!,
    write('6. run').

printFightCommandBoss :-
    skillCounter(X),
    (X >= 3 -> write('skill ready !'),nl; nl),
    write('1. attack'), nl,
    write('2. skill '), write(X), write('/3'), nl,
    write('3. heal'), nl,
    write('4. attackPotion'), nl,
    write('5. defencePotion'), nl,!.

% Enemy attack - 12% defense
enemyAttack :-
    char(Karakter),
    defense(Karakter, Def),
    enemy(Enemy),
    write('attacked by '), write(Enemy), nl,
    dungeonDamage(Enemy, Dmg),
    TotalDmg is round(Dmg - (0.12*Def)),
    (TotalDmg < 0 -> TotalDmg is 0; TotalDmg is TotalDmg),
    updateHPPlayer(TotalDmg), write('Careful, they will strike !!!'), nl,
    write('They got you, loss '), write(TotalDmg), write(' hp'),nl,nl,printPlayerhp,nl,fight,!.

printPlayerhp :-
    char(Karakter),
    healthPlayer(Karakter,X),
    write('Your hp : '), write(X), write(' hp'),!.

attack :-
    \+playing(_),
    write('Its not started yet'),!.

attack :-
    playing(_), 
    \+inBattle(_),
    write('Are you mad? Go somewhere else to find monster!'), nl, !.

attack :-
    playing(_), 
    inBattle(_),
    updateBattleStats,
    updateTurn,
    enemy(Enemy),
    defence(Enemy, Def),
    totalDamage(Dmg), TotalDmg is round(Dmg - 0.2*Def),
    (TotalDmg < 0 -> TotalDmg is 0; TotalDmg is TotalDmg),
    updateHPMonster(TotalDmg), write('Nice shot'), nl, write('You just hit '), write(TotalDmg), write(' damage'),nl,
    printEnemyStats(Enemy), nl, enemyAttack,!.

updateskillCounter(Num) :-
    retractall(skillCounter(_)),
    asserta(skillCounter(Num)),!.

incSkillCounter :-
    skillCounter(X),
    X1 is X + 1,
    retractall(skillCounter(_)),
    asserta(skillCounter(X1)),!.

skill :-
    \+playing(_),
    write('Its not started yet'),!.

skill :-
    playing(_), 
    \+inBattle(_),
    write('are you really want to waste your skill to a .. wind ?'), nl, !.

skill :-
    playing(_), 
    inBattle(_),
    totalTurn(X),
    updateskillCounter(X),
    skillCounter(Skill),
    enemy(Enemy),
    (Skill < 3 -> write('Youre not fully ready to use skill'),printEnemyStats(Enemy),fight,! ; 
     skill(Dmg), updateTurn,updateHPMonster(Dmg),nl,write('Nice skill boss'),nl, printEnemyStats(Enemy),updateskillCounter(0),enemyAttack,!).

heal :-
    \+playing(_),
    write('Its not started yet'),!.

heal :-
    playing(_), 
    inventory(0, health_potion),
    write('Nothing to consume, stay alive commander!'),nl,fight,!.

heal :-
    playing(_),
    \+inBattle(_), 
    char(Karakter),
    updateTurn,
    healthPlayer(Karakter, Hp),
    healthbase(Karakter, Base),
    Hp =:= Base, retractall(healed(_)),assertz(healed(1)), write('Youre fully healed, nothing to heal'),!.

heal :-
    playing(_),
    inBattle(_), 
    char(Karakter),
    updateTurn,
    healthPlayer(Karakter, Hp),
    healthbase(Karakter, Base),
    Hp =:= Base, retractall(healed(_)),assertz(healed(1)), write('Youre fully healed, nothing to heal'),nl,fight,!.

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
    updateTurn,
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
    asserta(inventory(NewPotion, health_potion)), nl,printPlayerStats(Karakter), nl, enemyAttack,!.
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
    \+attPotionEffect(_),
    totalTurn(Count),
    C is Count + 3,
    asserta(potionCounterAtt(C)),
    inventory(X, attack_potion),
    X > 0, 
    updateTurn,
    decrementInventory(attack_potion),
    asserta(attPotionEffect(1)),
    totalDamage(Dmg), NewDmg is Dmg + 100,
    retractall(totalDamage(_)), asserta(totalDamage(NewDmg)),write('youre stronger than before commander'),nl,enemyAttack,!. %tambahin enemy attack

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
    \+defPotionEffect(_),
    totalTurn(Count),
    C is Count + 3,
    asserta(potionCounterDef(C)),
    inventory(X, defence_potion),
    X > 0, 
    updateTurn,
    decrementInventory(defence_potion),
    asserta(defPotionEffect(1)),
    totalDefense(Def), NewDef is Def + 50,
    retractall(totalDefense(_)), asserta(totalDefense(NewDef)), write('what a good choice, do u feel stronger now ?'),nl,
    enemyAttack,!. %tambahin enemy attack


% Efek damage atau defense kembali normal tanpa potion
backNormal(Potion) :-
    nl,
    write('Youre no longer have potion effect'),
    totalDamage(X),
    totalDefense(Y),
    (Potion = att -> X1 is X - 100, retractall(totalDamage(_)), assertz(totalDamage(X1)), retractall(potionCounterAtt(_)), retractall(attPotionEffect(_)),!;
     Potion = def -> Y1 is Y - 50, retractall(totalDefense(_)), assertz(totalDefense(Y1)),retractall(potionCounterDef(_)), retractall(defPotionEffect(_))),!.

updateHPPlayer(Damage) :-
    char(Karakter),
    healthPlayer(Karakter, Hp),
    TempHpPlayer is Hp - Damage,
    (TempHpPlayer =< 0 -> 
        write('you lose to this ?'), 
        nl, 
        write('you are not strong enough'),resetall,fail; 
        retractall(healthPlayer(Karakter,_)),
        asserta(healthPlayer(Karakter, TempHpPlayer)),!).

updateHPMonster(DamagePlayer) :-
    enemy(Enemy),
    health(Enemy, HpMonster),
    TempHpMonster is HpMonster - DamagePlayer,
    (TempHpMonster > 0 -> 
        retractall(health(Enemy,_)),
        asserta(health(Enemy, TempHpMonster)),!; write('Good job, you just killed '), write(Enemy),nl, enemykilled,nl,fail).

decrementInventory(NamaItem) :-
    inventory(X,NamaItem),
    X1 is X - 1,
    retractall(inventory(_,NamaItem)),
    asserta(inventory(X1, NamaItem)),!.

enemykilled :-
    \+inQuest(_),
    enemy(Enemy),
    char(Karakter),

    % nambah exp dari dungeon ke exp pemain
    dungeonExp(Enemy,ExpTambah),
    expplayer(Karakter,ExpSiPlayer),
    expplayerbase(Karakter, ExpPlayerbase),
    TempExp is ExpSiPlayer + ExpTambah,
    SisaExp is TempExp - ExpPlayerbase,

    %if naik level
    (ExpPlayerbase =< TempExp -> updatelevel(Karakter,SisaExp),nl,write('Congratulations, you just level up'),nl,!;
    %else
    retractall(expplayer(Karakter,_)),
    assertz(expplayer(Karakter,TempExp))),
    restoreHealth(Enemy),

    %if
    levelplayer(Karakter, LevelPlayer),
    level(Enemy, Levelmonster),
    ((LevelPlayer - Levelmonster) mod 2 =:= 0 -> getlevel(Enemy); nl),!,

    printmap,
    %if
    updateruby,
    retractall(inBattle(_)),
    retractall(enemy(_)),
    retractall(totalTurn(_)),
    retractall(totalDamage(_)),
    retractall(totalDefense(_)),
    retractall(attPotionEffect(_)),
    retractall(defPotionEffect(_)),
    retractall(potionCounterAtt(_)),
    retractall(potionCounterDef(_)),
    retractall(skillCounter(_)),!.

enemykilled :-
    enemy(Enemy),
    char(Karakter),

    % nambah exp dari dungeon ke exp pemain
    dungeonExp(Enemy,ExpTambah),
    expplayer(Karakter,ExpSiPlayer),
    expplayerbase(Karakter, ExpPlayerbase),
    TempExp is ExpSiPlayer + ExpTambah,
    SisaExp is TempExp - ExpPlayerbase,

    %if naik level
    (ExpPlayerbase =< TempExp -> updatelevel(Karakter,SisaExp),nl,write('Congratulations, you just level up'),nl,!;
    %else
    retractall(expplayer(Karakter,_)),
    assertz(expplayer(Karakter,TempExp))),
    restoreHealth(Enemy),

    %if
    levelplayer(Karakter, LevelPlayer),
    level(Enemy, Levelmonster),
    ((LevelPlayer - Levelmonster) mod 2 =:= 0 -> getlevel(Enemy); nl),!,

    printmap,
    %if
    updateruby,
    retractall(inBattle(_)),
    retractall(enemy(_)),
    retractall(totalTurn(_)),
    retractall(totalDamage(_)),
    retractall(totalDefense(_)),
    retractall(attPotionEffect(_)),
    retractall(defPotionEffect(_)),
    retractall(potionCounterAtt(_)),
    retractall(potionCounterDef(_)),
    retractall(skillCounter(_)),
    retractall(fightBoss(_)),

    %update progress quest
    write('aaaa'),
    asserta(whatdefeated(Enemy)),
    incdefeated,
    checkquestprogress,
    !.

status :-
    char(Karakter),
    printPlayerStats(Karakter),!.

resetBattle :-
    retractall(inBattle(_)),
    retractall(enemy(_)),
    retractall(totalTurn(_)),
    retractall(totalDamage(_)),
    retractall(totalDefense(_)),
    retractall(attPotionEffect(_)),
    retractall(defPotionEffect(_)),
    retractall(potionCounterAtt(_)),
    retractall(potionCounterDef(_)),
    retractall(skillCounter(_)),
    retractall(healed(_)), 
    retractall(fightBoss(_)),!.