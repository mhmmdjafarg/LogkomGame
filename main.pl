:- include('map.pl').
:- include('equipment.pl').

:- dynamic(char/1). % gajadi dihapus
:- dynamic(playing/1). % untuk status sedang bermain atau tidak

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

pickClass :-
    write('Pick your class:'),nl,
    write('-  swordsman'),nl,
    write('-  archer'),nl,
    write('-  ninja'),nl,
    read(Karaker),
    asserta(char(Karaker)),
    !.

resetall :-
    resetplayer.
    resetdungeon.
    resetEquipment.
    resetMap.
.



