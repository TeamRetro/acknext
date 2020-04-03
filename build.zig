const std = @import("std");

const acknext = @import("acknext/build.zig");

pub fn build(b: *std.build.Builder) void {
    const acknext_lib = acknext.buildLib("./acknext", b);

    const rotating_cube = b.addExecutable("rotating-cube", null);

    rotating_cube.addIncludeDir("./acknext/include");
    rotating_cube.addIncludeDir("./extern/ode/include");
    rotating_cube.addIncludeDir("./extern/gl3w/include");
    rotating_cube.addCSourceFile("examples/rotating-cube/main.c", &[_][]const u8{});

    rotating_cube.addLibPath("./extern/ode/ode/src/.libs");
    rotating_cube.linkSystemLibraryName("ode");

    rotating_cube.addLibPath("./extern/physfs-3.0.2/build");
    rotating_cube.linkSystemLibraryName("physfs");

    rotating_cube.linkLibC();

    rotating_cube.linkLibrary(acknext_lib);
    rotating_cube.install();
}
