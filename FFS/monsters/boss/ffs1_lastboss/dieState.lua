function die()
  world.spawnProjectile( "ffs1_lastboss_dead_start", mcontroller.position() )
  world.spawnProjectile( "ffs1_lastboss_part_c", mcontroller.position() )
  spawnDrops()
end
