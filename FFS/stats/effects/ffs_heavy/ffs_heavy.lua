function init()
  animator.setParticleEmitterOffsetRegion("ffs_heavy", mcontroller.boundBox())
  animator.setParticleEmitterEmissionRate("ffs_heavy", config.getParameter("emissionRate", 5))
  animator.setParticleEmitterActive("ffs_heavy", true)
end

function update(dt)
  mcontroller.controlModifiers({
	  movementSuppressed = false, 
      groundMovementModifier = 1.0,
      speedModifier = 1.0,
	  facingSuppressed = false,
	  runningSuppressed = true,
	  jumpingSuppressed = true
    })
end

function uninit()
end