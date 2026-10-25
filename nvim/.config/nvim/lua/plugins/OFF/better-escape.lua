-- [1] Install plugin
vim.pack.add({ { src = "https://github.com/max397574/better-escape.nvim" } })

-- [2] Setup plugin
require("better_escape").setup({
  timeout = vim.o.timeoutlen, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
  default_mappings = false,
  mappings = {
    i = {
      j = {
        -- These can all also be functions
        k = "<Esc>",
        j = "<Esc>",
      },
    },
    c = {
      j = {
        k = "<Esc>",
        j = "<Esc>",
      },
    },
    t = {
      j = {
        k = "<C-\\><C-n>",
      },
    },
    v = {
      j = {
        k = "<Esc>",
      },
    },
    s = {
      j = {
        k = "<Esc>",
      },
    },
  },
})
