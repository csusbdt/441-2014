#include "global.h"

static void on_window_closing(lua_State * L) {
	lua_getglobal(L, "on_window_closing");
	if (lua_isnil(L, 1)) return;
	if (lua_pcall(L, 0, 0, 0)) error(lua_tostring(L, -1));
}

static void on_mouse_down(lua_State * L, const SDL_MouseButtonEvent * e) {
	if (e->type == SDL_MOUSEBUTTONDOWN && e->button == SDL_BUTTON_LEFT) {
		lua_getglobal(L, "on_touch");
		if (lua_isnil(L, 1)) return;
		lua_pushinteger(L, e->x);
		lua_pushinteger(L, e->y);
		if (lua_pcall(L, 2, 0, 0)) error(lua_tostring(L, -1));
	}
}

/*
static void on_finger_down(lua_State * L, const SDL_TouchFingerEvent * e) {
	//int x = e->x * APP_WIDTH;
	//int y = e->y * APP_HEIGHT;
	lua_getglobal(L, "on_touch");
	if (lua_isnil(L, 1)) return;
	//lua_pushinteger(L, x);
	//lua_pushinteger(L, y);
	lua_pushnumber(L, e->x);
	lua_pushnumber(L, e->y);
	if (lua_pcall(L, 2, 0, 0)) error(lua_tostring(L, -1));
}
*/
bool process_event_queue(lua_State * L) {
	SDL_Event e;
	while (SDL_PollEvent(&e)) {
		if      (e.type == SDL_QUIT)          { on_window_closing(L);  return false; } 
		else if (e.type == SDL_MOUSEBUTTONDOWN) on_mouse_down(L, &e.button);
		//else if (e.type == SDL_FINGERDOWN)      on_finger_down(L, &e.tfinger);
	}
	return true;
}

