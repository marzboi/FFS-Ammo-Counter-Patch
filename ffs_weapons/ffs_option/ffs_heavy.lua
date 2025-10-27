require "/scripts/util.lua"
require "/scripts/vec2.lua"
require "/items/active/weapons/weapon.lua"

function init()
  activeItem.setCursor("/cursors/ffs_reticle0.cursor")
  animator.setGlobalTag("paletteSwaps", config.getParameter("paletteSwaps", ""))

  status.setResource("energy", 100)
  
  self.weapon = Weapon:new()

  self.weapon:addTransformationGroup("weapon", {0,0}, 0)

  local primaryAbility = getPrimaryAbility()
  self.weapon:addAbility(primaryAbility)

  local secondaryAbility = getAltAbility(self.weapon.elementalType)
  if secondaryAbility then
    self.weapon:addAbility(secondaryAbility)
  end

  self.weapon:init()
end

function update(dt, fireMode, shiftHeld)
  self.weapon:update(dt, fireMode, shiftHeld)
  mcontroller.controlModifiers({
      speedModifier = 1.0
    })
  mcontroller.controlModifiers({
      airJumpModifier = 1.0
    })
  mcontroller.controlModifiers({
	  runningSuppressed = true
    })
  status.setResourcePercentage("energyRegenBlock", 1.0)
end

function uninit()
  self.weapon:uninit()
end
