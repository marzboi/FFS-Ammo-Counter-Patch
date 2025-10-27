function die()
  world.spawnProjectile( "ffs_blood_explosion", mcontroller.position() )
  world.spawnProjectile( "ffs2_lastboss_engine_dead_start", mcontroller.position() )
  spawnDrops()
end
