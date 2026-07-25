# ECS Release Process

> All workflows are triggered from the [Actions tab](https://github.com/elastic/ecs/actions).

## Overview

| Phase | Workflow | Input | RM actions |
|---|---|---|---|
| Feature Freeze | `ecs-release-ff.yml` | `version` | Approve PRs |
| RC Cut | `ecs-release-rc.yml` | `version`, `rc_number` | Approve version PR |
| Release Preparation | `ecs-release-prep.yml` | `version` | Create docs-builder PR (manual) |
| Release Day | `ecs-release-day.yml` | `version` | Approve PRs, publish release |
| Post-release | `ecs-release-post.yml` | `version` | Resolve flagged items |

Event-driven workflows (no manual trigger):

| Workflow | Trigger | Purpose |
|---|---|---|
| `ecs-release-rc-tag.yml` | RC version PR merged (`release/*/set-rc*`) | Creates and publishes the RC pre-release tag |
| `backport-trigger.yml` | PR merged with `needs_backport` | Posts `/backport` for Mergify |
| `forward-port-trigger.yml` | PR merged with `needs_forward_port` on a release branch | Forward-ports to intermediate release branches |
| `port-label-cleanup.yml` | Port PR opened/labeled (`backport` or `forward_port`) | Removes `needs_backport` / `needs_forward_port` from source PRs once expected port PRs are opened |


## Patch Release (e.g. 9.3.1)

Patch releases use the same five workflows. Only the Feature Freeze step differs.

**Prerequisites**: Release branch (`9.3`) already exists, changes are backported, `CHANGELOG.next.md` entries are present.

### 1. Changelog Cut

**Trigger**: "ECS Release: Feature Freeze" with `version` = `9.3.1`

The workflow detects `patch > 0` and skips branch creation and the main PR. It only creates a changelog cut PR on the release branch (titled `9.3.1` without "Feature Freeze"), labeled `needs_forward_port`.

**RM actions**: Approve and merge the changelog PR, then approve the forward-port PRs.

### 2-5. RC Cut through Post-release

Same as minor release.


## Troubleshooting

| Problem | Fix |
|---|---|
| "Changelog section not found" | Run Feature Freeze / Changelog Cut first; ensure the PR is merged |
| "Outstanding needs_backport PRs" | Ensure expected backport PRs were created; if cleanup automation missed one, remove stale label manually |
| CI not running on bot PR | See [Bot-authored PR CI](#bot-authored-pr-ci) |
| CI fails on auto-generated PR | Push a fix to the PR branch; approvals are preserved |
| Forward-port PR has conflicts | Check out the branch, resolve, push |

All workflows are **idempotent** -- re-running after a partial failure is safe.

