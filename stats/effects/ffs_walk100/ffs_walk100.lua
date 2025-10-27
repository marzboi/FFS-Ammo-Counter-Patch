function init()
end

function update(dt)
  mcontroller.controlModifiers({
      groundMovementModifier = 1.0,
      speedModifier = 1.0,
      airJumpModifier = 1.0,
	  runningSuppressed = true
    })
end