#include "global.h"

#define SDL_INIT_FLAGS (SDL_INIT_TIMER | SDL_INIT_AUDIO | SDL_INIT_VIDEO | SDL_INIT_EVENTS)

bool process_event_queue(lua_State * L);

static lua_State  * L;
static SDL_Window * window;
static SDL_Renderer * renderer;
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

	renderer = SDL_CreateRenderer(
		window,
		-1,
		SDL_RENDERER_ACCELERATED | SDL_RENDERER_PRESENTVSYNC);
	if (!renderer) fatal(SDL_GetError());
    
	//if (SDL_RenderSetLogicalSize(renderer, APP_WIDTH, APP_HEIGHT))
	//	fatal(SDL_GetError());

	register_util_functions(L);
}

static void draw() {
	lua_getglobal(L, "on_draw");
        if (lua_isnil(L, -1)) {
		lua_pop(L, 1);
		return;
	}
        if (lua_pcall(L, 0, 0, 0)) error(lua_tostring(L, -1));	
}

void loop() {
	SDL_SetRenderDrawColor(renderer, 0, 0, 0, 255);
	SDL_RenderClear(renderer);

	while (running) {
		SDL_RenderPresent(renderer);
		SDL_SetRenderDrawColor(renderer, 0, 0, 0, 255);
		SDL_RenderClear(renderer);

		SDL_SetRenderDrawColor(renderer, 255, 0, 0, 255);
		SDL_Rect rect = { 10, 10, APP_WIDTH - 20, APP_HEIGHT - 20 };
		SDL_RenderFillRect(renderer, &rect);

		if (!process_event_queue(L)) break;

		draw();
	}
}

int main(int argc, char * argv[]) {
	init(); 
	loop();
	quit();
	return 0;
}

