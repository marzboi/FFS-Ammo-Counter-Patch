function die()
  world.spawnProjectile( "ffs_blood_explosion", mcontroller.position() )
  world.spawnProjectile( "ffs2_lastboss_integratedmind_dead_start", mcontroller.position() )
  spawnDrops()
end
