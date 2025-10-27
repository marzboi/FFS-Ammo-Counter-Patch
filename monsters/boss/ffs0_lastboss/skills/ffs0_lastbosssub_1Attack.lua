--------------------------------------------------------------------------------
ffs0_lastbosssub_1Attack = {}

function ffs0_lastbosssub_1Attack.enter()
  if not hasTarget() then return nil end

  rangedAttack.setConfig(config.getParameter("ffs0_lastbosssub_1Attack.projectile.type"), config.getParameter("ffs0_lastbosssub_1Attack.projectile.config"), config.getParameter("ffs0_lastbosssub_1Attack.fireInterval"))

  return {
    timer = 0,
    bobTime = config.getParameter("ffs0_lastbosssub_1Attack.bobTime"),
    bobHeight = config.getParameter("ffs0_lastbosssub_1Attack.bobHeight"),
    skillTime = config.getParameter("ffs0_lastbosssub_1Attack.skillTime"),
    direction = util.randomDirection(),
    basePosition = self.spawnPosition,
    cruiseDistance = config.getParameter("cruiseDistance")
  }
  end

function ffs0_lastbosssub_1Attack.enteringState(stateData)
  monster.setActiveSkillName(nil)
end

function ffs0_lastbosssub_1Attack.update(dt, stateData)
 animator.setAnimationState("movement", "sub1Attack")
	
  if not hasTarget() then return true end

  local projectileOffset = config.getParameter("ffs0_lastbosssub_1Attack.projectileOffset")

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

function ffs0_lastbosssub_1Attack.leavingState(stateData)
end
