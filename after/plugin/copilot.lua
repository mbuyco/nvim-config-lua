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

local PHP_REVIEW = [[
I want you to also support reviewing PHP code.
Please provide feedback on the code, including:
- Code quality and readability
- Best practices and standards
- Performance optimizations
- Security considerations
- Compatibility with PHP versions ^7.1 and ^8.0
]]

local COPILOT_REVIEW = [[
I want you to act as a Code reviewer who is experienced developer in the given code language. I will provide you with the code block or methods or code file along with the code language name, and I would like you to review the code and share the feedback, suggestions and alternative recommended approaches. Please write explanations behind the feedback or suggestions or alternative approaches. Reply in English using technical tone for developers.
]] .. PHP_REVIEW .. prompts.COPILOT_BASE.system_prompt

local COPILOT_DOES_MY_CODE_SUCK = [[
I want you to act like a php interpreter. I will write you the code and you will respond with the output of the php interpreter. I want you to only reply with the terminal output inside one unique code block, and nothing else. do not write explanations. Do not type commands unless I instruct you to do so. When i need to tell you something in english, i will do so by putting text inside curly brackets {like this}. My first command is <?php echo ‘Current PHP version: ‘ . phpversion(); Reply in English using technical tone for developers.
]]

local COPILOT_COMMIT = [[
Write concise, informative commit messages: Start with a summary in imperative mood, explain the 'why' behind changes, keep the summary under 50 characters, use bullet points for multiple changes, avoid using the word refactor, instead explain what was done, and reference related issues or tickets. What you write will be passed to git commit -m "[message]"').
Wrap code with backticks (e.g. variable names, function names, etc.) for clarity.
Sort bullet points alphabetically.
Keep summary and body lowercase for consistency.
]] .. prompts.COPILOT_BASE.system_prompt

chat.setup({
  prompts = {
    DoesMyCodeSuck = {
      prompt = 'Does my code suck?',
      mapping = '<leader>ci',
      system_prompt = COPILOT_DOES_MY_CODE_SUCK,
      context = 'buffer',
    },
    Commit = {
      prompt = [[
        Write commit message for the change using Conventional Commits 1.0.0 specification.
      ]],
      mapping = '<leader>cm',
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
