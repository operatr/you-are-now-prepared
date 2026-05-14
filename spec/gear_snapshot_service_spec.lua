local GearSnapshotService = require("src.GearSnapshotService")

local function stubDeps(overrides)
	local deps = {
		flavor = "classic_era",
		slotProfiles = {
			GetSlots = function()
				return { "HeadSlot", "MainHandSlot" }
			end,
		},
		parser = {
			ParseItemLink = function(link)
				return { itemId = 19019, enchantId = 0, gems = { 0, 0, 0, 0 } }, nil
			end,
		},
		itemInfoProvider = {
			TryGetName = function(link)
				return "Thunderfury, Blessed Blade of the Windseeker", nil
			end,
		},
		linkFetcher = function(slotName, slotId)
			return "item:19019:0:0:0:0:0"
		end,
	}
	for k, v in pairs(overrides or {}) do
		deps[k] = v
	end
	return deps
end

describe("GearSnapshotService", function()
	it("returns an entry per slot", function()
		local entries, err = GearSnapshotService.BuildSnapshot(stubDeps())
		assert.is_nil(err)
		assert.are.equal(2, #entries)
	end)

	it("sets slot name on each entry", function()
		local entries, err = GearSnapshotService.BuildSnapshot(stubDeps())
		assert.is_nil(err)
		assert.are.equal("HeadSlot", entries[1].slot)
		assert.are.equal("MainHandSlot", entries[2].slot)
	end)

	it("populates item fields for equipped slots", function()
		local entries, err = GearSnapshotService.BuildSnapshot(stubDeps())
		assert.is_nil(err)
		local item = entries[1].item
		assert(item, "expected item to be non-nil")
		assert.are.equal("Thunderfury, Blessed Blade of the Windseeker", item.name)
		assert.are.equal(19019, item.id)
		assert.are.equal(0, item.enchantId)
		assert.are.same({ 0, 0, 0, 0 }, item.gems)
	end)

	it("sets item to nil for empty slots", function()
		local entries, err = GearSnapshotService.BuildSnapshot(stubDeps({
			linkFetcher = function()
				return nil
			end,
		}))
		assert.is_nil(err)
		assert.is_nil(entries[1].item)
		assert.is_nil(entries[2].item)
	end)

	it("handles mixed equipped and empty slots", function()
		local entries, err = GearSnapshotService.BuildSnapshot(stubDeps({
			linkFetcher = function(slotName)
				if slotName == "MainHandSlot" then
					return "item:19019:0:0:0:0:0"
				end
				return nil
			end,
		}))
		assert.is_nil(err)
		assert.is_nil(entries[1].item)
		assert(entries[2].item, "expected MainHandSlot to have an item")
	end)

	it("propagates parse errors", function()
		local entries, err = GearSnapshotService.BuildSnapshot(stubDeps({
			parser = {
				ParseItemLink = function()
					return nil, "invalid item string"
				end,
			},
		}))
		assert.is_nil(entries)
		assert.is_true((err or ""):find("parse failed", 1, true) ~= nil)
	end)

	it("propagates item info cache misses", function()
		local entries, err = GearSnapshotService.BuildSnapshot(stubDeps({
			itemInfoProvider = {
				TryGetName = function()
					return nil, "cache miss"
				end,
			},
		}))
		assert.is_nil(entries)
		assert.is_true((err or ""):find("item info unavailable", 1, true) ~= nil)
	end)
end)
