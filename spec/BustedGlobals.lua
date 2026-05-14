---@meta

---@diagnostic disable: undefined-global

---@class BustedAssertAre
---@field equal fun(expected:any, actual:any)
---@field same fun(expected:any, actual:any)

---@class BustedAssert
---@field are BustedAssertAre
---@field is_nil fun(value:any)
---@field is_true fun(value:any)

---@type fun(name:string, fn:function)
describe = describe

---@type fun(name:string, fn:function)
it = it

---@type any
assert = assert
