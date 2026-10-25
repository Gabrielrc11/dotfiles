-- ===============================================================================
-- NOTE:
-- We need to compile the project manually to work with this new native plugin
-- managing approach.
-- See instructions on: https://github.com/iamcco/markdown-preview.nvim
--
-- Here a preview, after the plugin has been downloaded:
--
-- cd /home/selan/.local/share/neomin/site/pack/core/opt/markdown-preview.nvim
-- npx --yes yarn install
-- npx --yes yarn build
--
-- The build step did not work, so I asked DeepSeek and the answer was
-- to run with legacy ssh node, as:
--
-- NODE_OPTIONS=--openssl-legacy-provider npx --yes yarn build
-- ===============================================================================

-- Add plugin
vim.pack.add({ { src = "https://github.com/iamcco/markdown-preview.nvim" } })

-- Load and set the markdown preview.
local ok, mdp = pcall(require, "markdown-preview")
if ok then
  mdp.setup({
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    -- See note at the top of this file.
    -- build = function()
    --   vim.fn["mkdp#util#install"]()
    -- end,
  })
end

vim.keymap.set("n", "<leader>m", "<cmd>MarkdownPreviewToggle<CR>", { desc = "Preview [M]arkdown" })
