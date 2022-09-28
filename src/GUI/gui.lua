GUI = {}
GUI.__index = GUI

function GUI:new()
    return setmetatable({
        game = {
            mainMenu = {}
        }
    }, GUI)
end

function GUI:update()
    for i, component in pairs(self.game.mainMenu) do
        component:update()
    end
end

function GUI:draw()
    for i, component in pairs(self.game.mainMenu) do
        component:draw()
    end
end

return GUI