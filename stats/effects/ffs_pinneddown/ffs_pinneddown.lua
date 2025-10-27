function init()
end

function update(dt)
  mcontroller.controlModifiers({
	  movementSuppressed = false, 
      groundMovementModifier = 0.5,
      speedModifier = 0.5,
	  facingSuppressed = false,
	  runningSuppressed = true,
	  jumpingSuppressed = true
    })
end