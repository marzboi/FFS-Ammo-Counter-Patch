idleState = {}

function idleState.enter()
  if hasTarget() then return nil end

  return {}
end

function idleState.update(dt, stateData)
  local toSpawn = world.distance(self.spawnPosition, mcontroller.position())
  if math.abs(toSpawn[1]) > 1 then
    move(toSpawn, true)
    animator.setAnimationState("movement", "idle")
  else
    animator.setAnimationState("movement", "idle")
  end
end
