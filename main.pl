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
    write('| 4. w            : move north               |'), nl,
    write('| 5. a            : move west                |'), nl,
    write('| 6. s            : move south               |'), nl,
    write('| 7. d            : move east                |'), nl,
    write('| 8. inventory.   : show available commands  |'), nl,
    write('| 9. useWeapon(X).: use weapon available     |'), nl,
    write('| 10. useArmor(X).: use armor available      |'), nl,
    write('| 11. help.       : show available commands  |'), nl,
    write('| 12. quit.       : quit the game            |'), nl,
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



