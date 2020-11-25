:- dynamic(equipment/3). % berisi Id,nama, value

:- discontiguous(initEquipment/0).
:- discontiguous(useWeapon/1).
:- discontiguous(useArmor/1).
:- discontiguous(resetEquipment/0).

initEquipment :-
    char(Karakter),
    (Karakter == swordsman -> FirstWeapon = common_sword; Karakter == archer -> FirstWeapon = common_bow; Karakter == ninja -> FirstWeapon = shuriken),
    damageweapon(FirstWeapon, Val),
    assertz(equipment(weapon,FirstWeapon, Val)),
    (Karakter == swordsman -> FirstArmor = common_armor; Karakter == archer -> FirstArmor = common_armor; Karakter == ninja -> FirstArmor = common_armor),
    kerasarmor(FirstArmor, ValArmor),
    assertz(equipment(armor,FirstArmor, ValArmor)),!.

% cek untuk weapon
useWeapon(NamaEquipment) :-
    inventory(X, NamaEquipment),
    X > 0,
    char(Karakter),
    typeweapon(Karakter, NamaEquipment),
    equipment(weapon,UsedEquipment, _ ),
    inventory(Y, UsedEquipment),
    Y1 is Y + 1,
    retractall(inventory(_,UsedEquipment)),
    assertz(inventory(Y1, UsedEquipment)),
    X1 is X - 1,
    retractall(inventory(_,NamaEquipment)),
    assertz(inventory(X1,NamaEquipment)),
    retractall(equipment(weapon, _, _)),
    damageweapon(NamaEquipment, Val),
    assertz(equipment(weapon, NamaEquipment, Val)),
    printPlayerStats(Karakter),nl,write('Ready to fight boss?'),!.


% cek untuk weapon
useWeapon(NamaEquipment) :-
    inventory(_, NamaEquipment),
    char(Karakter),
    \+typeweapon(Karakter, NamaEquipment),
    write('Pick what you can pick master !'), nl,!.

useArmor(NamaEquipment) :-
    typearmor(NamaEquipment),
    inventory(X, NamaEquipment),
    X > 0,
    equipment(armor,UsedEquipment, _ ),
    inventory(Y, UsedEquipment),
    Y1 is Y + 1,
    retractall(inventory(_,UsedEquipment)),
    assertz(inventory(Y1, UsedEquipment)),
    X1 is X - 1,
    retractall(inventory(_,NamaEquipment)),
    assertz(inventory(X1,NamaEquipment)),
    retractall(equipment(armor, _, _)),
    kerasarmor(NamaEquipment, ValArmor),
    assertz(equipment(armor, NamaEquipment, ValArmor)),
    char(Player), printPlayerStats(Player), nl, write('it looks nice on you'),!.

useArmor(NamaEquipment) :-
    inventory(_, NamaEquipment),
    \+typearmor(NamaEquipment), write('pick what you can pick please '), nl,!.

% cek untuk weapon dipastikan pemain tidak akan mendapat senjata yang tidak sesuai char
useWeapon(NamaEquipment) :-
    inventory(X, NamaEquipment),
    X =:= 0, nl,
    write('You dont have that item comrads'), !.

useArmor(NamaEquipment) :-
    inventory(X, NamaEquipment),
    X =:= 0, nl,
    write('You dont have that item comrads'), !.

resetEquipment :-
    retractall(equipment(_,_,_)).