local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")

if not status_ok then
  vim.notify("Unable to load TreeSitter")
  return
end

treesitter.setup({
  -- ensure_installed = { "cpp", "vim", "lua", "python", "rust", "javascript", "html", "css", "json", "toml" },
  ensure_installed = "all",
  matchup = {
    enable = true,
  },
  autopairs = { 
    enable = true,
  },
  highlight = {
    disable = { "css" },
    additional_vim_regex_highlighting = true,
  },
  indent = { enable = true },
  incremental_selection = { enable = true },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  rainbow = {
    enable = true,
    disable = { "html" },
    extended_mode = false,
    max_file_lines = nil,
  },
  autotag = { enable = true },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["of"] = "@function.outer",
        ["if"] = "@function.inner",
        ["oc"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        ["]f"] = "@function.outer",
        ["]c"] = "@class.outer",
      },
      goto_next_end = {
        ["]F"] = "@function.outer",
        ["]C"] = "@class.outer",
        ["]/"] = "@comment.outer",
      },
      goto_previous_start = {
        ["[f"] = "@function.outer",
        ["[c"] = "@class.outer",
      },
      goto_previous_end = {
        ["[F"] = "@function.outer",
        ["[C"] = "@class.outer",
        ["[/"] = "@comment.outer",
      },
    },
    swap = {
      enable = false,
    },
  },
})
