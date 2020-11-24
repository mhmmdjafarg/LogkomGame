:- dynamic(equipment/3). % berisi Id,nama, value
% Id => armor / weapon

:- discontiguous(initEquipment/0).
:- discontiguous(useEquipment/1).

initEquipment :-
    char(Karakter),
    (Karakter =:= swordsman -> FirstWeapon is common_sword; Karakter =:= archer -> FirstWeapon is common_bow; Karakter =:= ninja -> FirstWeapon is shuriken),
    damageweapon(FirstWeapon, Val),

    assertz(equipment(weapon,FirstWeapon, Val)),!.

    (Karakter =:= swordsman -> FirstArmor is common_armor; Karakter =:= archer -> FirstArmor is common_armor; Karakter =:= ninja -> FirstArmor is common_armor),
    kerasarmor(FirstArmor, ValArmor),
    assertz(equipment(armor,FirstArmor, ValArmor)),!.

% cek untuk weapon
useEquipment(NamaEquipment) :-
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
    assertz(equipment(weapon, NamaEquipment, Val)),!.; 
    %else if
    inventory(X, NamaEquipment),
    X > 0,
    char(Karakter),
    typearmor(Karakter, NamaEquipment),
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
    assertz(equipment(armor, NamaEquipment, ValArmor)),!.
    
% cek untuk weapon
useEquipment(NamaEquipment) :-
    inventory(X, NamaEquipment),
    X =:= 0,
    write('You dont have that item comrads'), !.
