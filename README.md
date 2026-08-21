# Renovate `gomodTidyAll` graph-cycle reproduction

This repository is a minimal reproduction for a Renovate failure when
`gomodTidyAll` processes a Go monorepo whose local `replace` graph contains a
cycle.

## Module graph

The repository contains three Go modules:

```text
tooling ──▶ service ──▶ app
   ▲          │
   └──────────┘
```

The arrows show how Renovate constructs its graph: a replaced module points to
the module containing the `replace` directive.

- `service/go.mod` requires and replaces `tooling` with `../tooling`.
- `tooling/go.mod` requires and replaces `service` with `../service`.
- `app/go.mod` consumes `service` and provides the local replacements needed
  to build the application.

The Go package imports themselves are acyclic: `service` imports the root
`tooling` package, while the separate `tooling/format` package imports
`service/model`.

## Trigger

`tooling/go.mod` starts with `go.yaml.in/yaml/v3` at `v3.0.4`.
`renovate.json` disables unrelated local-module and Go-toolchain updates, and
enables `gomodTidyAll` for that dependency.

When Renovate updates the dependency to `v3.0.5`, the primary `tooling` module
is updated. Renovate then tries to find the dependent modules that also need
`go mod tidy`.

## Expected behavior

Renovate should update `tooling` and run `go mod tidy` in the reachable
dependent modules, including `service` and `app`.

## Actual behavior

Renovate logs:

```text
WARN: Failed to find dependent Go modules
      Error: Cycle found
```

The dependency graph is passed to `topologicalSort` in its entirety. The cycle
causes sorting to throw before Renovate schedules any dependent-module tidy
commands, leaving the update incomplete.

## Automated reproduction

The `Renovate dry run` GitHub Actions workflow runs Renovate with debug logging
on pushes to `main`, and can also be started manually. It uses
`RENOVATE_DRY_RUN=full` together with read-only repository permissions, so it
exercises the GitHub-platform update path without creating branches or pull
requests.

The graph error is caught and logged by Renovate, so the workflow itself may
still exit successfully. Search its debug output for `Failed to find dependent
Go modules` and `Cycle found`.

## Verify the fixture

Each module can be checked independently:

```sh
go -C tooling test ./...
go -C service test ./...
go -C app test ./...
```
