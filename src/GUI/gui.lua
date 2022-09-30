GUI = {}
GUI.__index = GUI

function GUI:new()
    return setmetatable({
        currentWindow = nil
    }, GUI)
end

function GUI:setWindow(window)
    self.currentWindow = window
end

function GUI:update()
    self.currentWindow:update()
end

function GUI:draw()
    self.currentWindow:draw()
end

return GUI