# acknext
A game engine prototype loosely inspired by the Acknex A8 engine.

## Features

- bone animation
- Convenient custom shaders
- collider
- plugin support
  - terrain rendering (large scale, LOD, multitexturing)
  - `wait(1)`
  - `default.c`
  - cef (chromium embedded)
- custom resource files
- debug drawing
- entity update logic ("action")
- primitives audio (snd_play, …)
- I/O
  - virtual file system
  - BLOBs (binary files, support for deflate/inflate)
  - Serializer APIs for binary files
- flexibles rendering
  - "Standard" PBR-Renderer
  - Custom Materials
  - Arbitrary Geometry
  - OpenGL Wrapper
- Logging
- Metatagging of engine objekten (pass info to shader etc.)
- Event Handling
- Input
  - Keyboard
  - Mouse
- VIEWs for layered rendering

## Building (Linux)

1. Clone the repo
2. Get current master for [Zig](https://ziglang.org/download/) and make it available in your `PATH`
3. Prepare the environment: `source setup-env`
4. Build ODE
    1. Go to `extern/ode/`
    2. Run `./bootstrap`
    3. Run `./configure --disable-demos  --enable-static  --enable-libccd  --with-drawstuff=none  --with-libccd=internal`
    4. Run `make`
7. Build the engine
    1. Go to root directory
    2. `zig build`
8. Test it
    1. Run `./zig-cache/bin/rotating-cube`

## Licence

Acknext is published under the [zlib licence](LICENCE).

## External libraries

The following libraries are used and have the following licences:

| Library                                                 | Licence       | Static Linking | Dynamic Linking | Requires Credits |
|---------------------------------------------------------|---------------|----------------|-----------------|------------------|
| [SDL2](https://www.libsdl.org/)                         | zlib          | ✓              | ✓               | ✗                |
| [SDL_mixer](https://www.libsdl.org/projects/SDL_mixer/) | zlib          | ✓              | ✓               | ✗                |
| [ODE](https://www.ode.org/)                             | BSD 3-Clause  | ✓              | ✓               | ✓                |
| [gl3w](https://github.com/skaslev/gl3w)                 | Public Domain | ✓              | ✓               | ✗                |
| [glm](https://glm.g-truc.net/)                          | MIT           | ✓              | ✓               | ✓                |
| [imgui](https://github.com/ocornut/imgui)               | MIT           | ✓              | ✓               | ✓                |
| [json](https://github.com/nlohmann/json)                | MIT           | ✓              | ✓               | ✓                |
| [physfs](https://icculus.org/physfs/)                   | zlib          | ✓              | ✓               | ✗                |
| [stb](https://github.com/nothings/stb)                  | MIT           | ✓              | ✓               | ✓                |
| [zlib](https://www.zlib.net/)                           | zlib          | ✓              | ✓               | ✗                |
