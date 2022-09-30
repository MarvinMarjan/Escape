GUI = require "GUI/gui"
Window = require "Window/window"

Button = require "GUI/Components/Button/button"
CheckBox = require "GUI/Components/CheckBox/checkbox"
Label = require "GUI/Components/Label/label" 

Mouse = require "Mouse/mouse"

windows = require "Window/windows_def"


settings = require "Settings/settings"
require "Settings/settings_funcs"



debug_mode = false
debug_points = {}

function love.load()
    winX, winY = love.window.getMode()
    mouse = Mouse:new()

    ui = GUI:new()

    ui:setWindow(windows.mainMenu)
end

function love.update(dt)
    mouse:update(dt)
    
    ui:update()

    love.window.setVSync(settings.VSync) -- improve this
end

function love.draw()
    ui:draw()
    
    mouse:draw()

    -- debug
    if debug_mode then
        love.graphics.print("Mouse X: " .. love.mouse.getX() .. " Mouse Y: " .. love.mouse.getY(), 10, 10)

        if love.mouse.isDown(1) then
            table.insert(debug_points, {x = love.mouse.getX(), y = love.mouse.getY()})
        end

        for i, v in ipairs(debug_points) do
            love.graphics.circle("fill", v.x, v.y, 2)
        end
    end
end