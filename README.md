# monospec

A monorepo for storing [OpenSpec](https://github.com/Fission-AI/OpenSpec) directories across multiple projects. Each project gets its own `openspec/` directory here, symlinked from the project's working directory.

## Install

Clone this repo, then run:

```bash
bash install.sh
source ~/.bashrc  # or ~/.zshrc
```

This symlinks the `monospec` CLI to `~/.local/bin` and sets `MONOSPEC_ROOT` in your shell config.

## Usage

From inside any project directory:

```bash
monospec init [project-name] [openspec-init-flags]
```

- `project-name` defaults to the current directory name
- Any additional flags are passed through to `openspec init` (e.g. `--tools claude`)

This will:
1. Create `$MONOSPEC_ROOT/projects/<project-name>/openspec/`
2. Symlink `./openspec` in your project to that directory
3. Run `openspec init` to scaffold the openspec structure

## Requirements

- [OpenSpec](https://github.com/Fission-AI/OpenSpec) must be installed (`openspec` available in PATH)
