function init()
  animator.setParticleEmitterOffsetRegion("ffs_snipe", mcontroller.boundBox())
  animator.setParticleEmitterEmissionRate("ffs_snipe", config.getParameter("emissionRate", 5))
  animator.setParticleEmitterActive("ffs_snipe", true)
end

function update(dt)
  mcontroller.controlModifiers({
	  movementSuppressed = false, 
      groundMovementModifier = 0.0,
      speedModifier = 0.0,
	  facingSuppressed = false,
	  runningSuppressed = true,
	  jumpingSuppressed = true
    })
end

function uninit()

end