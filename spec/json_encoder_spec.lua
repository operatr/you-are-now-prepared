local JsonEncoder = require("src.JsonEncoder")

describe("JsonEncoder", function()
	it("encodes null item slots", function()
		local payload = JsonEncoder.EncodeGearEntries({
			{ slot = "MainHandSlot", item = nil },
		})

		assert.is_true(payload:find('"MainHandSlot": null', 1, true) ~= nil)
	end)

	it("keeps the expected top-level JSON shape", function()
		local payload = JsonEncoder.EncodeGearEntries({
			{
				slot = "MainHandSlot",
				item = {
					name = "Not Thunderfury, Blessed Blade of the Windseeker",
					id = 19019,
					enchantId = 0,
					gems = { 0, 0, 0, 0 },
				},
			},
		})

		assert.is_true(payload:sub(1, 1) == "{")
		assert.is_true(payload:sub(-1) == "}")
		assert.is_true(payload:find('"MainHandSlot": {', 1, true) ~= nil)
		assert.is_true(payload:find('"name": "Not Thunderfury, Blessed Blade of the Windseeker"', 1, true) ~= nil)
		assert.is_true(payload:find('"id": 19019', 1, true) ~= nil)
		assert.is_true(payload:find('"enchant_id": 0', 1, true) ~= nil)
		assert.is_true(payload:find('"gems": [0, 0, 0, 0]', 1, true) ~= nil)
	end)

	it("keeps the expected top-level JSON shape for empty slots", function()
		local payload = JsonEncoder.EncodeGearEntries({
			{ slot = "HeadSlot", item = nil },
		})

		assert.is_true(payload:sub(1, 1) == "{")
		assert.is_true(payload:sub(-1) == "}")
		assert.is_true(payload:find('"HeadSlot": null', 1, true) ~= nil)
	end)

	it("escapes quotes in item names", function()
		local payload = JsonEncoder.EncodeGearEntries({
			{
				slot = "MainHandSlot",
				item = {
					name = 'The "Great" Weapon, Not Thunderfury, Blessed Blade of the Windseeker',
					id = 28393,
					enchantId = 27977,
					gems = { 0, 0, 0, 0 },
				},
			},
		})

		assert.is_true(payload:find('The \\"Great\\" Weapon', 1, true) ~= nil)
	end)
end)
