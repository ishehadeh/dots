local wezterm = require 'wezterm'
local act = wezterm.action

return {
  keys = {
    ------------------
    -- TAB CONTROLS --
    ------------------

    -- cycle
    { key = 'Tab',   mods = 'CTRL',       action = act.ActivateTabRelative(1) },
    { key = 'Tab',   mods = 'SHIFT|CTRL', action = act.ActivateTabRelative(-1) },

    -- jump
    { key = '1',     mods = 'ALT',        action = act.ActivateTab(0) },
    { key = '2',     mods = 'ALT',        action = act.ActivateTab(1) },
    { key = '3',     mods = 'ALT',        action = act.ActivateTab(2) },
    { key = '4',     mods = 'ALT',        action = act.ActivateTab(3) },
    { key = '5',     mods = 'ALT',        action = act.ActivateTab(4) },
    { key = '6',     mods = 'ALT',        action = act.ActivateTab(5) },
    { key = '7',     mods = 'ALT',        action = act.ActivateTab(6) },
    { key = '8',     mods = 'ALT',        action = act.ActivateTab(7) },
    { key = '9',     mods = 'ALT',        action = act.ActivateTab(8) },



    ------------------
    -- SPLITS --
    ------------------
    { key = 'i',     mods = 'LEADER',     action = act.SplitPane { direction = "Up" } },
    { key = 'k',     mods = 'LEADER',     action = act.SplitPane { direction = "Down" } },
    { key = 'l',     mods = 'LEADER',     action = act.SplitPane { direction = "Right" } },
    { key = 'j',     mods = 'LEADER',     action = act.SplitPane { direction = "Left" } },


    ------------------
    -- COSMETIC --
    ------------------
    { key = 'F11',   mods = 'NONE',       action = act.ToggleFullScreen },

    -- fonts
    { key = '=',     mods = 'CTRL',       action = act.IncreaseFontSize },
    { key = '-',     mods = 'CTRL',       action = act.DecreaseFontSize },
    { key = '0',     mods = 'CTRL',       action = act.ResetFontSize },


    ------------------
    -- CLIPBOARD --
    ------------------
    { key = 'c',     mods = 'SHIFT|CTRL', action = act.CopyTo 'Clipboard' },
    { key = 'c',     mods = 'SUPER',      action = act.CopyTo 'Clipboard' },
    { key = 'v',     mods = 'SHIFT|CTRL', action = act.PasteFrom 'Clipboard' },
    { key = 'v',     mods = 'SUPER',      action = act.PasteFrom 'Clipboard' },
    { key = 'Copy',  mods = 'NONE',       action = act.CopyTo 'Clipboard' },
    { key = 'Paste', mods = 'NONE',       action = act.PasteFrom 'Clipboard' },


    ------------------
    -- SEARCH --
    ------------------
    { key = 'f',     mods = 'CTRL',       action = act.Search 'CurrentSelectionOrEmptyString' },
    { key = '/',     mods = 'LEADER',     action = act.Search 'CurrentSelectionOrEmptyString' },


    ------------------
    -- WINDOW BEHAVIOR --
    ------------------
    { key = 'm',     mods = 'CTRL',       action = act.Hide },
    { key = 'n',     mods = 'CTRL',       action = act.SpawnWindow },

    ------------------
    -- DOMAIN --
    ------------------
    { key = 'd',     mods = 'CTRL|SHIFT', action = act.DetachDomain 'CurrentPaneDomain' },

    { key = 'p',     mods = 'CTRL',       action = act.ActivateCommandPalette },

    {
      key = 'o',
      mods = 'CTRL',
      action = act.QuickSelectArgs {
        label = 'open',
        patterns = {
          '(?:https?://|git@|git://|ssh://|ftp://|file:///)\\S+',
          '(?:[.\\w\\-@~]+)?(?:/[.\\w\\-@]+)+',
        },
        action = wezterm.action_callback(function(window, pane)
          local url = window:get_selection_text_for_pane(pane)
          wezterm.log_info('opening: ' .. url)
          wezterm.open_with(url)
        end),
      },
    },
    { key = 'phys:Space', mods = 'CTRL',           action = act.QuickSelect },
    { key = 'x',          mods = 'CTRL',           action = act.ActivateCopyMode },

    { key = 'P',          mods = 'SHIFT|CTRL',     action = act.ActivateCommandPalette },
    { key = 'R',          mods = 'CTRL',           action = act.ReloadConfiguration },
    { key = 'R',          mods = 'SHIFT|CTRL',     action = act.ReloadConfiguration },
    { key = 'T',          mods = 'CTRL',           action = act.SpawnTab 'CurrentPaneDomain' },
    { key = 'T',          mods = 'SHIFT|CTRL',     action = act.SpawnTab 'CurrentPaneDomain' },
    { key = 'U',          mods = 'CTRL',           action = act.CharSelect { copy_on_select = true, copy_to = 'ClipboardAndPrimarySelection' } },
    { key = 'U',          mods = 'SHIFT|CTRL',     action = act.CharSelect { copy_on_select = true, copy_to = 'ClipboardAndPrimarySelection' } },

    { key = 'W',          mods = 'CTRL',           action = act.CloseCurrentTab { confirm = true } },
    { key = 'W',          mods = 'SHIFT|CTRL',     action = act.CloseCurrentTab { confirm = true } },
    { key = 'n',          mods = 'SHIFT|CTRL',     action = act.SpawnWindow },
    { key = 'n',          mods = 'SUPER',          action = act.SpawnWindow },
    { key = 'p',          mods = 'SHIFT|CTRL',     action = act.ActivateCommandPalette },
    { key = 'r',          mods = 'SHIFT|CTRL',     action = act.ReloadConfiguration },
    { key = 'r',          mods = 'SUPER',          action = act.ReloadConfiguration },
    { key = 't',          mods = 'SHIFT|CTRL',     action = act.SpawnTab 'CurrentPaneDomain' },
    { key = 't',          mods = 'SUPER',          action = act.SpawnTab 'CurrentPaneDomain' },
    { key = 'u',          mods = 'SHIFT|CTRL',     action = act.CharSelect { copy_on_select = true, copy_to = 'ClipboardAndPrimarySelection' } },
    { key = 'w',          mods = 'SHIFT|CTRL',     action = act.CloseCurrentTab { confirm = true } },
    { key = 'w',          mods = 'SUPER',          action = act.CloseCurrentTab { confirm = true } },
    { key = 'x',          mods = 'SHIFT|CTRL',     action = act.ActivateCopyMode },
    { key = 'z',          mods = 'SHIFT|CTRL',     action = act.TogglePaneZoomState },
    { key = '{',          mods = 'SUPER',          action = act.ActivateTabRelative(-1) },
    { key = '{',          mods = 'SHIFT|SUPER',    action = act.ActivateTabRelative(-1) },
    { key = '}',          mods = 'SUPER',          action = act.ActivateTabRelative(1) },
    { key = '}',          mods = 'SHIFT|SUPER',    action = act.ActivateTabRelative(1) },
    { key = 'PageUp',     mods = 'SHIFT',          action = act.ScrollByPage(-1) },
    { key = 'PageUp',     mods = 'CTRL',           action = act.ActivateTabRelative(-1) },
    { key = 'PageUp',     mods = 'SHIFT|CTRL',     action = act.MoveTabRelative(-1) },
    { key = 'PageDown',   mods = 'SHIFT',          action = act.ScrollByPage(1) },
    { key = 'PageDown',   mods = 'CTRL',           action = act.ActivateTabRelative(1) },
    { key = 'PageDown',   mods = 'SHIFT|CTRL',     action = act.MoveTabRelative(1) },
    { key = 'LeftArrow',  mods = 'SHIFT|CTRL',     action = act.ActivatePaneDirection 'Left' },
    { key = 'LeftArrow',  mods = 'SHIFT|ALT|CTRL', action = act.AdjustPaneSize { 'Left', 1 } },
    { key = 'RightArrow', mods = 'SHIFT|CTRL',     action = act.ActivatePaneDirection 'Right' },
    { key = 'RightArrow', mods = 'SHIFT|ALT|CTRL', action = act.AdjustPaneSize { 'Right', 1 } },
    { key = 'UpArrow',    mods = 'SHIFT',          action = act.ScrollToPrompt(-1) },
    { key = 'UpArrow',    mods = 'SHIFT|CTRL',     action = act.ActivatePaneDirection 'Up' },
    { key = 'UpArrow',    mods = 'SHIFT|ALT|CTRL', action = act.AdjustPaneSize { 'Up', 1 } },
    { key = 'DownArrow',  mods = 'SHIFT',          action = act.ScrollToPrompt(1) },
    { key = 'DownArrow',  mods = 'SHIFT|CTRL',     action = act.ActivatePaneDirection 'Down' },
    { key = 'DownArrow',  mods = 'SHIFT|ALT|CTRL', action = act.AdjustPaneSize { 'Down', 1 } },
  },

  key_tables = {
    copy_mode = {
      { key = 'Escape',     mods = 'NONE',  action = act.CopyMode 'Close' },
      { key = 'q',          mods = 'NONE',  action = act.CopyMode 'Close' },

      { key = 'Tab',        mods = 'NONE',  action = act.CopyMode 'MoveForwardWord' },
      { key = 'Tab',        mods = 'SHIFT', action = act.CopyMode 'MoveBackwardWord' },
      { key = 'Enter',      mods = 'NONE',  action = act.CopyMode 'MoveToStartOfNextLine' },

      { key = 'Space',      mods = 'NONE',  action = act.CopyMode { SetSelectionMode = 'Cell' } },
      { key = '$',          mods = 'NONE',  action = act.CopyMode 'MoveToEndOfLineContent' },
      { key = '#',          mods = 'NONE',  action = act.CopyMode { MoveBackwardZoneOfType = 'Prompt' } },
      { key = ',',          mods = 'NONE',  action = act.CopyMode 'JumpReverse' },
      { key = '0',          mods = 'NONE',  action = act.CopyMode 'MoveToStartOfLine' },
      { key = ';',          mods = 'NONE',  action = act.CopyMode 'JumpAgain' },
      { key = 'F',          mods = 'NONE',  action = act.CopyMode { JumpBackward = { prev_char = false } } },
      { key = 'F',          mods = 'SHIFT', action = act.CopyMode { JumpBackward = { prev_char = false } } },
      { key = 'G',          mods = 'NONE',  action = act.CopyMode 'MoveToScrollbackBottom' },
      { key = 'G',          mods = 'SHIFT', action = act.CopyMode 'MoveToScrollbackBottom' },
      { key = 'H',          mods = 'NONE',  action = act.CopyMode 'MoveToViewportTop' },
      { key = 'H',          mods = 'SHIFT', action = act.CopyMode 'MoveToViewportTop' },
      { key = 'L',          mods = 'NONE',  action = act.CopyMode 'MoveToViewportBottom' },
      { key = 'L',          mods = 'SHIFT', action = act.CopyMode 'MoveToViewportBottom' },
      { key = 'M',          mods = 'NONE',  action = act.CopyMode 'MoveToViewportMiddle' },
      { key = 'M',          mods = 'SHIFT', action = act.CopyMode 'MoveToViewportMiddle' },
      { key = 'O',          mods = 'NONE',  action = act.CopyMode 'MoveToSelectionOtherEndHoriz' },
      { key = 'O',          mods = 'SHIFT', action = act.CopyMode 'MoveToSelectionOtherEndHoriz' },
      { key = 'T',          mods = 'NONE',  action = act.CopyMode { JumpBackward = { prev_char = true } } },
      { key = 'T',          mods = 'SHIFT', action = act.CopyMode { JumpBackward = { prev_char = true } } },
      { key = 'V',          mods = 'NONE',  action = act.CopyMode { SetSelectionMode = 'Line' } },
      { key = 'V',          mods = 'SHIFT', action = act.CopyMode { SetSelectionMode = 'Line' } },
      { key = '^',          mods = 'NONE',  action = act.CopyMode 'MoveToStartOfLineContent' },
      { key = '^',          mods = 'SHIFT', action = act.CopyMode 'MoveToStartOfLineContent' },
      { key = 'b',          mods = 'NONE',  action = act.CopyMode 'MoveBackwardWord' },
      { key = 'b',          mods = 'ALT',   action = act.CopyMode 'MoveBackwardWord' },
      { key = 'b',          mods = 'CTRL',  action = act.CopyMode 'PageUp' },
      { key = 'c',          mods = 'CTRL',  action = act.CopyMode 'Close' },
      { key = 'd',          mods = 'CTRL',  action = act.CopyMode { MoveByPage = (0.5) } },
      { key = 'e',          mods = 'NONE',  action = act.CopyMode 'MoveForwardWordEnd' },
      { key = 'f',          mods = 'NONE',  action = act.CopyMode { JumpForward = { prev_char = false } } },
      { key = 'f',          mods = 'ALT',   action = act.CopyMode 'MoveForwardWord' },
      { key = 'f',          mods = 'CTRL',  action = act.CopyMode 'PageDown' },
      { key = 'g',          mods = 'NONE',  action = act.CopyMode 'MoveToScrollbackTop' },
      { key = 'g',          mods = 'CTRL',  action = act.CopyMode 'Close' },
      { key = 'h',          mods = 'NONE',  action = act.CopyMode 'MoveLeft' },
      { key = 'j',          mods = 'NONE',  action = act.CopyMode 'MoveDown' },
      { key = 'k',          mods = 'NONE',  action = act.CopyMode 'MoveUp' },
      { key = 'l',          mods = 'NONE',  action = act.CopyMode 'MoveRight' },
      { key = 'm',          mods = 'ALT',   action = act.CopyMode 'MoveToStartOfLineContent' },
      { key = 'o',          mods = 'NONE',  action = act.CopyMode 'MoveToSelectionOtherEnd' },
      { key = 't',          mods = 'NONE',  action = act.CopyMode { JumpForward = { prev_char = true } } },
      { key = 'u',          mods = 'CTRL',  action = act.CopyMode { MoveByPage = (-0.5) } },
      { key = 'v',          mods = 'NONE',  action = act.CopyMode { SetSelectionMode = 'Cell' } },
      { key = 'v',          mods = 'CTRL',  action = act.CopyMode { SetSelectionMode = 'Block' } },
      { key = 'w',          mods = 'NONE',  action = act.CopyMode 'MoveForwardWord' },
      { key = 'c',          mods = 'CTRL',  action = act.Multiple { { CopyTo = 'ClipboardAndPrimarySelection' }, { CopyMode = 'Close' } } },
      { key = 'PageUp',     mods = 'NONE',  action = act.CopyMode 'PageUp' },
      { key = 'PageDown',   mods = 'NONE',  action = act.CopyMode 'PageDown' },
      { key = 'End',        mods = 'NONE',  action = act.CopyMode 'MoveToEndOfLineContent' },
      { key = 'Home',       mods = 'NONE',  action = act.CopyMode 'MoveToStartOfLine' },
      { key = 'LeftArrow',  mods = 'NONE',  action = act.CopyMode 'MoveLeft' },
      { key = 'LeftArrow',  mods = 'ALT',   action = act.CopyMode 'MoveBackwardWord' },
      { key = 'RightArrow', mods = 'NONE',  action = act.CopyMode 'MoveRight' },
      { key = 'RightArrow', mods = 'ALT',   action = act.CopyMode 'MoveForwardWord' },
      { key = 'UpArrow',    mods = 'NONE',  action = act.CopyMode 'MoveUp' },
      { key = 'DownArrow',  mods = 'NONE',  action = act.CopyMode 'MoveDown' },
    },

    search_mode = {
      { key = 'Enter',     mods = 'NONE', action = act.CopyMode 'PriorMatch' },
      { key = 'Escape',    mods = 'NONE', action = act.CopyMode 'Close' },
      { key = 'n',         mods = 'CTRL', action = act.CopyMode 'NextMatch' },
      { key = 'p',         mods = 'CTRL', action = act.CopyMode 'PriorMatch' },
      { key = 'r',         mods = 'CTRL', action = act.CopyMode 'CycleMatchType' },
      { key = 'u',         mods = 'CTRL', action = act.CopyMode 'ClearPattern' },
      { key = 'PageUp',    mods = 'NONE', action = act.CopyMode 'PriorMatchPage' },
      { key = 'PageDown',  mods = 'NONE', action = act.CopyMode 'NextMatchPage' },
      { key = 'UpArrow',   mods = 'NONE', action = act.CopyMode 'PriorMatch' },
      { key = 'DownArrow', mods = 'NONE', action = act.CopyMode 'NextMatch' },
    },

  }
}
