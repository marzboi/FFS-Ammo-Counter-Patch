ffs0_3boss_specialattack = {}

--------------------------------------------------------------------------------
function ffs0_3boss_specialattack.enter()
  if not hasTarget() then return nil end

  return {
    distanceRange = config.getParameter("ffs0_3boss_specialattack.distanceRange"),
    winddownTimer = config.getParameter("ffs0_3boss_specialattack.winddownTime"),
    windupTimer = config.getParameter("ffs0_3boss_specialattack.windupTime"),
    specialing = false
  }
end

--------------------------------------------------------------------------------
function ffs0_3boss_specialattack.enteringState(stateData)
  animator.setAnimationState("movement", "windup")

  monster.setActiveSkillName("ffs0_3boss_specialattack")
end

--------------------------------------------------------------------------------
function ffs0_3boss_specialattack.update(dt, stateData)
  if not hasTarget() then return true end

  local toTarget = world.distance(self.targetPosition, mcontroller.position())
  local targetDir = util.toDirection(toTarget[1])

  if not stateData.specialing then 
    if math.abs(toTarget[1]) > stateData.distanceRange[2] then
      animator.setAnimationState("movement", "move")
      mcontroller.controlMove(util.toDirection(toTarget[1]), true)
    elseif math.abs(toTarget[1]) < stateData.distanceRange[1] then
      mcontroller.controlMove(util.toDirection(-toTarget[1]), true)
      animator.setAnimationState("movement", "move")
      mcontroller.controlFace(targetDir)
    else
      stateData.specialing = true
    end
  else
    mcontroller.controlFace(targetDir)
    if stateData.windupTimer > 0 then
      if stateData.windupTimer == config.getParameter("ffs0_3boss_specialattack.windupTime") then
      animator.setAnimationState("movement", "special")
      end
      stateData.windupTimer = stateData.windupTimer - dt
    elseif stateData.winddownTimer > 0 then
      if stateData.winddownTimer == config.getParameter("ffs0_3boss_specialattack.winddownTime") then
        ffs0_3boss_specialattack.special(targetDir)
        animator.playSound("special")
      end
      stateData.winddownTimer = stateData.winddownTimer - dt
    else
      return true
    end
  end


  return false
end

function ffs0_3boss_specialattack.special(direction)
  local projectileType = config.getParameter("ffs0_3boss_specialattack.projectile.type")
  local projectileConfig = config.getParameter("ffs0_3boss_specialattack.projectile.config")
  local projectileOffset = config.getParameter("ffs0_3boss_specialattack.projectile.offset")
  
  if projectileConfig.power then
    projectileConfig.power = projectileConfig.power * root.evalFunction("monsterLevelPowerMultiplier", monster.level())
  end

  world.spawnProjectile(projectileType, monster.toAbsolutePosition(projectileOffset), entity.id(), {direction, 0}, true, projectileConfig)
end

function ffs0_3boss_specialattack.leavingState(stateData)
  animator.setAnimationState("movement", "winddown")
  monster.setActiveSkillName("")
end
