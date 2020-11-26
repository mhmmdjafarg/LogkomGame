:- dynamic(inQuest/1).
:- dynamic(quest1done/1).
:- dynamic(quest2done/1).
:- dynamic(quest3done/1).
:- dynamic(goblindefeated/1).
:- dynamic(slimedefeated/1).
:- dynamic(wolfdefeated/1).
:- dynamic(needkillSlime/1).
:- dynamic(needkillGoblin/1).
:- dynamic(needkillWolf/1).
:- dynamic(onsecret/1).
:- dynamic(whatdefeated/1).

quest :-
	\+inQuest(_),
	\+quest1done(1),
	!,ambilQuestSatu.

quest :-
	\+inQuest(_),
	\+quest2done(1),
	quest1done(1),
	!,ambilQuestDua.

quest :-
	\+inQuest(_),
	\+quest3done(1),
	quest1done(1),
	quest2done(1),
	!,ambilQuestTiga.

quest :-
	\+inQuest(_),
	quest1done(1),
	quest2done(1),
	quest3done(1),
	write('go home.'),nl,!.

quest :-
	inQuest(_),
	write('Finish your current quest first!'),!.

ambilQuestSatu :-
	asserta(inQuest(1)),
	write('             Quest no. 1: Returning the Favor'), nl,nl,
	write('The villagers are in trouble!, you decided to help them'), nl,
	write('as a way to say thank you for their hospitality'), nl, nl,
	write('           Defeat 1 slime, 1 goblin, and 1 wolf'),nl,
	asserta(goblindefeated(0)),
	asserta(slimedefeated(0)),
	asserta(wolfdefeated(0)),
	asserta(needkillSlime(1)),
	asserta(needkillGoblin(1)),
	asserta(needkillWolf(1)),
	!.

ambilQuestDua :-
	asserta(inQuest(2)),
	write('             Quest no. 2: Gaining Trust'), nl,nl,
	write('You are getting fond of the villagers and their ways and they are starting to accept you,'), nl,
	write('defeating monsters is basically what you do for the village'), nl, nl,
	write('           Defeat 2 slime, 2 goblin, and 2 wolf'),nl,
	retractall(needkillSlime(_)),
	retractall(needkillGoblin(_)),
	retractall(needkillWolf(_)),
	asserta(goblindefeated(0)),
	asserta(slimedefeated(0)),
	asserta(wolfdefeated(0)),
	asserta(needkillSlime(2)),
	asserta(needkillGoblin(2)),
	asserta(needkillWolf(2)),
	!.

ambilQuestTiga :-
	asserta(inQuest(3)),
	write('             Quest no. 3: Going Home'), nl,nl,
	write('The villagers are happy to have you as family, but you know deep down you'), nl,
	write('dont belong in the Above World. As much as you want to stay there, you know '), nl,
	write('you have to return to Dangarnon. '), nl, nl,
	write('           Defeat 3 slime, 3 goblin, and 3 wolf'),nl,nl,
	write('And a path to the key to Dangarnon will open.'),nl,
	retractall(needkillSlime(_)),
	retractall(needkillGoblin(_)),
	retractall(needkillWolf(_)),
	asserta(goblindefeated(0)),
	asserta(slimedefeated(0)),
	asserta(wolfdefeated(0)),
	asserta(needkillSlime(3)),
	asserta(needkillGoblin(3)),
	asserta(needkillWolf(3)),
	!.

done1 :-
	write('Welldone traveller, you\'ve finished your quest, but the villagers might'),nl,
	write('still need your help. Get back to the Q area to get your next quest'),nl,
	retractall(inQuest(_)),
	asserta(quest1done(1)),
	retractall(slimedefeated(_)),
	retractall(goblindefeated(_)),
	retractall(wolfdefeated(_)),
	!.

done2 :-
	write('Welldone traveller, you\'ve finished your guest, but the villagers might'),nl,
	write('still need your help. Get back to the Q area to get your next quest'),nl,
	retractall(inQuest(_)),
	asserta(quest2done(1)),
	retractall(slimedefeated(_)),
	retractall(goblindefeated(_)),
	retractall(wolfdefeated(_)),
	!.

done3 :-
	write('Welldone traveller, you\'ve finished all your quests!'),nl,
	write('The villagers are more than glad to have you as quest, but now it\'s time to go home.'),nl,
	write('You have all the right to go, but still...'),nl,nl,
	write('Something doesn\'t sit right in the back of your mind.'),nl,
	retractall(inQuest(_)),
	asserta(quest3done(1)),
	retractall(slimedefeated(_)),
	retractall(goblindefeated(_)),
	retractall(wolfdefeated(_)),
	retractall(whichstage(_)),
	asserta(whichstage(2)),
	retractall(needkillSlime(_)),
	retractall(needkillGoblin(_)),
	retractall(needkillWolf(_)),
	asserta(goblindefeated(0)),
	asserta(slimedefeated(0)),
	asserta(wolfdefeated(0)),
	asserta(needkillSlime(3)),
	asserta(needkillGoblin(3)),
	asserta(needkillWolf(3)),
	asserta(onsecret(1)),
	!.

checkquestprogress :-
	inQuest(1),
	\+quest1done(1),
	slimedefeated(X1),
	needkillSlime(Y1),
	goblindefeated(X2),
	needkillGoblin(Y2),
	wolfdefeated(X3),
	needkillWolf(Y3),
	X1 >= Y1, X2 >= Y2, X3 >= Y3,
	done1,!.

checkquestprogress :-
	inQuest(2),
	\+quest2done(1),
	quest1done(1),
	slimedefeated(X1),
	needkillSlime(Y1),
	goblindefeated(X2),
	needkillGoblin(Y2),
	wolfdefeated(X3),
	needkillWolf(Y3),
	X1 >= Y1, X2 >= Y2, X3 >= Y3,
	done2,!.

checkquestprogress :-
	inQuest(3),
	\+quest3done(1),
	quest1done(1),
	quest2done(1),
	slimedefeated(X1),
	needkillSlime(Y1),
	goblindefeated(X2),
	needkillGoblin(Y2),
	wolfdefeated(X3),
	needkillWolf(Y3),
	X1 >= Y1, X2 >= Y2, X3 >= Y3,
	done3,!.

checkquestprogress :-
	inQuest(_),
	write('Well done!, you\'re one step closer to finishing your quest!'),nl,!.

checkquestprogress :-
	onsecret(1),
	slimedefeated(X1),
	needkillSlime(Y1),
	goblindefeated(X2),
	needkillGoblin(Y2),
	wolfdefeated(X3),
	needkillWolf(Y3),
	X1 >= Y1, X2 >= Y2, X3 >= Y3,
	retractall(whichstage(_)),
	asserta(whichstage(3)),
	write('           why are you still here?'),nl,
	map,!.

checkquestprogress :-
	write(''),!.

incdefeated :-
	whatdefeated(1),
	slimedefeated(X),
	Xinc is X+1,
	retractall(slimedefeated(_)),
	asserta(slimedefeated(Xinc)),
	retractall(whatdefeated(_)),
	!.

incdefeated :-
	whatdefeated(2),
	goblindefeated(X),
	Xinc is X+1,
	retractall(goblindefeated(_)),
	asserta(goblindefeated(Xinc)),
	retractall(whatdefeated(_)),
	!.

incdefeated :-
	whatdefeated(3),
	wolfdefeated(X),
	Xinc is X+1,
	retractall(wolfdefeated(_)),
	asserta(wolfdefeated(Xinc)),
	retractall(whatdefeated(_)),
	!.










