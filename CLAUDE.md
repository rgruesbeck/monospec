# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

A monorepo that stores `openspec` directories for multiple projects. Each project gets a subdirectory under `projects/`, and the `monospec` CLI helps initialize new projects by creating the openspec directory here and symlinking it from the project's own working directory.

## Structure

```
projects/<project-name>/openspec/   # managed openspec dirs (symlink targets)
scripts/monospec                    # the CLI (source of truth)
install.sh                          # installs the CLI and sets env vars
```

## Installing

```bash
bash install.sh
source ~/.bashrc  # or ~/.zshrc
```

`install.sh` symlinks `scripts/monospec` to `~/.local/bin/monospec` and writes `MONOSPEC_ROOT` and the PATH entry to the user's shell rc file. Re-running it is safe.

## CLI usage

```bash
# From inside a project directory:
monospec init [project-name] [openspec-init-flags]
```

- `project-name` defaults to the current directory name.
- Any flags after the project name are passed directly to `openspec init` (e.g. `--tools claude`).
- Creates `$MONOSPEC_ROOT/projects/<name>/openspec/`, symlinks `./openspec` to it, then calls `openspec init` to scaffold the openspec structure.

## Adding new subcommands

The CLI is a `case` statement in `scripts/monospec`. Add new commands by adding cases before the `*)` fallthrough. The `shift` at the top of the script has already consumed the subcommand, so `$1`/`$@` inside each case are the subcommand's own arguments.
