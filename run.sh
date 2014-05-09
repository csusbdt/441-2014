if [ ! -f working/a.out ] 
then 
	clang -o working/a.out `sdl2-config --libs --cflags` -I /usr/local/include -llua -lSDL2_ttf src/*.c
fi

if [ -f working/a.out ] 
then 
	cd working
	./a.out
fi

