require "/scripts/util.lua"
require "/scripts/interp.lua"

-- Base gun fire ability
GunFire = WeaponAbility:new()

function GunFire:init()
  if not storage.isWeaponReady then
    self:setState(self.draw)
    self.cooldownTimer = self.stances.draw.duration
  elseif storage.totalAmmo < 1 then
    self.weapon:setStance(self.stances.draw)
    self:setState(self.reload)
    self.cooldownTimer = self.stances.reloadmotion1.duration
  else
    self.weapon:setStance(self.stances.idle)
    self.cooldownTimer = 0
  end

  storage.maxAmmo = math.floor((100 / self.energyUsage) + 0.5)
  activeItem.setCursor("/cursors/ffs_reticle_normal.cursor")

  if storage.maxAmmo < 1 then
    storage.maxAmmo = 1
  end

  if not storage.totalAmmo then
    storage.totalAmmo = storage.maxAmmo
  end

  self.weapon.onLeaveAbility = function()
    self.weapon:setStance(self.stances.idle)
  end
end

function GunFire:draw()
  self.weapon:setStance(self.stances.draw)
  animator.stopAllSounds("draw_1")
  animator.stopAllSounds("draw_2")
  animator.stopAllSounds("draw_3")
  animator.stopAllSounds("reload_1")
  animator.stopAllSounds("reload_2")
  animator.stopAllSounds("reload_3")
  animator.stopAllSounds("reload_4")
  animator.stopAllSounds("reload_5")

  local progress = 0
  util.wait(self.stances.draw.duration, function()
    local from = self.stances.draw.weaponOffset or { 0, 0 }
    local to = self.stances.draw2.weaponOffset or { 0, 0 }
    self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2], to[2]) }

    self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress, self.stances.draw.weaponRotation,
      self.stances.draw2.weaponRotation))
    self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.draw.armRotation,
      self.stances.draw2.armRotation))

    progress = math.min(1.0, progress + (self.stances.draw.duration))
  end)

  self:setState(self.draw2)
end

function GunFire:draw2()
  self.weapon:setStance(self.stances.draw2)
  animator.playSound("draw_1")

  local progress = 0
  util.wait(self.stances.draw2.duration, function()
    local from = self.stances.draw2.weaponOffset or { 0, 0 }
    local to = self.stances.draw3.weaponOffset or { 0, 0 }
    self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2], to[2]) }

    self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress, self.stances.draw2.weaponRotation,
      self.stances.draw3.weaponRotation))
    self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.draw2.armRotation,
      self.stances.draw3.armRotation))

    progress = math.min(1.0, progress + (self.dt / self.stances.draw2.duration))
  end)

  self:setState(self.draw3)
end

function GunFire:draw3()
  self.weapon:setStance(self.stances.draw3)

  local progress = 0
  util.wait(self.stances.draw3.duration, function()
    local from = self.stances.draw3.weaponOffset or { 0, 0 }
    local to = self.stances.draw4.weaponOffset or { 0, 0 }
    self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2], to[2]) }

    self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress, self.stances.draw3.weaponRotation,
      self.stances.draw4.weaponRotation))
    self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.draw3.armRotation,
      self.stances.draw4.armRotation))

    progress = math.min(1.0, progress + (self.dt / self.stances.draw3.duration))
  end)

  self:setState(self.draw4)
end

function GunFire:draw4()
  self.weapon:setStance(self.stances.draw4)

  local progress = 0
  util.wait(self.stances.draw4.duration, function()
    local from = self.stances.draw4.weaponOffset or { 0, 0 }
    local to = self.stances.draw5.weaponOffset or { 0, 0 }
    self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2], to[2]) }

    self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress, self.stances.draw4.weaponRotation,
      self.stances.draw5.weaponRotation))
    self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.draw4.armRotation,
      self.stances.draw5.armRotation))

    progress = math.min(1.0, progress + (self.dt / self.stances.draw4.duration))
  end)

  self:setState(self.draw5)
end

function GunFire:draw5()
  self.weapon:setStance(self.stances.draw5)

  local progress = 0
  util.wait(self.stances.draw5.duration, function()
    local from = self.stances.draw5.weaponOffset or { 0, 0 }
    local to = self.stances.draw6.weaponOffset or { 0, 0 }
    self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2], to[2]) }

    self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress, self.stances.draw5.weaponRotation,
      self.stances.draw6.weaponRotation))
    self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.draw5.armRotation,
      self.stances.draw6.armRotation))

    progress = math.min(1.0, progress + (self.dt / self.stances.draw5.duration))
  end)

  self:setState(self.draw6)
end

function GunFire:draw6()
  self.weapon:setStance(self.stances.draw6)

  local progress = 0
  util.wait(self.stances.draw6.duration, function()
    local from = self.stances.draw6.weaponOffset or { 0, 0 }
    local to = self.stances.draw7.weaponOffset or { 0, 0 }
    self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2], to[2]) }

    self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress, self.stances.draw6.weaponRotation,
      self.stances.draw7.weaponRotation))
    self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.draw6.armRotation,
      self.stances.draw7.armRotation))

    progress = math.min(1.0, progress + (self.dt / self.stances.draw6.duration))
  end)

  self:setState(self.draw7)
end

function GunFire:draw7()
  self.weapon:setStance(self.stances.draw7)

  local progress = 0
  util.wait(self.stances.draw7.duration, function()
    local from = self.stances.draw7.weaponOffset or { 0, 0 }
    local to = self.stances.draw8.weaponOffset or { 0, 0 }
    self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2], to[2]) }

    self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress, self.stances.draw7.weaponRotation,
      self.stances.draw8.weaponRotation))
    self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.draw7.armRotation,
      self.stances.draw8.armRotation))

    progress = math.min(1.0, progress + (self.dt / self.stances.draw7.duration))
  end)

  self:setState(self.draw8)
end

function GunFire:draw8()
  self.weapon:setStance(self.stances.draw8)

  local progress = 0
  util.wait(self.stances.draw8.duration, function()
    local from = self.stances.draw8.weaponOffset or { 0, 0 }
    local to = self.stances.draw9.weaponOffset or { 0, 0 }
    self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2], to[2]) }

    self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress, self.stances.draw8.weaponRotation,
      self.stances.draw9.weaponRotation))
    self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.draw8.armRotation,
      self.stances.draw9.armRotation))

    progress = math.min(1.0, progress + (self.dt / self.stances.draw8.duration))
  end)

  self:setState(self.draw9)
end

function GunFire:draw9()
  self.weapon:setStance(self.stances.draw9)

  local progress = 0
  util.wait(self.stances.draw9.duration, function()
    local from = self.stances.draw9.weaponOffset or { 0, 0 }
    local to = self.stances.draw10.weaponOffset or { 0, 0 }
    self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2], to[2]) }

    self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress, self.stances.draw9.weaponRotation,
      self.stances.draw10.weaponRotation))
    self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.draw9.armRotation,
      self.stances.draw10.armRotation))

    progress = math.min(1.0, progress + (self.dt / self.stances.draw9.duration))
  end)

  self:setState(self.draw10)
end

function GunFire:draw10()
  self.weapon:setStance(self.stances.draw10)

  local progress = 0
  util.wait(self.stances.draw10.duration, function()
    local from = self.stances.draw10.weaponOffset or { 0, 0 }
    local to = self.stances.draw11.weaponOffset or { 0, 0 }
    self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2], to[2]) }

    self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress, self.stances.draw10.weaponRotation,
      self.stances.draw11.weaponRotation))
    self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.draw10.armRotation,
      self.stances.draw11.armRotation))

    progress = math.min(1.0, progress + (self.dt / self.stances.draw10.duration))
  end)

  self:setState(self.draw11)
end

function GunFire:draw11()
  self.weapon:setStance(self.stances.draw11)

  local progress = 0
  util.wait(self.stances.draw11.duration, function()
    local from = self.stances.draw11.weaponOffset or { 0, 0 }
    local to = self.stances.draw12.weaponOffset or { 0, 0 }
    self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2], to[2]) }

    self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress, self.stances.draw11.weaponRotation,
      self.stances.draw12.weaponRotation))
    self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.draw11.armRotation,
      self.stances.draw12.armRotation))

    progress = math.min(1.0, progress + (self.dt / self.stances.draw11.duration))
  end)

  self:setState(self.draw12)
end

function GunFire:draw12()
  self.weapon:setStance(self.stances.draw12)

  local progress = 0
  util.wait(self.stances.draw12.duration, function()
    local from = self.stances.draw12.weaponOffset or { 0, 0 }
    local to = self.stances.draw13.weaponOffset or { 0, 0 }
    self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2], to[2]) }

    self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress, self.stances.draw12.weaponRotation,
      self.stances.draw13.weaponRotation))
    self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.draw12.armRotation,
      self.stances.draw13.armRotation))

    progress = math.min(1.0, progress + (self.dt / self.stances.draw12.duration))
  end)

  self:setState(self.draw13)
end

function GunFire:draw13()
  self.weapon:setStance(self.stances.draw13)
  animator.playSound("draw_2")

  local progress = 0
  util.wait(self.stances.draw13.duration, function()
    local from = self.stances.draw13.weaponOffset or { 0, 0 }
    local to = self.stances.draw14.weaponOffset or { 0, 0 }
    self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2], to[2]) }

    self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress, self.stances.draw13.weaponRotation,
      self.stances.draw14.weaponRotation))
    self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.draw13.armRotation,
      self.stances.draw14.armRotation))

    progress = math.min(1.0, progress + (self.dt / self.stances.draw13.duration))
  end)

  self:setState(self.draw14)
end

function GunFire:draw14()
  self.weapon:setStance(self.stances.draw14)

  local progress = 0
  util.wait(self.stances.draw14.duration, function()
    local from = self.stances.draw14.weaponOffset or { 0, 0 }
    local to = self.stances.draw15.weaponOffset or { 0, 0 }
    self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2], to[2]) }

    self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress, self.stances.draw14.weaponRotation,
      self.stances.draw15.weaponRotation))
    self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.draw14.armRotation,
      self.stances.draw15.armRotation))

    progress = math.min(1.0, progress + (self.dt / self.stances.draw14.duration))
  end)

  self:setState(self.draw15)
end

function GunFire:draw15()
  self.weapon:setStance(self.stances.draw15)

  local progress = 0
  util.wait(self.stances.draw15.duration, function()
    local from = self.stances.draw15.weaponOffset or { 0, 0 }
    local to = self.stances.draw16.weaponOffset or { 0, 0 }
    self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2], to[2]) }

    self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress, self.stances.draw15.weaponRotation,
      self.stances.draw16.weaponRotation))
    self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.draw15.armRotation,
      self.stances.draw16.armRotation))

    progress = math.min(1.0, progress + (self.dt / self.stances.draw15.duration))
  end)

  self:setState(self.draw16)
end

function GunFire:draw16()
  self.weapon:setStance(self.stances.draw16)

  local progress = 0
  util.wait(self.stances.draw16.duration, function()
    local from = self.stances.draw16.weaponOffset or { 0, 0 }
    local to = self.stances.draw17.weaponOffset or { 0, 0 }
    self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2], to[2]) }

    self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress, self.stances.draw16.weaponRotation,
      self.stances.draw17.weaponRotation))
    self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.draw16.armRotation,
      self.stances.draw17.armRotation))

    progress = math.min(1.0, progress + (self.dt / self.stances.draw16.duration))
  end)

  self:setState(self.draw17)
end

function GunFire:draw17()
  self.weapon:setStance(self.stances.draw17)
  animator.playSound("draw_3")

  local progress = 0
  util.wait(self.stances.draw17.duration, function()
    local from = self.stances.draw17.weaponOffset or { 0, 0 }
    local to = self.stances.draw18.weaponOffset or { 0, 0 }
    self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2], to[2]) }

    self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress, self.stances.draw17.weaponRotation,
      self.stances.draw18.weaponRotation))
    self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.draw17.armRotation,
      self.stances.draw18.armRotation))

    progress = math.min(1.0, progress + (self.dt / self.stances.draw17.duration))
  end)

  self:setState(self.draw18)
end

function GunFire:draw18()
  self.weapon:setStance(self.stances.draw18)

  local progress = 0
  util.wait(self.stances.draw18.duration, function()
    local from = self.stances.draw18.weaponOffset or { 0, 0 }
    local to = self.stances.draw19.weaponOffset or { 0, 0 }
    self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2], to[2]) }

    self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress, self.stances.draw18.weaponRotation,
      self.stances.draw19.weaponRotation))
    self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.draw18.armRotation,
      self.stances.draw19.armRotation))

    progress = math.min(1.0, progress + (self.dt / self.stances.draw18.duration))
  end)

  self:setState(self.draw19)
end

function GunFire:draw19()
  self.weapon:setStance(self.stances.draw19)

  local progress = 0
  util.wait(self.stances.draw19.duration, function()
    local from = self.stances.draw19.weaponOffset or { 0, 0 }
    local to = self.stances.draw20.weaponOffset or { 0, 0 }
    self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2], to[2]) }

    self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress, self.stances.draw19.weaponRotation,
      self.stances.draw20.weaponRotation))
    self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.draw19.armRotation,
      self.stances.draw20.armRotation))

    progress = math.min(1.0, progress + (self.dt / self.stances.draw19.duration))
  end)

  self:setState(self.draw20)
end

function GunFire:draw20()
  self.weapon:setStance(self.stances.draw20)

  local progress = 0
  util.wait(self.stances.draw20.duration, function()
    local from = self.stances.draw20.weaponOffset or { 0, 0 }
    local to = self.stances.idle.weaponOffset or { 0, 0 }
    self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2], to[2]) }

    self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress, self.stances.draw20.weaponRotation,
      self.stances.idle.weaponRotation))
    self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.draw20.armRotation,
      self.stances.idle.armRotation))

    progress = math.min(1.0, progress + (self.dt / self.stances.draw20.duration))
  end)

  storage.isWeaponReady = true
  storage.magazineIn = true
  self:reload()
end

function GunFire:update(dt, fireMode, shiftHeld)
  WeaponAbility.update(self, dt, fireMode, shiftHeld)

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
  if storage.totalAmmo >= 1 then
    self.weapon:setStance(self.stances.fire)
    animator.setParticleEmitterActive("smoke_end", false)
    animator.setParticleEmitterActive("ember", false)
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
    animator.playSound("fireAT_1")

    local progress = 0
    util.wait(self.stances.motion1.duration, function()
      local from = self.stances.motion1.weaponOffset or { 0, 0 }
      local to = self.stances.motion2.weaponOffset or { 0, 0 }
      self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2], to[2]) }

      self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress,
        self.stances.motion1.weaponRotation,
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

      self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress,
        self.stances.motion2.weaponRotation,
        self.stances.motion3.weaponRotation))
      self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.motion2.armRotation,
        self.stances.motion3.armRotation))

      progress = math.min(1.0, progress + (self.dt / self.stances.motion2.duration))
    end)

    while self.fireMode == (self.activatingFireMode or self.abilitySlot) and storage.totalAmmo >= 1 do
      self.weapon:setStance(self.stances.motion3)

      local progress = 0
      util.wait(self.stances.motion3.duration, function()
        local from = self.stances.motion3.weaponOffset or { 0, 0 }
        local to = self.stances.motion4.weaponOffset or { 0, 0 }
        self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2],
          to[2]) }

        self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress,
          self.stances.motion3.weaponRotation,
          self.stances.motion4.weaponRotation))
        self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.motion3
          .armRotation,
          self.stances.motion4.armRotation))

        progress = math.min(1.0, progress + (self.dt / self.stances.motion3.duration))
      end)

      self.weapon:setStance(self.stances.motion4)

      local progress = 0
      util.wait(self.stances.motion4.duration, function()
        local from = self.stances.motion4.weaponOffset or { 0, 0 }
        local to = self.stances.motion5.weaponOffset or { 0, 0 }
        self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2],
          to[2]) }

        self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress,
          self.stances.motion4.weaponRotation,
          self.stances.motion5.weaponRotation))
        self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.motion4
          .armRotation,
          self.stances.motion5.armRotation))

        progress = math.min(1.0, progress + (self.dt / self.stances.motion4.duration))
      end)

      self.weapon:setStance(self.stances.motion5)
      animator.setParticleEmitterActive("at_smoke", true)
      animator.playSound("fireAT_2")

      local progress = 0
      util.wait(self.stances.motion5.duration, function()
        local from = self.stances.motion5.weaponOffset or { 0, 0 }
        local to = self.stances.motion6.weaponOffset or { 0, 0 }
        self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2],
          to[2]) }

        self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress,
          self.stances.motion5.weaponRotation,
          self.stances.motion6.weaponRotation))
        self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.motion5
          .armRotation,
          self.stances.motion6.armRotation))

        progress = math.min(1.0, progress + (self.dt / self.stances.motion5.duration))
      end)

      self.weapon:setStance(self.stances.motion6)
      animator.setParticleEmitterActive("ember", true)
      animator.setParticleEmitterActive("smoke_end", true)
      animator.playSound("fireAT_fire")
      self:fireProjectile()
      self:consumeAmmo()

      local progress = 0
      util.wait(self.stances.motion6.duration, function()
        local from = self.stances.motion6.weaponOffset or { 0, 0 }
        local to = self.stances.cooldown.weaponOffset or { 0, 0 }
        self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2],
          to[2]) }

        self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress,
          self.stances.motion6.weaponRotation,
          self.stances.cooldown.weaponRotation))
        self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress, self.stances.motion6
          .armRotation,
          self.stances.cooldown.armRotation))

        progress = math.min(1.0, progress + (self.dt / self.stances.motion6.duration))
      end)

      self.weapon:setStance(self.stances.cooldown)
      self.weapon:updateAim()

      animator.setParticleEmitterActive("smoke", false)
      animator.setParticleEmitterActive("at_smoke", false)
      animator.setParticleEmitterActive("ember", false)
      animator.setParticleEmitterActive("smoke_end", false)

      local progress = 0
      util.wait(self.stances.cooldown.duration, function()
        local from = self.stances.cooldown.weaponOffset or { 0, 0 }
        local to = self.stances.idle.weaponOffset or { 0, 0 }
        self.weapon.weaponOffset = { interp.linear(progress, from[1], to[1]), interp.linear(progress, from[2],
          to[2]) }

        self.weapon.relativeWeaponRotation = util.toRadians(interp.linear(progress,
          self.stances.cooldown.weaponRotation,
          self.stances.idle.weaponRotation))
        self.weapon.relativeArmRotation = util.toRadians(interp.linear(progress,
          self.stances.cooldown.armRotation,
          self.stances.idle.armRotation))

        progress = math.min(1.0, progress + (self.dt / self.stances.cooldown.duration))
      end)
    end
  end

  if storage.totalAmmo < 1 then
    self:reload()
  end
  animator.setParticleEmitterActive("smoke", false)
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

function GunFire:reload()
  storage.totalAmmo = 0

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

    progress = math.min(1.0, progress + (self.stances.reloadmotion1.duration))
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
  animator.setParticleEmitterActive("smoke", true)

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
  animator.playSound("reload_1")

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
  animator.playSound("reload_2")

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
  animator.playSound("reload_3")

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
  animator.playSound("reload_4")

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
  animator.playSound("reload_4")

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
  animator.playSound("reload_4")

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

  storage.totalAmmo = storage.maxAmmo
  animator.setParticleEmitterActive("smoke", false)
end

function GunFire:damagePerShot()
  return (self.baseDamage or self.baseDps) * (self.baseDamageMultiplier or 1.0) *
      config.getParameter("damageLevelMultiplier") / self.projectileCount
end

function GunFire:uninit()
  animator.setParticleEmitterActive("smoke", false)
  animator.setParticleEmitterActive("smoke_end", false)
  animator.setParticleEmitterActive("ember", false)
  animator.setParticleEmitterActive("at_smoke", false)
end
