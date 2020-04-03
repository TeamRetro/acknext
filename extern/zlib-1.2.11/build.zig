const std = @import("std");
const Builder = std.build.Builder;

pub fn buildLib(comptime prefix_path: []const u8, b: *Builder) *std.build.LibExeObjStep {
    if (comptime std.mem.eql(u8, prefix_path, ""))
        @compileError("Don't pass empty string to buildLib. If you want to pass cwd(), use \".\".");

    const lib = b.addStaticLibrary("zlib", null);

    lib.addIncludeDir(prefix_path ++ "/src");
    inline for (sources) |file| {
        lib.addCSourceFile(prefix_path ++ "/" ++ file, &[_][]const u8{});
    }

    lib.linkLibC();

    return lib;
}

pub fn build(b: *Builder) void {
    const lib = buildLib(".", b);

    const mode = b.standardReleaseOptions();
    const target = b.standardTargetOptions(.{});
    lib.setTarget(target);
    lib.setBuildMode(mode);
    lib.install();
}

const sources = [_][]const u8{
    "adler32.c",
    "compress.c",
    "crc32.c",
    "deflate.c",
    "gzclose.c",
    "gzlib.c",
    "gzread.c",
    "gzwrite.c",
    "inflate.c",
    "infback.c",
    "inftrees.c",
    "inffast.c",
    "trees.c",
    "uncompr.c",
    "zutil.c",
};
