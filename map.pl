:- dynamic(lebarpeta/1).
:- dynamic(tinggipeta/1).
:- dynamic(peta/1).
:- dynamic(legenda/1).
:- dynamic(barrier/2).
:- dynamic(gate/2).
:- dynamic(star/2).
:- dynamic(kunci/2).
:- dynamic(shop/2).
:- dynamic(quest/2).
:- dynamic(goblincamp/2).
:- dynamic(slimecamp/2).
:- dynamic(wolfcamp/2).
:- dynamic(underlord/2).
:- dynamic(secretboss/2).

lebarpeta(18).
tinggipeta(18).

mulai :- 
	asserta(kunci(14,3)),
	asserta(shop(9,1)),
	asserta(quest(9,2)),

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

misidone :- 
	asserta(kunci(14,3)),
	asserta(shop(9,1)),
	asserta(quest(9,2)),

	asserta(gate(10,1)),
	asserta(gate(10,2)),
	asserta(gate(10,3)),
	asserta(gate(9,3)),

	asserta(gate(9,5)),
	asserta(gate(10,5)),
	asserta(gate(11,5)),
	asserta(gate(12,5)),
	asserta(gate(13,5)),
	asserta(gate(14,5)),
	asserta(gate(15,5)),
	asserta(gate(16,5)),
	asserta(gate(17,5)),

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

secretmap :- 
	asserta(kunci(14,3)),
	asserta(shop(9,1)),
	asserta(quest(9,2)),

	asserta(gate(10,1)),
	asserta(gate(10,2)),
	asserta(gate(10,3)),
	asserta(gate(9,3)),

	asserta(gate(9,5)),
	asserta(gate(10,5)),
	asserta(gate(11,5)),
	asserta(gate(12,5)),
	asserta(gate(13,5)),
	asserta(gate(14,5)),
	asserta(gate(15,5)),
	asserta(gate(16,5)),
	asserta(gate(17,5)),

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
printpeta(X,Y) :-
	batasatas(X,Y), !, write('#').
printpeta(X,Y) :-
	batasbawah(X,Y), !, write('#').
printpeta(X,Y) :-
	bataskiri(X,Y), !, write('#').
printpeta(X,Y) :-
	bataskanan(X,Y), !, write('#').
printpeta(X,Y) :-
	barrier(X,Y), !, write('#').
printpeta(X,Y) :-
	gate(X,Y), !, write('/').
printpeta(X,Y) :-
	star(X,Y), !, write('*').
printpeta(X,Y) :-
	kunci(X,Y), !, write('K').
printpeta(X,Y) :-
	shop(X,Y), !, write('S').
printpeta(X,Y) :-
	quest(X,Y), !, write('Q').
printpeta(X,Y) :-
	goblincamp(X,Y), !, write('G').
printpeta(X,Y) :-
	slimecamp(X,Y), !, write('L').
printpeta(X,Y) :-
	wolfcamp(X,Y), !, write('W').
printpeta(X,Y) :-
	underlord(X,Y), !, write('D').
printpeta(X,Y) :-
	secretboss(X,Y), !, write('H').
printpeta(_,_) :-
	write('-').

legenda(mulai) :-
	write('Legends:'),nl,
	write('     K: Key'),nl,
	write('     S: Shop'), nl,
	write('     Q: Quests'),nl,
	write('     G: Goblin camp'),nl,
	write('     S: Slime camp'),nl,
	write('     W: Wolf camp'),nl,
	write('     D: Dungeon'),
	!.

legenda(misidone) :-
	write('Legends:'),nl,
	write('     K: Key'),nl,
	write('     S: Shop'), nl,
	write('     Q: Quests'),nl,
	write('     G: Goblin camp'),nl,
	write('     S: Slime camp'),nl,
	write('     W: Wolf camp'),nl,
	write('     D: Dungeon'),
	!.

legenda(secretmap) :-
	write('Legends:'),nl,
	write('     K: Key'),nl,
	write('     S: Shop'), nl,
	write('     Q: Quests'),nl,
	write('     D: Dungeon'),nl,
	write('     H: Go there and find out for yourself.'),
	!.

peta(Apa) :-
	retractall(gate(_,_)),
	retractall(slimecamp(_,_)),
	retractall(goblincamp(_,_)),
	retractall(wolfcamp(_,_)),
	retractall(barrier(_,_)),
	Apa,
	tinggipeta(T),
	lebarpeta(L),
	X is 0,
	Xmax is L,
	Y is 0,
	Ymax is T,
	forall(between(Y,Ymax,J), (
			forall(between(X,Xmax,I), (
					printpeta(I,J)
				)),
			nl
		)),
	legenda(Apa),
	!.



	











