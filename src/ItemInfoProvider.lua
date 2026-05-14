---@class ItemInfoProvider
---@field TryGetName fun(itemLink:string): string|nil, string|nil Returns item name or a cache/API error token.

local _, ns = ...

local ItemInfoProvider = {}

---@param itemLink string
---@return string|nil itemName, string|nil errorToken
function ItemInfoProvider.TryGetName(itemLink)
	if type(GetItemInfo) ~= "function" then
		return nil, "item info API unavailable: GetItemInfo is not a function in this environment"
	end

	local itemName = GetItemInfo(itemLink)
	if not itemName then
		return nil, "cache miss: item info is not yet cached by the WoW client"
	end

	return itemName, nil
end

if ns then
	ns.ItemInfoProvider = ItemInfoProvider
else
	return ItemInfoProvider
end
