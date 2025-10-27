ffs0_hiddenmidboss_punchattack = {}

--------------------------------------------------------------------------------
function ffs0_hiddenmidboss_punchattack.enter()
  if not hasTarget() then return nil end

  return {
    distanceRange = config.getParameter("ffs0_hiddenmidboss_punchattack.distanceRange"),
    winddownTimer = config.getParameter("ffs0_hiddenmidboss_punchattack.winddownTime"),
    windupTimer = config.getParameter("ffs0_hiddenmidboss_punchattack.windupTime"),
    punching = false
  }
end

--------------------------------------------------------------------------------
function ffs0_hiddenmidboss_punchattack.enteringState(stateData)
  animator.setAnimationState("movement", "windup")

  monster.setActiveSkillName("ffs0_hiddenmidboss_punchattack")
end

--------------------------------------------------------------------------------
function ffs0_hiddenmidboss_punchattack.update(dt, stateData)
  if not hasTarget() then return true end

  local toTarget = world.distance(self.targetPosition, mcontroller.position())
  local targetDir = util.toDirection(toTarget[1])

  if not stateData.punching then 
    if math.abs(toTarget[1]) > stateData.distanceRange[2] then
      animator.setAnimationState("movement", "move")
      mcontroller.controlMove(util.toDirection(toTarget[1]), true)
    elseif math.abs(toTarget[1]) < stateData.distanceRange[1] then
      mcontroller.controlMove(util.toDirection(-toTarget[1]), true)
      animator.setAnimationState("movement", "move")
      mcontroller.controlFace(targetDir)
    else
      stateData.punching = true
    end
  else
    mcontroller.controlFace(targetDir)
    if stateData.windupTimer > 0 then
      if stateData.windupTimer == config.getParameter("ffs0_hiddenmidboss_punchattack.windupTime") then
      animator.setAnimationState("movement", "windup")
        animator.playSound("ready")
      end
      stateData.windupTimer = stateData.windupTimer - dt
    elseif stateData.winddownTimer > 0 then
      if stateData.winddownTimer == config.getParameter("ffs0_hiddenmidboss_punchattack.winddownTime") then
      animator.setAnimationState("movement", "winddown")
        ffs0_hiddenmidboss_punchattack.punch(targetDir)
        animator.playSound("punch")
      end
      stateData.winddownTimer = stateData.winddownTimer - dt
    else
      return true
    end
  end


  return false
end

function ffs0_hiddenmidboss_punchattack.punch(direction)
  local projectileType = config.getParameter("ffs0_hiddenmidboss_punchattack.projectile.type")
  local projectileConfig = config.getParameter("ffs0_hiddenmidboss_punchattack.projectile.config")
  local projectileOffset = config.getParameter("ffs0_hiddenmidboss_punchattack.projectile.offset")
  
  if projectileConfig.power then
    projectileConfig.power = projectileConfig.power * root.evalFunction("monsterLevelPowerMultiplier", monster.level())
  end

  world.spawnProjectile(projectileType, monster.toAbsolutePosition(projectileOffset), entity.id(), {direction, 0}, true, projectileConfig)
end

function ffs0_hiddenmidboss_punchattack.leavingState(stateData)
  monster.setActiveSkillName("")
end
