Particle = {}
Particle.__index = Particle

function Particle:new(img, buffer, lifeTime, emissionRate, sizeVariation, linearAcceleration, color)
    if not img then
        img = love.graphics.newCanvas(4, 4)

        love.graphics.setCanvas(img)
            love.graphics.setColor(color)
            love.graphics.rectangle("fill", 0, 0, 4, 4)
        love.graphics.setCanvas()
    end

    particle = love.graphics.newParticleSystem(img, buffer)

    particle:setParticleLifetime(lifeTime[1], lifeTime[2])
    particle:setEmissionRate(emissionRate)
    particle:setSizeVariation(sizeVariation)
    particle:setLinearAcceleration(linearAcceleration[1], linearAcceleration[2], linearAcceleration[3], linearAcceleration[4])
    particle:setColors(1, 1, 1, 1, 1, 1, 1, 0)

    return setmetatable({
        particle = particle
    }, Particle)
end

function Particle:update(dt)
    self.particle:update(dt)
end

function Particle:draw()
    love.graphics.draw(self.particle)
end

return Particle