--[[
    GD50 2018
    Pong Remake

    -- Confetti Class --

    Author: Kevin Velazquez
    katz_powa@hotmail.com

    A small pixel that fly around the screen, starts with a random direction (dx & dy) but
    it's affected by gravity
]]

Confetti = Class{}

function Confetti:init(x, y, size, quantity)
    -- Origin point
    self.x = x
    self.y = y
    -- Gravity var
    self.gravity = 0.98 -- Second day using Lua, should constant variables be here?
    -- Size of each pellet (?)
    self.size = size
    -- How many pellet(s)
    self.quantity = quantity

    -- Each individual confetti will have its x, y, dX, dY and color
    confetti_table = {}
    for i = 1, self.quantity do
        attributes = {
            ['color'] = {['r'] = math.random(0, 255)/255, ['g'] = math.random(0, 255)/255, ['b'] = math.random(0, 255)/255},
            ['x'] = self.x + math.random(-5, 5),
            ['y'] = self.y + math.random(-5, 5),
            ['dx'] = math.random(-100, 100),
            ['dy'] = math.random(-280, -60)
        }
        table.insert(confetti_table, attributes)
    end
    self.confetti_table = confetti_table
end

function Confetti:reset()
    for i = 1, self.quantity do
        self.confetti_table[i].x = self.x + math.random(-5, 5)
        self.confetti_table[i].y = self.y + math.random(-5, 5)
        self.confetti_table[i].dx = math.random(-80, 80)
        self.confetti_table[i].dy = math.random(-220, -80)
    end
end

function Confetti:update(dt)
    for i = 1, self.quantity do
        self.confetti_table[i].x = self.confetti_table[i].x + self.confetti_table[i].dx * dt
        self.confetti_table[i].y = self.confetti_table[i].y + self.confetti_table[i].dy * dt
        self.confetti_table[i].dy = self.confetti_table[i].dy + self.gravity
    end
end

function Confetti:render()
    for i = 1, self.quantity do
        love.graphics.setColor(self.confetti_table[i].color['r'], self.confetti_table[i].color['g'], self.confetti_table[i].color['b'], 255)
        love.graphics.rectangle('fill', self.confetti_table[i].x, self.confetti_table[i].y, self.size, self.size)
    end
end