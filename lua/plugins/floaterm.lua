if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE
return {
  "nvzone/floaterm",
  dependencies = {
    { "nvzone/volt", lazy = true },
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          -- Normal 模式映射
          n = {
            ["<C-t>"] = { "<cmd>FloatermToggle<cr>", desc = "Toggle Floaterm" },
            ["<leader>fn"] = { "<cmd>FloatermNew<cr>", desc = "New Floaterm" },
            ["<leader>fj"] = { "<cmd>FloatermNext<cr>", desc = "Next Floaterm" },
            ["<leader>fk"] = { "<cmd>FloatermPrev<cr>", desc = "Previous Floaterm" },
          },
          -- Terminal 模式映射 (确保你在终端里也能随时用 Ctrl+t 关掉)
          t = {
            ["<C-t>"] = { "<cmd>FloatermToggle<cr>", desc = "Toggle Floaterm" },
          },
        },
      },
    },
  },
  cmd = { "FloatermToggle", "FloatermNew", "FloatermNext", "FloatermPrev" },
  opts = {
    border = true,
    size = { h = 70, w = 90 },
  },
}
