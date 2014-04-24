#include "global.h"

bool process_event_queue(lua_State * L);

static lua_State  * L;
static SDL_Window * window;

void quit();

void init() {
	L = luaL_newstate();
	if (L == NULL) {
		fatal("Can not create Lua state.");
	}

	luaL_openlibs(L);

	if (SDL_Init(SDL_INIT_EVERYTHING) != 0) {
		fatal(SDL_GetError());
	}

	window = SDL_CreateWindow(
		APP_TITLE, 
		SDL_WINDOWPOS_CENTERED,
		SDL_WINDOWPOS_CENTERED,
		APP_WIDTH,
		APP_HEIGHT,
		0);
	if (window == NULL) {
		fatal(SDL_GetError());
	}

	if (luaL_dofile(L, "main.lua") != 0) {
		fatal(luaL_checkstring(L, -1));

	}

	while (process_event_queue(L)) {
		// do ai
		// render
	}
}

void loop() {

}

void quit() {
	SDL_DestroyWindow(window);
	SDL_Quit();
	lua_close(L);
}

int main(int argc, char * argv[]) {
	init(); 
	loop();
	quit();
}

