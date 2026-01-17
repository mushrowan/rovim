-- SECTION: tabby
-- Tab line with per-tab buffer scoping via scope.nvim
--
-- Layout: buffers (left) | tabs (right)
-- Navigation:
--   Ctrl+h/l      = Cycle buffers in current tab
--   <leader>1-5   = Switch to tab N
--   <leader>j     = Jump to tab (with labels)
return {
  {
    "tabby.nvim",
    for_cat = "ui",
    event = "DeferredUIEnter",
    load = function(name)
      vim.cmd.packadd("scope.nvim")
      require("scope").setup({})
      vim.cmd.packadd(name)
    end,
    after = function()
      local eva02 = require("partials.eva02")
      local c = eva02.colors
      local icons = require("mini.icons")

      -- Highlight groups
      local hl_groups = {
        TabbyHead = { fg = c.bg, bg = c.red, bold = true },
        TabbyHeadSep = { fg = c.red, bg = c.bg_dark },
        TabbyActive = { fg = c.white, bg = c.red, bold = true },
        TabbyActiveSep = { fg = c.red, bg = c.bg_dark },
        TabbyInactive = { fg = c.grey, bg = c.bg_light },
        TabbyInactiveSep = { fg = c.bg_light, bg = c.bg_dark },
        TabbyFill = { bg = c.bg_dark },
        TabbyTail = { fg = c.bg, bg = c.orange, bold = true },
        TabbyTailSep = { fg = c.orange, bg = c.bg_dark },
        TabbyIcon = { fg = c.gold, bg = c.red },
        TabbyIconInactive = { fg = c.amber_dark, bg = c.bg_light },
        TabbyDir = { fg = c.gold, bg = c.red, italic = true },
        TabbyDirInactive = { fg = c.grey_dim, bg = c.bg_light, italic = true },
      }
      for name, opts in pairs(hl_groups) do
        vim.api.nvim_set_hl(0, name, opts)
      end

      -- Get abbreviated project directory for a tab
      local function get_tab_dir(tabid)
        local tabnr = vim.api.nvim_tabpage_get_number(tabid)
        local cwd = vim.fn.getcwd(-1, tabnr)
        local dir = vim.fn.fnamemodify(cwd, ":t")
        return dir:sub(1, 3):lower()
      end

      -- Get primary filetype icon for a tab
      local function get_tab_icon(tabid)
        local wins = vim.api.nvim_tabpage_list_wins(tabid)
        local ft_counts = {}
        local excluded = { oil = true, snacks_picker_list = true, [""] = true }

        for _, win in ipairs(wins) do
          local ft = vim.bo[vim.api.nvim_win_get_buf(win)].filetype
          if ft and not excluded[ft] then
            ft_counts[ft] = (ft_counts[ft] or 0) + 1
          end
        end

        local max_ft, max_count = nil, 0
        for ft, count in pairs(ft_counts) do
          if count > max_count then
            max_ft, max_count = ft, count
          end
        end

        return max_ft and icons.get("filetype", max_ft) or "󰈔"
      end

      require("tabby").setup({
        line = function(line)
          -- Collect listed file buffers
          local buffers = {}
          for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
            local valid = vim.api.nvim_buf_is_valid(bufnr)
            local listed = vim.bo[bufnr].buflisted
            local has_name = vim.api.nvim_buf_get_name(bufnr) ~= ""
            local normal = vim.bo[bufnr].buftype == ""
            if valid and listed and has_name and normal then
              table.insert(buffers, bufnr)
            end
          end

          local current_buf = vim.api.nvim_get_current_buf()

          return {
            -- Buffers on the left
            vim.tbl_map(function(bufnr)
              local is_current = bufnr == current_buf
              local hl = is_current and "TabbyActive" or "TabbyInactive"
              local sep_hl = is_current and "TabbyActiveSep" or "TabbyInactiveSep"
              local name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":t")
              local icon = icons.get("file", name)
              local modified = vim.bo[bufnr].modified and " ●" or ""

              return {
                line.sep("", sep_hl, "TabbyFill"),
                icon .. " ",
                name,
                modified,
                line.sep("", sep_hl, "TabbyFill"),
                hl = hl,
                margin = " ",
              }
            end, buffers),

            line.spacer(),

            -- Tabs on the right
            line.tabs().foreach(function(tab)
              local is_current = tab.is_current()
              local hl = is_current and "TabbyActive" or "TabbyInactive"
              local sep_hl = is_current and "TabbyActiveSep" or "TabbyInactiveSep"
              local icon_hl = is_current and "TabbyIcon" or "TabbyIconInactive"
              local dir_hl = is_current and "TabbyDir" or "TabbyDirInactive"

              local icon = get_tab_icon(tab.id)
              local dir = get_tab_dir(tab.id)

              return {
                line.sep("", sep_hl, "TabbyFill"),
                { icon .. " ", hl = icon_hl },
                tab.in_jump_mode() and tab.jump_key() or tab.number(),
                { " " .. dir, hl = dir_hl },
                tab.close_btn(""),
                line.sep("", sep_hl, "TabbyFill"),
                hl = hl,
                margin = " ",
              }
            end),

            -- Tail
            {
              line.sep("", "TabbyTailSep", "TabbyFill"),
              { "  ", hl = "TabbyTail" },
            },
            hl = "TabbyFill",
          }
        end,
      })

      vim.o.showtabline = 2

      -- Buffer navigation
      vim.keymap.set("n", "<C-h>", "<cmd>bprev<CR>", { desc = "Previous buffer" })
      vim.keymap.set("n", "<C-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })

      -- Tab navigation
      for i = 1, 5 do
        vim.keymap.set("n", "<leader>" .. i, i .. "gt", { desc = "Go to tab " .. i })
      end
      vim.keymap.set("n", "<leader><C-h>", "<cmd>tabprev<CR>", { desc = "Previous tab" })
      vim.keymap.set("n", "<leader><C-l>", "<cmd>tabnext<CR>", { desc = "Next tab" })

      -- Tab management
      local utils = require("partials.utils")
      utils.map_all("n", {
        { "<leader>j", ":Tabby jump_to_tab<CR>", "Jump to tab" },
        { "<leader>ta", ":$tabnew<CR>", "New tab" },
        { "<leader>tc", ":tabclose<CR>", "Close tab" },
        { "<leader>to", ":tabonly<CR>", "Tab only" },
        { "<leader>tmp", ":-tabmove<CR>", "Move tab left" },
        { "<leader>tmn", ":+tabmove<CR>", "Move tab right" },
      })
    end,
  },
}
