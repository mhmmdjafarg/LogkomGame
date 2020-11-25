:- include('battle.pl').
:- include('store.pl').

%cara testing: compile dulu, habis itu "mulai.", "map." buat cetak peta, wasd buat jalan jalan

:- dynamic(lebarpeta/1).
:- dynamic(tinggipeta/1).

:- dynamic(posisipemain/2).

:- dynamic(legenda/1).
:- dynamic(barrier/2).
:- dynamic(star/2).

:- dynamic(posisikunci/2).
:- dynamic(posisishop/2).
:- dynamic(posisiquest/2).

:- dynamic(goblincamp/2).
:- dynamic(slimecamp/2).
:- dynamic(wolfcamp/2).

:- dynamic(underlord/2).
:- dynamic(secretboss/2).

:- dynamic(whichstage/1).

:- discontiguous(resetMap/0).

lebarpeta(18).
tinggipeta(18).

spawnpemain :-
	asserta(posisipemain(1,1)).

mulai :-
	retractall(whichstage(_)),
	spawnpemain,
	asserta(whichstage(1)).

questsdone :-
	retractall(whichstage(_)),
	asserta(whichstage(2)).

secretstage :-
	retractall(whichstage(_)),
	asserta(whichstage(3)).


mapawal :- 
	asserta(posisikunci(14,3)),
	asserta(posisishop(9,1)),
	asserta(posisiquest(9,2)),

	asserta(star(10,17)),
	asserta(star(11,17)),

	asserta(star(7,17)),
	asserta(star(8,17)),

	asserta(barrier(10,1)),
	asserta(barrier(10,2)),
	asserta(barrier(10,3)),
	asserta(barrier(10,4)),

	asserta(barrier(10,5)),
	asserta(barrier(11,5)),
	asserta(barrier(12,5)),
	asserta(barrier(13,5)),
	asserta(barrier(14,5)),
	asserta(barrier(15,5)),
	asserta(barrier(16,5)),
	asserta(barrier(17,5)),

	asserta(barrier(10,8)),
	asserta(barrier(11,8)),
	asserta(barrier(12,8)),
	asserta(barrier(13,8)),
	asserta(barrier(14,8)),
	asserta(barrier(15,8)),
	asserta(barrier(16,8)),
	asserta(barrier(17,8)),

	asserta(barrier(10,11)),
	asserta(barrier(11,11)),
	asserta(barrier(12,11)),
	asserta(barrier(13,11)),
	asserta(barrier(14,11)),
	asserta(barrier(15,11)),
	asserta(barrier(16,11)),
	asserta(barrier(17,11)),

	asserta(barrier(10,14)),
	asserta(barrier(11,14)),
	asserta(barrier(12,14)),
	asserta(barrier(13,14)),
	asserta(barrier(14,14)),
	asserta(barrier(15,14)),
	asserta(barrier(16,14)),
	asserta(barrier(17,14)),

	asserta(goblincamp(15,6)),
	asserta(goblincamp(16,6)),
	asserta(goblincamp(17,6)),
	asserta(goblincamp(15,7)),
	asserta(goblincamp(16,7)),
	asserta(goblincamp(17,7)),

	asserta(slimecamp(15,9)),
	asserta(slimecamp(16,9)),
	asserta(slimecamp(17,9)),
	asserta(slimecamp(15,10)),
	asserta(slimecamp(16,10)),
	asserta(slimecamp(17,10)),

	asserta(wolfcamp(15,12)),
	asserta(wolfcamp(16,12)),
	asserta(wolfcamp(17,12)),
	asserta(wolfcamp(15,13)),
	asserta(wolfcamp(16,13)),
	asserta(wolfcamp(17,13)),

	asserta(underlord(9,17)),
	!.

mapunlock :- 
	asserta(posisikunci(14,3)),
	asserta(posisishop(9,1)),
	asserta(posisiquest(9,2)),

	asserta(barrier(10,1)),
	asserta(barrier(10,2)),
	asserta(barrier(10,3)),
	asserta(barrier(9,3)),

	asserta(barrier(9,5)),
	asserta(barrier(10,5)),
	asserta(barrier(11,5)),
	asserta(barrier(12,5)),
	asserta(barrier(13,5)),
	asserta(barrier(14,5)),
	asserta(barrier(15,5)),
	asserta(barrier(16,5)),
	asserta(barrier(17,5)),

	asserta(star(10,17)),
	asserta(star(11,17)),

	asserta(star(7,17)),
	asserta(star(8,17)),

	asserta(barrier(10,8)),
	asserta(barrier(11,8)),
	asserta(barrier(12,8)),
	asserta(barrier(13,8)),
	asserta(barrier(14,8)),
	asserta(barrier(15,8)),
	asserta(barrier(16,8)),
	asserta(barrier(17,8)),

	asserta(barrier(10,11)),
	asserta(barrier(11,11)),
	asserta(barrier(12,11)),
	asserta(barrier(13,11)),
	asserta(barrier(14,11)),
	asserta(barrier(15,11)),
	asserta(barrier(16,11)),
	asserta(barrier(17,11)),

	asserta(barrier(10,14)),
	asserta(barrier(11,14)),
	asserta(barrier(12,14)),
	asserta(barrier(13,14)),
	asserta(barrier(14,14)),
	asserta(barrier(15,14)),
	asserta(barrier(16,14)),
	asserta(barrier(17,14)),

	asserta(goblincamp(15,6)),
	asserta(goblincamp(16,6)),
	asserta(goblincamp(17,6)),
	asserta(goblincamp(15,7)),
	asserta(goblincamp(16,7)),
	asserta(goblincamp(17,7)),

	asserta(slimecamp(15,9)),
	asserta(slimecamp(16,9)),
	asserta(slimecamp(17,9)),
	asserta(slimecamp(15,10)),
	asserta(slimecamp(16,10)),
	asserta(slimecamp(17,10)),

	asserta(wolfcamp(15,12)),
	asserta(wolfcamp(16,12)),
	asserta(wolfcamp(17,12)),
	asserta(wolfcamp(15,13)),
	asserta(wolfcamp(16,13)),
	asserta(wolfcamp(17,13)),

	asserta(underlord(9,17)),
	!.

mapsecret :- 
	asserta(posisikunci(14,3)),
	asserta(posisishop(9,1)),
	asserta(posisiquest(9,2)),

	asserta(barrier(10,1)),
	asserta(barrier(10,2)),
	asserta(barrier(10,3)),
	asserta(barrier(9,3)),

	asserta(barrier(9,5)),
	asserta(barrier(10,5)),
	asserta(barrier(11,5)),
	asserta(barrier(12,5)),
	asserta(barrier(13,5)),
	asserta(barrier(14,5)),
	asserta(barrier(15,5)),
	asserta(barrier(16,5)),
	asserta(barrier(17,5)),

	asserta(star(10,17)),
	asserta(star(11,17)),

	asserta(star(7,17)),
	asserta(star(8,17)),

	asserta(star(1,10)),
	asserta(star(2,10)),

	asserta(star(1,12)),
	asserta(star(2,12)),

	asserta(secretboss(1,11)),
	asserta(underlord(9,17)),
	!.

%definisi borders
batasatas(_,Y):-
	Y =:= 0,!.
batasbawah(_,Y):-
	tinggipeta(A),
	Y =:= A,!.
bataskiri(X,_):-
	X =:= 0,!.
bataskanan(X,_):-
	lebarpeta(A),
	X =:= A,!.

%mengeprint peta gaes
printchar(X,Y) :-
	posisipemain(X,Y), !, write('P').
printchar(X,Y) :-
	batasatas(X,Y), !, write('#').
printchar(X,Y) :-
	batasbawah(X,Y), !, write('#').
printchar(X,Y) :-
	bataskiri(X,Y), !, write('#').
printchar(X,Y) :-
	bataskanan(X,Y), !, write('#').
printchar(X,Y) :-
	barrier(X,Y), !, write('#').
printchar(X,Y) :-
	star(X,Y), !, write('*').
printchar(X,Y) :-
	posisikunci(X,Y), !, write('K').
printchar(X,Y) :-
	posisishop(X,Y), !, write('S').
printchar(X,Y) :-
	posisiquest(X,Y), !, write('Q').
printchar(X,Y) :-
	goblincamp(X,Y), !, write('G').
printchar(X,Y) :-
	slimecamp(X,Y), !, write('L').
printchar(X,Y) :-
	wolfcamp(X,Y), !, write('W').
printchar(X,Y) :-
	underlord(X,Y), !, write('D').
printchar(X,Y) :-
	secretboss(X,Y), !, write('H').
printchar(_,_) :-
	write('-').

legenda(mapawal) :-
	write('Legends:'),nl,
	write('     K: Key'),nl,
	write('     S: Shop'), nl,
	write('     Q: Quests'),nl,
	write('     G: Goblin camp'),nl,
	write('     S: Slime camp'),nl,
	write('     W: Wolf camp'),nl,
	write('     D: Dungeon'),
	!.

legenda(mapunlock) :-
	write('Legends:'),nl,
	write('     K: Key'),nl,
	write('     S: Shop'), nl,
	write('     Q: Quests'),nl,
	write('     G: Goblin camp'),nl,
	write('     S: Slime camp'),nl,
	write('     W: Wolf camp'),nl,
	write('     D: Dungeon'),
	!.

legenda(mapsecret) :-
	write('Legends:'),nl,
	write('     K: Key'),nl,
	write('     S: Shop'), nl,
	write('     Q: Quests'),nl,
	write('     D: Dungeon'),nl,
	write('     H: Go there and find out for yourself.'),
	!.

map :-
	whichstage(1),
	retractall(barrier(_,_)),
	retractall(slimecamp(_,_)),
	retractall(goblincamp(_,_)),
	retractall(wolfcamp(_,_)),
	retractall(barrier(_,_)),
	mapawal,
	tinggipeta(T),
	lebarpeta(L),
	X is 0,
	Xmax is L,
	Y is 0,
	Ymax is T,
	forall(between(Y,Ymax,J), (
			forall(between(X,Xmax,I), (
					printchar(I,J)
				)),
			nl
		)),
	legenda(mapawal),
	!.

map :-
	whichstage(2),
	retractall(barrier(_,_)),
	retractall(slimecamp(_,_)),
	retractall(goblincamp(_,_)),
	retractall(wolfcamp(_,_)),
	retractall(barrier(_,_)),
	mapunlock,
	tinggipeta(T),
	lebarpeta(L),
	X is 0,
	Xmax is L,
	Y is 0,
	Ymax is T,
	forall(between(Y,Ymax,J), (
			forall(between(X,Xmax,I), (
					printchar(I,J)
				)),
			nl
		)),
	legenda(mapunlock),
	!.

map :-
	whichstage(3),
	retractall(barrier(_,_)),
	retractall(slimecamp(_,_)),
	retractall(goblincamp(_,_)),
	retractall(wolfcamp(_,_)),
	retractall(barrier(_,_)),
	mapsecret,
	printmap,
	legenda(mapsecret),
	!.

printmap :-
	tinggipeta(T),
	lebarpeta(L),
	X is 0,
	Xmax is L,
	Y is 0,
	Ymax is T,
	forall(between(Y,Ymax,J), (
			forall(between(X,Xmax,I), (
					printchar(I,J)
				)),
			nl
		)),
	!.

join_wolf :-
	retract(posisipemain(_,_)),
	wolfcamp(P,Q),
	asserta(posisipemain(P,Q)),muncul,
	write('You have been teleported to Wolf Den'),nl,!.

join_goblin :-
	retract(posisipemain(_,_)),
	goblincamp(P,Q),
	asserta(posisipemain(P,Q)),muncul,
	write('You have been teleported to Goblin Hut'),nl,!.

join_slime :-
	retract(posisipemain(_,_)),
	slimecamp(P,Q),
	asserta(posisipemain(P,Q)),muncul,
	write('You have been teleported to Slime Chamber'),nl,!.

w :-
	posisipemain(X,Y),
	Ynew is Y-1,
	batasatas(X,Ynew),
	write('You ran into a wall.'),
	!.

w :-
	posisipemain(X,Y),
	Ynew is Y-1,
	barrier(X,Ynew),
	write('You ran into a wall.'),
	!.

w :-
	inBattle(_),
	write('You are in a battle!'),nl,
	!.

w :-
	retract(posisipemain(X,Y)),
	Ynew is Y-1,
	asserta(posisipemain(X,Ynew)),
	muncul,
	!.

s :-
	posisipemain(X,Y),
	Ynew is Y+1,
	batasbawah(X,Ynew),
	write('You ran into a wall.'),
	!.

s :-
	posisipemain(X,Y),
	Ynew is Y+1,
	barrier(X,Ynew),
	write('You ran into a wall.'),
	!.

s :-
	inBattle(_),
	write('You are in a battle!'),nl,
	!.

s :-
	retract(posisipemain(X,Y)),
	Ynew is Y+1,
	asserta(posisipemain(X,Ynew)),
	muncul,
	!.

a :-
	posisipemain(X,Y),
	Xnew is X-1,
	bataskiri(Xnew,Y),
	write('You ran into a wall.'),
	!.

a :-
	posisipemain(X,Y),
	Xnew is X-1,
	barrier(Xnew,Y),
	write('You ran into a wall.'),
	!.

a :-
	inBattle(_),
	write('You are in a battle!'),nl,
	!.

a :-
	retract(posisipemain(X,Y)),
	Xnew is X-1,
	asserta(posisipemain(Xnew,Y)),
	muncul,
	!.

d :-
	posisipemain(X,Y),
	Xnew is X+1,
	bataskanan(Xnew,Y),
	write('You ran into a wall.'),
	!.

d :-
	posisipemain(X,Y),
	Xnew is X+1,
	barrier(Xnew,Y),
	write('You ran into a wall.'),
	!.

d :-
	inBattle(_),
	write('You are in a battle!'),nl,
	!.

d :-
	retract(posisipemain(X,Y)),
	Xnew is X+1,
	asserta(posisipemain(Xnew,Y)),
	muncul,
	!.

muncul :-
	posisipemain(X,Y),
	posisishop(X,Y),
	printmap,
	rubyplayer(Class, Money),
	shop(Money,Class),
	!.

muncul :-
	repeat,
		random(1,8, X),
		(X =:= 4 -> decide; lain),!.

lain :-
	printmap,!.


resetMap :-
    retractall(lebarpeta(_)),
    retractall(tinggipeta(_)),
    retractall(posisipemain(_,_)),
    retractall(legenda(_)),
    retractall(barrier(_,_)),
    retractall(star(_,_)),
    retractall(posisikunci(_,_)),
    retractall(posisishop(_,_)),
    retractall(posisiquest(_,_)),
    retractall(goblincamp(_,_)),
    retractall(slimecamp(_,_)),
    retractall(wolfcamp(_)),
    retractall(underlord(_,_)),
    retractall(secretboss(_,_)),
    retractall(whichstage(_)).