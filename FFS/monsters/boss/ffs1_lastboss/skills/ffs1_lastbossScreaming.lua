--------------------------------------------------------------------------------
ffs1_lastbossScreaming = {}

function ffs1_lastbossScreaming.enter()
  if not hasTarget() then return nil end

  rangedAttack.setConfig(config.getParameter("ffs1_lastbossScreaming.projectile.type"), config.getParameter("ffs1_lastbossScreaming.projectile.config"), config.getParameter("ffs1_lastbossScreaming.fireInterval"))

  return {
    timer = 0,
    bobTime = config.getParameter("ffs1_lastbossScreaming.bobTime"),
    bobHeight = config.getParameter("ffs1_lastbossScreaming.bobHeight"),
    skillTime = config.getParameter("ffs1_lastbossScreaming.skillTime"),
    direction = util.randomDirection(),
    basePosition = self.spawnPosition,
    cruiseDistance = config.getParameter("cruiseDistance")
  }
  end

function ffs1_lastbossScreaming.enteringState(stateData)
  monster.setActiveSkillName(nil)
end

function ffs1_lastbossScreaming.update(dt, stateData)
 animator.setAnimationState("movement", "visible")
	
  if not hasTarget() then return true end

  local projectileOffset = config.getParameter("ffs1_lastbossScreaming.projectileOffset")

  local toTarget = vec2.norm(world.distance(self.targetPosition, monster.toAbsolutePosition(projectileOffset)))
  rangedAttack.aim(projectileOffset, toTarget)
  rangedAttack.fireContinuous()

  local position = mcontroller.position()

  local toTarget = world.distance(self.targetPosition, position)
  if toTarget[1] < -stateData.cruiseDistance or checkWalls(1) then
    stateData.direction = 1
  elseif toTarget[1] > stateData.cruiseDistance or checkWalls(-1) then
    stateData.direction = 1
  end

  stateData.timer = stateData.timer + dt
  local angle = 2.0 * math.pi * stateData.timer / stateData.bobTime
  local targetPosition = {
    position[1] + stateData.direction * 5,
    stateData.basePosition[2] + stateData.bobHeight * math.cos(angle)
  }
  flyTo(targetPosition)

  if stateData.timer > stateData.skillTime then
    return true
  else
    return false
  end
end

function ffs1_lastbossScreaming.leavingState(stateData)
end
