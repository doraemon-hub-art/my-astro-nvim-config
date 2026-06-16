-- ~/.config/nvim/lua/plugins/codecompanion.lua

return {
  {
    "olimorris/codecompanion.nvim",
    opts = function(_, opts)
      opts.strategies = {
        chat = { adapter = "deepseek" },
        inline = { adapter = "deepseek" },
        agent = { adapter = "deepseek" },
      }
      opts.language = "Chinese"
      opts.adapters = opts.adapters or {}
      opts.adapters.deepseek = function()
        return require("codecompanion.adapters").extend("deepseek", {
          env = {
            api_key = "cmd:echo $DEEPSEEK_API_KEY",
          },
          schema = {
            model = {
              default = "deepseek-v4-flash",
            },
          },
          opts = {
            reasoning = false,
          }
        })
      end

      return opts
    end,
  },
}
