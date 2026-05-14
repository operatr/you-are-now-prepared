---@class SlotProfiles
---@field GetSlots fun(flavor:string): string[] Returns a copy of the slot names for the requested flavor.

local _, ns = ...

local SlotProfiles = {}

local defaultSlots = {
	"HeadSlot",
	"NeckSlot",
	"ShoulderSlot",
	"BackSlot",
	"ChestSlot",
	"ShirtSlot",
	"TabardSlot",
	"WristSlot",
	"HandsSlot",
	"WaistSlot",
	"LegsSlot",
	"FeetSlot",
	"Finger0Slot",
	"Finger1Slot",
	"Trinket0Slot",
	"Trinket1Slot",
	"MainHandSlot",
	"SecondaryHandSlot",
	"RangedSlot",
}

local slotsByFlavor = {
	classic_era = defaultSlots,
	classic_tbc = defaultSlots,
}

---@param values string[]
---@return string[]
local function copyArray(values)
	local copied = {}
	for index, value in ipairs(values) do
		copied[index] = value
	end
	return copied
end

---@param flavor string
---@return string[]
function SlotProfiles.GetSlots(flavor)
	local profile = slotsByFlavor[flavor] or slotsByFlavor.classic_era
	return copyArray(profile)
end

if ns then
	ns.SlotProfiles = SlotProfiles
else
	return SlotProfiles
end
