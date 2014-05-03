#include "global.h"

#define SDL_INIT_FLAGS (SDL_INIT_TIMER | SDL_INIT_AUDIO | SDL_INIT_VIDEO | SDL_INIT_EVENTS)
#define DESIRED_MILLIS_PER_FRAME (1000 / 60)

bool process_event_queue(lua_State * L);

bool running = true;
SDL_Renderer * renderer;

static lua_State  * L;
static SDL_Window * window;

void register_util_functions(lua_State * L);
void register_texture_functions(lua_State * L);

static void shutdown() {
	SDL_DestroyRenderer(renderer);
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
	if (!window) {
		fatal(SDL_GetError());
	}

	renderer = SDL_CreateRenderer(
		window,
		-1,
		SDL_RENDERER_ACCELERATED | SDL_RENDERER_PRESENTVSYNC);
	if (!renderer) fatal(SDL_GetError());
    
	//if (SDL_RenderSetLogicalSize(renderer, APP_WIDTH, APP_HEIGHT))
	//	fatal(SDL_GetError());

	register_util_functions(L);
	register_texture_functions(L);

	if (luaL_dofile(L, "main.lua") != 0) {
		fatal(luaL_checkstring(L, -1));

	}
}

static void draw() {
	lua_getglobal(L, "on_draw");
	assert(lua_gettop(L) == 1);
        if (lua_isnil(L, -1)) {
		lua_pop(L, 1);
		assert(lua_gettop(L) == 0);
		return;
	}
        if (lua_pcall(L, 0, 0, 0)) {
		fatal(lua_tostring(L, -1));
	}
}

void loop() {
	SDL_SetRenderDrawColor(renderer, 0, 0, 0, 255);
	SDL_RenderClear(renderer);
	while (running) {
		Uint32 start_time = SDL_GetTicks();
		SDL_RenderPresent(renderer);
		SDL_SetRenderDrawColor(renderer, 0, 0, 0, 255);
		SDL_RenderClear(renderer);
		if (!process_event_queue(L)) break;
		draw();
		Uint32 elapsed_time = SDL_GetTicks() - start_time;
		if (elapsed_time < DESIRED_MILLIS_PER_FRAME) {
			SDL_Delay(DESIRED_MILLIS_PER_FRAME - elapsed_time);
		} else {
			SDL_Delay(1);
		}
	}
}

int main(int argc, char * argv[]) {
	init(); 
	loop();
	shutdown();
	return 0;
}

