const Element = @This();
const Context = @import("Context.zig");
const std = @import("std");

pub const Handle = struct {
    id: u8,
    pub fn element(self: Handle, context: *Context) !*Element {
        for (context.elements.items) |ele| {
            if (ele.id == self.id) return &element;
        }
        return error.NoMatchingId;
    }
};

context:  *Context,
parent:   ?Handle, // id, null if root
id:       u8,
x:        i32,
y:        i32,
width:    i32,
height:   i32,

pub fn init(
        context: *Context, 
        parent:  ?Handle, 
        x:     i32, y:      i32, 
        width: i32, height: i32
    ) Handle {
    const element = try context.elements.append(.{
        .context = context, 
        .id      = std.crypto.random.int(u8),
        .parent  = parent,
        .x       = x,
        .y       = y,
        .width   = width,
        .height  = height,
    });
    return Handle { .id = element.id };
}

