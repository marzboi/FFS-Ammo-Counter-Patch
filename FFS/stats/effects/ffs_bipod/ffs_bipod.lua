function init()
  animator.setParticleEmitterOffsetRegion("ffs_heavy", mcontroller.boundBox())
  animator.setParticleEmitterEmissionRate("ffs_heavy", config.getParameter("emissionRate", 5))
  animator.setParticleEmitterActive("ffs_heavy", true)
end

function update(dt)
  mcontroller.clearControls()
  mcontroller.controlModifiers({
	  movementSuppressed = false, 
      groundMovementModifier = 0.0,
      speedModifier = 0.0,
	  facingSuppressed = false,
	  runningSuppressed = true,
	  jumpingSuppressed = true
    })
  mcontroller.setVelocity({0, 0})
  mcontroller.controlCrouch()
  animator.setAnimationRate(0)
end

function uninit()
end