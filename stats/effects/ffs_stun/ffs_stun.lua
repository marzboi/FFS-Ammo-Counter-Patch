function init()
end

function update(dt)
  mcontroller.controlModifiers({
      facingSuppressed = true,
	  movementSuppressed = true
    })
end

function uninit()

end
