const Element = @This();
const Context = @import("Context.zig");
const std = @import("std");

context:  *Context,
children: std.ArrayList(Element),
x:        i32,
y:        i32,
width:    i32,
height:   i32,

pub fn init(context: *Context, parent: ?Element, x: i32, y: i32, width: i32, height: i32) Element {
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
    return element;
}

