CheckBox = {}
CheckBox.__index = CheckBox

function CheckBox:new(x, y, width, height, rx, ry, color, audio, event)
    if not width then width = 25 end
    if not height then height = 25 end

    if not rx then rx = 3 end
    if not ry then ry = 3 end

    if not event then 

        event = {
            onClick = function() end,
            onHover = function() end
        } 
    end

    if not event.onClick then event.onClick = function() end end
    if not event.onHover then event.onHover = function() end end

    if not color then
        color = {
            default = {0.9, 0.9, 0.9, 1},
            hover = {0.7, 0.7, 0.7, 1},
            pressed = {0.5, 0.5, 0.5, 1}
        }
    end

    if not color.default then color.default = {0.9, 0.9, 0.9, 1} end
    if not color.hover then color.hover = {color.default[1] - 0.2, color.default[2] - 0.2, color.default[3] - 0.2, 1} end
    if not color.pressed then color.pressed = {color.default[1] - 0.4, color.default[2] - 0.4, color.default[3] - 0.4, 1} end

    if not audio then
        audio = {
            hover = love.audio.newSource("Audios/GUI_Sounds/Button/hover.mp3", "static"),
            click = love.audio.newSource("Audios/GUI_Sounds/Button/click.mp3", "static")
        }
    end

    if not audio.hover then audio.hover = love.audio.newSource("Audios/GUI_Sounds/Button/hover.mp3", "static") end
    if not audio.click then audio.click = love.audio.newSource("Audios/GUI_Sounds/Button/click.mp3", "static") end

    return setmetatable({
        x = x,
        y = y,
        rx = rx,
        ry = ry,

        width = width,
        height = height,

        event = event,

        audio = audio,

        currentColor = color.default,

        color = color,

        selected = false,

        isHover = nil,
        clicked = nil,
        clicked2 = nil,
        enter = nil,
        tap = nil
    }, CheckBox)
end

function CheckBox:checkEvents()
    if mouseCollide(self.x, self.y, self.width, self.height) then
        if love.mouse.isDown(1) then self.event.onClick() end

        self.event.onHover()
    end
end

function CheckBox:update()
    -- check for events
    self:checkEvents()

    self.isHover = mouseCollide(self.x, self.y, self.width, self.height)
    self.isDown = love.mouse.isDown(1)

    if self.enter then self.enter = false end

    if self.tap then self.tap = false end

    if self.isHover and not self.clicked then
        self.clicked = true
        self.enter = true

    elseif not self.isHover and self.clicked then self.clicked = false end

    if self.isDown and not self.clicked2 then
        self.clicked2 = true
        self.tap = true

    elseif not self.isDown and self.clicked2 then self.clicked2 = false end

    if mouseCollide(self.x, self.y, self.width, self.height) then
        self.currentColor = self.color.hover

        -- plays the hover sound
        if self.audio.hover and self.enter then love.audio.play(self.audio.hover) end

        if love.mouse.isDown(1) then
            self.currentColor = self.color.pressed

            -- plays the click sound
            if self.tap then 
                love.audio.play(self.audio.click)
                self.selected = not self.selected 
            end
        else
            self.currentColor = self.color.hover
        end
    else
        self.currentColor = self.color.default
    end
end

-- drawing function
function CheckBox:draw()
    if self.selected then drawFilledSymbol(self.x, self.y) end

    love.graphics.setColor(self.currentColor)
    love.graphics.rectangle("line", self.x, self.y, self.width, self.height, self.rx, self.ry)
end

-- checks if the mouse is colliding with a rectangle
function mouseCollide(x, y, width, height)
    local mouseX, mouseY = love.mouse.getPosition()
    if mouseX >= x and mouseX <= x + width and mouseY >= y and mouseY <= y + height then
        return true
    else
        return false
    end
end

function drawFilledSymbol(x, y)
    love.graphics.setColor(1, 0, 0)
    love.graphics.setLineWidth(2)
    love.graphics.line(x + 4, y + 11, x + 10, y + 20)
    love.graphics.line(x + 10, y + 20, x + 24, y + 2)
    love.graphics.setLineWidth(0)
end

return CheckBox