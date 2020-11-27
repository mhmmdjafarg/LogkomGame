% Author :
%     Randy Zakya Suchrady		13519061
%     Muhammad Fahmi Alamsyah	13519077
%     Ryandito Diandaru			13519157
%     Muhammad Jafar Gundari	13519197

% Date Created : November 27th 2020

:- include('map.pl').
:- include('equipment.pl').

:- dynamic(char/1). % gajadi dihapus
:- dynamic(playing/1). % untuk status sedang bermain atau tidak

:- discontiguous(verifikasi_char/1).
start :-
    playing(_),
    write('The game has already started!'),nl.

start :-
    asserta(playing(1)),
    write('______                _       _          ___      _                 _'),nl,                  
    write('| ___ \\              | |     ( )        / _ \\    | |               | |'),nl,                 
    write('| |_/ /__ _ _ __   __| |_   _|/ ___    / /_\\ \\ __| |_   _____ _ __ | |_ _   _ _ __ ___'),nl, 
    write('|    // _  |  _ \\ / _  | | | | / __|   |  _  |/ _  \\ \\ / / _ \\  _ \\| __| | | |  __/ _ \\'),nl,
    write('| |\\ \\ (_| | | | | (_| | |_| | \\__ \\   | | | | (_| |\\ V /  __/ | | | |_| |_| | | |  __/'),nl,
    write('\\_| \\_\\__,_|_| |_|\\__,_|\\__, | |___/   \\_| |_/\\__,_| \\_/ \\___|_| |_|\\__|\\__,_|_|  \\___|'),nl,
    write('                         __/ |'),nl,                                                         
    write('                        |___/'),nl,nl,
    spawnDungeon,
    charplayer,
    writelore,
    pickClass,
    initEquipment,
    mulai,
    map,!.

writelore :-
	write('Anda adalah seorang pengembara yang berasal dari kota bawah tanah, Dangarnon, yang dikhianati oleh rekan pengembara anda.'),nl,
	write('Rekan pengembara anda pergi meninggalkan anda, pulang sendirian sambil membawa kunci untuk kembali ke Dangarnon. Anda'),nl,
	write('ditinggalkan sendirian di dunia atas, permukaan bumi. Saat anda terbangun, anda disambut oleh baiknya warga bumi.'),nl,
	write('Anda memilih untuk membalas kebaikan mereka terlebih dahulu sebelum berusaha untuk kembali ke Dangarnon, anda membantu'),nl,
	write('melawan parasit-parasit yang meresahkan warga. Anda harus memperkuat diri karena pintu gerbang ke Dangarnon diawasi oleh'),nl,
	write('teman pengembara anda yang tidak ingin anda kembali ke Dangarnon, yang rekan pengembara anda tidak ketahui adalah penghuni'),nl,
	write('dunia atas juga memiliki kunci untuk pergi ke dunia bawah tanah, bisakah anda kembali ke Dangarnon? dan bisakah anda mencari'),nl,
	write('tahu bagaimana penghuni dunia atas bisa memiliki kunci ke Dangarnon?'),nl,nl.

help :-
    write('~~~~~~~~~~~~~Randy"s Adventure~~~~~~~~~~~~~~'), nl,
    write('| Available commands:                        |'), nl,
    write('| 1. start.       : start the game!          |'), nl,
    write('| 2. map.         : look at the map          |'), nl,
    write('| 3. status.      : show your status         |'), nl,
    write('| 4. join_<enemy> : portal to enemy camp     |'), nl,
    write('| 5. w            : move north               |'), nl,
    write('| 6. a            : move west                |'), nl,
    write('| 7. s            : move south               |'), nl,
    write('| 8. d            : move east                |'), nl,
    write('| 9. inventory.   : show available commands  |'), nl,
    write('| 10.useWeapon(X).: use weapon available     |'), nl,
    write('| 11. useArmor(X).: use armor available      |'), nl,
    write('| 12. help.       : show available commands  |'), nl,
    write('| 13. quit.       : quit the game            |'), nl,
    write('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'), nl.

inventory :-
	openinventory.

verifikasi_char(Karaker):-
    Karaker = 'ninja',
    asserta(char(Karaker)),!.

verifikasi_char(Karaker):-
    Karaker = 'swordsman',
    asserta(char(Karaker)),!.

verifikasi_char(Karaker):-
    Karaker = 'archer',
    asserta(char(Karaker)),!.


pickClass :-
    write('Pick your class:'),nl,
    write('-  swordsman'),nl,
    write('-  archer'),nl,
    write('-  ninja'),nl,
    read(Karaker),
    verifikasi_char(Karaker),
    !.

verifikasi_char(_):-
    write('Please choose the 3 classes above!'),
    pickClass,nl,!.

goHome :-
    char(Karakter),
    (Karakter == swordsman -> printplayer; Karakter == archer -> printarcher; Karakter == ninja -> printninja),
    write('Thank you for playing this game !'),nl,
    write('Type yes.'),nl,
    read(_),
    quit.

quit:- 
	halt,!.

resetmain :-
    retractall(char(_)),
    retractall(playing(_)).

resetall :-
    resetplayer,
    resetdungeon,
    resetEquipment,
    resetMap,
    resetBattle,resetmain,!.

loreSecretBoss :-
    printsecretboss,nl,nl,
    write('It turns out that what you just fought was the friend who betrayed you, he was just trying to save you... '), nl,nl,
    write('He knew that Dangarnon is not a safe place and that he only want the best for you.'),nl,
    write('How the villagers have the key to Dangarnon is because he also tried to save someone just like you in the past, but he failed and the key got left behind.'),nl, 
    write('He swore to not lose another good friend.'),
    nl,
    write('And now that you have proven yourself to be strong enough to go by yourself, to even right the wrongs of Dangarnon, he finally lets you go and peacefully rest.'),nl,
    nl,nl, write('\"Godspeed, friend.\", he said.'),nl,!.

loreBoss :-
    printgohome,nl,
    nl,
    write('Citizens of dangarnon shed tears of joy as you slay the monster.'), nl,nl,
    write('Congratulations traveller! you\'ve made Dangarnon a better place, just like what everyone expected of you.'),nl,nl,
    write('You go on living in Dangarnon as the mayor and you pay a visit to the village every now and then.'),nl,
    nl, write('Fin.'),nl,nl,
    write('You can goHome now . . . .'),!.