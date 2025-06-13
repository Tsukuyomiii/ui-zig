const Context = @This();
const Element = @import("Element.zig");

const std = @import("std");
const raylib = @import("raylib");

pub const Font = enum {
    Fira
};

const ContextAllocator = std.heap.GeneralPurposeAllocator(.{ .verbose_log = true });
const FontMap = std.AutoHashMap(Font, raylib.Font);
gpa: ContextAllocator,
fonts: FontMap,
elements: std.ArrayList(Element),
show_box_debug: bool = false,
mouse: struct {
    pos: struct {
        x: i32,
        y: i32,
    },
},

fn root_draw(_: Element) void {}

pub fn init() !*Context {
    var gpa = ContextAllocator.init;
    const context = try gpa.allocator().create(Context);
    context.* = .{
        .mouse    = .{
            .pos   = .{ .x = 0, .y = 0 },
        },
        .gpa      = gpa,
        .fonts    = FontMap.init(context.gpa.allocator()),
        .elements = std.ArrayList(Element).init(context.gpa.allocator()),
    };
    try context.fonts.put(.Fira, raylib.loadFont("FiraCode-Regular.ttf") catch @panic("couldn't load fira code"));
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
    self.mouse.pos = .{ 
        .x = raylib.getMouseX(),
        .y = raylib.getMouseY(),
    };
    
    if (raylib.isWindowResized()) {
        self.elements.items[0].height = raylib.getScreenHeight();
        self.elements.items[0].width  = raylib.getScreenWidth();
    }
}