# nvim-config-lua

My custom configuration for Neovim IDE.

Currently the configuration mainly supports PHP development. This repository will evolve overtime to support programming languages that I will be using in my day-to-day work.

## Ollama Copilot setup

Dependencies are installed during plugin build with config venv python:

`~/.config/nvim/venv/bin/python3 -m pip install pygls<2.0.0 ollama`

Run:

`nvim --headless "+Lazy! build Ollama-Copilot" +qa`
