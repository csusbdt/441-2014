#include "global.h"

const SDL_Color APP_WHITE = { 255, 255, 255, 255 };

void error(const char * msg) {
	SDL_ShowSimpleMessageBox(SDL_MESSAGEBOX_INFORMATION, APP_TITLE, msg, NULL); 
}

void fatal(const char * msg) {
	SDL_ShowSimpleMessageBox(SDL_MESSAGEBOX_ERROR, APP_TITLE, msg, NULL);
	exit(1);
}

