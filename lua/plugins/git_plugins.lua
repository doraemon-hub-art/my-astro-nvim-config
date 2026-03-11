return {
  -- 插件 1: git-blame.nvim (在行末实时显示提交信息)
  {
    "f-person/git-blame.nvim",
    event = "VeryLazy", -- 延迟加载，不影响启动速度
    opts = {
      enabled = true, -- 默认开启
      message_template = "  󰊢 <author> • <date> • <summary>", -- 自定义显示格式
      date_format = "%Y-%m-%d",
    },
  },

  -- 插件 2: diffview.nvim (超强大的 Git 差异对比工具)
  {
    "sindrets/diffview.nvim",
    event = "VeryLazy",
    cmd = { "DiffviewOpen", "DiffviewClose" }, -- 只有输入命令时才加载
  },
}
