function init()
  animator.setParticleEmitterOffsetRegion("energy", mcontroller.boundBox())
  animator.setParticleEmitterEmissionRate("energy", config.getParameter("emissionRate", 5))
  animator.setParticleEmitterActive("energy", true)

  effect.addStatModifierGroup({{stat = "maxEnergy", baseMultiplier = config.getParameter("energyAmount", 0.0)}})
  effect.addStatModifierGroup({{stat = "energyRegenPercentageRate", amount = config.getParameter("regenBonusAmount", 10)}})
  effect.addStatModifierGroup({{stat = "maxEnergy", amount = config.getParameter("energyAmount", 100)}})
end

function update(dt)
end

function uninit()
  effect.addStatModifierGroup({{stat = "maxEnergy", baseMultiplier = config.getParameter("energyAmount", 1.0)}})
end
