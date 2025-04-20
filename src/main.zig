//! By convention, main.zig is where your main function lives in the case that
//! you are building an executable. If you are making a library, the convention
//! is to delete this file and start with root.zig instead.

const std = @import("std");
std.heap.DebugAllocator()
const raylib = @import("raylib");

pub fn main() !void {
    raylib.initWindow(800, 600, "UI");
    raylib.setTargetFPS(144);

    {
        var path = try std.fs.path.resolve()
    }

    while (!raylib.windowShouldClose()) {
        raylib.beginDrawing();
        raylib.clearBackground(raylib.Color.dark_gray);
        raylib.drawFPS(0, 0);
        raylib.endDrawing();
    }
}
