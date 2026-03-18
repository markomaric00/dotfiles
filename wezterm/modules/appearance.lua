local wezterm = require("wezterm")

local M = {}

-- ── Platform detection ───────────────────────────────────────────────
local is_windows = wezterm.target_triple:find("windows") ~= nil

-- Tokyo Night palette (for consistent use in status bar)
local colors = {
    red     = "#f7768e",
    blue    = "#7dcfff",
    purple  = "#bb9af7",
    yellow  = "#e0af68",
    green   = "#9ece6a",
    fg      = "#c0caf5",
    bg      = "#1a1b26",
    comment = "#565f89",
}

function M.setup(config)

    -- ── Font ──────────────────────────────────────────────────────────
    config.font = wezterm.font("Inconsolata Nerd Font", { weight = "Regular" })
    config.font_size = 12
    config.line_height = 1.1
    config.font_rules = {
        {
            intensity = "Bold",
            font = wezterm.font("Inconsolata Nerd Font", { weight = "Regular" })
        },
    }

    -- ── Colors & background ───────────────────────────────────────────
    config.color_scheme = "Tokyo Night"
    config.window_background_opacity = 0.6

    local bg_path = is_windows
        and [[C:\Users\u19y01\.config\wezterm\background\background.jpg]]
        or  "/home/marko/.config/wezterm/background/background.jpg"

    config.background = {
        {
            source = { File = bg_path },
            hsb = { brightness = 0.08, saturation = 0.9 },
        },
    }

    -- ── Window ────────────────────────────────────────────────────────
    config.initial_rows = 48
    config.initial_cols = 160
    config.window_decorations = "RESIZE"
    config.window_close_confirmation = "AlwaysPrompt"
    config.window_padding = { left = 4, right = 4, top = 4, bottom = 4 }
    config.window_frame = {
        border_left_width    = "2px",
        border_right_width   = "2px",
        border_bottom_height = "2px",
        border_top_height    = "2px",
        border_left_color    = colors.comment,
        border_right_color   = colors.comment,
        border_bottom_color  = colors.comment,
        border_top_color     = colors.comment,
    }

    -- ── Cursor ────────────────────────────────────────────────────────
    config.default_cursor_style = "BlinkingBar"
    config.cursor_blink_rate = 500

    -- ── Scrollback ────────────────────────────────────────────────────
    config.scrollback_lines = 10000

    -- ── Workspace / CWD ───────────────────────────────────────────────
    config.default_workspace = "main"
    config.default_cwd = is_windows
        and [[C:\Github\sdt-test]]
        or  "/home/yourusername"

    -- ── Tab bar ───────────────────────────────────────────────────────
    config.use_fancy_tab_bar = false
    config.tab_bar_at_bottom = false
    config.status_update_interval = 500
    config.tab_max_width = 24

    -- ── Status bar ────────────────────────────────────────────────────
    wezterm.on("update-status", function(window, pane)

        -- Left: workspace / key-table / leader indicator
        local stat       = window:active_workspace()
        local stat_color = colors.red
        local stat_icon  = wezterm.nerdfonts.oct_table

        if window:active_key_table() then
            stat       = window:active_key_table()
            stat_color = colors.blue
            stat_icon  = wezterm.nerdfonts.md_keyboard
        end
        if window:leader_is_active() then
            stat       = "LDR"
            stat_color = colors.purple
            stat_icon  = wezterm.nerdfonts.md_lightning_bolt
        end

        window:set_left_status(wezterm.format({
            { Foreground = { Color = stat_color } },
            { Text = "  " .. stat_icon .. "  " .. stat .. "  │" },
        }))

        -- Helpers
        local basename = function(s)
            return string.gsub(s, "(.*[/\\])(.*)", "%2")
        end

        -- CWD
        local cwd = pane:get_current_working_dir()
        cwd = cwd and basename(cwd.file_path) or ""

        -- Foreground process
        local cmd = pane:get_foreground_process_name()
        cmd = cmd and basename(cmd) or ""

        -- Battery (optional — gracefully skipped if no battery)
        local bat_text = ""
        local bat_ok, batteries = pcall(wezterm.battery_info)
        if bat_ok and batteries and #batteries > 0 then
            local b = batteries[1]
            local pct = math.floor(b.state_of_charge * 100)
            local icon = pct > 80 and wezterm.nerdfonts.md_battery_high
                      or pct > 40 and wezterm.nerdfonts.md_battery_medium
                      or             wezterm.nerdfonts.md_battery_low
            bat_text = " │ " .. icon .. "  " .. pct .. "%"
        end

        -- Date/time
        local time = wezterm.strftime(" %H:%M")

        window:set_right_status(wezterm.format({
            { Foreground = { Color = colors.fg } },
            { Text = wezterm.nerdfonts.md_folder .. "  " .. cwd },
            { Text = "  │  " },
            { Foreground = { Color = colors.yellow } },
            { Text = wezterm.nerdfonts.fa_code .. "  " .. cmd },
            { Foreground = { Color = colors.comment } },
            { Text = bat_text },
            { Text = "  │" },
            { Foreground = { Color = colors.green } },
            { Text = time .. "  " },
        }))
    end)

    return config
end

return M
