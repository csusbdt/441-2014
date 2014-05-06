#include "global.h"

static int open_font(lua_State * L) {
	const char * fontname = luaL_checkstring(L, 1);
	lua_Integer fontsize = luaL_checkinteger(L, 2);
	TTF_Font * font = TTF_OpenFont(fontname, fontsize);
	if (!font) fatal(TTF_GetError());
	void * ud = lua_newuserdata(L, sizeof(TTF_Font *));
	* (TTF_Font **) ud = font;
	return 1;
}

static int close_font(lua_State * L) {
	void * ud = lua_touserdata(L, 1);
	if (ud == NULL) {
		fatal("close_font called with bad argument");
	}
	TTF_Font * font = * (TTF_Font **) ud;
	TTF_CloseFont(font);
	return 0;
}

void register_font_functions(lua_State * L) {
	lua_register(L, "open_font"  , open_font  );
	lua_register(L, "close_font" , close_font );
}

