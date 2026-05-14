# You Are Now Prepared

You Are Now Prepared is a World of Warcraft addon that exports your currently equipped gear to copyable JSON.

It includes item IDs, enchant IDs, and gem IDs for each equipped slot.

Supported game versions:
- World of Warcraft Classic Era
- World of Warcraft TBC Classic

Not supported:
- Retail WoW

## Player guide

### Supported clients

- `YouAreNowPrepared_Vanilla.toc` for Classic Era
- `YouAreNowPrepared_TBC.toc` for TBC Classic

Retail is intentionally out of scope for this repository right now.

### Install

1. Download the ZIP for the client you play from Releases.
2. Extract it into your addons folder so the addon folder sits directly under `Interface/AddOns`.

	- Classic Era example: `World of Warcraft/_classic_/Interface/AddOns/YouAreNowPrepared/`
	- TBC Classic example: `World of Warcraft/_anniversary_/Interface/AddOns/YouAreNowPrepared/`

3. Enable the addon on the character select screen.

### Use

1. Log in.
2. Type `/exportgearjson` in chat.
3. If item info is still loading, wait a second and run `/exportgearjson` again.
4. Copy the JSON from the popup window.

The command opens a text popup and highlights the JSON automatically so you can copy it immediately.

### Troubleshooting

If the addon is not visible in the AddOns list or `/exportgearjson` does nothing:

1. Verify folder layout is exactly `Interface/AddOns/YouAreNowPrepared/YouAreNowPrepared.toc`.
2. Make sure the ZIP is extracted one level deep (no nested `YouAreNowPrepared/YouAreNowPrepared/` folder).
3. On character select, open AddOns and enable **Load out of date AddOns**.
4. Log in and run `/reload`, then try `/exportgearjson` again.

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

## Feedback

Submit questions, comments, bug reports, pitchforks, and torches to the issue tracker:

- Open an issue on GitHub: `https://github.com/operatr/you-are-now-prepared/issues`

## License

MIT. See `LICENSE`.