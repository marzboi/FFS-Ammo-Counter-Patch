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
  status.addEphemeralEffect("ffs_fixmag")

  self.cooldownTimer = math.max(0, self.cooldownTimer - self.dt)

  if self.fireMode == (self.activatingFireMode or self.abilitySlot)
      and not self.weapon.currentAbility
      and self.cooldownTimer == 0
      and not world.lineTileCollision(mcontroller.position(), self:firePosition()) then
    if self.fireType == "auto" then
      self:setState(self.auto)
    end
  end
end

function GunFire:auto()
  self.weapon:setStance(self.stances.fire)

  while self.fireMode == (self.activatingFireMode or self.abilitySlot) and storage.totalAmmo >= 1 do
    self.weapon:setStance(self.stances.fire)
    if self.stances.fire.duration then
      util.wait(self.stances.fire.duration)
    end

    self.weapon:setStance(self.stances.motion1)
    if self.stances.motion1.duration then
      util.wait(self.stances.motion1.duration)
    end

    self:fireProjectile()
    self:consumeAmmo()
    animator.playSound("fireSingle")

    if self.stances.fire.duration then
      util.wait(self.fireTime - (self.stances.fire.duration + self.stances.motion1.duration))
    end
  end

  self:setState(self.cooldown)
end

function GunFire:motion1()
  self.weapon:setStance(self.stances.motion1)

  local progress = 0
  util.wait(self.stances.motion1.duration, function()
    local from = self.stances.motion1.weaponOffset or { 0, 0 }
    local to = self.stances.cooldown.weaponOffset or { 0, 0 }
    self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2], to[2]) }

    self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress, self.stances.motion1.weaponRotation,
      self.stances.cooldown.weaponRotation))
    self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.motion1.armRotation,
      self.stances.cooldown.armRotation))

    progress = math.min(1.0, progress + (self.dt / self.stances.motion1.duration))
  end)
end

function GunFire:cooldown()
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

  item.consume(1)

  if storage.totalAmmo < 1 then
    storage.totalAmmo = 0
    animator.playSound("reload_1")
    self.weapon:setStance(self.stances.reloadmotion1)
    self:firemagazineProjectile()

    local progress = 0
    util.wait(self.stances.reloadmotion1.duration, function()
      local from = self.stances.reloadmotion1.weaponOffset or { 0, 0 }
      local to = self.stances.reloadmotion2.weaponOffset or { 0, 0 }
      self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2], to[2]) }

      self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress,
        self.stances.reloadmotion1.weaponRotation, self.stances.reloadmotion2.weaponRotation))
      self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.reloadmotion1.armRotation,
        self.stances.reloadmotion2.armRotation))

      progress = math.min(1.0, progress + (self.dt / self.stances.reloadmotion1.duration))
    end)

    self.weapon:setStance(self.stances.reloadmotion2)

    local progress = 0
    util.wait(self.stances.reloadmotion2.duration, function()
      local from = self.stances.reloadmotion2.weaponOffset or { 0, 0 }
      local to = self.stances.reloadmotion3.weaponOffset or { 0, 0 }
      self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2], to[2]) }

      self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress,
        self.stances.reloadmotion2.weaponRotation, self.stances.reloadmotion3.weaponRotation))
      self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.reloadmotion2.armRotation,
        self.stances.reloadmotion3.armRotation))

      progress = math.min(1.0, progress + (self.dt / self.stances.reloadmotion2.duration))
    end)

    self.weapon:setStance(self.stances.reloadmotion3)
    animator.setParticleEmitterActive("smoke", false)

    local progress = 0
    util.wait(self.stances.reloadmotion3.duration, function()
      local from = self.stances.reloadmotion3.weaponOffset or { 0, 0 }
      local to = self.stances.reloadmotion4.weaponOffset or { 0, 0 }
      self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2], to[2]) }

      self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress,
        self.stances.reloadmotion3.weaponRotation, self.stances.reloadmotion4.weaponRotation))
      self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.reloadmotion3.armRotation,
        self.stances.reloadmotion4.armRotation))

      progress = math.min(1.0, progress + (self.dt / self.stances.reloadmotion3.duration))
    end)

    self.weapon:setStance(self.stances.reloadmotion4)
    animator.playSound("reload_2")

    local progress = 0
    util.wait(self.stances.reloadmotion4.duration, function()
      local from = self.stances.reloadmotion4.weaponOffset or { 0, 0 }
      local to = self.stances.reloadmotion5.weaponOffset or { 0, 0 }
      self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2], to[2]) }

      self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress,
        self.stances.reloadmotion4.weaponRotation, self.stances.reloadmotion5.weaponRotation))
      self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.reloadmotion4.armRotation,
        self.stances.reloadmotion5.armRotation))

      progress = math.min(1.0, progress + (self.dt / self.stances.reloadmotion4.duration))
    end)

    self.weapon:setStance(self.stances.reloadmotion5)

    local progress = 0
    util.wait(self.stances.reloadmotion5.duration, function()
      local from = self.stances.reloadmotion5.weaponOffset or { 0, 0 }
      local to = self.stances.reloadmotion6.weaponOffset or { 0, 0 }
      self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2], to[2]) }

      self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress,
        self.stances.reloadmotion5.weaponRotation, self.stances.reloadmotion6.weaponRotation))
      self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.reloadmotion5.armRotation,
        self.stances.reloadmotion6.armRotation))

      progress = math.min(1.0, progress + (self.dt / self.stances.reloadmotion5.duration))
    end)

    self.weapon:setStance(self.stances.reloadmotion6)

    local progress = 0
    util.wait(self.stances.reloadmotion6.duration, function()
      local from = self.stances.reloadmotion6.weaponOffset or { 0, 0 }
      local to = self.stances.reloadmotion7.weaponOffset or { 0, 0 }
      self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2], to[2]) }

      self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress,
        self.stances.reloadmotion6.weaponRotation, self.stances.reloadmotion7.weaponRotation))
      self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.reloadmotion6.armRotation,
        self.stances.reloadmotion7.armRotation))

      progress = math.min(1.0, progress + (self.dt / self.stances.reloadmotion6.duration))
    end)

    self.weapon:setStance(self.stances.reloadmotion7)

    local progress = 0
    util.wait(self.stances.reloadmotion7.duration, function()
      local from = self.stances.reloadmotion7.weaponOffset or { 0, 0 }
      local to = self.stances.reloadmotion8.weaponOffset or { 0, 0 }
      self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2], to[2]) }

      self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress,
        self.stances.reloadmotion7.weaponRotation, self.stances.reloadmotion8.weaponRotation))
      self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.reloadmotion7.armRotation,
        self.stances.reloadmotion8.armRotation))

      progress = math.min(1.0, progress + (self.dt / self.stances.reloadmotion7.duration))
    end)

    self.weapon:setStance(self.stances.reloadmotion8)
    animator.playSound("reload_3")

    local progress = 0
    util.wait(self.stances.reloadmotion8.duration, function()
      local from = self.stances.reloadmotion8.weaponOffset or { 0, 0 }
      local to = self.stances.reloadmotion9.weaponOffset or { 0, 0 }
      self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2], to[2]) }

      self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress,
        self.stances.reloadmotion8.weaponRotation, self.stances.reloadmotion9.weaponRotation))
      self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.reloadmotion8.armRotation,
        self.stances.reloadmotion9.armRotation))

      progress = math.min(1.0, progress + (self.dt / self.stances.reloadmotion8.duration))
    end)

    self.weapon:setStance(self.stances.reloadmotion9)

    local progress = 0
    util.wait(self.stances.reloadmotion9.duration, function()
      local from = self.stances.reloadmotion9.weaponOffset or { 0, 0 }
      local to = self.stances.reloadmotion10.weaponOffset or { 0, 0 }
      self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2], to[2]) }

      self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress,
        self.stances.reloadmotion9.weaponRotation, self.stances.reloadmotion10.weaponRotation))
      self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.reloadmotion9.armRotation,
        self.stances.reloadmotion10.armRotation))

      progress = math.min(1.0, progress + (self.dt / self.stances.reloadmotion9.duration))
    end)

    self.weapon:setStance(self.stances.reloadmotion10)

    local progress = 0
    util.wait(self.stances.reloadmotion10.duration, function()
      local from = self.stances.reloadmotion10.weaponOffset or { 0, 0 }
      local to = self.stances.reloadmotion11.weaponOffset or { 0, 0 }
      self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2], to[2]) }

      self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress,
        self.stances.reloadmotion10.weaponRotation, self.stances.reloadmotion11.weaponRotation))
      self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.reloadmotion10.armRotation,
        self.stances.reloadmotion11.armRotation))

      progress = math.min(1.0, progress + (self.dt / self.stances.reloadmotion10.duration))
    end)

    self.weapon:setStance(self.stances.reloadmotion11)

    local progress = 0
    util.wait(self.stances.reloadmotion11.duration, function()
      local from = self.stances.reloadmotion11.weaponOffset or { 0, 0 }
      local to = self.stances.reloadmotion12.weaponOffset or { 0, 0 }
      self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2], to[2]) }

      self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress,
        self.stances.reloadmotion11.weaponRotation, self.stances.reloadmotion12.weaponRotation))
      self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.reloadmotion11.armRotation,
        self.stances.reloadmotion12.armRotation))

      progress = math.min(1.0, progress + (self.dt / self.stances.reloadmotion11.duration))
    end)

    self.weapon:setStance(self.stances.reloadmotion12)
    animator.playSound("reload_4")

    local progress = 0
    util.wait(self.stances.reloadmotion12.duration, function()
      local from = self.stances.reloadmotion12.weaponOffset or { 0, 0 }
      local to = self.stances.reloadmotion13.weaponOffset or { 0, 0 }
      self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2], to[2]) }

      self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress,
        self.stances.reloadmotion12.weaponRotation, self.stances.reloadmotion13.weaponRotation))
      self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.reloadmotion12.armRotation,
        self.stances.reloadmotion13.armRotation))

      progress = math.min(1.0, progress + (self.dt / self.stances.reloadmotion12.duration))
    end)

    self.weapon:setStance(self.stances.reloadmotion13)

    local progress = 0
    util.wait(self.stances.reloadmotion13.duration, function()
      local from = self.stances.reloadmotion13.weaponOffset or { 0, 0 }
      local to = self.stances.reloadmotion14.weaponOffset or { 0, 0 }
      self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2], to[2]) }

      self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress,
        self.stances.reloadmotion13.weaponRotation, self.stances.reloadmotion14.weaponRotation))
      self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.reloadmotion13.armRotation,
        self.stances.reloadmotion14.armRotation))

      progress = math.min(1.0, progress + (self.dt / self.stances.reloadmotion13.duration))
    end)

    self.weapon:setStance(self.stances.reloadmotion14)

    local progress = 0
    util.wait(self.stances.reloadmotion14.duration, function()
      local from = self.stances.reloadmotion14.weaponOffset or { 0, 0 }
      local to = self.stances.reloadmotion15.weaponOffset or { 0, 0 }
      self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2], to[2]) }

      self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress,
        self.stances.reloadmotion14.weaponRotation, self.stances.reloadmotion15.weaponRotation))
      self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.reloadmotion14.armRotation,
        self.stances.reloadmotion15.armRotation))

      progress = math.min(1.0, progress + (self.dt / self.stances.reloadmotion14.duration))
    end)

    self.weapon:setStance(self.stances.reloadmotion15)

    local progress = 0
    util.wait(self.stances.reloadmotion15.duration, function()
      local from = self.stances.reloadmotion15.weaponOffset or { 0, 0 }
      local to = self.stances.reloadmotion16.weaponOffset or { 0, 0 }
      self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2], to[2]) }

      self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress,
        self.stances.reloadmotion15.weaponRotation, self.stances.reloadmotion16.weaponRotation))
      self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.reloadmotion15.armRotation,
        self.stances.reloadmotion16.armRotation))

      progress = math.min(1.0, progress + (self.dt / self.stances.reloadmotion15.duration))
    end)

    self.weapon:setStance(self.stances.reloadmotion16)

    local progress = 0
    util.wait(self.stances.reloadmotion16.duration, function()
      local from = self.stances.reloadmotion16.weaponOffset or { 0, 0 }
      local to = self.stances.reloadmotion17.weaponOffset or { 0, 0 }
      self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2], to[2]) }

      self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress,
        self.stances.reloadmotion16.weaponRotation, self.stances.reloadmotion17.weaponRotation))
      self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.reloadmotion16.armRotation,
        self.stances.reloadmotion17.armRotation))

      progress = math.min(1.0, progress + (self.dt / self.stances.reloadmotion16.duration))
    end)

    self.weapon:setStance(self.stances.reloadmotion17)
    animator.playSound("reload_5")

    local progress = 0
    util.wait(self.stances.reloadmotion17.duration, function()
      local from = self.stances.reloadmotion17.weaponOffset or { 0, 0 }
      local to = self.stances.reloadmotion18.weaponOffset or { 0, 0 }
      self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2], to[2]) }

      self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress,
        self.stances.reloadmotion17.weaponRotation, self.stances.reloadmotion18.weaponRotation))
      self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.reloadmotion17.armRotation,
        self.stances.reloadmotion18.armRotation))

      progress = math.min(1.0, progress + (self.dt / self.stances.reloadmotion17.duration))
    end)

    self.weapon:setStance(self.stances.reloadmotion18)

    local progress = 0
    util.wait(self.stances.reloadmotion18.duration, function()
      local from = self.stances.reloadmotion18.weaponOffset or { 0, 0 }
      local to = self.stances.reloadmotion19.weaponOffset or { 0, 0 }
      self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2], to[2]) }

      self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress,
        self.stances.reloadmotion18.weaponRotation, self.stances.reloadmotion19.weaponRotation))
      self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.reloadmotion18.armRotation,
        self.stances.reloadmotion19.armRotation))

      progress = math.min(1.0, progress + (self.dt / self.stances.reloadmotion18.duration))
    end)

    self.weapon:setStance(self.stances.reloadmotion19)

    local progress = 0
    util.wait(self.stances.reloadmotion19.duration, function()
      local from = self.stances.reloadmotion19.weaponOffset or { 0, 0 }
      local to = self.stances.reloadmotion20.weaponOffset or { 0, 0 }
      self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2], to[2]) }

      self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress,
        self.stances.reloadmotion19.weaponRotation, self.stances.reloadmotion20.weaponRotation))
      self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.reloadmotion19.armRotation,
        self.stances.reloadmotion20.armRotation))

      progress = math.min(1.0, progress + (self.dt / self.stances.reloadmotion19.duration))
    end)

    self.weapon:setStance(self.stances.reloadmotion20)
    self.weapon:updateAim()

    local progress = 0
    util.wait(self.stances.reloadmotion20.duration, function()
      local from = self.stances.reloadmotion20.weaponOffset or { 0, 0 }
      local to = self.stances.idle.weaponOffset or { 0, 0 }
      self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2], to[2]) }

      self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress,
        self.stances.reloadmotion20.weaponRotation, self.stances.idle.weaponRotation))
      self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.reloadmotion20.armRotation,
        self.stances.idle.armRotation))

      progress = math.min(1.0, progress + (self.dt / self.stances.reloadmotion20.duration))
    end)


    storage.totalAmmo = 1
    animator.setParticleEmitterActive("smoke", true)
  end
  animator.setParticleEmitterActive("smoke", true)
end

function GunFire:firemagazineProjectile(projectileType2, projectileParams, inaccuracy, firePosition, projectileCount)
  local params = sb.jsonMerge(self.projectileParameters, projectileParams or {})
  params.power = self:damagePerShot()
  params.powerMultiplier = activeItem.ownerPowerMultiplier()
  params.speed = util.randomInRange(params.speed)

  if not projectileType2 then
    projectileType2 = self.projectileType2
  end
  if type(projectileType2) == "table" then
    projectileType2 = projectileType2[math.random(#projectileType2)]
  end

  local projectileId = 0
  for i = 1, (projectileCount or self.projectileCount) do
    if params.timeToLive then
      params.timeToLive = util.randomInRange(params.timeToLive)
    end

    projectileId = world.spawnProjectile(
      projectileType2,
      firePosition or self:firePosition(),
      activeItem.ownerEntityId(),
      self:aimVector(inaccuracy or self.inaccuracy),
      false,
      params
    )
  end
  return projectileId
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

function GunFire:consumeAmmo()
  storage.totalAmmo = storage.totalAmmo - 1
end

function GunFire:damagePerShot()
  return (self.baseDamage or self.baseDps) * (self.baseDamageMultiplier or 1.0) *
      config.getParameter("damageLevelMultiplier") / self.projectileCount
end

function GunFire:uninit()
end
