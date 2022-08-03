<!-- markdown lint configuration, can be separated into .markdownlint.json -->
<!-- Multiple Headings with same Content -->
<!-- markdownlint-disable-file MD024 -->
<!-- top 2 level with = and -, others with # -->
<!-- markdownlint-configure-file {
  "MD003": { "style": "setext_with_atx" }
} -->
Changelog
===

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

Types of changes:

- `Added` for new features.
- `Changed` for changes in existing functionality.
- `Deprecated` for soon-to-be removed features.
- `Removed` for now removed features.
- `Fixed` for any bug fixes.
- `Security` in case of vulnerabilities.

[Unreleased]
---

- Announce things to come here

[0.4.0] - 2022-08-03
---

### Added

- `cmd/git-pull-push-interactive.cmd` as an interactive wrapper for `cmd/git-pull-push.cmd`

[0.3.0] - 2022-08-01
---

### Added

- `cmd/create-conda-python-versions.cmd` to download python versions

[0.2.0] - 2022-07-30
---

### Changed

- Error levels to CMD for committing and pushing folders

[0.1.0] - 2022-07-29
---

### Added

- CMD for committing and pushing folders
