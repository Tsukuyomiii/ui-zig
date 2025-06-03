const Context = @This();
const Element = @import("Element.zig");

const std = @import("std");
const raylib = @import("raylib");

gpa: std.heap.GeneralPurposeAllocator(.{}),
elements: std.ArrayList(Element),
show_box_debug: bool = false,
mouse_pos: struct {
    x: i32,
    y: i32,
} = .{},
pub fn init() !*Context {
    var gpa = std.heap.GeneralPurposeAllocator(.{}).init;
    const context = try gpa.allocator().create(Context);
    context.* = .{ 
        .gpa      = gpa,
        .elements = std.ArrayList(Element).init(gpa.allocator()),
    };
    // create root element
    try context.elements.append(.{
        .context = context,
        .id      = 0,
        .parent  = null,
        .height  = raylib.getScreenHeight(),
        .width   = raylib.getScreenWidth(),
        .x       = 0,
        .y       = 0,
    });
    return context;
}

pub fn update(self: *Context) void {
    self.show_box_debug = raylib.isMouseButtonDown(.forward);
    self.mouse_pos = .{ 
        .x = raylib.getMouseX(),
        .y = raylib.getMouseY(),
    };
    if (raylib.isWindowResized()) {
        
    }
}