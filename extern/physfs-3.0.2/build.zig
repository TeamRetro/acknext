const std = @import("std");
const Builder = std.build.Builder;

pub fn buildLib(comptime prefix_path: []const u8, b: *Builder) *std.build.LibExeObjStep {
    if (comptime std.mem.eql(u8, prefix_path, ""))
        @compileError("Don't pass empty string to buildLib. If you want to pass cwd(), use \".\".");

    const lib = b.addStaticLibrary("physfs", null);

    lib.addIncludeDir(prefix_path ++ "/src");
    inline for (sources) |file| {
        lib.addCSourceFile(prefix_path ++ "/" ++ file, &[_][]const u8{});
    }

    lib.linkLibC();

    lib.linkSystemLibrary("pthread");

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
    "src/physfs.c",
    "src/physfs_byteorder.c",
    "src/physfs_unicode.c",
    "src/physfs_platform_posix.c",
    "src/physfs_platform_unix.c",
    "src/physfs_platform_windows.c",
    "src/physfs_platform_os2.c",
    "src/physfs_platform_qnx.c",
    "src/physfs_archiver_dir.c",
    "src/physfs_archiver_unpacked.c",
    "src/physfs_archiver_grp.c",
    "src/physfs_archiver_hog.c",
    "src/physfs_archiver_7z.c",
    "src/physfs_archiver_mvl.c",
    "src/physfs_archiver_qpak.c",
    "src/physfs_archiver_wad.c",
    "src/physfs_archiver_zip.c",
    "src/physfs_archiver_slb.c",
    "src/physfs_archiver_iso9660.c",
    "src/physfs_archiver_vdf.c",
};
