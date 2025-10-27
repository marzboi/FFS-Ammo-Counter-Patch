function init()
  animator.setParticleEmitterOffsetRegion("ffs_concentration", mcontroller.boundBox())
  animator.setParticleEmitterEmissionRate("ffs_concentration", config.getParameter("emissionRate", 5))
  animator.setParticleEmitterActive("ffs_concentration", true)
end

function update(dt)
  mcontroller.controlModifiers({
	  movementSuppressed = false, 
      groundMovementModifier = 0.5,
      speedModifier = 0.5,
	  facingSuppressed = false,
	  runningSuppressed = true,
	  jumpingSuppressed = true
    })
end

function uninit()

end