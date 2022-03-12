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
    on_use = function(itemstack, user, pointed_thing)
      if minetest.get_node(pointed_thing.under).name == "vfcrates:key_opener" then
        local player_name = user:get_player_name()
        local returned = take_item(itemstack)
        local drop = loot[math.random(#loot)]
        user:get_inventory():add_item("main", get_item(returned) .. " " .. get_count(returned))
        return drop
      end
    end
  })
end

loot = {"jumpdrive:engine 16", "jumpdrive:fleet_controller 2", "jumpdrive:backbone 99", "xtraores:helmet_chromium", "xtraores:chestplate_chromium", "xtraores:leggings_chromium", "xtraores:boots_chromium", "xtraores:pickaxe_chromium"}
register_key("silver", loot)
register_key("gold", loot)
register_key("vfium", loot)
register_key("rainbow", loot)
