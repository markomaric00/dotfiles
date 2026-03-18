-- -- --- wezterm.lua
-- -- --- $ figlet -f small Wezterm
-- -- --- __      __      _
-- -- --- \ \    / /__ __| |_ ___ _ _ _ __
-- -- ---  \ \/\/ / -_)_ /  _/ -_) '_| '  \
-- -- ---   \_/\_/\___/__|\__\___|_| |_|_|_|
-- -- ---
-- -- --- My Wezterm config file

local wezterm = require("wezterm")
local mappings = require("modules.mappings")
local appearance = require("modules.appearance")
local act = wezterm.action
local mux = wezterm.mux

local config = {}
if wezterm.config_builder then config = wezterm.config_builder() end

-- ── Platform detection ───────────────────────────────────────────────
local is_windows = wezterm.target_triple:find("windows") ~= nil

-- ── Shell ────────────────────────────────────────────────────────────
if is_windows then
    config.default_prog = { "powershell.exe" }
else
    config.default_prog = { "/bin/zsh" }
end

-- ── Appearance & mappings ────────────────────────────────────────────
config = appearance.setup(config)
config.leader     = mappings.leader
config.keys       = mappings.keys
config.key_tables = mappings.key_tables

-- ── LEADER + 1-9 → switch to tab N ───────────────────────────────────
for i = 1, 9 do
    table.insert(config.keys, {
        key    = tostring(i),
        mods   = "LEADER",
        action = act.ActivateTab(i - 1),
    })
end

-- ── Startup workspace (Windows only) ─────────────────────────────────
if is_windows then
    local PATHS = {
        project  = [[C:\Github\sdt-test]],
        rinstall = [[C:\Installations\R2026.1]],
        git_sh   = [[C:\Users\u19y01\AppData\Local\Programs\Git\bin\sh.exe]],
    }

    wezterm.on("gui-startup", function(cmd)
        local args = cmd and cmd.args or {}

        -- Tab 1 — nvim (editor)
        local ftab, _, window = mux.spawn_window {
            workspace = "work",
            cwd       = PATHS.project,
            args      = { "nvim" },
        }
        ftab:set_title("nvim")

        -- Tab 2 — git bash
        local stab, spane, _ = window:spawn_tab {
            cwd = PATHS.project,
        }
        -- Fix: split args so WezTerm passes them correctly to the OS
        spane:send_text('"' .. PATHS.git_sh .. '" --login\r')
        stab:set_title("git")

        -- Tab 3 — sdt (build/run)
        local ttab, _, _ = window:spawn_tab { cwd = PATHS.rinstall }
        ttab:set_title("sdt")

        -- Tab 4 — dlb
        local fotab, _, _ = window:spawn_tab { cwd = PATHS.rinstall }
        fotab:set_title("dlb")

        -- Tab 5 — run
        local fitab, _, _ = window:spawn_tab { cwd = PATHS.rinstall }
        fitab:set_title("run")

        -- Start focused on the editor tab
        ftab:activate()

        -- Set the active workspace name visible in status bar
        mux.set_active_workspace("work")
    end)
end

return config
