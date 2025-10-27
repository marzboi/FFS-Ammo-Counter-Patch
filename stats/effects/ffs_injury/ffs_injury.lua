function init()
  animator.setParticleEmitterOffsetRegion("injury", mcontroller.boundBox())
  animator.setParticleEmitterActive("injury", true)
  animator.playSound("injury", -1)
  effect.setParentDirectives("fade=AA0000=0.2")
  
  script.setUpdateDelta(5)

  self.tickTime = 999.0
  self.tickTimer = self.tickTime
  self.damage = 20

  status.applySelfDamageRequest({
      damageType = "IgnoresDef",
      damage = 20,
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
  mcontroller.controlModifiers({
      groundMovementModifier = 0.5,
      speedModifier = 0.5,
      airJumpModifier = 0.5,
	  runningSuppressed = true
    })
end

function uninit()
  
end
