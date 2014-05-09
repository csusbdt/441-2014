#include "global.h"

extern bool running;

static int quit(lua_State * L) {
	running = false;
	return 0;
}

static int msgbox(lua_State * L) {
	const char * msg;
	
	msg = luaL_checkstring(L, 1);
	SDL_ShowSimpleMessageBox(SDL_MESSAGEBOX_INFORMATION, APP_TITLE, msg, NULL); 
	return 0;
}

static int set_draw_color(lua_State * L) {
	int r, g, b, a;

	r = luaL_checkinteger(L, 1);
	g = luaL_checkinteger(L, 2);
	b = luaL_checkinteger(L, 3);
	a = luaL_checkinteger(L, 4);
	SDL_SetRenderDrawColor(renderer, r, g, b, a);
	return 0;
}

static int draw_line(lua_State * L) {
	int x1, y1, x2, y2;

	x1 = luaL_checkinteger(L, 1);
	y1 = luaL_checkinteger(L, 2);
	x2 = luaL_checkinteger(L, 3);
	y2 = luaL_checkinteger(L, 4);
	if (SDL_RenderDrawLine(renderer, x1, y1, x2, y2)) fatal(SDL_GetError());
	return 0;
}

void register_util_functions(lua_State * L) {
	lua_register(L, "quit"           , quit           );
	lua_register(L, "msgbox"         , msgbox         );
	lua_register(L, "set_draw_color" , set_draw_color );
	lua_register(L, "draw_line"      , draw_line      );
}

