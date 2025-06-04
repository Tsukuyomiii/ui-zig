const Context = @This();
const Element = @import("Element.zig");

const std = @import("std");
const raylib = @import("raylib");

pub fn fira_code() !raylib.Font {
    return raylib.loadFont("FiraCode-Regular.ttf");
}

pub const Font = struct {
    const fira_code = raylib.loadFont("FiraCode-Regular.ttf") catch @compileError("Couldn't load Fira Code!");
};

gpa: std.heap.GeneralPurposeAllocator(.{}),
elements: std.ArrayList(Element),
show_box_debug: bool = false,
mouse_pos: struct {
    x: i32,
    y: i32,
} = .{ .x = 0, .y = 0 },

fn root_draw(_: Element) void {}

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
        .draw_fn = root_draw,
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