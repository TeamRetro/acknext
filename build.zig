const std = @import("std");

const acknext = @import("acknext/build.zig");
const physfs = @import("extern/physfs-3.0.2/build.zig");
const zlib = @import("extern/zlib-1.2.11/build.zig");
// const ode = @import("extern/ode/build.zig");

pub fn build(b: *std.build.Builder) void {
    const mode = b.standardReleaseOptions();
    const target = b.standardTargetOptions(.{});

    const acknext_lib = acknext.buildLib("./acknext", b);
    acknext_lib.setTarget(target);
    acknext_lib.setBuildMode(mode);
    acknext_lib.install();

    const physfs_lib = physfs.buildLib("./extern/physfs-3.0.2", b);
    physfs_lib.setTarget(target);
    physfs_lib.setBuildMode(mode);

    const zlib_lib = zlib.buildLib("./extern/zlib-1.2.11", b);
    zlib_lib.setTarget(target);
    zlib_lib.setBuildMode(mode);

    // const ode_lib = zlib.buildLib("./extern/ode", b);
    // ode_lib.setTarget(target);
    // ode_lib.setBuildMode(mode);

    const rotating_cube = b.addExecutable("rotating-cube", null);

    rotating_cube.addIncludeDir("./acknext/include");
    rotating_cube.addIncludeDir("./extern/ode/include");
    rotating_cube.addIncludeDir("./extern/gl3w/include");
    rotating_cube.addCSourceFile("examples/rotating-cube/main.c", &[_][]const u8{});

    rotating_cube.addLibPath("./extern/ode/ode/src/.libs");
    rotating_cube.linkSystemLibraryName("ode");

    rotating_cube.linkLibC();

    rotating_cube.linkLibrary(physfs_lib);
    rotating_cube.linkLibrary(zlib_lib);
    // rotating_cube.linkLibrary(ode_lib);
    rotating_cube.linkLibrary(acknext_lib);

    rotating_cube.setTarget(target);
    rotating_cube.setBuildMode(mode);
    rotating_cube.install();
}
