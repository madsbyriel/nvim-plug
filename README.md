# C# Debugging & Test Running

## Debugging (nvim-dap + netcoredbg)

| Keymap | Action |
|---|---|
| `<leader>db` | Toggle breakpoint |
| `<leader>dc` | Continue / start debugging |
| `<leader>dj` | Step over |
| `<leader>dl` | Step into |
| `<leader>dt` | Terminate session |
| `<leader>dr` | Toggle DAP REPL |
| `<leader>du` | Toggle dap-ui (scopes/watches/breakpoints/stacks/repl) |
| `<leader>de` | Evaluate/hover the variable under the cursor |

`<leader>du` is what fixes object enumeration: it opens a tree view where you can expand nested properties and collections. `nvim-dap-virtual-text` also shows variable values inline next to the code while stepping.

**Known limitation:** netcoredbg can't evaluate LINQ or other compiled expressions in watches/hover (e.g. `list.Where(x => x.Id == 1)` will fail). Plain member access, indexing, and browsing objects/collections in the dap-ui tree works fine.

### Project config: `.nvim-dap.json`

Drop a `.nvim-dap.json` in your project root to control the "Launch" config:

```json
{
  "cwd": "src/MyApp",
  "program": "src/MyApp/bin/Debug/net8.0/MyApp.dll",
  "args": ["--some-flag"],
  "stopAtEntry": false,
  "env": { "ASPNETCORE_ENVIRONMENT": "Development" }
}
```

All keys are optional. If `program` is missing/not found, it auto-detects `bin/Debug/net*/<project>.dll`, falling back to a manual path prompt if that fails too. `env` is merged on top of the default `ASPNETCORE_ENVIRONMENT=Development`.

There's also an "Attach" config (pick a running process to attach to).

## Tests (neotest + neotest-dotnet)

| Keymap | Action |
|---|---|
| `<leader>tt` | Run nearest test |
| `<leader>td` | Debug nearest test (launches via the same netcoredbg adapter) |
| `<leader>tf` | Run all tests in the current file |
| `<leader>to` | Open test output panel |
| `<leader>ts` | Toggle test summary tree (gutter pass/fail signs also appear automatically) |

## Typical workflow

1. Open a C# file, set a breakpoint with `<leader>db`.
2. `<leader>dc` to launch (uses `.nvim-dap.json` if present, else auto-detects the build output).
3. When it stops at the breakpoint, `<leader>du` opens the variable tree — expand objects/collections there. Step with `<leader>dj`/`<leader>dl`.
4. For tests: open a test file, `<leader>tt` to run the nearest test (gutter shows pass/fail), or `<leader>td` to debug it and hit your breakpoints.
