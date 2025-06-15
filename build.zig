const std = @import("std");

// TODO: replace this whole file with std.fs.Dir API
// e.g. src/memory/main.zig can run as zig build run-memory
// and so on
pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "memory",
        .root_source_file = b.path("src/memory/main.zig"),
        .target = target,
        .optimize = optimize,
    });

    b.installArtifact(exe);

    const run_exe = b.addRunArtifact(exe);

    const run_step = b.step("run-memory", "Run the application");
    run_step.dependOn(&run_exe.step);
}
