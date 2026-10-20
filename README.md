# nvim-config-lua

My custom configuration for Neovim IDE.

Currently the configuration mainly supports PHP development. This repository will evolve overtime to support programming languages that I will be using in my day-to-day work.

## Local LLM autocomplete (minuet-ai.nvim + Ollama)

Inline ghost-text completion from a local model, configured in `lua/plugins/minuet.lua`.

Prerequisites:

```sh
ollama serve
ollama pull qwen2.5-coder:1.5b
```

Model, endpoint, delay (`debounce_ms`, default 300), filetypes and keymaps live in the `settings` table at the top of `lua/plugins/minuet.lua`. Set any keymap to `false` to disable it.

| Mode   | Key             | Action                                  |
|--------|-----------------|-----------------------------------------|
| insert | `<leader><Tab>` | Accept suggestion                       |
| insert | `<M-C-Right>`   | Accept one line                         |
| insert | `<M-C-Down>`    | Accept N lines (prompts for count)      |
| insert | `<M-]>`         | Next suggestion (requests one if none)  |
| insert | `<M-[>`         | Previous suggestion                     |
| insert | `<C-]>`         | Dismiss                                 |
| insert | `<M-\>`        | Request suggestion now                  |
| normal | `<leader>at`    | Toggle auto-trigger for current buffer  |
| normal | `<leader>am`    | Change model                            |

Alt keys require the terminal to send Option as Meta.
