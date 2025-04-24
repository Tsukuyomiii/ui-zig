//! By convention, main.zig is where your main function lives in the case that
//! you are building an executable. If you are making a library, the convention
//! is to delete this file and start with root.zig instead.

const std = @import("std");
const raylib = @import("raylib");

pub fn main() !void {
    raylib.initWindow(800, 600, "UI");
    raylib.setTargetFPS(144);

    const Box = struct {
        const Self = @This();
        x: i32,
        y: i32,
        width: i32,
        height: i32,
        pub fn draw(self: Self) void {
            raylib.drawRectangle(self.x, self.y, self.height, self.width, raylib.Color.blue);
        }
    };

    var box = .{ .thing = "yeah", .other = fn (
        self: @This(),
    ) void{std.debug.print("deadass?")} };

    while (!raylib.windowShouldClose()) {
        raylib.beginDrawing();
        raylib.clearBackground(raylib.Color.dark_gray);
        raylib.drawFPS(0, 0);
        box.draw(box);
        raylib.endDrawing();
    }
}
