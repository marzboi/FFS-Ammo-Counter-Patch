function init()
  animator.setParticleEmitterOffsetRegion("bleed", mcontroller.boundBox())
  animator.setParticleEmitterActive("bleed", true)
  animator.playSound("bleed", -1)
  
  script.setUpdateDelta(5)

  self.tickDamagePercentage = 0.025
  self.tickTime = 1.0
  self.tickTimer = self.tickTime
end

function update(dt)
  self.tickTimer = self.tickTimer - dt
  if self.tickTimer <= 0 then
    self.tickTimer = self.tickTime
    status.applySelfDamageRequest({
        damageType = "IgnoresDef",
        damage = math.floor(status.resourceMax("health") * self.tickDamagePercentage) + 1,
        damageSourceKind = "default",
        sourceEntityId = entity.id()
      })
  end
  
  effect.setParentDirectives(string.format("fade=AA0000=%.1f", self.tickTimer * 0.4))
end

function uninit()
  
end
