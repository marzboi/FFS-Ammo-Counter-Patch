function init()
  animator.setParticleEmitterOffsetRegion("ffs_at", mcontroller.boundBox())
  animator.setParticleEmitterEmissionRate("ffs_at", config.getParameter("emissionRate", 5))
  animator.setParticleEmitterActive("ffs_at", true)
end

function update(dt)
  mcontroller.controlModifiers({
	  movementSuppressed = false, 
	  facingSuppressed = false,
	  runningSuppressed = true,
	  jumpingSuppressed = true
    })
end

function uninit()

end