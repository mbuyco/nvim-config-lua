return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dap.set_log_level("TRACE")
      dapui.setup()

      -- auto open dapui on dap events
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end

      -- dap adapter configs
      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          args = {
            os.getenv("HOME") .. "/.local/share/js-debug/src/dapDebugServer.js",
            "${port}",
          },
        }
      }
      dap.adapters["chrome"] = {
        type = "executable",
        command = "node",
        args = { os.getenv("HOME") .. "/.local/share/vscode-chrome-debug/out/src/chromeDebug.js" },
      }
      dap.adapters["php"] = {
        type = "executable",
        command = "node",
        args = { os.getenv("HOME") .. "/.local/share/vscode-php-debug/out/phpDebug.js" },
      }

      -- dap launch configs
      local tsConfig = {
        type = "pwa-node",
        request = "launch",
        name = "run_typescript_file",
        cwd = "${workspaceFolder}",
        runtimeExecutable = "npx",
        runtimeArgs = { "-y", "tsx", "${file}" },
        sourceMaps = true,
      }
      local npmRunDevConfig = {
        type = "pwa-node",
        request = "launch",
        name = "npm_run_dev",
        runtimeExecutable = "npm",
        runtimeArgs = { "run", "dev" },
        cwd = "${workspaceFolder}",
        sourceMaps = true,
        console = "integratedTerminal",
        autoAttachChildProcesses = true,
        resolveSourceMapLocations = {
          "${workspaceFolder}/**",
          "!**/node_modules/**",
        },
        skipFiles = {
          "<node_internals>/**",
          "**/node_modules/**",
        },
      }
      local bunRunDevConfig = {
        type = "pwa-node",
        request = "launch",
        name = "run_bun_dev",
        runtimeExecutable = "bun",
        runtimeArgs = { "run", "dev" },
        cwd = "${workspaceFolder}",
        sourceMaps = true,
        console = "integratedTerminal",
        autoAttachChildProcesses = true,
        resolveSourceMapLocations = {
          "${workspaceFolder}/**",
          "!**/node_modules/**",
        },
        skipFiles = {
          "<node_internals>/**",
          "**/node_modules/**",
        },
      }
      local chromeDevConfig = {
        type = "chrome",
        request = "launch",
        name = "launch_chrome",
        host = "localhost",
        port = function()
          local val = vim.fn.input("Enter port number (default 3000): ")
          return tonumber(val) or 3000
        end,
        webRoot = "${workspaceFolder}",
        skipFiles = { "**/node_modules/**" },
      }
      local chromeAstroDevConfig = {
        type = "chrome",
        request = "launch",
        name = "launch_chrome_with_astro_dev_server",
        url = "http://localhost:4321",
        webRoot = "${workspaceFolder}",
        skipFiles = { "**/node_modules/**" },
      }

      -- dap launch configs per language
      dap.configurations.javascript = {
        bunRunDevConfig,
        chromeAstroDevConfig,
        chromeDevConfig,
        npmRunDevConfig,
        tsConfig,
      }
      dap.configurations.typescript = {
        bunRunDevConfig,
        chromeAstroDevConfig,
        chromeDevConfig,
        npmRunDevConfig,
        tsConfig,
      }
      dap.configurations.typescriptreact = {
        bunRunDevConfig,
        chromeAstroDevConfig,
        chromeDevConfig,
        npmRunDevConfig,
        tsConfig,
      }
      dap.configurations.astro = {
        bunRunDevConfig,
        chromeAstroDevConfig,
        chromeDevConfig,
        npmRunDevConfig,
        tsConfig,
      }
      dap.configurations.php = {
        {
          type = "php",
          request = "launch",
           name = "Listen for Xdebug",
           port = 9003,
           log = true,
           pathMappings = {
            ["/var/www/html"] = "${workspaceFolder}",
          },
        }
      }
    end
  },
}
