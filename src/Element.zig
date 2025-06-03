const Element = @This();
const Context = @import("Context.zig");
const std = @import("std");

pub const Handle = struct {
    id: u8,
    pub fn element(self: Handle, context: *Context) !*Element {
        
    }
};

context:  *Context,
parent:   ?u8, // id, null if root
id:       u8 = std.Random.int(@FieldType(Element, "id")),
x:        i32,
y:        i32,
width:    i32,
height:   i32,

pub fn init(context: *Context, parent: ?Handle, x: i32, y: i32, width: i32, height: i32) Handle {
    const element = Element {
        .context = context, 
        .parent  = parent,
        .x       = x,
        .y       = y,
        .width   = width,
        .height  = height,
    };
    context.elements.create
    return Handle { .id = element.id };
}

