GUI = require "GUI/gui"

Button = require "GUI/Components/Button/button"
Mouse = require "Mouse/mouse"

function love.load()
    winX, winY = love.window.getMode()
    mouse = Mouse:new()

    ui = GUI:new()

    ui.game.mainMenu = {
        playButton = Button:new(winX / 2 - 200 / 2, winY / 2 + 40, 200, 50, 10, 10, {content = "Play"}, _, _),
        settingButton = Button:new(winX / 2 - 200 / 2, winY / 2 + 80 / 2 + 60, 200, 50, 10, 10, {content = "Setting"}, _, _),
        exitButton = Button:new(winX / 2 - 200 / 2, winY / 2 + 160 / 2 + 80, 200, 50, 10, 10, {content = "Exit"}, _, _, {
            onClick = function() love.event.quit() end
        })
    }
end

function love.update(dt)
    mouse:update(dt)

    
    ui:update()
end

function love.draw()
    
    ui:draw()
    
    mouse:draw()
end