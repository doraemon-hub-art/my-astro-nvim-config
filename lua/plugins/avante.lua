-- lua/plugins/avante.lua
return {
  {
    "yetone/avante.nvim",
    opts = {
      provider = "deepseek", -- 告诉 avante 使用下面定义的 deepseek
      auto_suggestions_provider = "deepseek",
      system_prompt = "You must always respond in Chinese.",  -- default language
      -- 重点：必须包在 vendors 里面
      vendors = {
        deepseek = {
          __inherited_from = "openai", -- 必须有这一行，否则它不知道怎么发请求
          endpoint = "https://api.deepseek.com",
          model = "deepseek-v4-flash", -- 注意：目前官方是 deepseek-chat 或 deepseek-reasoner，没有 v4-flash
          api_key_name = "OPENAI_API_KEY", -- 建议写变量名，然后在系统里设置
          timeout = 30000,
          temperature = 0,
          max_tokens = 4096,
          extra_request_body = {
            thinking = { type = "disabled" },
          }
        },
      },
    },
  }
}
