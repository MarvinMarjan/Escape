winX, winY = love.window.getMode()

windows = {
    mainMenu = Window:new({
        playButton = Button:new(winX / 2 - 200 / 2, winY / 2 + 40, 200, 50, 10, 10, {content = "Play"}, _, _),
        settingButton = Button:new(winX / 2 - 200 / 2, winY / 2 + 80 / 2 + 60, 200, 50, 10, 10, {content = "Setting"}, _, _, {
            onClick = function() ui:setWindow(windows.settings) end
        }),

        exitButton = Button:new(winX / 2 - 200 / 2, winY / 2 + 160 / 2 + 80, 200, 50, 10, 10, {content = "Exit"}, _, _, {
            onClick = function() love.event.quit() end
        })
    }),

    settings = Window:new({
        backButton = Button:new(20, 20, 50, 50, 10, 10, {content = "Back"}, _, _, {
            onClick = function() ui:setWindow(windows.mainMenu) end
        }),

        VSyncTitle = Label:new(420, 300, "VSync: ", 20, {1, 1, 1, 1}),
        VSyncSetting = CheckBox:new(500, 300)
    })
}

return windows