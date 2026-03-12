-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    -- 配置安装这几种语言的语法解析器
    ensure_installed = {
      "lua",
      "vim",
      "doxygen", -- doxygen comment highlight
      -- add more arguments for adding more treesitter parsers
    },
  },
}
