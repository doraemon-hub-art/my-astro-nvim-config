-- lua/plugins/avante.lua
return {
  {
    "yetone/avante.nvim",
    opts = {
      -- 1. 指定使用 openai 协议但指向 deepseek
      provider = "openai",
      auto_suggestions_provider = "openai", -- 自动补全也用它
      openai = {
        endpoint = "https://api.deepseek.com",
        model = "deepseek-v4-flash", -- 或者 "deepseek-coder"
        timeout = 30000, -- 毫秒
        temperature = 0,
        max_tokens = 4096,
        extra_request_body = {
          thinking = { type = "disabled" },
        }
        -- add api key in ~/.bashrc 
        -- export OPENAI_API_KEY="你的_DeepSeek_API_Key"
      },
    },
  },
}
