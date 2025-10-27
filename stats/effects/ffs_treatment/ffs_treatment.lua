function init()
  animator.setParticleEmitterOffsetRegion("ffs_treatment", mcontroller.boundBox())
  animator.setParticleEmitterEmissionRate("ffs_treatment", config.getParameter("emissionRate", 5))
  animator.setParticleEmitterActive("ffs_treatment", true)
end

function update(dt)
  mcontroller.controlModifiers({
      groundMovementModifier = 1.0,
      speedModifier = 1.0,
      airJumpModifier = 0.5,
	  movementSuppressed = true
    })
end

function uninit()

end