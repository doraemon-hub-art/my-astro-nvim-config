-- lua/plugins/avante.lua
if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE
return {
  {
    "yetone/avante.nvim",
    opts = {
      provider = "deepseek", -- 告诉 avante 使用下面定义的 deepseek
      auto_suggestions_provider = "deepseek",
      system_prompt = "You must always respond in Chinese.",  -- default language
      -- 使用 providers 替代已弃用的 vendors
      providers = {
        deepseek = {
          __inherited_from = "openai", -- 必须有这一行，否则它不知道怎么发请求
          endpoint = "https://api.deepseek.com",
          model = "deepseek-v4-flash", -- 注意：目前官方是 deepseek-chat 或 deepseek-reasoner，没有 v4-flash
          api_key_name = "DEEPSEEK_API_KEY", -- 建议写变量名，然后在系统里设置
          timeout = 30000,
          max_tokens = 4096,
          extra_request_body = {
            temperature = 0,
            max_tokens = 4096,
            thinking = { type = "disabled" }, -- disable thinking for deepseek-v4-flash
          }
        },
      },
      behaviour = {
        -- 关闭自动应用 diff，避免 AI 生成的代码直接写入文件，给你审查的机会
        auto_apply_diff_after_generation = false, -- 建议设为 false
        -- 关闭工具自动批准，AI 每次使用工具（创建/修改文件、执行命令等）都需要你手动确认
        auto_approve_tool_permissions = false, -- 设为 false 可阻止 AI 直接写入文件; 设为 true 则 AI 可自动执行工具操作
        -- 移除未变更的行，让 diff 更清晰
        minimize_diff = true,
        -- diff 确认 UI 风格：inline_buttons（侧边栏内联按钮）或 popup（弹窗）
        confirmation_ui_style = "inline_buttons",
      },
      diff = {
        autojump = true,           -- 自动跳转到 diff 位置
        override_timeoutlen = 500, -- 避免进入操作符等待模式
      },
    },
  }
}
