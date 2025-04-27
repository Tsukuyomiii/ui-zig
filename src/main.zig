const std = @import("std");
const raylib = @import("raylib");

const Box = struct {
    x: i32,
    y: i32,
    width:  i32,
    height: i32,
    pub fn draw(self: @This()) void {
        raylib.drawRectangle(self.x, self.y, self.height, self.width, raylib.Color.blue);
    }
};

const Element = union(enum) {
    box: Box,
};



pub fn main() !void {
    raylib.initWindow(800, 600, "UI");
    raylib.setTargetFPS(144);

    const box = Box { 
        .x = 0,
        .y = 0,
        .width  = 100,
        .height = 100,
    };

    const elements = [_]Element{
        Element{.box = box}
    };

    if (raylib.isMouseButtonDown(.left)) {
        const mx = raylib.getMouseX();
        const my = raylib.getMouseY();
        if (mx >= box.x and mx <= (box.x + box.width) and my >= box.y and my <= (box.y + box.height)) {

        }
    }
    

    while (!raylib.windowShouldClose()) {
        raylib.beginDrawing();
        raylib.clearBackground(raylib.Color.dark_gray);
        raylib.drawFPS(0, 0);
        for (elements) |element| {
            element.draw();
        }
        raylib.endDrawing();
    }
}
