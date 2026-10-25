-- blink.lua
-- =======================================================================
-- NOTE:
-- Recompile fuzzy rust after an update.
--
-- cd ~/.local/share/neomin/site/pack/core/opt/blink.cmp
-- git pull
-- cargo build --release
--
-- If using LuaSnip engine, don't forget to "recompile" it also.
--
-- cd ~/.local/share/neomin/site/pack/core/opt/LuaSnip
-- make install_jsregexp
--
-- Supported snippet engines:
-- 1. vim.snippet (default)
-- 2. mini.snippet
-- 3. LuaSnip
--
-- For more info on how to set a snipped engine, see
-- https://main.cmp.saghen.dev/configuration/snippets
--
-- To add more snippest in case [2], copy snippets folder from the
-- friendly-snippets repo into any location in `runtimepath`
-- The repo is located in
-- $HOME/.local/share/neoslim/site/pack/core/opt/friendly-snippets/
-- =======================================================================

-- Adicionar os plugins necessários
vim.pack.add({
  { src = "https://github.com/saghen/blink.cmp", version = "v1.6.0" },
  { src = "https://github.com/rafamadriz/friendly-snippets" },
  -- { src = "https://github.com/L3MON4D3/LuaSnip" },
  -- { src = "https://github.com/folke/lazydev.nvim" },
})

-- Configuração principal do blink.cmp
local blink = require("blink.cmp")
blink.setup({
  -- 'default' (recomendado) para mapeamentos similares aos completions built-in (C-y para aceitar)
  -- Todos os presets têm os seguintes mapeamentos:
  -- C-space: Abrir menu ou abrir docs se já estiver aberto
  -- C-n/C-p ou Up/Down: Selecionar próximo/anterior item
  -- C-e: Esconder menu
  -- C-k: Toggle signature help (se signature.enabled = true)
  --
  -- Veja :h blink-cmp-config-keymap para definir seu próprio keymap
  keymap = {
    preset = "default",
    ["<C-n>"] = { "show", "select_next", "fallback" },
    ["<C-p>"] = { "show", "select_prev", "fallback" },
    ["<C-l>"] = { "snippet_forward", "fallback" },
    ["<C-h>"] = { "snippet_backward", "fallback" },
    ["<C-u>"] = { "scroll_documentation_up", "fallback" },
    ["<C-d>"] = { "scroll_documentation_down", "fallback" },
  },

  cmdline = {
    keymap = { preset = "inherit" },
    completion = { menu = { auto_show = true } },
  },

  appearance = {
    nerd_font_variant = "mono",
    kind_icons = {
      Text = "",
      Method = "m",
      Function = "",
      Constructor = "",

      Field = "",
      Variable = "",
      Property = "",

      Class = "",
      Interface = "",
      Struct = "",
      Module = "",

      Unit = "",
      Value = "",
      Enum = "",
      EnumMember = "",

      Keyword = "",
      Constant = "",

      Snippet = "",
      Color = "",
      File = "",
      Reference = "",
      Folder = "",
      Event = "",
      Operator = "",
      TypeParameter = "",
    },
  },

  -- Apenas mostrar o popup de documentação quando manualmente acionado (padrão)
  completion = {
    trigger = {
      show_on_keyword = false,
      show_on_trigger_character = true,
    },
    documentation = {
      auto_show = true,
      -- Don't use treesitter in the hightlight
      treesitter_highlighting = false,
    },
    menu = {
      auto_show = true,
      draw = {
        columns = {
          { "kind_icon", "kind", gap = 1 },
          { "label", "label_description", gap = 1, "source_name" },
        },
        -- From recipies: https://cmp.saghen.dev/recipes.html#completion-menu-drawing
        components = {
          kind_icon = {
            text = function(ctx)
              local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
              return kind_icon
            end,
            -- (optional) use highlights from mini.icons
            highlight = function(ctx)
              local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
              return hl
            end,
          },
          kind = {
            -- (optional) use highlights from mini.icons
            highlight = function(ctx)
              local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
              return hl
            end,
          },
        },
      },
    },
  },

  -- Lista padrão de providers habilitados
  sources = {
    -- default = { "lsp", "path", "snippets", "buffer", "lazydev" },
    default = { "lsp", "path", "snippets", "buffer" },
    -- Desabilitar todas as sources para tex
    per_filetype = {
      tex = { "lsp", "path", "snippets" }, -- sem "buffer"
      plaintex = { "lsp", "path", "snippets" },
      -- markdown = { "lsp", "path", "snippets" },
    },
    providers = {
      -- Engine: vim.snippets
      snippets = {
        opts = {
          search_paths = { vim.fn.stdpath("config") .. "/snippets" },
        },
      }, -- default
    },
  },

  -- Choosing other engines...
  -- snippets = {preset = 'luasnip'}, -- Need to add  {'L3MON4D3/LuaSnip', version = 'v2.*' },
  -- snippets = {preset = 'mini_snippets'}, -- Need to enable `mini.snippets`

  -- Veja a documentação de fuzzy para mais informações
  fuzzy = { implementation = "prefer_rust_with_warning" },

  -- Mostra uma janela de signature help enquanto você digita argumentos para uma função
  signature = { enabled = true },
})
