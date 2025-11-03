require "/scripts/util.lua"
require "/ffs_weapons/ffs_option/ffs_weapon.lua"
require "/ffs_weapons/ffs_lua_v2_right/ffs_alt_mlrs_basic.lua"

AltFireAttack = GunFire:new()

function AltFireAttack:new(abilityConfig)
  local primary = config.getParameter("primaryAbility")
  return GunFire.new(self, sb.jsonMerge(primary, abilityConfig))
end

function AltFireAttack:init()
  self.cooldownTimer = self.fireTime
end

function AltFireAttack:update(dt, fireMode, shiftHeld)
  WeaponAbility.update(self, dt, fireMode, shiftHeld)

  self.cooldownTimer = math.max(0, self.cooldownTimer - self.dt)

  if self.fireMode == "alt"
    and not self.weapon.currentAbility
    and self.cooldownTimer == 0
    and not world.lineTileCollision(mcontroller.position(), self:firePosition()) then
    
    if self.fireType == "auto" then
      self:setState(self.auto)
    end
  end
end

function AltFireAttack:firePosition()
  if self.firePositionPart then
    return vec2.add(mcontroller.position(), activeItem.handPosition(animator.partPoint(self.firePositionPart, "firePosition")))
  else
    return GunFire.firePosition(self)
  end
end
