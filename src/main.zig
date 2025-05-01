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
    dragging: DragState,
};

const Element = struct {
    // context: *Context,
    id: u32,
    frame: struct {
        x: i32,
        y: i32,
        width:  i32,
        height: i32,
    },
    variant: union(enum) {
        box: Box,
    }
};

const Box = struct {
    element: *Element,
    pub fn draw(this: Box) void {
        raylib.drawRectangle(this.x, this.y, this.height, this.width, raylib.Color.blue);
    }
    pub fn new() Box {

    }
};


pub fn main() !void {
    const etype = @TypeOf(Context.elements);
    
    std.debug.print(etype);
    raylib.initWindow(800, 600, "UI");
    raylib.setTargetFPS(120);

    const context = Context {
        .elements = .{
            .data = undefined,
        },
        .drag_states = undefined,
    };
    
    while (!raylib.windowShouldClose()) {
        raylib.beginDrawing();
        raylib.clearBackground(raylib.Color.dark_gray);
        raylib.drawFPS(0, 0);
        if (raylib.isMouseButtonDown(.left)) {
            
            
        }
        for (context.elements) |element| {
            element.draw();
        }
        raylib.endDrawing();
    }
}
