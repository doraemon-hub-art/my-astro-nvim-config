return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters = {
        -- 覆盖社区包自带的 clang_format 配置
        clang_format = {
          -- 关键点：强制指定你的自定义配置文件路径
          prepend_args = function()
            -- 拼接出你的绝对路径：~/.config/nvim/my_config/.clang-format
            local custom_path = vim.fn.stdpath("config") .. "/my_config/.clang-format"
            -- 返回参数：-style=file:<路径>
            -- 这会告诉 clang-format 忽略项目目录，强制使用这个文件
            return { "-style=file:" .. custom_path }
          end,
        },
      },
    },
  },
}
