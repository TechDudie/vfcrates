function upper(str)
    return (str:gsub("^%l", string.upper))
end

minetest.register_node("vfcrates:key_opener", {
  description = "Key Opener",
  tiles = {
    "vfcrates_key_opener_side.png",
    "vfcrates_key_opener_side.png",
    "vfcrates_key_opener_side.png",
    "vfcrates_key_opener_side.png",
    "vfcrates_key_opener_side.png",
    "vfcrates_key_opener_front.png",
  }
})

function register_key(name, loot)
  minetest.register_craftitem("vfcrates:" .. name .. "_key", {
    description = upper(name) .. " Key",
    inventory_image = "vfcrates_" .. name .. "_key.png",
    on_punch = function(itemstack, user, pointed_thing)
      if minetest.get_node(pointed_thing.above).name == "vfcrates:key_opener" then
        local player_name = user:get_player_name()
        local drop = loot[math.random(#loot)
        return drop
      }
    end
  })
end

loot = {"jumpdrive:engine", "jumpdrive:fleet_controller", "jumpdrive:backbone 99", "xtraores:helmet_chromium", "xtraores:chestplate_chromium", "xtraores:leggings_chromium", "xtraores:boots_chromium", "xtraores:pickaxe_chromium"}
