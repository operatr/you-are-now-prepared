---@class YANPNamespace
---@field name string Addon name passed in by WoW.
---@field version string Semantic version string for the addon.
---@field flavor string Client flavor identifier: classic_era or classic_tbc.
---@field SlotProfiles table Module table for slot lists.
---@field ItemLinkParser table Module table for item-link parsing.
---@field ItemInfoProvider table Module table for item info lookups.
---@field JsonEncoder table Module table for JSON output.
---@field GearSnapshotService table Module table for assembling gear snapshots.
---@field ExportFrame table Module table for the copyable UI frame.

local addonName, ns = ...

ns.name = addonName
ns.version = "1.0.0"
ns.flavor = ns.flavor or "classic_era"
