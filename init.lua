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
  if texture == nil then
    img = "vfcrates_" .. name .. "_key.png"
  end
  if texture:sub(1, 1) == "#" then
    img = "vfcrates_default_key.png^[colorize:" .. texture .. ":255"
  end
  minetest.register_craftitem("vfcrates:" .. name .. "_key", {
    description = upper(name) .. " Key",
    inventory_image = "vfcrates_" .. name .. "_key.png",
    on_use = function(itemstack, user, pointed_thing)
      if minetest.get_node(pointed_thing.under).name == "vfcrates:key_opener" then
        local player_name = user:get_player_name()
        local returned = take_item(itemstack)
        returned = set_name(get_name(returned) .. "\n" .. minetest.colorize("#00FF00", upper(name) .. " Crate Loot"))
        local drop = loot[math.random(#loot)]
        minetest.chat_send_all(playername .. " won a " .. drop .. " from a " .. upper(name) .. " Crate!")
        user:get_inventory():add_item("main", get_name(returned) .. " " .. get_count(returned))
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
