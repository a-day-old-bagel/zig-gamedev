const std = @import("std");
const system_sdk = @import("../../libs/mach-glfw/system_sdk.zig");
const glfw = @import("../../libs/mach-glfw/build.zig");
const gpu_dawn = @import("../../libs/mach-gpu-dawn/build.zig");

const Options = @import("../../build.zig").Options;
const content_dir = "triangle_wgpu_content/";

pub fn build(b: *std.build.Builder, options: Options) *std.build.LibExeObjStep {
    const exe = b.addExecutable("triangle_wgpu", thisDir() ++ "/src/triangle_wgpu.zig");

    exe.setBuildMode(options.build_mode);
    exe.setTarget(options.target);
    exe.addPackagePath("glfw", thisDir() ++ "/../../libs/mach-glfw/src/main.zig");
    exe.addPackagePath("gpu", thisDir() ++ "/../../libs/mach-gpu/src/main.zig");

    glfw.link(b, exe, .{ .system_sdk = .{ .set_sysroot = false } });
    gpu_dawn.link(b, exe, .{ .from_source = options.dawn_from_source });

    return exe;
}

fn thisDir() []const u8 {
    return std.fs.path.dirname(@src().file) orelse ".";
}