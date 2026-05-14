---@class SnapshotItem
---@field name string Display name from GetItemInfo.
---@field id number Parsed item ID.
---@field enchantId number Parsed enchant ID.
---@field gems number[] Parsed gem IDs.

---@class SnapshotEntry
---@field slot string Slot name.
---@field item SnapshotItem|nil Item payload or nil if empty.

---@class GearSnapshotService
---@field BuildSnapshot fun(deps: table): SnapshotEntry[]|nil, string|nil Builds a slot-by-slot gear snapshot using injected dependencies.

local _, ns = ...

local GearSnapshotService = {}

---@param slotName string
---@param slotId number|nil
---@return string|nil
local function defaultLinkFetcher(slotName, slotId)
	if type(GetInventoryItemLink) ~= "function" or slotId == nil then
		return nil
	end
	return GetInventoryItemLink("player", slotId)
end

---@param deps table
---@return SnapshotEntry[]|nil entries, string|nil errorToken
function GearSnapshotService.BuildSnapshot(deps)
	local parser = deps.parser
	local itemInfoProvider = deps.itemInfoProvider
	local slotProfiles = deps.slotProfiles
	local flavor = deps.flavor
	local linkFetcher = deps.linkFetcher or defaultLinkFetcher

	local slots = slotProfiles.GetSlots(flavor)
	local entries = {}

	for _, slotName in ipairs(slots) do
		local slotId = type(GetInventorySlotInfo) == "function" and GetInventorySlotInfo(slotName) or nil
		local itemLink = linkFetcher(slotName, slotId)

		if not itemLink then
			entries[#entries + 1] = { slot = slotName, item = nil }
		else
			local parsed, parseError = parser.ParseItemLink(itemLink)
			if not parsed then
				return nil, "parse failed for slot " .. slotName .. ": " .. tostring(parseError)
			end

			local itemName, itemError = itemInfoProvider.TryGetName(itemLink)
			if not itemName then
				return nil, "item info unavailable for slot " .. slotName .. ": " .. tostring(itemError)
			end

			entries[#entries + 1] = {
				slot = slotName,
				item = {
					name = itemName,
					id = parsed.itemId,
					enchantId = parsed.enchantId,
					gems = parsed.gems,
				},
			}
		end
	end

	return entries, nil
end

if ns then
	ns.GearSnapshotService = GearSnapshotService
else
	return GearSnapshotService
end
