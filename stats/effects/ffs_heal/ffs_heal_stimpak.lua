function init()
  animator.setParticleEmitterOffsetRegion("ffs_healing", mcontroller.boundBox())
  animator.setParticleEmitterEmissionRate("ffs_healing", config.getParameter("emissionRate", 3))
  animator.setParticleEmitterActive("ffs_healing", true)
  effect.addStatModifierGroup({{stat = "ffs_bleedingImmunity", amount = 1}, {stat = "injuryImmunity", amount = 1}, {stat = "poisonStatusImmunity", amount = 1}, {stat = "fireStatusImmunity", amount = 1}, {stat = "iceStatusImmunity", amount = 1}, {stat = "electricStatusImmunity", amount = 1}, {stat = "ffs_thickerflameImmunity", amount = 1}, {stat = "lavaImmunity", amount = 1}})

  script.setUpdateDelta(5)

  self.healingRate = config.getParameter("healAmount", 30) / effect.duration()
end

function update(dt)
  status.modifyResource("health", self.healingRate * dt)
end

function uninit()
  
end
