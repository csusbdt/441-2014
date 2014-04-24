#include "global.h"

void fatal(const char * msg) {
	SDL_ShowSimpleMessageBox(SDL_MESSAGEBOX_ERROR, APP_TITLE, msg, NULL);
	exit(1);
}

