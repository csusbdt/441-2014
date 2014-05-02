#include "global.h"

#define TEXTURE_MT_NAME "texture"

extern SDL_Renderer * renderer;

static int texture_from_file(lua_State * L) {
	const char * filename = luaL_checkstring(L, 1);
	SDL_Surface * surface = SDL_LoadBMP(filename);
	if (!surface) {
		fatal(SDL_GetError());
	}
	SDL_Texture * texture = SDL_CreateTextureFromSurface(renderer, surface);
	SDL_FreeSurface(surface);
	if (!texture) {
		fatal(SDL_GetError());
	}
	SDL_Texture ** ud = (SDL_Texture **) lua_newuserdata(L, sizeof(SDL_Texture *));
	if (ud == NULL) {
		fatal("failed to create userdata in texture_from_file");
	}
	*ud = texture;
	int w;
	int h;
	SDL_QueryTexture(texture, NULL, NULL, &w, &h);
	lua_pushinteger(L, w);
	lua_pushinteger(L, h);
	return 3;
}

static int destroy_texture(lua_State * L) {
	SDL_Texture * texture = (SDL_Texture *) lua_touserdata(L, 1);
	if (texture == NULL) {
		fatal("destroy_texture called with bad argument");
	}
	SDL_DestroyTexture(texture);
	return 0;
}

static int render_texture(lua_State * L) {
	SDL_Texture ** ud = (SDL_Texture **) lua_touserdata(L, 1);
	if (ud == NULL) {
		fatal("render_texture called with bad argument");
	}
	SDL_Texture * texture = *ud;
	SDL_Rect src;
	SDL_Rect dst;
	if (lua_gettop(L) == 3) {
	        dst.x = luaL_checknumber(L, 2);
	        dst.y = luaL_checknumber(L, 3);
		SDL_QueryTexture(texture, NULL, NULL, &dst.w, &dst.h);
	        SDL_RenderCopy(renderer, texture, NULL, &dst);
	} else {
	        src.x = luaL_checknumber(L, 2);
	        src.y = luaL_checknumber(L, 3);
		src.w = luaL_checknumber(L, 4);
		src.h = luaL_checknumber(L, 5);
	        dst.x = luaL_checknumber(L, 6);
	        dst.y = luaL_checknumber(L, 7);
		dst.w = luaL_checknumber(L, 8);
		dst.h = luaL_checknumber(L, 9);
	        SDL_RenderCopy(renderer, texture, &src, &dst);
	}
	return 0;
}

void register_texture_functions(lua_State * L) {
	lua_register(L, "texture_from_file" , texture_from_file );
	lua_register(L, "destroy_texture"   , destroy_texture   );
	lua_register(L, "render_texture"    , render_texture    );
}

