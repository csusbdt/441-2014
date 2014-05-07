#include "global.h"

TTF_Font * get_font(lua_State * L, int stack_pos) {
	TTF_Font ** ud = (TTF_Font **) lua_touserdata(L, 1);
	if (ud == NULL) {
		fatal("close_font called with bad argument");
	}
	return *ud;
}

static int open_font(lua_State * L) {
	const char * fontname = luaL_checkstring(L, 1);
	lua_Integer fontsize = luaL_checkinteger(L, 2);
	TTF_Font * font = TTF_OpenFont(fontname, fontsize);
	if (!font) fatal(TTF_GetError());
	TTF_Font ** ud = (TTF_Font **) lua_newuserdata(L, sizeof(TTF_Font *));
	if (ud == NULL) fatal("ud NULL in open_font");
	*ud = font;
	return 1;
}

static int close_font(lua_State * L) {
	TTF_Font * font = get_font(L, 1);
	TTF_CloseFont(font);
	return 0;
}

void register_font_functions(lua_State * L) {
	lua_register(L, "open_font"  , open_font  );
	lua_register(L, "close_font" , close_font );
}
