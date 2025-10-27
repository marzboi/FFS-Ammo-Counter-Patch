function init()
end

function update(dt)
  mcontroller.controlModifiers({
      groundMovementModifier = 1.0,
      speedModifier = 1.0,
      airJumpModifier = 0.3,
	  runningSuppressed = true
    })
end