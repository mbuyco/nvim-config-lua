local chat = require('CopilotChat')
local prompts = require('CopilotChat.config.prompts')

local COPILOT_PLAN = [[
You are a software architect and technical planner focused on clear, actionable development plans.
]] .. prompts.COPILOT_BASE.system_prompt .. [[

When creating development plans:
- Start with a high-level overview
- Break down into concrete implementation steps
- Identify potential challenges and their solutions
- Consider architectural impacts
- Note required dependencies or prerequisites
- Estimate complexity and effort levels
- Track confidence percentage (0-100%)
- Format in markdown with clear sections

Always end with:
"Current Confidence Level: X%"
]]

local COPILOT_REVIEW = [[
I want you to act as a Code reviewer who is experienced developer in the given code language. I will provide you with the code block or methods or code file along with the code language name, and I would like you to review the code and share the feedback, suggestions and alternative recommended approaches. Please write explanations behind the feedback or suggestions or alternative approaches. Reply in English using technical tone for developers.
]] .. prompts.COPILOT_BASE.system_prompt

local COPILOT_COMMIT = [[
You are a software engineer who is an expert in writing clear, concise commit messages.
]] .. prompts.COPILOT_BASE.system_prompt .. [[

When writing commit messages:
- Focus on the "why" behind the change, not just the "what"
- Use the imperative mood (e.g., "Fix bug" instead of "Fixed bug")
- Keep the subject line under 50 characters
- Format in markdown with clear sections
- Always end with a summary of the changes made
- Use bullet points for multiple changes or explanations
- Sort bullet points in alphabetical order for clarity
]]

chat.setup({
  prompts = {
    Commit = {
      mapping = '<leader>cc',
      system_prompt = COPILOT_COMMIT,
    },
    Optimize = {
      mapping = '<leader>co',
      context = 'buffer',
    },
    Review = {
      system_prompt = COPILOT_REVIEW,
      mapping = '<leader>cr',
      context = {
        'file:.copilot/review.md',
        'buffer',
      },
      progress = function()
        return false
      end,
      callback = function(response, source)
        chat.chat:append('Review completed successfully!', source.winnr)
        local review_file = source.cwd() .. '/.copilot/review.md'
        local dir = vim.fn.fnamemodify(review_file, ':h')
        vim.fn.mkdir(dir, 'p')
        local file = io.open(review_file, 'w')
        if file then
          file:write(response)
          file:close()
        end
      end,
    },
    Plan = {
      prompt = 'Create or update the development plan for the selected code. Focus on architecture, implementation steps, and potential challenges.',
      system_prompt = COPILOT_PLAN,
      mapping = '<leader>cp',
      context = 'file:.copilot/plan.md',
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
