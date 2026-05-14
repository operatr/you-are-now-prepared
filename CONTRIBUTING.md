# Contributing

Thanks for helping maintain You Are Now Prepared.

## Release artifacts

- Push to `main` for continuous builds, or tag a release like `v1.0.1` for stable builds.
- GitHub Actions produces one ZIP per client:
	- `YouAreNowPrepared-ClassicEra-*.zip`
	- `YouAreNowPrepared-ClassicTBC-*.zip`

## Auto updates via GitHub Actions

- On every push to `main`, workflow `.github/workflows/auto-release.yml` builds two artifacts: `YouAreNowPrepared-ClassicEra-continuous.zip` and `YouAreNowPrepared-ClassicTBC-continuous.zip`.
- On version tags like `v1.2.0`, workflow `.github/workflows/release-on-tag.yml` publishes two tagged artifacts with the tag in the filename.
- Both workflows rewrite the packaged `## Version` field from the build tag or commit so the release metadata matches the artifact.

## Commands

- `/exportgearjson` - Build and show current gear loadout as copyable JSON.

## Release quickstart

- Continuous build: push to `main`.
- Stable build: create and push a version tag:

```bash
git tag v1.0.1
git push origin v1.0.1
```

## Project layout

- `src/SlotProfiles.lua` flavor-driven slot definitions
- `src/ItemLinkParser.lua` item-link parsing
- `src/ItemInfoProvider.lua` WoW item-info adapter
- `src/GearSnapshotService.lua` snapshot orchestration
- `src/JsonEncoder.lua` deterministic JSON encoding
- `src/ExportFrame.lua` UI output frame
- `src/SlashCommand.lua` command wiring

## Module map

### Startup path

1. WoW loads the TOC in order.
2. `src/Namespace.lua` creates the shared `ns` table.
3. `src/Flavor.ClassicEra.lua` or `src/Flavor.ClassicTBC.lua` sets the active flavor.
4. `src/SlashCommand.lua` wires `/exportgearjson` and kicks off the export flow.

### Export flow

1. `src/SlashCommand.lua` builds the dependency table.
2. `src/GearSnapshotService.lua` walks the slot list for the active flavor.
3. `src/ItemLinkParser.lua` extracts IDs from each item link.
4. `src/ItemInfoProvider.lua` asks WoW for the item name.
5. `src/JsonEncoder.lua` turns the snapshot into JSON.
6. `src/ExportFrame.lua` displays the final text in a copyable window.

### Supporting pieces

- `src/SlotProfiles.lua` keeps slot lists per client flavor.
- `src/Namespace.lua` is the shared module registry.
- `spec/*.lua` exercises parser, slot, and JSON behavior.

## Testing

Run locally:

```bash
luarocks install busted
eval "$(luarocks path)"
busted spec
```

## Style

- Lua indentation uses tabs.
- Formatter config is in `stylua.toml`.
- Editor defaults are in `.editorconfig`.

## Notes

- `## Interface` values may need to be bumped for current patch levels.
