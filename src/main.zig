const std = @import("std");
const raylib = @import("raylib");

const Context = @import("Context.zig");
const Element = @import("Element.zig");

pub fn main() !void {
    raylib.initWindow(800, 600, "THING");

    var allocator = std.heap.GeneralPurposeAllocator(.{}).init;
    const context = try Context.init(allocator.allocator());

    

    // const fira = try raylib.loadFont("FiraCode-Regular.ttf");

    // var show_box_debug: bool = false;

    // const TextBox = struct {
    //     deco: struct {
    //         font: raylib.Font,
    //         border_color: raylib.Color = raylib.Color.white,
    //     },
    //     frame: struct {
    //         x: i32,
    //         y: i32,
    //         width: i32,
    //         height: i32,
    //         pub fn tup(self: @This()) struct { i32, i32, i32, i32 } {
    //             return .{ self.x, self.y, self.width, self.height };
    //         }
    //     },
    //     text: []const u8,
    //     pub fn draw(self: @This()) void {
    //         raylib.drawRectangleLines(self.frame.x, self.frame.y, self.frame.width, self.frame.height, self.deco.border_color);
    //         const tx = self.frame.x + 5;
    //         const ty = self.frame.y + 5;
    //         const text_sent: [:0]const u8 = @ptrCast(self.text);
    //         const font = raylib.getFontDefault();
    //         raylib.drawTextEx(font, text_sent, .{ .x = @floatFromInt(tx), .y = @floatFromInt(ty) }, 16, 1, raylib.Color.white);
    //     }

    //     pub fn is_hovered(self: @This(), mouse: struct { i32, i32 }) bool {
    //         const x, const y, const height, const width = self.frame.tup();
    //         const mx, const my = mouse;

    //         if ((x < mx and mx < x + width) and (y < my and my < y + height)) {
    //             return true;
    //         }
    //         return false;
    //     }
    // };

    
    while (!raylib.windowShouldClose()) {
        context.update();

        
        raylib.beginDrawing();
        defer raylib.endDrawing();

        raylib.clearBackground(raylib.Color.dark_gray);

        // {
        //     var x: [10]u8 = undefined;
        //     var y: [10]u8 = undefined;
        //     var buf: [20]u8 = undefined;
        //     const x_txt = std.fmt.bufPrintIntToSlice(&x, context.mouse_pos.x, 10, .lower, .{});
        //     const y_txt = std.fmt.bufPrintIntToSlice(&y, context.mouse_pos.y, 10, .lower, .{});
        //     var i: u32 = 0;
        //     for (x_txt) |char| {
        //         buf[i] = char;
        //         i += 1;
        //     }
        //     buf[i] = ',';
        //     i += 1;
        //     buf[i] = ' ';
        //     i += 1;
        //     for (y_txt) |char| {
        //         buf[i] = char;
        //         i += 1;
        //     }
        //     buf[i] = '\x00';

        //     // @breakpoint();

        //     raylib.drawText(@ptrCast(buf[0..]), 10, 10, 16, raylib.Color.white);
        // }


        
    }
}