const std = @import("std");
const raylib = @import("raylib");


const Context = @import("Context.zig");
const Element = @import("Element.zig");

fn draw_box(e: Element) void {
    raylib.drawRectangle(e.x, e.y, e.width, e.height, raylib.Color.red);
}

fn draw_framed_box(x: i32, y: i32, width: i32, height: i32, border_color: raylib.Color, background_color: raylib.Color) void {
    raylib.drawRectangle(x, y, width, height, background_color);
    raylib.drawRectangleLinesEx(
        .{
            .x      = @floatFromInt(x),
            .y      = @floatFromInt(y),
            .height = @floatFromInt(height),
            .width  = @floatFromInt(width)
        },
        5,
        border_color
    );
}

fn draw_fps_box(e: Element) void {
    draw_framed_box(e.x, e.y, e.width, e.height, raylib.Color.light_gray, raylib.Color.black);
    raylib.drawFPS(e.x + @divExact(e.width, 2), e.y + @divExact(e.height, 2));
}

pub fn main() !void {
    raylib.initWindow(800, 600, "THING");

    var context = try Context.init();
  
    const root_handle = Element.Handle { .id = 0, };

    _ = try Element.init(context, root_handle, 10, 10, 100, 100, draw_box);

    _ = try Element.init(context, root_handle, 100, 100, 100, 50, draw_fps_box);

    std.debug.print("{}", .{context.*});

    while (!raylib.windowShouldClose()) {
        context.update();

        raylib.beginDrawing();
        defer raylib.endDrawing();

        for (context.elements.items) |element| {
            element.draw_fn(element);
        }

        raylib.clearBackground(raylib.Color.dark_gray);    
    }
}