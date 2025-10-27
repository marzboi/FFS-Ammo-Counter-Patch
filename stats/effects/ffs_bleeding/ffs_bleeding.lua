function init()
  animator.setParticleEmitterOffsetRegion("bleed", mcontroller.boundBox())
  animator.setParticleEmitterActive("bleed", true)
  animator.setParticleEmitterActive("bleed2", true)
  animator.playSound("bleed", -1)
  effect.setParentDirectives("fade=AA0000=0.2")
  
  script.setUpdateDelta(5)

  self.tickTime = 1.0
  self.tickTimer = self.tickTime
  self.damage = 3

  status.applySelfDamageRequest({
      damageType = "IgnoresDef",
      damage = 3,
      damageSourceKind = "default",
      sourceEntityId = entity.id()
    })
end

function update(dt)
  self.tickTimer = self.tickTimer - dt
  if self.tickTimer <= 0 then
    self.tickTimer = self.tickTime
    self.damage = self.damage
    status.applySelfDamageRequest({
        damageType = "IgnoresDef",
        damage = self.damage,
        damageSourceKind = "default",
        sourceEntityId = entity.id()
      })
  end
end

function uninit()
  
end
