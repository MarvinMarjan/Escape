Particle = require "Particle/particle_obj"

Mouse = {}
Mouse.__index = Mouse

function Mouse:new()
    love.mouse.setVisible(false)

    return setmetatable({
        x = nil,
        y = nil,

        isDown = nil,
        clicked = nil,
        tap = nil,

        color = {1, 1, 0.4, 0.5},

        trace = Particle:new(_, 1000, {0, 1.4}, 60, 0.4, {-30, -30, 30, 30}, {1, 1, 1, 1})
    }, Mouse)
end

function Mouse:update(dt)
    self.x, self.y = love.mouse.getPosition()
    self.isDown = love.mouse.isDown(1)

    if self.tap then
        self.tap = false
    end

    if self.isDown and not self.clicked then
        self.clicked = true
        self.tap = true

    elseif not self.isDown and self.clicked then
        self.clicked = false
    end

    if self.tap then
        self.trace.particle:setPosition(self.x, self.y)
        self.trace.particle:setParticleLifetime(0, 0.6)
        self.trace.particle:setLinearAcceleration(-170, -170, 170, 170)
        self.trace.particle:emit(120)

    else
        self.trace.particle:setParticleLifetime(0, 1.4)
        self.trace.particle:setLinearAcceleration(-30, -30, 30, 30)
    end

    self.trace.particle:setPosition(self.x, self.y)
    self.trace:update(dt)
end

function Mouse:draw()
    love.graphics.setColor(self.color)
    love.graphics.circle("fill", self.x, self.y, 4)

    self.trace:draw(self.x, self.y)
end

return Mouse