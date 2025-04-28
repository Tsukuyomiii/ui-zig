const std = @import("std");
const raylib = @import("raylib");

const Context = struct {
    const DragState = struct {
        id: u32,
        start_pos: struct { x: i32, y: i32 }, 
    };
    elements: struct {
        data: [20]Element,
    },
    drag_states: [10]DragState,
};

const Element = union(enum) {
    const Box = struct {
        id: u32,
        x: i32,
        y: i32,
        width:  i32,
        height: i32,
        pub fn draw(this: Box) void {
            raylib.drawRectangle(this.x, this.y, this.height, this.width, raylib.Color.blue);
        }
        pub fn new() Box {

        }
    };
    box: Box,
};

pub fn main() !void {
    raylib.initWindow(800, 600, "UI");
    raylib.setTargetFPS(144);

    const context: Context = .{
        .elements = .{
            .data = undefined,
        },
        .drag_states = undefined,
    };

    const box = Element.Box {
        .id = std.crypto.random.int(u32),
        .x = 0,
        .y = 0,
        .width  = 100,
        .height = 100,
    };

    while (!raylib.windowShouldClose()) {
        raylib.beginDrawing();
        raylib.clearBackground(raylib.Color.dark_gray);
        raylib.drawFPS(0, 0);
        if (raylib.isMouseButtonDown(.left)) {
            const mx = raylib.getMouseX();
            const my = raylib.getMouseY();
            if (mx >= box.x and mx <= (box.x + box.width) and my >= box.y and my <= (box.y + box.height)) {
                
            }
        }
        for (context.elements) |element| {
            element.draw();
        }
        raylib.endDrawing();
    }
}
