function init()
  self.maxDV = 15

  self.blinkTimer = 1.0
  self.lastSpeed = world.magnitude(mcontroller.velocity())
end

function update(dt)
  self.newSpeed = world.magnitude(mcontroller.velocity())

  self.blinkTimer = self.blinkTimer - dt
  if self.blinkTimer <= 0 then self.blinkTimer = 1.0 end

  if self.blinkTimer < 0.2 or self.newSpeed > self.maxDV then
    effect.setParentDirectives("")
  else
    effect.setParentDirectives("")
  end

  if math.abs(self.lastSpeed - self.newSpeed) > self.maxDV then
    world.spawnProjectile("ffs_airborne_explosion", mcontroller.position(), 0, {0, 0}, false, { timeToLive = 0 })
  end

  self.lastSpeed = self.newSpeed
end

function uninit()
  
end
