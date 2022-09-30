Window = {}
Window.__index = Window

function Window:new(components)
    return setmetatable({
        components = components
    }, Window)
end

function Window:setComponents(components)
    self.components = components
end

function Window:update()
    for i, component in pairs(self.components) do
        component:update()
    end
end

function Window:draw()
    for i, component in pairs(self.components) do
        component:draw()
    end
end

return Window