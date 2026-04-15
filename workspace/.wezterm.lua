 -- ~/.wezterm.lua
-- Parallel-Claude-agent workspace launcher.
-- Single-file config per WezTerm quick-start docs.

local wezterm = require("wezterm")
local mux     = wezterm.mux
local act     = wezterm.action
local config  = wezterm.config_builder()

---------------------------------------------------------------------------
-- Appearance
---------------------------------------------------------------------------
-- Monokai variants available as built-ins. Pick one:
config.color_scheme = "Monokai (dark) (terminal.sexy)"
-- config.color_scheme = "Monokai Remastered"
-- config.color_scheme = "Monokai Pro (Gogh)"
-- config.color_scheme = "MonokaiDimmed"

config.font                      = wezterm.font("JetBrains Mono")
config.font_size                 = 13.0
config.initial_cols              = 220
config.initial_rows              = 56
config.enable_tab_bar            = true
config.use_fancy_tab_bar         = true
config.tab_bar_at_bottom         = false
config.show_tab_index_in_tab_bar = true
config.window_decorations        = "RESIZE"
config.window_frame              = { font_size = 12.0 }
config.window_padding            = { left = 4, right = 4, top = 4, bottom = 4 }

-- Make active pane visually obvious
config.inactive_pane_hsb = { saturation = 0.7, brightness = 0.6 }
config.colors = {
  tab_bar = {
    background = "#0b0b0b",
  },
}

---------------------------------------------------------------------------
-- Workspace data (the future "product schema")
---------------------------------------------------------------------------
local HOME = os.getenv("HOME")
local function h(p) return (p:gsub("^~", HOME)) end

local WORKSPACES = {
  main = {
    tabs = {
      {
        name = "Planner",
        panes = {
          { title = "planner", cwd = h("~/SecondBrain") },
          { title = "workflow",   cwd = h("~/SecondBrain/6. Spaces/62. Business") },
          { title = "summary", cwd = h("~/SecondBrain") },
          { title = "research",   cwd = h("~/SecondBrain/6. Spaces/62. Business") },
          { title = "sketch",   cwd = h("~/SecondBrain/6. Spaces/62. Business") },
          { title = "shell",   cwd = h("~/SecondBrain") },
        },
      },
      {
        name = "StartingKit",
        panes = {
          { title = "main", cwd = h("~/SecondBrain/6. Spaces/62. Business") },
          { title = "wt-a", cwd = h("~/SecondBrain/6. Spaces/62. Business") },
          { title = "wt-b", cwd = h("~/SecondBrain/6. Spaces/62. Business") },
          { title = "wt-c", cwd = h("~/SecondBrain/6. Spaces/62. Business") },
          { title = "dev",  cwd = h("~/SecondBrain/6. Spaces/62. Business") },
          { title = "logs", cwd = h("~/SecondBrain/6. Spaces/62. Business") },
        },
      },
      {
        name = "AutomateIdeasAI",
        panes = {
          { title = "main", cwd = h("~/Projects/automateideasai.com/main") },
          { title = "wt-a", cwd = h("~/Projects/automateideasai.com/main") },
          { title = "wt-b", cwd = h("~/Projects/automateideasai.com/main") },
          { title = "wt-c", cwd = h("~/Projects/automateideasai.com/main") },
          { title = "dev",  cwd = h("~/Projects/automateideasai.com/main") },
          { title = "logs", cwd = h("~/Projects/automateideasai.com/main") },
        },
      },
      {
        name = "Content",
        panes = {
          { title = "assistant",   cwd = h("~/SecondBrain/6. Spaces/62. Business") },
          { title = "research", cwd = h("~/SecondBrain/6. Spaces/62. Business") },
          { title = "shortform",     cwd = h("~/SecondBrain/6. Spaces/62. Business") },
          { title = "longform", cwd = h("~/SecondBrain/6. Spaces/62. Business") },
          { title = "ghost",    cwd = h("~/SecondBrain/6. Spaces/62. Business") },
          { title = "shell",     cwd = h("~/SecondBrain/6. Spaces/62. Business") },
        },
      },
    },
  },
}

---------------------------------------------------------------------------
-- Launcher: build pane grids (2x2 for 4 panes, 3x2 for 6 panes)
---------------------------------------------------------------------------
local function build_grid_2x2(pane, defs)
  local p = { pane }
  -- Top row: split right
  p[2] = p[1]:split({ direction = "Right", cwd = defs[2].cwd, size = 0.50 })
  -- Bottom row: split each top pane downward
  p[3] = p[1]:split({ direction = "Bottom", cwd = defs[3].cwd, size = 0.50 })
  p[4] = p[2]:split({ direction = "Bottom", cwd = defs[4].cwd, size = 0.50 })
end

local function build_grid_3x2(pane, defs)
  local p = { pane }
  -- Top row: split right twice
  p[2] = p[1]:split({ direction = "Right", cwd = defs[2].cwd, size = 0.66 })
  p[3] = p[2]:split({ direction = "Right", cwd = defs[3].cwd, size = 0.50 })
  -- Bottom row: split each top pane downward
  p[4] = p[1]:split({ direction = "Bottom", cwd = defs[4].cwd, size = 0.50 })
  p[5] = p[2]:split({ direction = "Bottom", cwd = defs[5].cwd, size = 0.50 })
  p[6] = p[3]:split({ direction = "Bottom", cwd = defs[6].cwd, size = 0.50 })
end

local function build_grid(pane, defs)
  -- cd pane 1 (the seed pane had no cwd applied at split time)
  if defs[1].cwd then
    pane:send_text(string.format("cd %q && clear\n", defs[1].cwd))
  end

  if #defs <= 4 then
    build_grid_2x2(pane, defs)
  else
    build_grid_3x2(pane, defs)
  end
end

local function build_workspace(ws_name)
  local ws = WORKSPACES[ws_name]
  if not ws then return end

  local first = ws.tabs[1]
  local tab, pane, window = mux.spawn_window({
    workspace = ws_name,
    cwd = first.panes[1].cwd,
  })
  tab:set_title(first.name)
  build_grid(pane, first.panes)

  for i = 2, #ws.tabs do
    local tdef = ws.tabs[i]
    local new_tab, new_pane, _ = window:spawn_tab({ cwd = tdef.panes[1].cwd })
    new_tab:set_title(tdef.name)
    build_grid(new_pane, tdef.panes)
  end

  mux.set_active_workspace(ws_name)
end

wezterm.on("gui-startup", function(cmd)
  build_workspace("main")
end)

---------------------------------------------------------------------------
-- Per-tab colors + locked titles
---------------------------------------------------------------------------
local TAB_COLORS = {
  Planner         = { bg = "#f92672", fg = "#ffffff" }, -- pink
  ["Ship & Sell Starting Kit"] = { bg = "#3D7186", fg = "#000000" }, -- calypso
  AutomateIdeasAI = { bg = "#66d9ef", fg = "#000000" }, -- cyan
  Content         = { bg = "#a6e22e", fg = "#000000" }, -- green
}

---------------------------------------------------------------------------
-- Right status: list panes of the active tab with their titles
---------------------------------------------------------------------------
local function pane_label(pane_info)
  -- Prefer our user var (set by the zsh precmd hook), fall back to title
  local p = pane_info.pane
  local uv = (p and p:get_user_vars()) or {}
  return uv.panetitle or pane_info.title or "?"
end

wezterm.on("update-status", function(window, pane)
  local tab = window:active_tab()
  if not tab then window:set_right_status(""); return end
  local active_pane_id = pane:pane_id()
  local cells = {}
  for _, p in ipairs(tab:panes_with_info()) do
    local label = pane_label(p)
    if p.pane:pane_id() == active_pane_id then
      table.insert(cells, "[" .. label .. "]")
    else
      table.insert(cells, " " .. label .. " ")
    end
  end
  window:set_right_status(wezterm.format({
    { Foreground = { Color = "#a6e22e" } },
    { Text = table.concat(cells, "·") .. " " },
  }))
end)

wezterm.on("format-tab-title", function(tab, tabs, panes, cfg, hover, max_width)
  local title = (tab.tab_title and #tab.tab_title > 0)
    and tab.tab_title
    or tostring(tab.tab_index + 1)
  local c = TAB_COLORS[title] or { bg = "#3a3a3a", fg = "#ffffff" }
  if not tab.is_active then
    c = { bg = "#1e1e1e", fg = c.bg }
  end

  -- Append active pane label, e.g. "Planner — roadmap"
  local ap = tab.active_pane
  local uv = (ap and ap.user_vars) or {}
  local pane_name = uv.panetitle or (ap and ap.title) or ""
  local label = " " .. title
  if pane_name ~= "" then
    label = label .. " — " .. pane_name
  end
  label = label .. " "

  return {
    { Background = { Color = c.bg } },
    { Foreground = { Color = c.fg } },
    { Text = label },
  }
end)

---------------------------------------------------------------------------
-- Keybinds
---------------------------------------------------------------------------
config.keys = {
  { key = "d", mods = "CMD",       action = act.SplitHorizontal { domain = "CurrentPaneDomain" } },
  { key = "d", mods = "CMD|SHIFT", action = act.SplitVertical   { domain = "CurrentPaneDomain" } },
  { key = "w", mods = "CMD",       action = act.CloseCurrentPane { confirm = true } },
  { key = "LeftArrow",  mods = "CMD|OPT", action = act.ActivatePaneDirection "Left"  },
  { key = "RightArrow", mods = "CMD|OPT", action = act.ActivatePaneDirection "Right" },
  { key = "UpArrow",    mods = "CMD|OPT", action = act.ActivatePaneDirection "Up"    },
  { key = "DownArrow",  mods = "CMD|OPT", action = act.ActivatePaneDirection "Down"  },
}

return config
