#ifndef APP_GLOBAL_H
#define APP_GLOBAL_H

#include <stdlib.h>
#include <assert.h>
#include <stdbool.h>

#include "lua.h"
#include "lualib.h"
#include "lauxlib.h"

#include "SDL.h"

#define APP_TITLE  "Sample SDL Lua Project"
#define APP_WIDTH  640
#define APP_HEIGHT 480

void error(const char * msg);
void fatal(const char * msg);

#endif

