function init()
  animator.setParticleEmitterOffsetRegion("armorcrushing", mcontroller.boundBox())
  animator.setParticleEmitterActive("armorcrushing", true)
  animator.playSound("armorcrushing")
  effect.setParentDirectives("fade=AA0000=0.2")
  effect.setStatModifierGroup({
   stat = "protection", baseMultiplier = 0.5
 --OR amount = 50
 --OR baseMultiplier = 1.5
 --OR effectiveMultiplier = 1.5
  })
  script.setUpdateDelta(5)
end

function update(dt)
end

function uninit()
  
end
