---@class ExportFrame
---@field Show fun(jsonOutput:string) Shows the JSON in a copyable UI frame when possible.

local _, ns = ...

local ExportFrame = {}

local frame
local editBox

---@return nil
local function ensureFrame()
	if frame or type(CreateFrame) ~= "function" then
		return
	end

	local frameTemplate = BackdropTemplateMixin and "BackdropTemplate" or nil
	frame = CreateFrame("Frame", "YANPJSONFrame", UIParent, frameTemplate)
	frame:SetSize(460, 340)
	frame:SetPoint("CENTER")
	frame:SetFrameStrata("DIALOG")
	if frame.SetBackdrop then
		frame:SetBackdrop({
			bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
			edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
			tile = true,
			tileSize = 32,
			edgeSize = 32,
			insets = { left = 8, right = 8, top = 8, bottom = 8 },
		})
	end
	frame:Hide()

	local scrollArea = CreateFrame("ScrollFrame", "YANPJSONScroll", frame, "UIPanelScrollFrameTemplate")
	scrollArea:SetPoint("TOPLEFT", 14, -16)
	scrollArea:SetPoint("BOTTOMRIGHT", -34, 44)

	editBox = CreateFrame("EditBox", nil, scrollArea)
	editBox:SetMultiLine(true)
	editBox:SetAutoFocus(false)
	if GameFontHighlightSmall then
		editBox:SetFontObject(GameFontHighlightSmall)
	end
	editBox:SetWidth(390)
	editBox:SetScript("OnEscapePressed", function()
		frame:Hide()
	end)
	scrollArea:SetScrollChild(editBox)

	local closeButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
	closeButton:SetSize(100, 22)
	closeButton:SetPoint("BOTTOM", 0, 12)
	closeButton:SetText("Close")
	closeButton:SetScript("OnClick", function()
		frame:Hide()
	end)
end

---@param jsonOutput string
function ExportFrame.Show(jsonOutput)
	ensureFrame()

	if not frame or not editBox then
		if type(print) == "function" then
			print(jsonOutput)
		end
		return
	end

	frame:Show()
	editBox:SetText(jsonOutput)
	editBox:HighlightText()
	editBox:SetFocus()
end

if ns then
	ns.ExportFrame = ExportFrame
else
	return ExportFrame
end
