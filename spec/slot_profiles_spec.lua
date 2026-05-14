local SlotProfiles = require("src.SlotProfiles")

describe("SlotProfiles", function()
	it("returns classic era slot list", function()
		local slots = SlotProfiles.GetSlots("classic_era")
		assert.is_true(#slots > 0)
		assert.are.equal("HeadSlot", slots[1])
	end)

	it("falls back to classic era for unknown flavor", function()
		local slots = SlotProfiles.GetSlots("unknown")
		assert.are.equal("HeadSlot", slots[1])
	end)
end)
