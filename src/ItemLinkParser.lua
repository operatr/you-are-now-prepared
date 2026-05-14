---@class ParsedItem
---@field itemId number Numeric item ID extracted from the item string.
---@field enchantId number Enchant ID; zero if absent.
---@field gems number[] Four gem IDs, zero-filled.

---@class ItemLinkParser
---@field ExtractItemString fun(itemLink:string): string|nil, string|nil Extracts the raw item string from a hyperlink or raw item string.
---@field ParseItemLink fun(itemLink:string): ParsedItem|nil, string|nil Parses a WoW item link into IDs used by JSON output.

local _, ns = ...

local ItemLinkParser = {}

---@param value any
---@param defaultValue number
---@return number
local function toNumber(value, defaultValue)
	local parsed = tonumber(value)
	if parsed == nil then
		return defaultValue
	end
	return parsed
end

---@param itemString string
---@return string[]
local function splitItemString(itemString)
	local fields = {}
	for token in string.gmatch(itemString .. ":", "([^:]*):") do
		fields[#fields + 1] = token
	end
	return fields
end

---@param itemLink string
---@return string|nil itemString, string|nil errorToken
function ItemLinkParser.ExtractItemString(itemLink)
	if type(itemLink) ~= "string" then
		return nil, "invalid item link: expected a string, got " .. type(itemLink)
	end

	local embedded = itemLink:match("|H(item:[^|]+)|h")
	if embedded then
		return embedded, nil
	end

	local raw = itemLink:match("^(item:[-%d:]+)$") or itemLink:match("(item:[-%d:]+)")
	if not raw then
		return nil, "invalid item link: expected a WoW item hyperlink or raw item string"
	end

	return raw, nil
end

---@param itemLink string
---@return ParsedItem|nil parsedItem, string|nil errorToken
function ItemLinkParser.ParseItemLink(itemLink)
	local itemString, extractError = ItemLinkParser.ExtractItemString(itemLink)
	if not itemString then
		return nil, extractError
	end

	local fields = splitItemString(itemString)
	if fields[1] ~= "item" then
		return nil, "invalid item string: expected a leading 'item' token"
	end

	local itemId = tonumber(fields[2])
	if not itemId then
		return nil, "invalid item string: missing or non-numeric item ID"
	end

	local enchantId = toNumber(fields[3], 0)
	local gem1 = toNumber(fields[4], 0)
	local gem2 = toNumber(fields[5], 0)
	local gem3 = toNumber(fields[6], 0)
	local gem4 = toNumber(fields[7], 0)

	return {
		itemId = itemId,
		enchantId = enchantId,
		gems = { gem1, gem2, gem3, gem4 },
	}, nil
end

if ns then
	ns.ItemLinkParser = ItemLinkParser
else
	return ItemLinkParser
end
