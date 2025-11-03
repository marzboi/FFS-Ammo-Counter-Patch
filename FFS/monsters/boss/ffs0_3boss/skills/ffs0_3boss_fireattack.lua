ffs0_3boss_fireattack = {}

--------------------------------------------------------------------------------
function ffs0_3boss_fireattack.enter()
  if not hasTarget() then return nil end

  return {
    distanceRange = config.getParameter("ffs0_3boss_fireattack.distanceRange"),
    winddownTimer = config.getParameter("ffs0_3boss_fireattack.winddownTime"),
    windupTimer = config.getParameter("ffs0_3boss_fireattack.windupTime"),
    fireing = false
  }
end

--------------------------------------------------------------------------------
function ffs0_3boss_fireattack.enteringState(stateData)
  animator.setAnimationState("movement", "windup")

  monster.setActiveSkillName("ffs0_3boss_fireattack")
end

--------------------------------------------------------------------------------
function ffs0_3boss_fireattack.update(dt, stateData)
  if not hasTarget() then return true end

  local toTarget = world.distance(self.targetPosition, mcontroller.position())
  local targetDir = util.toDirection(toTarget[1])

  if not stateData.fireing then 
    if math.abs(toTarget[1]) > stateData.distanceRange[2] then
      animator.setAnimationState("movement", "move")
      mcontroller.controlMove(util.toDirection(toTarget[1]), true)
    elseif math.abs(toTarget[1]) < stateData.distanceRange[1] then
      mcontroller.controlMove(util.toDirection(-toTarget[1]), true)
      animator.setAnimationState("movement", "move")
      mcontroller.controlFace(targetDir)
    else
      stateData.fireing = true
    end
  else
    mcontroller.controlFace(targetDir)
    if stateData.windupTimer > 0 then
      if stateData.windupTimer == config.getParameter("ffs0_3boss_fireattack.windupTime") then
      animator.setAnimationState("movement", "fire")
      end
      stateData.windupTimer = stateData.windupTimer - dt
    elseif stateData.winddownTimer > 0 then
      if stateData.winddownTimer == config.getParameter("ffs0_3boss_fireattack.winddownTime") then
        ffs0_3boss_fireattack.fire(targetDir)
        animator.playSound("fire")
      end
      stateData.winddownTimer = stateData.winddownTimer - dt
    else
      return true
    end
  end


  return false
end

function ffs0_3boss_fireattack.fire(direction)
  local projectileType = config.getParameter("ffs0_3boss_fireattack.projectile.type")
  local projectileConfig = config.getParameter("ffs0_3boss_fireattack.projectile.config")
  local projectileOffset = config.getParameter("ffs0_3boss_fireattack.projectile.offset")
  
  if projectileConfig.power then
    projectileConfig.power = projectileConfig.power * root.evalFunction("monsterLevelPowerMultiplier", monster.level())
  end

  world.spawnProjectile(projectileType, monster.toAbsolutePosition(projectileOffset), entity.id(), {direction, 0}, true, projectileConfig)
end

function ffs0_3boss_fireattack.leavingState(stateData)
  monster.setActiveSkillName("")
end
