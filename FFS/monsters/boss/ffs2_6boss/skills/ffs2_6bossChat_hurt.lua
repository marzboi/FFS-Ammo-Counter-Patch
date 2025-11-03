--------------------------------------------------------------------------------
ffs2_6bossChat_hurt = {}

function ffs2_6bossChat_hurt.enter()
  if not hasTarget() then return nil end

  rangedAttack.setConfig(config.getParameter("ffs2_6bossChat_hurt.projectile.type"), config.getParameter("ffs2_6bossChat_hurt.projectile.config"), config.getParameter("ffs2_6bossChat_hurt.fireInterval"))

  return {
    timer = 0,
    bobTime = config.getParameter("ffs2_6bossChat_hurt.bobTime"),
    bobHeight = config.getParameter("ffs2_6bossChat_hurt.bobHeight"),
    skillTime = config.getParameter("ffs2_6bossChat_hurt.skillTime"),
    direction = util.randomDirection(),
    basePosition = self.spawnPosition,
    cruiseDistance = config.getParameter("cruiseDistance")
  }
  end

function ffs2_6bossChat_hurt.enteringState(stateData)
  monster.setActiveSkillName(nil)
end

function ffs2_6bossChat_hurt.update(dt, stateData)
 status.addEphemeralEffect("invulnerable")
 animator.setAnimationState("movement", "talk")
	
  if not hasTarget() then return true end

  local projectileOffset = config.getParameter("ffs2_6bossChat_hurt.projectileOffset")

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

function ffs2_6bossChat_hurt.leavingState(stateData)
  status.modifyResourcePercentage( "health", -0.2 )
end
