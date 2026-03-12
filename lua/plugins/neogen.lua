return {
  "danymat/neogen",
  dependencies = "nvim-treesitter/nvim-treesitter",
  opts = {
    enabled = true,
    languages = {
      cpp = {
        template = {
          annotation_convention = "doxygen",
        },
      },
    },
  },
  keys = {
    { "<Leader>dg", function() require("neogen").generate() end, desc = "生成函数注释" },
    -- 文件注释在astrocore.lua中
  },
}
