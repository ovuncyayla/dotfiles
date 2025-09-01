return {

  "L3MON4D3/LuaSnip",
  config = function()
    local ls = require("luasnip")
    local map = vim.keymap.set

    map({ "i", "s" }, "<C-l>", function()
      ls.jump(1)
    end, { silent = true })
    map({ "i", "s" }, "<C-j>", function()
      ls.jump(-1)
    end, { silent = true })
    map({ "i", "s" }, "<C-k>", function()
      if ls.choice_active() then
        ls.change_choice(1)
      end
    end, { silent = true })

    --require("luasnip.loaders.from_vscode").lazy_load({})
    -- some shorthands...
    local s = ls.snippet
    local sn = ls.snippet_node
    local t = ls.text_node
    local i = ls.insert_node
    local f = ls.function_node
    local c = ls.choice_node
    local d = ls.dynamic_node
    local r = ls.restore_node
    local l = require("luasnip.extras").lambda
    local rep = require("luasnip.extras").rep
    local p = require("luasnip.extras").partial
    local m = require("luasnip.extras").match
    local n = require("luasnip.extras").nonempty
    local dl = require("luasnip.extras").dynamic_lambda
    local fmt = require("luasnip.extras.fmt").fmt
    local fmta = require("luasnip.extras.fmt").fmta
    local types = require("luasnip.util.types")
    local conds = require("luasnip.extras.conditions")
    local conds_expand = require("luasnip.extras.conditions.expand")
    local ft_from_cursor_pos = require("luasnip.extras.filetype_functions").from_cursor_pos

    ls.setup({
      history = true,
      -- Update more often, :h events for more info.
      update_events = "TextChanged,TextChangedI",
      -- Snippets aren't automatically removed if their text is deleted.
      -- `delete_check_events` determines on which events (:h events) a check for
      -- deleted snippets is performed.
      -- This can be especially useful when `history` is enabled.
      delete_check_events = "TextChanged",
      ext_opts = {
        [types.choiceNode] = {
          active = {
            virt_text = { { "choiceNode", "Comment" } },
          },
        },
      },
      -- treesitter-hl has 100, use something higher (default is 200).
      ext_base_prio = 300,
      -- minimal increase in priority.
      ext_prio_increase = 1,
      enable_autosnippets = true,
      -- mapping for cutting selected text so it's usable as SELECT_DEDENT,
      -- SELECT_RAW or TM_SELECTED_TEXT (mapped via xmap).
      store_selection_keys = "<Tab>",
      -- luasnip uses this function to get the currently active filetype. This
      -- is the (rather uninteresting) default, but it's possible to use
      -- eg. treesitter for getting the current filetype by setting ft_func to
      -- require("luasnip.extras.filetype_functions").from_cursor (requires
      -- `nvim-treesitter/nvim-treesitter`). This allows correctly resolving
      -- the current filetype in eg. a markdown-code block or `vim.cmd()`.
      -- ft_func = function()
      -- 	return vim.split(vim.bo.filetype, ".", true)
      -- end,
      ft_func = ft_from_cursor_pos,
    })

    ls.add_snippets("all", {

      s(
        "Dino",
        fmt("Dinozor{} kaldiramayinca {neyi} gitmis{} burdan", {
          c(1, { t(""), t("lar") }),
          neyi = i(2, "gercegi"),
          c(3, { t(""), t("ler") }),
        })
      ),

      s(
        "au",
        fmt(
          [[
vim.api.nvim_create_autocmd("{}", {{
  group = vim.api.nvim_create_augroup("{}", {{ clear = {} }}),
  pattern = "{}",
  callback = function(ev)
    {}
  end
}})
    ]],
          {
            i(1, "EventName"),
            i(2, "GroupName"),
            c(3, { t("true"), t("false") }),
            i(4, "Pattern"),
            i(5),
          }
        )
      ),
    })

    ls.add_snippets("all", {
      s(
        "defenv",
        fmt("{}=${{{}-{}}}", {
          i(1),
          rep(1),
          i(2),
        })
      ),

      s(
        "allow",
        fmt("#[allow({})]", {
          c(1, {
            t(""),
            t("dead_code"),
            t("unused_imports"),
          }),
        })
      ),

      s(
        "derserdeb",
        fmt("#[derive({})]", {
          c(1, {
            t(""),
            t("Serialize, Deserialize, Debug"),
          }),
        })
      ),
    })

    ls.add_snippets("javascript", {
      s(
        "typ",
        fmt("/** @type {} **/", {
          i(1),
        })
      ),
      s(
        "typort",
        fmt("/** @type import('{}').{} **/", {
          i(1),
          i(2),
        })
      ),
    })
  end,
}
