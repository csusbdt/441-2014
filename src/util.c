#include "global.h"

static int quit(lua_State * L) {
//	quit_loop();
	return 0;
}

static int msgbox(lua_State * L) {
	const char * msg = luaL_checkstring(L, 1);
	SDL_ShowSimpleMessageBox(SDL_MESSAGEBOX_INFORMATION, APP_TITLE, msg, NULL); 
	return 0;
}

void register_util_functions(lua_State * L) {
	lua_register(L, "quit"      , quit      );
	lua_register(L, "msgbox"    , msgbox    );
}

