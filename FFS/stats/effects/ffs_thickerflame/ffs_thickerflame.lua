function init()
  animator.setParticleEmitterOffsetRegion("ffs_thicker", mcontroller.boundBox())
  animator.setParticleEmitterActive("ffs_thicker", true)
  effect.setParentDirectives("fade=FF8800=0.2")

  script.setUpdateDelta(5)

  self.tickTime = 0.5
  self.tickTimer = self.tickTime
  self.damage = 3

  status.applySelfDamageRequest({
      damageType = "IgnoresDef",
      damage = 3,
      damageSourceKind = "fire",
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
        damageSourceKind = "fire",
        sourceEntityId = entity.id()
      })
  end
end

function onExpire()
end
