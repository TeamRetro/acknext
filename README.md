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

These instructions are only for building the core of the engine. Building
the tools requires a complex setup yet to be simplified.

### Dependencies

- Latest master [Zig](https://ziglang.org/download/) in `$PATH`
- [glslangValidator](https://github.com/KhronosGroup/glslang), available in most package managers
- gnu make
- gnu binutils
- 7-zip command line util (`7z`)
- qt5-base for `rcc`

### Build Steps

1. Prepare the resource environment (`make -C resource`)
2. Build the engine (`zig build`)
3. Test it (`./zig-cache/bin/rotating-cube`)

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
