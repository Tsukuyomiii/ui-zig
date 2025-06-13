const Element = @This();
const Context = @import("Context.zig");
const std = @import("std");
const raylib = @import("raylib");

const DrawFn   = *const fn (*Context, Element) void;
const UpdateFn = *const fn (*Context, Element) void;

pub const Handle = struct {
    id: u8,
    pub fn element(self: Handle, context: *Context) .NoMatchingId!*Element {
        for (context.elements.items, 0..) |ele, i| {
            if (ele.id == self.id) return &context.elements.items[i];
        }
        return error.NoMatchingId;
    }
};

context:  *Context,
parent:   ?Handle, // id, null if root
id:       u8,
x:        i32,
y:         i32,
width:     i32,
height:    i32,
draw_fn:   DrawFn,
update_fn: UpdateFn,

pub fn init(
        context: *Context, 
        parent:  ?Handle, 
        x:     i32, y:      i32, 
        width: i32, height: i32,
        draw_fn:  DrawFn
    ) !Handle {
    try context.elements.append(.{
        .context = context, 
        .id      = std.crypto.random.int(u8),
        .parent  = parent,
        .x       = x,
        .y       = y,
        .width   = width,
        .height  = height,
        .draw_fn = draw_fn,
    });
    const items = context.elements.items;
    const element = items[items.len - 1];
    return Handle { .id = element.id };
}

pub fn rect(self: Element) raylib.Rectangle {
    // TODO(optimize) look into conversion costs - allegedly fp is no longer a perf bottleneck
    return .{
        .x      = @floatFromInt(self.x),
        .y      = @floatFromInt(self.y),
        .height = @floatFromInt(self.height),
        .width  = @floatFromInt(self.width)
    };
}

