const Context = @This();
const Element = @import("Element.zig");

const std = @import("std");
const raylib = @import("raylib");

gpa: std.heap.GeneralPurposeAllocator(.{}).init,
elements: std.heap.MemoryPool(Element),
show_box_debug: bool = false,
mouse_pos: struct {
    x: i32 = 0,
    y: i32 = 0,
},
pub fn init() !*Context {
    const gpa = std.heap.GeneralPurposeAllocator(.{}).init;
    const context = try gpa.allocator().create(Context);
    context.* = .{ 
        .gpa      = gpa,
        .elements = std.heap.MemoryPool(Element).init(gpa.allocator()),
    };
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