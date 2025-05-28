const Element = @This();
const Context = @import("Context.zig");
const std = @import("std");

pub const Handle = struct {
    id: u8,
    pub fn element(self: Handle, context: *Context) !*Element {
        
    }
};

context:  *Context,
parent:   u8, // id
id:       u8 = std.Random.int(u8),
x:        i32,
y:        i32,
width:    i32,
height:   i32,

pub fn init(context: *Context, parent: ?*Element, x: i32, y: i32, width: i32, height: i32) Handle {
    const element = Element {
        .context  = context, 
        .children = std.ArrayList(Element).init(context.allocator),
        .x        = x,
        .y        = y,
        .width    = width,
        .height   = height,
    };
    if (parent) |parent_ele| {
        parent_ele.children.append(element);
    } else {
        context.root_element.children.append(element);
    }
    return &element;
}

