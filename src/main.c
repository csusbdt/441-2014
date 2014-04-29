#include "global.h"

#define SDL_INIT_FLAGS (SDL_INIT_TIMER | SDL_INIT_AUDIO | SDL_INIT_VIDEO | SDL_INIT_EVENTS)

bool process_event_queue(lua_State * L);

static lua_State  * L;
static SDL_Window * window;
bool running = true;

void register_util_functions(lua_State * L);

static void quit() {
	SDL_DestroyWindow(window);
	SDL_Quit();
	lua_close(L);
}

static void init() {
	L = luaL_newstate();
	if (L == NULL) {
		fatal("Can not create Lua state.");
	}

	luaL_openlibs(L);

	if (SDL_Init(SDL_INIT_FLAGS) != 0) {
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

	SDL_Renderer * renderer = SDL_CreateRenderer(
		window,
		-1,
		SDL_RENDERER_ACCELERATED | SDL_RENDERER_PRESENTVSYNC);
	if (!renderer) fatal(SDL_GetError());
    
	if (SDL_RenderSetLogicalSize(renderer, APP_WIDTH, APP_HEIGHT))
		fatal(SDL_GetError());

	register_util_functions(L);

	SDL_SetRenderDrawColor(renderer, 0, 0, 0, 255);
	SDL_RenderClear(renderer);
	//SDL_SetRenderDrawColor(renderer, 255, 0, 0, 255);
	//SDL_Rect rect = { 0, 0, APP_WIDTH, APP_HEIGHT };
	//SDL_RenderFillRect(renderer, &rect);
	SDL_RenderPresent(renderer);
}

void loop() {
	while (running) {
		if (!process_event_queue(L)) break;
		// do ai
		// render
	}
}

int main(int argc, char * argv[]) {
	init(); 
	loop();
	quit();
	return 0;
}

