function init()
  object.setInteractive(true)
end

function onInteraction(args)
  local race = world.entitySpecies(args.sourceId)
  if race ~= "human" then
    local interactData = config.getParameter("interactData")
    return { "OpenCraftingInterface", interactData }
  end
end

function update(args)
  
end