# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.2] - 2026-05-13

### Fixed
- TOC filename suffixes corrected to `_Vanilla` and `_TBC` — addon now appears in the addon list and slash commands work in both Classic Era and TBC clients
- Interface version bumped to 11508 (Classic Era) and 20505 (TBC)

### Changed
- CI consolidated into a single `ci.yml`; packaging is gated behind the test job
- Release workflow changed to tag-triggered (`v*`) — versioned zips are now attached directly to each GitHub release
- Duplicate slot tables in `SlotProfiles.lua` collapsed into a single shared table

### Added
- Full unit test coverage for `GearSnapshotService` (16 tests total)

## [1.0.1] - 2026-05-12

### Added
- Initial public release
- Classic Era and TBC flavor support
- Gear snapshot with item link parsing
- JSON export of equipped gear
- `/ynp` slash command

[1.0.2]: https://github.com/operatr/you-are-now-prepared/compare/v1.0.1...v1.0.2
[1.0.1]: https://github.com/operatr/you-are-now-prepared/releases/tag/v1.0.1
