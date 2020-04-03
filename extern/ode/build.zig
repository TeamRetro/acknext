const std = @import("std");
const Builder = std.build.Builder;

pub fn buildLib(comptime prefix_path: []const u8, b: *Builder) *std.build.LibExeObjStep {
    if (comptime std.mem.eql(u8, prefix_path, ""))
        @compileError("Don't pass empty string to buildLib. If you want to pass cwd(), use \".\".");

    const lib = b.addStaticLibrary("ode", null);

    lib.addIncludeDir(prefix_path ++ "/include");
    lib.addIncludeDir(prefix_path ++ "/ode/src");
    lib.addIncludeDir(prefix_path ++ "/include");
    lib.addIncludeDir(prefix_path ++ "/ode/src");
    lib.addIncludeDir(prefix_path ++ "/ode/src/joints");
    lib.addIncludeDir(prefix_path ++ "/ou/include");
    lib.addIncludeDir(prefix_path ++ "/OPCODE");
    lib.addIncludeDir(prefix_path ++ "/OPCODE/Ice");
    lib.addIncludeDir(prefix_path ++ "/libccd/src");
    lib.addIncludeDir(prefix_path ++ "/libccd/src/custom");
    lib.addIncludeDir(prefix_path ++ "/supply/include");

    inline for (sources) |file| {
        lib.addCSourceFile(prefix_path ++ "/" ++ file, &[_][]const u8{
            "-DdBUILTIN_THREADING_IMPL_ENABLED",
            "-DdTHREADING_INTF_DISABLED",
            "-DdLIBCCD_ENABLED",
            "-DdLIBCCD_INTERNAL",
            "-DdLIBCCD_BOX_CYL",
            "-DdLIBCCD_CAP_CYL",
            "-DdLIBCCD_CYL_CYL",
            "-DdLIBCCD_CONVEX_BOX",
            "-DdLIBCCD_CONVEX_CAP",
            "-DdLIBCCD_CONVEX_CONVEX",
            "-DdLIBCCD_CONVEX_CYL",
            "-DdLIBCCD_CONVEX_SPHERE",
            "-DdTRIMESH_ENABLED",
            "-DdTRIMESH_OPCODE",
            "-DdATOMICS_ENABLED",
            "-DODE_LIB",
            "-DdIDESINGLE PRIVATE",
            "-DCCD_IDESINGLE",
            "-D_OU_NAMESPACE=odeou",
            "-D_OU_FEATURE_SET=_OU_FEATURE_SET_ATOMICS",
            "-D_OU_TARGET_OS=_OU_TARGET_OS_GENUNIX",
            "-DdOU_ENABLED",
        });
    }

    lib.linkLibC();
    lib.linkSystemLibrary("c++");

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
    "ode/src/array.cpp",
    "ode/src/box.cpp",
    "ode/src/capsule.cpp",
    "ode/src/collision_cylinder_box.cpp",
    "ode/src/collision_cylinder_plane.cpp",
    "ode/src/collision_cylinder_sphere.cpp",
    "ode/src/collision_kernel.cpp",
    "ode/src/collision_quadtreespace.cpp",
    "ode/src/collision_sapspace.cpp",
    "ode/src/collision_space.cpp",
    "ode/src/collision_transform.cpp",
    "ode/src/collision_trimesh_disabled.cpp",
    "ode/src/collision_util.cpp",
    "ode/src/convex.cpp",
    "ode/src/cylinder.cpp",
    "ode/src/default_threading.cpp",
    "ode/src/error.cpp",
    "ode/src/export-dif.cpp",
    "ode/src/fastdot.cpp",
    "ode/src/fastldltfactor.cpp",
    "ode/src/fastldltsolve.cpp",
    "ode/src/fastlsolve.cpp",
    "ode/src/fastltsolve.cpp",
    "ode/src/fastvecscale.cpp",
    "ode/src/heightfield.cpp",
    "ode/src/lcp.cpp",
    "ode/src/mass.cpp",
    "ode/src/mat.cpp",
    "ode/src/matrix.cpp",
    "ode/src/memory.cpp",
    "ode/src/misc.cpp",
    "ode/src/objects.cpp",
    "ode/src/obstack.cpp",
    "ode/src/ode.cpp",
    "ode/src/odeinit.cpp",
    "ode/src/odemath.cpp",
    "ode/src/plane.cpp",
    "ode/src/quickstep.cpp",
    "ode/src/ray.cpp",
    "ode/src/resource_control.cpp",
    "ode/src/rotation.cpp",
    "ode/src/simple_cooperative.cpp",
    "ode/src/sphere.cpp",
    "ode/src/step.cpp",
    "ode/src/threading_base.cpp",
    "ode/src/threading_impl.cpp",
    "ode/src/threading_pool_posix.cpp",
    "ode/src/threading_pool_win.cpp",
    "ode/src/timer.cpp",
    "ode/src/util.cpp",
    "ode/src/joints/amotor.cpp",
    "ode/src/joints/ball.cpp",
    "ode/src/joints/contact.cpp",
    "ode/src/joints/dball.cpp",
    "ode/src/joints/dhinge.cpp",
    "ode/src/joints/fixed.cpp",
    "ode/src/joints/hinge.cpp",
    "ode/src/joints/hinge2.cpp",
    "ode/src/joints/joint.cpp",
    "ode/src/joints/lmotor.cpp",
    "ode/src/joints/null.cpp",
    "ode/src/joints/piston.cpp",
    "ode/src/joints/plane2d.cpp",
    "ode/src/joints/pr.cpp",
    "ode/src/joints/pu.cpp",
    "ode/src/joints/slider.cpp",
    "ode/src/joints/transmission.cpp",
    "ode/src/joints/universal.cpp",
    "ode/src/collision_libccd.cpp",
    "ode/src/collision_convex_trimesh.cpp",
    "ode/src/collision_cylinder_trimesh.cpp",
    "ode/src/collision_trimesh_box.cpp",
    "ode/src/collision_trimesh_ccylinder.cpp",
    "ode/src/collision_trimesh_internal.cpp",
    "ode/src/collision_trimesh_opcode.cpp",
    "ode/src/collision_trimesh_plane.cpp",
    "ode/src/collision_trimesh_ray.cpp",
    "ode/src/collision_trimesh_sphere.cpp",
    "ode/src/collision_trimesh_trimesh.cpp",
    "ode/src/collision_trimesh_trimesh_old.cpp",
    "OPCODE/OPC_AABBCollider.cpp",
    "OPCODE/OPC_AABBTree.cpp",
    "OPCODE/OPC_BaseModel.cpp",
    "OPCODE/OPC_Collider.cpp",
    "OPCODE/OPC_Common.cpp",
    "OPCODE/OPC_HybridModel.cpp",
    "OPCODE/OPC_LSSCollider.cpp",
    "OPCODE/OPC_MeshInterface.cpp",
    "OPCODE/OPC_Model.cpp",
    "OPCODE/OPC_OBBCollider.cpp",
    "OPCODE/OPC_OptimizedTree.cpp",
    "OPCODE/OPC_Picking.cpp",
    "OPCODE/OPC_PlanesCollider.cpp",
    "OPCODE/OPC_RayCollider.cpp",
    "OPCODE/OPC_SphereCollider.cpp",
    "OPCODE/OPC_TreeBuilders.cpp",
    "OPCODE/OPC_TreeCollider.cpp",
    "OPCODE/OPC_VolumeCollider.cpp",
    "OPCODE/Opcode.cpp",
    "OPCODE/Ice/IceAABB.cpp",
    "OPCODE/Ice/IceContainer.cpp",
    "OPCODE/Ice/IceHPoint.cpp",
    "OPCODE/Ice/IceIndexedTriangle.cpp",
    "OPCODE/Ice/IceMatrix3x3.cpp",
    "OPCODE/Ice/IceMatrix4x4.cpp",
    "OPCODE/Ice/IceOBB.cpp",
    "OPCODE/Ice/IcePlane.cpp",
    "OPCODE/Ice/IcePoint.cpp",
    "OPCODE/Ice/IceRandom.cpp",
    "OPCODE/Ice/IceRay.cpp",
    "OPCODE/Ice/IceRevisitedRadix.cpp",
    "OPCODE/Ice/IceSegment.cpp",
    "OPCODE/Ice/IceTriangle.cpp",
    "OPCODE/Ice/IceUtils.cpp",
    "ode/src/odeou.cpp",
    "ode/src/odetls.cpp",
    "ou/src/ou/atomic.cpp",
    "ou/src/ou/customization.cpp",
    "ou/src/ou/malloc.cpp",
    "ou/src/ou/threadlocalstorage.cpp",
    "ode/src/nextafterf.c",
    "libccd/src/alloc.c",
    "libccd/src/ccd.c",
    "libccd/src/mpr.c",
    "libccd/src/polytope.c",
    "libccd/src/support.c",
    "libccd/src/vec3.c",
};
