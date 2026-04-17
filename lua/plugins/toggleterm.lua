return {
  "akinsho/toggleterm.nvim",
  keys = {
    -- normal 模式下开/关
    { "<C-\\>", "<cmd>ToggleTerm direction=float<cr>", desc = "Float Terminal" },
    -- terminal 模式下也能关
    { "<C-\\>", "<cmd>ToggleTerm direction=float<cr>", desc = "Float Terminal", mode = "t" },
  },
}

