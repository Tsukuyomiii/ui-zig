const Context = @This();
const Element = @import("Element.zig");

const std = @import("std");
const raylib = @import("raylib");

gpa: std.heap.GeneralPurposeAllocator(.{}),
elements: struct {
    list: [20]?Element,
    pool: std.heap.MemoryPoolExtra(Element, .{ .alignment = std.mem.Alignment.of(Element), .growable = true }),
},
show_box_debug: bool = false,
mouse_pos: struct {
    x: i32 = 0,
    y: i32 = 0,
} = .{},
pub fn init() !*Context {
    var gpa = std.heap.GeneralPurposeAllocator(.{}).init;
    const context = try gpa.allocator().create(Context);
    context.* = .{ 
        .gpa      = gpa,
        .elements = .{
            .list = [20] // just use arraylist
            .pool = std.heap.MemoryPoolExtra(
                Element, 
                .{ 
                    .alignment = std.mem.Alignment.of(Element), 
                    .growable = true 
                },
            ).init(gpa.allocator()),
        }
    };
    const root = try context.elements.create();
    root.* = Element {
        .context = context,
        .id      = 0,
        .parent  = null,
        .height  = raylib.getScreenHeight(),
        .width   = raylib.getScreenWidth(),
        .x       = 0,
        .y       = 0,
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
        
    }
}