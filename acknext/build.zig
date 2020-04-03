const std = @import("std");
const Builder = std.build.Builder;

pub fn buildLib(comptime prefix_path: []const u8, b: *Builder) *std.build.LibExeObjStep {
    if (comptime std.mem.eql(u8, prefix_path, ""))
        @compileError("Don't pass empty string to buildLib. If you want to pass cwd(), use \".\".");

    const mode = b.standardReleaseOptions();
    const target = b.standardTargetOptions(.{});
    const lib = b.addStaticLibrary("acknext", null);

    // Add engine sources
    lib.addIncludeDir(prefix_path ++ "/include");
    lib.addIncludeDir(prefix_path ++ "/src");
    inline for (cpp_sources) |file| {
        lib.addCSourceFile(prefix_path ++ "/" ++ file, &[_][]const u8{
            "-D_ACKNEXT_INTERNAL_",
            "-Wno-gnu-designator",
        });
    }

    // Add resource zip file
    lib.addObjectFile(prefix_path ++ "/../resource/resource.o");

    // Add libc/libc++
    lib.linkLibC();
    lib.linkSystemLibrary("c++");

    // Add gl3w
    lib.addIncludeDir(prefix_path ++ "/../extern/gl3w/include");
    lib.addCSourceFile(prefix_path ++ "/../extern/gl3w/src/gl3w.c", &[_][]const u8{});
    lib.linkSystemLibrary("gl");
    lib.linkSystemLibrary("dl");

    // Add glm
    lib.addIncludeDir(prefix_path ++ "/../extern/glm");

    // Add PhysFS
    lib.addIncludeDir(prefix_path ++ "/../extern/physfs-3.0.2/src");

    // Add zlib
    lib.addIncludeDir(prefix_path ++ "/../extern/zlib");

    // Add ODE
    lib.addIncludeDir(prefix_path ++ "/../extern/ode/include");

    // Add stb
    lib.addIncludeDir(prefix_path ++ "/../extern/stb/include");

    // Link other libraries
    lib.linkSystemLibrary("sdl2");
    lib.linkSystemLibrary("SDL2_mixer");

    lib.setTarget(target);
    lib.setBuildMode(mode);
    lib.install();

    return lib;
}

pub fn build(b: *Builder) void {
    _ = buildLib(".", b);
}

const cpp_sources = [_][]const u8{
    "src/graphics/opengl/buffer.cpp",
    "src/graphics/opengl/shader.cpp",
    "src/graphics/scene/material.cpp",
    "src/graphics/scene/mesh.cpp",
    "src/graphics/scene/stage.cpp",
    "src/graphics/scene/pipeline.cpp",
    "src/graphics/scene/model.cpp",
    "src/graphics/scene/light.cpp",
    "src/graphics/scene/camera.cpp",
    "src/graphics/opengl/bitmap.cpp",
    "src/scene/entity.cpp",
    "src/collision/collision.cpp",
    "src/collision/hull.cpp",
    "src/graphics/core/view.cpp",
    "src/events/event.cpp",
    "src/input/gamepad.cpp",
    "src/input/joystick.cpp",
    "src/math/vector.cpp",
    "src/math/var.cpp",
    "src/core/init.cpp",
    "src/core/config.cpp",
    "src/core/log.cpp",
    "src/core/errorhandling.cpp",
    "src/graphics/core/graphics-core.cpp",
    "src/core/globals.cpp",
    "src/input/inputmanager.cpp",
    "src/input/input-strings.cpp",
    "src/core/blob.cpp",
    "src/graphics/opengl/opengl.cpp",
    "src/math/matrix.cpp",
    "src/virtfs/physfs-integration.cpp",
    "src/math/quaternion.cpp",
    "src/graphics/scene/scene-renderer.cpp",
    "src/math/transforms.cpp",
    "src/graphics/debug/debugdrawer.cpp",
    "src/collision/collisionsystem.cpp",
    "src/audio/audiomanager.cpp",
    "src/audio/sound.cpp",
    "src/virtfs/resourcemanager.cpp",
    "src/math/color.cpp",
    "src/graphics/opengl/programuniform.cpp",
    "src/core/blob_compression.c",
    "src/core/engineobject.cpp",
    "src/extensions/extension.cpp",
    "src/virtfs/serialization.cpp",
    "src/core/guid.cpp",
    "src/serialization/serializers.cpp",
    "src/graphics/core/glenum-translator.cpp",
    "src/virtfs/ackfile.cpp",
    "src/scene/animation.cpp",
    "src/graphics/opengl/framebuffer.cpp",
    "src/math/aabb.cpp",
    "src/graphics/stb_image.cpp",
};
