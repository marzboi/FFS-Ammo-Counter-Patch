function init()
  animator.setParticleEmitterOffsetRegion("penetration", mcontroller.boundBox())
  animator.setParticleEmitterActive("penetration", true)
  animator.playSound("penetration", -1)
  effect.setParentDirectives("fade=AA0000=0.2")
  
  script.setUpdateDelta(5)

  self.tickTime = 999.0
  self.tickTimer = self.tickTime
  self.damage = 10

  status.applySelfDamageRequest({
      damageType = "IgnoresDef",
      damage = 10,
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
