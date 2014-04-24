#ifndef APP_GLOBAL_H
#define APP_GLOBAL_H

#include <stdlib.h>
#include <assert.h>
#include <stdbool.h>

#include "lua.h"
#include "lualib.h"
#include "lauxlib.h"

#include "SDL.h"

#define APP_TITLE "Sample SDL Lua Project"

void fatal(const char * msg);

#endif

