# You Are Now Prepared

Exports equipped player gear to JSON with gems and enchants.

## Player guide

### Supported clients

- `YouAreNowPrepared_ClassicEra.toc` for Classic Era
- `YouAreNowPrepared_ClassicTBC.toc` for TBC Classic

Retail is intentionally out of scope for this repository right now.

### Install

1. Download the ZIP for the client you play from Releases.
2. Extract it into your addons folder so the addon folder sits directly under `Interface/AddOns`.

	- Classic Era example: `World of Warcraft/_classic_/Interface/AddOns/YouAreNowPrepared-ClassicEra/`
	- TBC Classic example: `World of Warcraft/_classic_/Interface/AddOns/YouAreNowPrepared-ClassicTBC/`

3. Enable the addon on the character select screen.

### Use

1. Log in.
2. Type `/exportgearjson` in chat.
3. If item info is still loading, wait a second and run `/exportgearjson` again.
4. Copy the JSON from the popup window.

The command opens a text popup and highlights the JSON automatically so you can copy it immediately.

### Example output

```json
{
	"MainHandSlot": {
		"name": "Not Thunderfury, Blessed Blade of the Windseeker",
		"id": 19019,
		"enchant_id": 0,
		"gems": [0, 0, 0, 0]
	}
}
```

## For contributors

Maintainer and development documentation lives in `CONTRIBUTING.md`.

## License

MIT. See `LICENSE`.