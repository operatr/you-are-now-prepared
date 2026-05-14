---@meta

---@diagnostic disable: undefined-global

---@class Frame
---@field SetSize fun(self:Frame, width:number, height:number)
---@field SetPoint fun(self:Frame, point:string, ...)
---@field SetFrameStrata fun(self:Frame, strata:string)
---@field SetBackdrop fun(self:Frame, backdrop:any)
---@field Hide fun(self:Frame)
---@field Show fun(self:Frame)
---@field SetMultiLine fun(self:Frame, enabled:boolean)
---@field SetAutoFocus fun(self:Frame, enabled:boolean)
---@field SetWidth fun(self:Frame, width:number)
---@field SetScript fun(self:Frame, scriptName:string, handler:function)
---@field SetScrollChild fun(self:Frame, child:Frame)
---@field SetText fun(self:Frame, text:string)
---@field SetFontObject fun(self:Frame, fontObject:any)
---@field HighlightText fun(self:Frame)
---@field SetFocus fun(self:Frame)

---@class CreateFrameOptions

---@type fun(itemLink:string): string|nil, number|nil, number|nil, number|nil, number|nil, number|nil, number|nil, number|nil, number|nil, number|nil, number|nil, number|nil GetItemInfo WoW API.
GetItemInfo = GetItemInfo

---@type fun(unit:string, slotId:number): string|nil GetInventoryItemLink WoW API.
GetInventoryItemLink = GetInventoryItemLink

---@type fun(slotName:string): number|nil GetInventorySlotInfo WoW API.
GetInventorySlotInfo = GetInventorySlotInfo

---@type fun(typeName:string, name:string|nil, parent:any|nil, template?:string): Frame CreateFrame WoW API.
CreateFrame = CreateFrame

---@type any UIParent WoW UI root frame.
UIParent = UIParent

---@type any BackdropTemplateMixin WoW backdrop mixin.
BackdropTemplateMixin = BackdropTemplateMixin

---@type any GameFontHighlightSmall WoW font object.
GameFontHighlightSmall = GameFontHighlightSmall

---@type table<string, fun(...)> SlashCmdList WoW slash command registry.
SlashCmdList = SlashCmdList
