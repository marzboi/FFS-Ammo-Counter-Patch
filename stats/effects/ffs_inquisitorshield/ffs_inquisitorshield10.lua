require "/scripts/status.lua"

function init()
  self.listener = damageListener("damageTaken", function()
    animator.setAnimationState("shield", "hit")
  end)

  effect.addStatModifierGroup({
    {stat = "physicalResistance", amount = 0.1}
  })
end

function update(dt)
  self.listener:update()
end
