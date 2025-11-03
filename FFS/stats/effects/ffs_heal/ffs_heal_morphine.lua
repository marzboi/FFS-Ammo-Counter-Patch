function init()
  animator.setParticleEmitterOffsetRegion("ffs_healing", mcontroller.boundBox())
  animator.setParticleEmitterEmissionRate("ffs_healing", config.getParameter("emissionRate", 3))
  animator.setParticleEmitterActive("ffs_healing", true)
  
  script.setUpdateDelta(5)

  self.healingRate = config.getParameter("healAmount", 30) / effect.duration()
end

function update(dt)
  status.modifyResource("health", self.healingRate * dt)
end

function uninit()
  
end
