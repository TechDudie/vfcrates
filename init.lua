function upper(str)
    return (str:gsub("^%l", string.upper))
end

-- Will be replaced soon with specific crates for specific keys
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

function register_key(name, loot, texture)
  local img = "vfcrates_default_key.png"
  img = "vfcrates_" .. name .. "_key.png"
  if texture ~= nil then
    if texture:sub(1, 1) == "#" then
      img = "vfcrates_default_key.png^[colorize:" .. texture .. ":255"
    end
  end
  minetest.register_tool("vfcrates:" .. name .. "_key", {
    description = upper(name) .. " Key",
    inventory_image = "vfcrates_" .. name .. "_key.png",
    on_use = function(itemstack, user, pointed_thing)
      if minetest.get_node(pointed_thing.under).name == "vfcrates:key_opener" then
        local player_name = user:get_player_name()
        local drop = loot[math.random(#loot)]
        local returned = ItemStack(drop)
        local loot_name = minetest.registered_items[returned:get_name()].description
        local loot_meta = returned:get_meta()
        minetest.chat_send_all(player_name .. " won a " .. loot_name .. " from a " .. upper(name) .. " Crate!")
        loot_meta:set_string("description", loot_name .. "\n" .. minetest.colorize("#00FF00", upper(name) .. " Crate Loot"))
        return returned
      end
    end
  })
end

--loot = {"jumpdrive:engine 16", "jumpdrive:fleet_controller 2", "jumpdrive:backbone 99", "xtraores:helmet_chromium", "xtraores:chestplate_chromium", "xtraores:leggings_chromium", "xtraores:boots_chromium", "xtraores:pickaxe_chromium"}
loot = {"jumpdrive:engine 16", "jumpdrive:fleet_controller 2", "jumpdrive:backbone 99"}
register_key("silver", loot)
register_key("gold", loot)
register_key("vfium", loot)
register_key("rainbow", loot)
