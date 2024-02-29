--- wezterm.lua
--- $ figlet -f small Wezterm
--- __      __      _
--- \ \    / /__ __| |_ ___ _ _ _ __
---  \ \/\/ / -_)_ /  _/ -_) '_| '  \
---   \_/\_/\___/__|\__\___|_| |_|_|_|
---
--- My Wezterm config file

local wezterm = require("wezterm")

local config = {}
-- Use config builder object if possible
if wezterm.config_builder then config = wezterm.config_builder() end

-- Settings
config.color_scheme = "Gigavolt (base16)"
config.window_background_opacity = 0.9
config.window_decorations = "RESIZE"
config.window_close_confirmation = "AlwaysPrompt"
config.scrollback_lines = 3000
config.default_workspace = "main"
config.font_size = 15.5
-- This is essential for Option key to work for macOS
config.send_composed_key_when_left_alt_is_pressed = true

-- Dim inactive panes
config.inactive_pane_hsb = {
    saturation = 0.24,
    brightness = 0.5
}

-- Tab bar
-- I don't like the look of "fancy" tab bar
config.use_fancy_tab_bar = false
config.status_update_interval = 1000
config.tab_bar_at_bottom = false
wezterm.on("update-status", function(window, pane)
    -- Workspace name
    local stat = window:active_workspace()
    local stat_color = "#f7768e"
    -- It's a little silly to have workspace name all the time
    -- Utilize this to display LDR or current key table name
    if window:active_key_table() then
        stat = window:active_key_table()
        stat_color = "#7dcfff"
    end
    if window:leader_is_active() then
        stat = "LDR"
        stat_color = "#bb9af7"
    end

    -- Current working directory
    local basename = function(s)
        -- Nothing a little regex can't fix
        return string.gsub(s, "(.*[/\\])(.*)", "%2")
    end
    -- CWD and CMD could be nil (e.g. viewing log using Ctrl-Alt-l). Not a big deal, but check in case
    local cwd = pane:get_current_working_dir()
    cwd = cwd and basename(cwd) or ""
    -- Current command
    local cmd = pane:get_foreground_process_name()
    cmd = cmd and basename(cmd) or ""

    -- Left status (left of the tab line)
    window:set_left_status(wezterm.format({
        { Foreground = { Color = stat_color } },
        { Text = "  " },
        { Text = wezterm.nerdfonts.oct_table .. "  " .. stat },
        { Text = " |" },
    }))

    -- Right status
    window:set_right_status(wezterm.format({
        -- Wezterm has a built-in nerd fonts
        -- https://wezfurlong.org/wezterm/config/lua/wezterm/nerdfonts.html
        { Text = wezterm.nerdfonts.md_folder .. "  " .. cwd },
        { Text = " | " },
        { Foreground = { Color = "#e0af68" } },
        { Text = wezterm.nerdfonts.fa_code .. "  " .. cmd },
        "ResetAttributes",
        { Text = " | " },
        { Text = "  " },
    }))
end)

return config
