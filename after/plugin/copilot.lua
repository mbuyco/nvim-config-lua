local chat = require('CopilotChat')
local default_prompts = require('CopilotChat.config.prompts')
local user_prompts = require('prompts')

local review_save_file = function(response, source)
  local review_file = source.cwd() .. '/.copilot/review.md'
  local dir = vim.fn.fnamemodify(review_file, ':h')
  vim.fn.mkdir(dir, 'p')
  local file = io.open(review_file, 'w')
  if file then
    file:write(response)
    file:close()
  end
end

chat.setup({
  prompts = {
    ListAllRelatedFiles = {
      prompt = user_prompts.file_listing_assistant,
      mapping = '<leader>cf',
      context = 'buffer',
    },
    Commit = {
      prompt = default_prompts.Commit.prompt .. [[
        Use imperative mood.
        Use bullet points for multiple changes.
        When mentioning code e.g. function names, class names, or variables, use backticks to format them.
      ]],
      mapping = '<leader>cm',
      system_prompt = user_prompts.commit,
    },
    Optimize = {
      mapping = '<leader>co',
      context = 'buffer',
    },
    PHPReview = {
      prompt = 'Review the provided PHP code.',
      system_prompt = user_prompts.code_review .. user_prompts.php_code_review,
      mapping = '<leader>cpr',
      context = 'buffer',
      progress = function()
        return false
      end,
      callback = function(response, source)
        chat.chat:append('Review completed successfully!', source.winnr)
        review_save_file(response, source)
      end,
    },
    DevopsReview = {
      prompt = 'Review the provided code/configurations.',
      system_prompt = user_prompts.devops_consultant,
      mapping = '<leader>cdr',
      context = 'buffer',
      progress = function()
        return false
      end,
      callback = function(response, source)
        chat.chat:append('Review completed successfully!', source.winnr)
        review_save_file(response, source)
      end,
    },
    Review = {
      prompt = 'Review the provided code.',
      system_prompt = user_prompts.code_review,
      mapping = '<leader>cr',
      context = 'buffer',
      progress = function()
        return false
      end,
      callback = function(response, source)
        chat.chat:append('Review completed successfully!', source.winnr)
        review_save_file(response, source)
      end,
    },
    Plan = {
      prompt = 'Create or update the development plan for the selected code. Focus on architecture, implementation steps, and potential challenges.',
      system_prompt = default_prompts.COPILOT_BASE.system_prompt .. user_prompts.software_architect_plan,
      mapping = '<leader>cp',
      context = {
        'file:.copilot/plan.md',
        'buffer',
      },
      progress = function()
        return false
      end,
      callback = function(response, source)
        chat.chat:append('Plan updated successfully!', source.winnr)
        local plan_file = source.cwd() .. '/.copilot/plan.md'
        local dir = vim.fn.fnamemodify(plan_file, ':h')
        vim.fn.mkdir(dir, 'p')
        local file = io.open(plan_file, 'w')
        if file then
          file:write(response)
          file:close()
        end
      end,
    },
    Changelog = {
      prompt = 'Generate a changelog entry for the latest changes in the project.',
      system_prompt = [[
        You are a changelog generator.
        Write a concise changelog entry for the latest changes in the project.
        Include:
        - Summary of changes
        - New features
        - Bug fixes
        - Improvements
        - Breaking changes
        Use markdown format.
      ]] .. default_prompts.COPILOT_BASE.system_prompt,
      mapping = '<leader>cl',
      context = 'git:staged',
    },
  },
})

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = 'copilot-*',
  callback = function()
    vim.keymap.set('n', '<C-l>', '<C-w>l', { buffer = true, silent = true, noremap = true })
    vim.keymap.set('i', '<C-l>', '<C-w>l', { buffer = true, silent = true, noremap = true })
    vim.cmd('vertical resize 69')
  end
})

vim.api.nvim_set_keymap('i', '<leader><Tab>', 'copilot#Accept("\\<CR>")', { silent = true, expr = true, script = true })
vim.g.copilot_no_tab_map = true
