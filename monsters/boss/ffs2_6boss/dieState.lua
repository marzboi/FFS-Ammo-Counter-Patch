function die()
  world.spawnProjectile( "ffs2_6boss_dead_start", mcontroller.position() )
  world.spawnProjectile( "ffs_blood_explosion", mcontroller.position() )
  spawnDrops()
end
