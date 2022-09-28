Button = {}
Button.__index = Button

function Button:new(x, y, width, height, rx, ry, text, color, audio, event)
    if not rx then rx = 0 end
    if not ry then ry = 0 end

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

    if not text then
        text = {
            content = "",
            font = love.graphics.newFont("GUI/Fonts/arial.ttf", 20),
            scale = 1,
            color = {0, 0, 0, 1}
        }

        text.font:setFilter("nearest", "nearest")
    end

    if not text.content then text.content = "" end
    if not text.font then text.font = love.graphics.newFont("GUI/Fonts/arial.ttf", 20) end
    if not text.scale then text.scale = 1 end
    if not text.color then text.color = {0, 0, 0, 1} end

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

        text = text,

        event = event,

        audio = audio,

        currentColor = color.default,

        color = color,

        isHover = nil,
        clicked = nil,
        clicked2 = nil,
        enter = nil,
        tap = nil
    }, Button)
end

function Button:checkEvents()
    if mouseCollide(self.x, self.y, self.width, self.height) then
        if love.mouse.isDown(1) then self.event.onClick() end

        self.event.onHover()
    end
end

function Button:update()
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

        if self.audio.hover and self.enter then
            love.audio.play(self.audio.hover)
        end

        if love.mouse.isDown(1) then
            self.currentColor = self.color.pressed

            if self.tap then love.audio.play(self.audio.click) end
        else
            self.currentColor = self.color.hover
        end
    else
        self.currentColor = self.color.default
    end
end

function Button:draw()
    love.graphics.setColor(self.currentColor)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height, self.rx, self.ry)

    love.graphics.setColor(self.text.color)
    love.graphics.setFont(self.text.font)
    drawCenteredText(self.x, self.y, self.width, self.height, self.text.content, self.text.scale)
end

function drawCenteredText(rectX, rectY, rectWidth, rectHeight, text, scale)
	local font = love.graphics.getFont()
	local textWidth = font:getWidth(text)
	local textHeight = font:getHeight()
	love.graphics.print(text, rectX+rectWidth/2, rectY+rectHeight/2, 0, scale, scale, textWidth/2, textHeight/2)
end

function mouseCollide(x, y, width, height)
    local mouseX, mouseY = love.mouse.getPosition()
    if mouseX >= x and mouseX <= x + width and mouseY >= y and mouseY <= y + height then
        return true
    else
        return false
    end
end

return Button