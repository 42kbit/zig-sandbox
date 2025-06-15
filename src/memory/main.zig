const std = @import("std");

pub fn main() !void {
    // std.mem.Allocator is a generic object for allocating memory
    // It contains a generic pointer (*anyopaque) and a vtable pointer (*Vtable)

    const allocator = std.heap.page_allocator;

    // memory is a slice
    const memory = try allocator.alloc(u32, 5);

    std.debug.print(
        "Size of memory is {d}, type is {s}\n",
        .{
            memory.len,
            @typeName(@TypeOf(memory.ptr)),
        },
    );

    @memset(memory, 0);

    for (memory, 0..) |value, i| {
        std.debug.print("[{d}] = {d}\n", .{ i, value });
    }
}
