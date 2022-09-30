Label = {}
Label.__index = Label

function Label:new(x, y, text, size, color, font)
    if not size then size = 20 end

    if not font then font = love.graphics.newFont("GUI/Fonts/arial.ttf", size) end
    if not color then color = {0, 0, 0, 1} end

    return setmetatable({
        x = x,
        y = y,
        size = size,
        text = text,
        font = font,
        color = color
    }, Label)
end

function Label:update() end

function Label:draw()
    love.graphics.setFont(self.font)
    love.graphics.setColor(self.color)
    love.graphics.print(self.text, self.x, self.y)
end

return Label