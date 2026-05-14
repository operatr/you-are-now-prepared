---@class GearEntry
---@field slot string Slot name such as HeadSlot or MainHandSlot.
---@field item table|nil Parsed item payload or nil for empty slots.

---@class JsonEncoder
---@field EscapeString fun(value:any): string Escapes a Lua string for JSON output.
---@field EncodeGearEntries fun(entries: GearEntry[]): string Encodes the gear snapshot into JSON text.

local _, ns = ...

local JsonEncoder = {}

local escapeMap = {
	["\\"] = "\\\\",
	['"'] = '\\"',
	["\b"] = "\\b",
	["\f"] = "\\f",
	["\n"] = "\\n",
	["\r"] = "\\r",
	["\t"] = "\\t",
}

---@param char string
---@return string
local function escapeChar(char)
	local escaped = escapeMap[char]
	if escaped then
		return escaped
	end
	return string.format("\\u%04x", string.byte(char))
end

---@param value any
---@return string
function JsonEncoder.EscapeString(value)
	if value == nil then
		return ""
	end

	return (tostring(value):gsub('[%z\1-\31\\"]', escapeChar))
end

---@param gems number[]
---@return string
local function encodeGemArray(gems)
	local values = {}
	for index = 1, 4 do
		values[index] = tostring(tonumber(gems[index]) or 0)
	end
	return "[" .. table.concat(values, ", ") .. "]"
end

---@param item table
---@return string
local function encodeItem(item)
	local rows = {
		"{",
		string.format('    "name": "%s",', JsonEncoder.EscapeString(item.name)),
		string.format('    "id": %d,', tonumber(item.id) or 0),
		string.format('    "enchant_id": %d,', tonumber(item.enchantId) or 0),
		string.format('    "gems": %s', encodeGemArray(item.gems or {})),
		"  }",
	}
	return table.concat(rows, "\n")
end

---@param entries GearEntry[]
---@return string
function JsonEncoder.EncodeGearEntries(entries)
	local rows = { "{" }

	for index, entry in ipairs(entries) do
		local suffix = index < #entries and "," or ""
		local slotKey = JsonEncoder.EscapeString(entry.slot)

		if entry.item == nil then
			rows[#rows + 1] = string.format('  "%s": null%s', slotKey, suffix)
		else
			local encodedItem = encodeItem(entry.item)
			local prefixed = encodedItem:gsub("\n", "\n  ")
			rows[#rows + 1] = string.format('  "%s": %s%s', slotKey, prefixed, suffix)
		end
	end

	rows[#rows + 1] = "}"
	return table.concat(rows, "\n")
end

if ns then
	ns.JsonEncoder = JsonEncoder
else
	return JsonEncoder
end
