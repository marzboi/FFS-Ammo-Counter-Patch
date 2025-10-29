require "/scripts/util.lua"
require "/scripts/interp.lua"

-- Base gun fire ability
GunFire = WeaponAbility:new()

function GunFire:init()
  self.weapon:setStance(self.stances.idle)

  self.cooldownTimer = 0

  self.weapon.onLeaveAbility = function()
    self.weapon:setStance(self.stances.idle)
  end
end

function GunFire:update(dt, fireMode, shiftHeld)
  WeaponAbility.update(self, dt, fireMode, shiftHeld)

  self.cooldownTimer = 0

  if self.fireMode == (self.activatingFireMode or self.abilitySlot)
      and not self.weapon.currentAbility
      and self.cooldownTimer == 0
      and not world.lineTileCollision(mcontroller.position(), self:firePosition()) then
    if self.fireType == "auto" then
      self:setState(self.reload)
    end
  end
end

function GunFire:reload()
  while self.fireMode == (self.activatingFireMode or self.abilitySlot) and storage.totalAmmo < storage.maxAmmo do
    storage.totalAmmo = 0
    storage.magazineIn = false
    animator.playSound("reload_1")
    self.weapon:setStance(self.stances.fire)
    self:fireProjectile()

    local progress = 0
    util.wait(self.stances.fire.duration, function()
      local from = self.stances.fire.weaponOffset or { 0, 0 }
      local to = self.stances.motion1.weaponOffset or { 0, 0 }
      self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2], to[2]) }

      self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress, self.stances.fire.weaponRotation,
        self.stances.motion1.weaponRotation))
      self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.fire.armRotation,
        self.stances.motion1.armRotation))

      progress = math.min(1.0, progress + (self.dt / self.stances.fire.duration))
    end)

    self.weapon:setStance(self.stances.motion1)

    local progress = 0
    util.wait(self.stances.motion1.duration, function()
      local from = self.stances.motion1.weaponOffset or { 0, 0 }
      local to = self.stances.motion2.weaponOffset or { 0, 0 }
      self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2], to[2]) }

      self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress, self.stances.motion1.weaponRotation,
        self.stances.motion2.weaponRotation))
      self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.motion1.armRotation,
        self.stances.motion2.armRotation))

      progress = math.min(1.0, progress + (self.dt / self.stances.motion1.duration))
    end)

    self.weapon:setStance(self.stances.motion2)

    local progress = 0
    util.wait(self.stances.motion2.duration, function()
      local from = self.stances.motion2.weaponOffset or { 0, 0 }
      local to = self.stances.motion3.weaponOffset or { 0, 0 }
      self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2], to[2]) }

      self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress, self.stances.motion2.weaponRotation,
        self.stances.motion3.weaponRotation))
      self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.motion2.armRotation,
        self.stances.motion3.armRotation))

      progress = math.min(1.0, progress + (self.dt / self.stances.motion2.duration))
    end)

    self.weapon:setStance(self.stances.motion3)

    local progress = 0
    util.wait(self.stances.motion3.duration, function()
      local from = self.stances.motion3.weaponOffset or { 0, 0 }
      local to = self.stances.motion4.weaponOffset or { 0, 0 }
      self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2], to[2]) }

      self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress, self.stances.motion3.weaponRotation,
        self.stances.motion4.weaponRotation))
      self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.motion3.armRotation,
        self.stances.motion4.armRotation))

      progress = math.min(1.0, progress + (self.dt / self.stances.motion3.duration))
    end)

    self.weapon:setStance(self.stances.motion4)
    animator.playSound("reload_2")

    local progress = 0
    util.wait(self.stances.motion4.duration, function()
      local from = self.stances.motion4.weaponOffset or { 0, 0 }
      local to = self.stances.motion5.weaponOffset or { 0, 0 }
      self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2], to[2]) }

      self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress, self.stances.motion4.weaponRotation,
        self.stances.motion5.weaponRotation))
      self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.motion4.armRotation,
        self.stances.motion5.armRotation))

      progress = math.min(1.0, progress + (self.dt / self.stances.motion4.duration))
    end)

    self.weapon:setStance(self.stances.motion5)

    local progress = 0
    util.wait(self.stances.motion5.duration, function()
      local from = self.stances.motion5.weaponOffset or { 0, 0 }
      local to = self.stances.motion6.weaponOffset or { 0, 0 }
      self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2], to[2]) }

      self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress, self.stances.motion5.weaponRotation,
        self.stances.motion6.weaponRotation))
      self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.motion5.armRotation,
        self.stances.motion6.armRotation))

      progress = math.min(1.0, progress + (self.dt / self.stances.motion5.duration))
    end)

    self.weapon:setStance(self.stances.motion6)

    local progress = 0
    util.wait(self.stances.motion6.duration, function()
      local from = self.stances.motion6.weaponOffset or { 0, 0 }
      local to = self.stances.motion7.weaponOffset or { 0, 0 }
      self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2], to[2]) }

      self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress, self.stances.motion6.weaponRotation,
        self.stances.motion7.weaponRotation))
      self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.motion6.armRotation,
        self.stances.motion7.armRotation))

      progress = math.min(1.0, progress + (self.dt / self.stances.motion6.duration))
    end)

    self.weapon:setStance(self.stances.motion7)

    local progress = 0
    util.wait(self.stances.motion7.duration, function()
      local from = self.stances.motion7.weaponOffset or { 0, 0 }
      local to = self.stances.motion8.weaponOffset or { 0, 0 }
      self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2], to[2]) }

      self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress, self.stances.motion7.weaponRotation,
        self.stances.motion8.weaponRotation))
      self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.motion7.armRotation,
        self.stances.motion8.armRotation))

      progress = math.min(1.0, progress + (self.dt / self.stances.motion7.duration))
    end)

    self.weapon:setStance(self.stances.motion8)
    animator.playSound("reload_3")

    local progress = 0
    util.wait(self.stances.motion8.duration, function()
      local from = self.stances.motion8.weaponOffset or { 0, 0 }
      local to = self.stances.motion9.weaponOffset or { 0, 0 }
      self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2], to[2]) }

      self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress, self.stances.motion8.weaponRotation,
        self.stances.motion9.weaponRotation))
      self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.motion8.armRotation,
        self.stances.motion9.armRotation))

      progress = math.min(1.0, progress + (self.dt / self.stances.motion8.duration))
    end)

    self.weapon:setStance(self.stances.motion9)

    local progress = 0
    util.wait(self.stances.motion9.duration, function()
      local from = self.stances.motion9.weaponOffset or { 0, 0 }
      local to = self.stances.motion10.weaponOffset or { 0, 0 }
      self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2], to[2]) }

      self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress, self.stances.motion9.weaponRotation,
        self.stances.motion10.weaponRotation))
      self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.motion9.armRotation,
        self.stances.motion10.armRotation))

      progress = math.min(1.0, progress + (self.dt / self.stances.motion9.duration))
    end)

    self.weapon:setStance(self.stances.motion10)

    local progress = 0
    util.wait(self.stances.motion10.duration, function()
      local from = self.stances.motion10.weaponOffset or { 0, 0 }
      local to = self.stances.motion11.weaponOffset or { 0, 0 }
      self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2], to[2]) }

      self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress, self.stances.motion10.weaponRotation,
        self.stances.motion11.weaponRotation))
      self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.motion10.armRotation,
        self.stances.motion11.armRotation))

      progress = math.min(1.0, progress + (self.dt / self.stances.motion10.duration))
    end)

    self.weapon:setStance(self.stances.motion11)

    local progress = 0
    util.wait(self.stances.motion11.duration, function()
      local from = self.stances.motion11.weaponOffset or { 0, 0 }
      local to = self.stances.motion12.weaponOffset or { 0, 0 }
      self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2], to[2]) }

      self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress, self.stances.motion11.weaponRotation,
        self.stances.motion12.weaponRotation))
      self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.motion11.armRotation,
        self.stances.motion12.armRotation))

      progress = math.min(1.0, progress + (self.dt / self.stances.motion11.duration))
    end)

    self.weapon:setStance(self.stances.motion12)
    animator.playSound("reload_4")

    local progress = 0
    util.wait(self.stances.motion12.duration, function()
      local from = self.stances.motion12.weaponOffset or { 0, 0 }
      local to = self.stances.motion13.weaponOffset or { 0, 0 }
      self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2], to[2]) }

      self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress, self.stances.motion12.weaponRotation,
        self.stances.motion13.weaponRotation))
      self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.motion12.armRotation,
        self.stances.motion13.armRotation))

      progress = math.min(1.0, progress + (self.dt / self.stances.motion12.duration))
    end)

    self.weapon:setStance(self.stances.motion13)

    local progress = 0
    util.wait(self.stances.motion13.duration, function()
      local from = self.stances.motion13.weaponOffset or { 0, 0 }
      local to = self.stances.motion14.weaponOffset or { 0, 0 }
      self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2], to[2]) }

      self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress, self.stances.motion13.weaponRotation,
        self.stances.motion14.weaponRotation))
      self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.motion13.armRotation,
        self.stances.motion14.armRotation))

      progress = math.min(1.0, progress + (self.dt / self.stances.motion13.duration))
    end)

    self.weapon:setStance(self.stances.motion14)

    local progress = 0
    util.wait(self.stances.motion14.duration, function()
      local from = self.stances.motion14.weaponOffset or { 0, 0 }
      local to = self.stances.motion15.weaponOffset or { 0, 0 }
      self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2], to[2]) }

      self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress, self.stances.motion14.weaponRotation,
        self.stances.motion15.weaponRotation))
      self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.motion14.armRotation,
        self.stances.motion15.armRotation))

      progress = math.min(1.0, progress + (self.dt / self.stances.motion14.duration))
    end)

    self.weapon:setStance(self.stances.motion15)

    local progress = 0
    util.wait(self.stances.motion15.duration, function()
      local from = self.stances.motion15.weaponOffset or { 0, 0 }
      local to = self.stances.motion16.weaponOffset or { 0, 0 }
      self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2], to[2]) }

      self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress, self.stances.motion15.weaponRotation,
        self.stances.motion16.weaponRotation))
      self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.motion15.armRotation,
        self.stances.motion16.armRotation))

      progress = math.min(1.0, progress + (self.dt / self.stances.motion15.duration))
    end)

    self.weapon:setStance(self.stances.motion16)

    local progress = 0
    util.wait(self.stances.motion16.duration, function()
      local from = self.stances.motion16.weaponOffset or { 0, 0 }
      local to = self.stances.motion17.weaponOffset or { 0, 0 }
      self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2], to[2]) }

      self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress, self.stances.motion16.weaponRotation,
        self.stances.motion17.weaponRotation))
      self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.motion16.armRotation,
        self.stances.motion17.armRotation))

      progress = math.min(1.0, progress + (self.dt / self.stances.motion16.duration))
    end)

    self.weapon:setStance(self.stances.motion17)
    animator.playSound("reload_5")

    local progress = 0
    util.wait(self.stances.motion17.duration, function()
      local from = self.stances.motion17.weaponOffset or { 0, 0 }
      local to = self.stances.motion18.weaponOffset or { 0, 0 }
      self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2], to[2]) }

      self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress, self.stances.motion17.weaponRotation,
        self.stances.motion18.weaponRotation))
      self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.motion17.armRotation,
        self.stances.motion18.armRotation))

      progress = math.min(1.0, progress + (self.dt / self.stances.motion17.duration))
    end)

    self.weapon:setStance(self.stances.motion18)

    local progress = 0
    util.wait(self.stances.motion18.duration, function()
      local from = self.stances.motion18.weaponOffset or { 0, 0 }
      local to = self.stances.motion19.weaponOffset or { 0, 0 }
      self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2], to[2]) }

      self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress, self.stances.motion18.weaponRotation,
        self.stances.motion19.weaponRotation))
      self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.motion18.armRotation,
        self.stances.motion19.armRotation))

      progress = math.min(1.0, progress + (self.dt / self.stances.motion18.duration))
    end)

    self.weapon:setStance(self.stances.motion19)

    local progress = 0
    util.wait(self.stances.motion19.duration, function()
      local from = self.stances.motion19.weaponOffset or { 0, 0 }
      local to = self.stances.motion20.weaponOffset or { 0, 0 }
      self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2], to[2]) }

      self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress, self.stances.motion19.weaponRotation,
        self.stances.motion20.weaponRotation))
      self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.motion19.armRotation,
        self.stances.motion20.armRotation))

      progress = math.min(1.0, progress + (self.dt / self.stances.motion19.duration))
    end)

    self.weapon:setStance(self.stances.motion20)

    local progress = 0
    util.wait(self.stances.motion20.duration, function()
      local from = self.stances.motion20.weaponOffset or { 0, 0 }
      local to = self.stances.cooldown.weaponOffset or { 0, 0 }
      self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2], to[2]) }

      self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress, self.stances.motion20.weaponRotation,
        self.stances.cooldown.weaponRotation))
      self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.motion20.armRotation,
        self.stances.cooldown.armRotation))

      progress = math.min(1.0, progress + (self.dt / self.stances.motion20.duration))
    end)

    self.weapon:setStance(self.stances.cooldown)
    self.weapon:updateAim()

    local progress = 0
    util.wait(self.stances.cooldown.duration, function()
      local from = self.stances.cooldown.weaponOffset or { 0, 0 }
      local to = self.stances.idle.weaponOffset or { 0, 0 }
      self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2], to[2]) }

      self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress, self.stances.cooldown.weaponRotation,
        self.stances.idle.weaponRotation))
      self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.cooldown.armRotation,
        self.stances.idle.armRotation))

      progress = math.min(1.0, progress + (self.dt / self.stances.cooldown.duration))
    end)

    storage.totalAmmo = storage.maxAmmo
    storage.magazineIn = true
  end
end

function GunFire:fireProjectile(projectileType, projectileParams, inaccuracy, firePosition, projectileCount)
  local params = sb.jsonMerge(self.projectileParameters, projectileParams or {})
  params.power = self:damagePerShot()
  params.powerMultiplier = activeItem.ownerPowerMultiplier()
  params.speed = util.randomInRange(params.speed)

  if not projectileType then
    projectileType = self.projectileType
  end
  if type(projectileType) == "table" then
    projectileType = projectileType[math.random(#projectileType)]
  end

  local projectileId = 0
  for i = 1, (projectileCount or self.projectileCount) do
    if params.timeToLive then
      params.timeToLive = util.randomInRange(params.timeToLive)
    end

    projectileId = world.spawnProjectile(
      projectileType,
      firePosition or self:firePosition(),
      activeItem.ownerEntityId(),
      self:aimVector(inaccuracy or self.inaccuracy),
      false,
      params
    )
  end
  return projectileId
end

function GunFire:firePosition()
  return vec2.add(mcontroller.position(), activeItem.handPosition(self.weapon.muzzleOffset))
end

function GunFire:aimVector(inaccuracy)
  local aimVector = vec2.rotate({ 1, 0 }, self.weapon.aimAngle + sb.nrand(inaccuracy, 0))
  aimVector[1] = aimVector[1] * mcontroller.facingDirection()
  return aimVector
end

function GunFire:damagePerShot()
  return (self.baseDamage or self.baseDps) * (self.baseDamageMultiplier or 1.0) *
      config.getParameter("damageLevelMultiplier") / self.projectileCount
end

function GunFire:uninit()
end
