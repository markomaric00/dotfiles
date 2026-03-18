local wezterm = require("wezterm")
local act = wezterm.action

return {
    leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 },

    keys = {

        -- ── Workspaces ────────────────────────────────────────────────
        { key = "s", mods = "LEADER", action = act.ShowLauncherArgs { flags = "FUZZY|WORKSPACES" } },
        -- Switch to next/prev workspace
        { key = "[", mods = "LEADER", action = act.SwitchWorkspaceRelative(-1) },
        { key = "]", mods = "LEADER", action = act.SwitchWorkspaceRelative(1) },
        -- Create a new named workspace
        {
            key = "S",
            mods = "LEADER",
            action = act.PromptInputLine {
                description = wezterm.format {
                    { Attribute = { Intensity = "Bold" } },
                    { Foreground = { AnsiColor = "Fuchsia" } },
                    { Text = "New workspace name:" },
                },
                action = wezterm.action_callback(function(window, pane, line)
                    if line then
                        window:perform_action(
                            act.SwitchToWorkspace { name = line },
                            pane
                        )
                    end
                end),
            },
        },

        -- ── Tabs ──────────────────────────────────────────────────────
        { key = "q", mods = "LEADER", action = act.ShowTabNavigator },
        { key = "t", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
        { key = "p", mods = "LEADER", action = act.ActivateTabRelative(-1) },
        { key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) },
        { key = "c", mods = "LEADER", action = act.CloseCurrentTab { confirm = true } },
        -- Duplicate current tab
        { key = "d", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
        -- Move tab mode
        { key = "m", mods = "LEADER", action = act.ActivateKeyTable { name = "move_tab", one_shot = false } },

        -- Rename tab
        {
            key = ",",
            mods = "LEADER",
            action = act.PromptInputLine {
                description = wezterm.format {
                    { Attribute = { Intensity = "Bold" } },
                    { Foreground = { AnsiColor = "Fuchsia" } },
                    { Text = "Rename tab:" },
                },
                action = wezterm.action_callback(function(window, pane, line)
                    if line then
                        window:active_tab():set_title(line)
                    end
                end),
            },
        },

        -- ── Pane splitting ────────────────────────────────────────────
        { key = "-", mods = "LEADER", action = act.SplitVertical   { domain = "CurrentPaneDomain" } },
        { key = "\\", mods = "LEADER", action = act.SplitHorizontal { domain = "CurrentPaneDomain" } },
        -- Pane navigation
        { key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
        { key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
        { key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
        { key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
        -- Pane resize mode
        { key = "R", mods = "LEADER", action = act.ActivateKeyTable { name = "resize_pane", one_shot = false } },
        -- Close current pane
        { key = "x", mods = "LEADER", action = act.CloseCurrentPane { confirm = true } },
        -- Zoom/unzoom pane
        { key = "z", mods = "LEADER", action = act.TogglePaneZoomState },

        -- ── Misc ──────────────────────────────────────────────────────
        -- Copy mode (keyboard-driven selection)
        { key = "/", mods = "LEADER", action = act.Search { CaseSensitiveString = "" } },
        { key = "f", mods = "LEADER", action = act.QuickSelect },
        -- Clear scrollback
        { key = "K", mods = "LEADER", action = act.ClearScrollback("ScrollbackAndViewport") },
    },

    key_tables = {
        -- ── Move tabs ─────────────────────────────────────────────────
        move_tab = {
            { key = "h",      action = act.MoveTabRelative(-1) },
            { key = "k",      action = act.MoveTabRelative(-1) },   -- h/k = left
            { key = "j",      action = act.MoveTabRelative(1) },    -- j/l = right
            { key = "l",      action = act.MoveTabRelative(1) },
            { key = "Escape", action = "PopKeyTable" },
            { key = "Enter",  action = "PopKeyTable" },
        },

        -- ── Resize panes ──────────────────────────────────────────────
        resize_pane = {
            { key = "h",      action = act.AdjustPaneSize { "Left",  5 } },
            { key = "j",      action = act.AdjustPaneSize { "Down",  5 } },
            { key = "k",      action = act.AdjustPaneSize { "Up",    5 } },
            { key = "l",      action = act.AdjustPaneSize { "Right", 5 } },
            { key = "Escape", action = "PopKeyTable" },
            { key = "Enter",  action = "PopKeyTable" },
        },
    },
}
