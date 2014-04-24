#include "global.h"

bool process_event_queue(lua_State * L);

int main(int argc, char * argv[]) {
	lua_State * L = luaL_newstate();
	if (L == NULL) {
		fatal("Can not create Lua state.");
	}

	luaL_openlibs(L);

	if (luaL_dofile(L, "main.lua") != 0) {
		fatal(luaL_checkstring(L, -1));

	}

	while (process_event_queue(L)) {
		// do ai
		// render
	}

	puts("i live.");
}

