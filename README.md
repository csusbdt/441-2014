This program illustrates one way to use SDL2 and Lua to build a 2D video game.

## Notes for Engine Developers

The code is written in C and Lua.

All userdata is light, which means that metatables are not attached to any userdata on
the C-side.  To guard against resource leaks, the Lua side always wraps a userdata object
in a table with a metatable with a garbage collection function.  This garbage collection
function is responsible to de-allocate resources.

Wrapped userdata objects currently include textures and sound data (called waves).

I placed Lua code that I feel belongs on the side of the engine developer under the
folder named 'eng'.

The program as it is written is prone to memory fragmentation.  A memory management
strategy is needed to fix this.  Please discuss with me if you want to work on this.

## Notes for Scriptors

### Textures

To access a texture, use the get method of the textures module as follows.

    textures = require('eng.textures')
    ima = textures.get('textures/ima.bmp')

Render a texture by calling its draw method.

    ima:draw()

To delete a texture, set all references to the texture to nil.

    ima = nil

Removing all references to a texture will cause the texture to eventually be garbage collected.
During garbage collection, the texture's __gc method will invoke the C function to destroy the
texture.  If you do not want to wait for the garbage collector to run at an unknown point in the
future, then force garbage collection as follows.

    collectgarbage()

### Sound effects (and small music)

Music data that is small can be treated like sound effects, which means the song can be completely
loaded into RAM.  Large sized music will take up too much space, requiring a streaming
process whereby chunks of sound data are read from persistent storage and mixed into the
audio buffers.  Also, we need to add code that decodes audio samples from ogg files.  Ogg files
are needed to reduce the size of audio data stored with the game.

Sound data is in wave format and stored under a folder named 'waves'. To play a wave file,
get a wave object from the waves module and then call its play function.  (Use the colon operator
to call the wave's play function.)

    waves = require('eng.waves')
    door = waves.get('waves/door.wav')
    door:play()

Call the loop method of a wave object to make the sound play continuously until its stop
method is called.

    wave = waves.get('waves/music.wav')
    music = wave.loop()
    ...
    music:stop()

### GUI

The Button module is the beginning of a GUI library.  Button instances can be used to display
textures.  They can also be used to function as buttons through the use of their contains
functions.




