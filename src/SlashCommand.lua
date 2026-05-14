---@class SlashCommandBootstrap
---@field buildDependencies fun(): table Internal dependency wiring for the export command.

local addonName, ns = ...

---@return table
local function buildDependencies()
	return {
		parser = ns.ItemLinkParser,
		itemInfoProvider = ns.ItemInfoProvider,
		slotProfiles = ns.SlotProfiles,
		flavor = ns.flavor,
	}
end

---@return nil
local function exportGearToJson()
	local snapshot, snapshotError = ns.GearSnapshotService.BuildSnapshot(buildDependencies())
	if not snapshot then
		if type(snapshotError) == "string" and snapshotError:find("cache miss", 1, true) then
			print(
				"|cffff9900YouAreNowPrepared:|r Item info is still loading. Try /exportgearjson again in 1-2 seconds."
			)
			return
		end

		print("|cffff0000YouAreNowPrepared:|r Export failed (" .. tostring(snapshotError) .. ").")
		return
	end

	local jsonOutput = ns.JsonEncoder.EncodeGearEntries(snapshot)
	ns.ExportFrame.Show(jsonOutput)
end

SLASH_YANP1 = "/exportgearjson"
SlashCmdList.YANP = exportGearToJson

print("|cff33ff99YouAreNowPrepared:|r Loaded for " .. tostring(ns.flavor) .. ". Use /exportgearjson")
