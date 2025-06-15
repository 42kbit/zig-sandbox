const std = @import("std");

pub fn main() !void {
    // std.mem.Allocator is a generic object for allocating memory
    // It contains a generic pointer (*anyopaque) and a vtable pointer (*Vtable)

    // basic allocator that would get an entire page for each allocation
    const allocator = std.heap.page_allocator;

    // memory is a slice
    const memory = try allocator.alloc(u32, 5);
    defer allocator.free(memory);

    std.debug.print(
        "Size of memory is {d}, type is {s}\n",
        .{
            memory.len,
            @typeName(@TypeOf(memory.ptr)),
        },
    );

    for (0..memory.len) |i| {
        // intCat since @sizeOf(usize) >= @sizeOf(u32)
        memory[i] = @intCast(i + 1);
    }

    for (memory, 0..) |value, i| {
        std.debug.print("[{d}] = {d}\n", .{ i, value });
    }

    // now since GPA is dead we use SMP allocator
    const smp = std.heap.smp_allocator;

    const parts = [_][]const u8{ "Hello", ", ", "world!" };
    const concatted = std.mem.concat(
        smp,
        u8,
        &parts,
    ) catch @panic("OOM");
    defer smp.free(concatted);

    std.debug.print("Concatted string is {s}\n", .{concatted});
}
