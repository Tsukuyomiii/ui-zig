const Context = @This();
const Element = @import("Element.zig");

const std = @import("std");
const raylib = @import("raylib");

allocator: std.mem.Allocator,
show_box_debug: bool = false,
mouse_pos: struct {
    x: i32 = 0,
    y: i32 = 0,
},
root_element: Element,
pub fn init(allocator: std.mem.Allocator) !*Context {
    const context = try allocator.create(Context);
    context.allocator = allocator;
    context.root_element = Element {
        .context  = context,
        .children = std.ArrayList(Element).init(allocator),
        .x = 0,
        .y = 0,
        .width  = raylib.getScreenWidth(),
        .height = raylib.getScreenHeight(),
    };
    context.mouse_pos = .{};
    context.show_box_debug = false;
    return context;
}

pub fn update(self: *Context) void {
    self.show_box_debug = raylib.isMouseButtonDown(.forward);
    self.mouse_pos = .{ 
        .x = raylib.getMouseX(), 
        .y = raylib.getMouseY(),
    };
    if (raylib.isWindowResized()) {
        self.root_element.width  = raylib.getScreenWidth();
        self.root_element.height = raylib.getScreenHeight();
    }
}