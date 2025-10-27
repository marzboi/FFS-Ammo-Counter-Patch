function init()
  animator.setParticleEmitterOffsetRegion("ffs_healing", mcontroller.boundBox())
  animator.setParticleEmitterActive("ffs_healing", config.getParameter("particles", true))
  effect.addStatModifierGroup({{stat = "ffs_bleedingImmunity", amount = 1}, {stat = "poisonStatusImmunity", amount = 1}, {stat = "fireStatusImmunity", amount = 1}, {stat = "iceStatusImmunity", amount = 1}, {stat = "electricStatusImmunity", amount = 1}, {stat = "lavaImmunity", amount = 1}})
  
  script.setUpdateDelta(5)

  self.healingRate = 1.0 / config.getParameter("healTime", 60)
end

function update(dt)
  status.modifyResourcePercentage("health", self.healingRate * dt)
end

function uninit()
  
end
