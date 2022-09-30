function updateSettings(settingsWindow)
    settings.VSync = settingsWindow.VSyncSetting.selected
end

return {updateSettings}