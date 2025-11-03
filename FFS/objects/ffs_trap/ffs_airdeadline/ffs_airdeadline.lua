require "/scripts/vec2.lua"

function die(smash)
  if smash then
    world.spawnProjectile(config.getParameter("explosionProjectile", "ffs_break_explosion"), vec2.add(object.position(), config.getParameter("explosionOffset", {0,0})), entity.id(), {0,0})
  end
end
