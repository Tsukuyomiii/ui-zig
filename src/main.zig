const std = @import("std");
const raylib = @import("raylib");


const Context = @import("Context.zig");
const Element = @import("Element.zig");

fn draw_box(e: Element) void {
    raylib.drawRectangle(e.x, e.y, e.width, e.height, raylib.Color.red);
}

fn draw_framed_box(
    rect: raylib.Rectangle, 
    border_color: raylib.Color, 
    background_color: raylib.Color
) void {
    raylib.drawRectangleRec(rect, background_color);
    raylib.drawRectangleLinesEx(
        rect,
        5,
        border_color
    );
}

const FrameOptions = struct {
    color: raylib.Color = raylib.Color.black,
    title: ?[:0]const u8 = null,
    thickness: i32 = 4, 
};

fn draw_frame(e: Element, opts: FrameOptions) void {
    const background_rect = e.rect();
    raylib.drawRectangleLinesEx(
        background_rect,
        @floatFromInt(opts.thickness),
        opts.color
    );

    var top_bar = background_rect;
    top_bar.height = 20;
    raylib.drawRectangleRec(top_bar, opts.color);
    if (opts.title) |title| {
        raylib.drawTextEx(
            raylib.getFontDefault() catch unreachable, 
            title, 
            .{ 
                .x = @floatFromInt(e.x + 3), 
                .y = @floatFromInt(e.y + 3) 
            }, 
            14, 
            2, 
            raylib.Color.white
        );
    }

    var drag_handle_rect: raylib.Rectangle = undefined;
    drag_handle_rect.height = 10;
    drag_handle_rect.width  = 10;
    const x_spacing: f32 = 3;
    const y_spacing: f32 = 3;
    drag_handle_rect.x = (background_rect.x + background_rect.width) - drag_handle_rect.width - x_spacing;
    drag_handle_rect.y = background_rect.y + y_spacing;
    raylib.drawLineV(.{ .x = drag_handle_rect.x, .y = drag_handle_rect.y }, .{ .x = drag_handle_rect.x + drag_handle_rect.width, .y = drag_handle_rect.y}, raylib.Color.white);
    raylib.drawLineV(.{ .x = drag_handle_rect.x + drag_handle_rect.width, .y = drag_handle_rect.y}, .{ .x = drag_handle_rect.x + drag_handle_rect.width, .y = drag_handle_rect.y + drag_handle_rect.height}, raylib.Color.white);
}

fn draw_fps_box(e: Element) void {
    draw_framed_box(e.rect(), raylib.Color.light_gray, raylib.Color.black);
    raylib.drawFPS(e.x + @divExact(e.width, 2), e.y + @divExact(e.height, 2));
}

fn test_draw(ele: Element) void {
    draw_frame(ele, .{ .color = raylib.Color.black, .thickness = 4, .title = "Test" });
}

pub fn main() !void {
    raylib.initWindow(800, 600, "THING");
    raylib.setWindowState(.{ .window_resizable = true });

    std.debug.print("Element size: {}\n", .{ @sizeOf(Element) });

    var context = try Context.init();
  
    const root_handle = Element.Handle { .id = 0, };

    _ = try Element.init(context, root_handle, 10, 10, 100, 100, draw_box);

    _ = try Element.init(context, root_handle, 10, 100, 100, 50, draw_fps_box);

    // _ = try Element.init(context, root_handle, 10, 200, 100, 100, struct { pub fn draw(ele: Element) void { 
    //     draw_frame(ele, .{ .color = raylib.Color.black, .thickness = 8 });
    // }}.draw);

    _ = try Element.init(context, root_handle, 10, 200, 250, 100, test_draw);

    // std.debug.print("{}\n", .{context.*});

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