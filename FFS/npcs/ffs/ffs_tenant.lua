require("/scripts/util.lua")
require("/scripts/actions/overrides.lua")

ffs_tenant = {}

function ffs_tenant.evictffs_tenant()
  storage.respawner = nil
  ffs_tenant.despawn(true)
end

function ffs_tenant.isffs_tenant()
  return storage.respawner ~= nil
end

function ffs_tenant.despawn(visibly)
  if entity.entityType() == "monster" then
    capturable.recall()
  elseif entity.entityType() == "npc" then
    npc.setDropPools({})

    local bounds = mcontroller.boundBox()
    local position = mcontroller.position()
    local collisionArea = {bounds[1] + position[1], bounds[2] + position[2], bounds[3] + position[1], bounds[4] + position[2]}
    if visibly and world.isVisibleToPlayer(collisionArea) then
      self.forceDie = true
    end
  end

  notify({ type = "ffs_tenant.evicted" })
end

function ffs_tenant.setHome(position, boundary, deedUniqueId, skipNotification)
  storage.homePosition = position
  storage.homeBoundary = boundary
  storage.respawner = deedUniqueId
  if not skipNotification then
    notify({ type = "ffs_tenant.setHome" })
  end

  status.addEphemeralEffect("beamin")

  if entity.entityType() == "monster" then
    capturable.startReleaseAnimation()
  end
end

function ffs_tenant.detachFromSpawner()
  if not storage.respawner then return end
  local entityId = world.loadUniqueEntity(storage.respawner)
  assert(entityId and world.entityExists(entityId))
  world.callScriptedEntity(entityId, "detachffs_tenant", entity.uniqueId())
  storage.respawner = nil
end

function ffs_tenant.backup()
  if storage.respawner and entity.uniqueId() and preservedStorage then
    local entityId = world.loadUniqueEntity(storage.respawner)
    if entityId and world.entityExists(entityId) then
      world.callScriptedEntity(entityId, "backupffs_tenantStorage", entity.uniqueId(), preservedStorage())
    end
  end
end

function ffs_tenant.returnHome(reason)
  notify({ type = "ffs_tenant.returnHome." .. reason })
end

function ffs_tenant.setGrumbles(grumbles)
  local hadGrumbles = storage.grumbles and #storage.grumbles > 0

  storage.grumbles = grumbles
  if #grumbles > 0 then
    if not world.polyContains(storage.homeBoundary, mcontroller.position()) then
      ffs_tenant.returnHome("grumble")
    elseif not hadGrumbles then
      notify({ type = "ffs_tenant.grumble" })
    end
  end
end

function ffs_tenant.canDeliverRent()
  return not hasAnyOverride()
end

function ffs_tenant.deliverRent(pool, level)
  ffs_tenant.returnHome("rent")
end

function ffs_tenant.setNpcType(npcType)
  if npc.npcType() == npcType then return end

  npc.resetLounging()

  -- Changing the ffs_tenant's npc type consists of:
  -- 1. Spawning a new npc at our current position
  -- 2. Updating the colonydeed with the new npc's npcType and uniqueId
  -- 3. Killing ourself
  -- This is done to turn villagers into crewmembers.

  -- Preserve head item slots, even if they haven't changed from the default:
  storage.itemSlots = storage.itemSlots or {}
  if not storage.itemSlots.headCosmetic and not storage.itemSlots.headCosmetic then
    storage.itemSlots.headCosmetic = npc.getItemSlot("headCosmetic")
  end
  if not storage.itemSlots.head then
    storage.itemSlots.head = npc.getItemSlot("head")
  end
  storage.itemSlots.primary = nil
  storage.itemSlots.alt = nil

  local newUniqueId = sb.makeUuid()
  local newEntityId = world.spawnNpc(entity.position(), npc.species(), npcType, npc.level(), npc.seed(), {
      identity = npc.humanoidIdentity(),
      scriptConfig = {
          personality = personality(),
          initialStorage = preservedStorage(),
          uniqueId = newUniqueId
        }
    })

  if storage.respawner then
    assert(newUniqueId and newEntityId)
    world.callScriptedEntity(newEntityId, "ffs_tenant.setHome", storage.homePosition, storage.homeBoundary, storage.respawner, true)

    local spawnerId = world.loadUniqueEntity(storage.respawner)
    assert(spawnerId and world.entityExists(spawnerId))
    world.callScriptedEntity(spawnerId, "replaceffs_tenant", entity.uniqueId(), {
        uniqueId = newUniqueId,
        type = npcType
      })
  end

  ffs_tenant.despawn(false)
end

function ffs_tenant.graduate()
  if storage.respawner then
    local respawnerEntityId = world.loadUniqueEntity(storage.respawner)
    if world.entityExists(respawnerEntityId) then
      if world.callScriptedEntity(respawnerEntityId, "countMonsterffs_tenants") > 0 then
        return
      end
    end
  end

  local graduation = config.getParameter("questGenerator.graduation")
  if graduation and #graduation.nextNpcType > 0 then
    local nextNpcType = util.weightedRandom(graduation.nextNpcType)
    ffs_tenant.setNpcType(nextNpcType)
  end
end
