:- include('battle.pl').

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

quest :-
	\+inQuest(_),
	ambilQuestSatu,!.

quest :-
	\+inQuest(_),
	quest1done(1),
	ambilQuestDua,!.

quest :-
	\+inQuest(_),
	quest1done(1),
	quest2done(1),
	ambilQuestTiga,!.

quest :-
	inQuest(_),
	write('You are currently in a quest'),!.

ambilQuestSatu :-
	asserta(inQuest(1)),
	write('Quest no. 1: Returning the Favor'), nl,
	write('The villagers are in trouble!, you decided to help them'), nl,
	write('as a way to say thank you for their hospitality'), nl, nl,
	write('Defeat 1 slime, 1 goblin, and 1 wolf'),nl,
	retract(needkillSlime(_)),
	retract(needkillGoblin(_)),
	retract(needkillWolf(_)),
	asserta(needkillSlime(1)),
	asserta(needkillGoblin(1)),
	asserta(needkillWolf(1)),
	!.

ambilQuestDua :-
	asserta(inQuest(2)),
	write('Quest no. 2: Gaining Trust'), nl,
	write('You are getting fond of the villagers and their ways and they are starting to accept you,'), nl,
	write('defeating monsters is basically what you do for the village'), nl, nl,
	write('Defeat 2 slime, 2 goblin, and 2 wolf'),nl,
	retract(needkillSlime(_)),
	retract(needkillGoblin(_)),
	retract(needkillWolf(_)),
	asserta(needkillSlime(2)),
	asserta(needkillGoblin(2)),
	asserta(needkillWolf(2)),
	!.

ambilQuestTiga :-
	asserta(inQuest(3)),
	write('Quest no. 3: Going Home'), nl,
	write('The villagers are happy to have you as family, but you know deep down you'), nl,
	write('dont belong in the Above World. As much as you want to stay there, you know '), nl,
	write('you have to return to Dangarnon. '), nl, nl,
	write('Defeat 3 slime, 3 goblin, and 3 wolf'),nl,nl,
	write('And a path to the key to Dangarnon will open.'),nl,
	retract(needkillSlime(_)),
	retract(needkillGoblin(_)),
	retract(needkillWolf(_)),
	asserta(needkillSlime(3)),
	asserta(needkillGoblin(3)),
	asserta(needkillWolf(3)),
	!.

quest1doneMessage :-
	write('Welldone traveller, you\'ve finished your quest, but the villagers might'),nl,
	write('still need your help. Get back to the Q area to get your next quest'),nl,
	retractall(inQuest(_)),
	asserta(quest1done(1)),
	!.

quest2doneMessage :-
	write('Welldone traveller, you\'ve finished your quest, but the villagers might'),nl,
	write('still need your help. Get back to the Q area to get your next quest'),nl,
	retractall(inQuest(_)),
	asserta(quest2done(1)),
	!.

secretquest :-
	write('You\'ve been very helpful to the villagers, now it\'s time to go home.'),nl,
	write('You have all the right to go, but still...'),nl,nl,
	write('Something doesn\'t sit right in the back of your mind.'),nl,
	retractall(inQuest(_)),
	asserta(quest3done(1)),
	!.









