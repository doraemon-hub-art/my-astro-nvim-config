return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local status = require "astroui.status"
    local luv = vim.uv or vim.loop

    local sys_stats = { cpu = "0", mem = "0" }
    local cpu_prev = nil

    -- 读取 /proc/stat 做两次采样差值，得到瞬时 CPU 使用率
    local function get_cpu()
      local f = io.open("/proc/stat")
      if not f then return "?" end
      local line = f:read("*l")
      f:close()

      local vals = {}
      for n in line:gmatch("%d+") do
        vals[#vals + 1] = tonumber(n)
      end

      local idle = vals[4] + (vals[5] or 0) -- idle + iowait
      local total = 0
      for _, v in ipairs(vals) do
        total = total + v
      end

      local cpu_pct = "0"
      if cpu_prev then
        local d_idle = idle - cpu_prev.idle
        local d_total = total - cpu_prev.total
        if d_total > 0 then
          cpu_pct = tostring(math.floor((1 - d_idle / d_total) * 100))
        end
      end
      cpu_prev = { idle = idle, total = total }
      return cpu_pct
    end

    -- 读取 /proc/meminfo，排除 buffer/cache，与 htop 计算方式一致
    local function get_mem()
      local info = {}
      for line in io.lines("/proc/meminfo") do
        local k, v = line:match("^(%w+):%s+(%d+)")
        if k then info[k] = tonumber(v) end
      end

      if not info.MemTotal or info.MemTotal == 0 then return "?" end

      local used = info.MemTotal - info.MemFree - (info.Buffers or 0) - (info.Cached or 0)
      return tostring(math.floor(used / info.MemTotal * 100))
    end

    local function update_stats()
      if vim.fn.has "mac" == 1 then
        local function fetch(cmd, key)
          local handle = io.popen(cmd)
          if handle then
            local res = handle:read("*all"):gsub("%s+", "")
            handle:close()
            if res and res ~= "" then sys_stats[key] = res end
          end
        end
        fetch("ps -A -o %mem | awk '{s+=$1} END {print int(s)}'", "mem")
        fetch("top -l 1 | grep 'CPU usage' | awk '{print $3}' | sed 's/%//'", "cpu")
      else
        sys_stats.cpu = get_cpu()
        sys_stats.mem = get_mem()
      end

      vim.schedule(function()
        vim.cmd "redrawstatus"
      end)
    end

    local timer = luv.new_timer()
    timer:start(0, 2000, vim.schedule_wrap(update_stats))

    local SysStatsComponent = status.component.builder {
      {
        provider = function()
          return "  " .. sys_stats.cpu .. "%%  󰍛 " .. sys_stats.mem .. "%% "
        end,
      },
      hl = { fg = "green", bold = true },
      surround = {
        separator = "right",
        color = "bg",
        condition = function() return true end,
      },
    }

    table.insert(opts.statusline, 2, SysStatsComponent)

    return opts
  end,
}
