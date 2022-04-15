function upper(str)
    return (str:gsub("^%l", string.upper))
end

-- Will be replaced soon with specific crates for specific keys
--[[
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
]]--

function register_key(name, loot, texture)
  local modifier = ""
  local color = "#00FF00"
  if texture ~= nil and texture:sub(1, 1) == "#" then
    modifier = "^[colorize:" .. texture .. ":127"
    color = texture
  end
  local key_texture = "vfcrates_" .. name .. "_key.png"
  if modifier ~= "" then
    key_texture = "vfcrates_default_key.png^[colorize:" .. texture .. ":255^vfcrates_mask_key.png"
  end
  minetest.register_node("vfcrates:" .. name .. "_crate", {
    description = upper(name) .. " Crate",
    tiles = {
      --[[
      "vfcrates_crate_" .. name .. "_up.png",
      "vfcrates_crate_" .. name .. "_down.png",
      "vfcrates_crate_" .. name .. "_right.png",
      "vfcrates_crate_" .. name .. "_left.png",
      "vfcrates_crate_" .. name .. "_back.png",
      "vfcrates_crate_" .. name .. "_front.png",
      ]]--
      "default_chest_top.png" .. modifier,
      "default_chest_top.png" .. modifier,
      "default_chest_side.png" .. modifier,
      "default_chest_side.png" .. modifier,
      "default_chest_side.png" .. modifier,
      "default_chest_lock.png" .. modifier,
    }
  })
  minetest.register_tool("vfcrates:" .. name .. "_key", {
    description = upper(name) .. " Key",
    inventory_image = key_texture,
    on_use = function(itemstack, user, pointed_thing)
      if minetest.get_node(pointed_thing.under).name ~= "vfcrates:" .. name .. "_crate" then
        return nil
      end
      if minetest.get_node(pointed_thing.under).name == "vfcrates:" .. name .. "_crate" then
        local player_name = user:get_player_name()
        local drop = loot[math.random(#loot)]
        local returned = ItemStack(drop)
        local loot_name = minetest.registered_items[returned:get_name()].description
        local loot_meta = returned:get_meta()
        minetest.chat_send_all(player_name .. " won a " .. loot_name .. " from a " .. upper(name) .. " Crate!")
        loot_meta:set_string("description", loot_name .. "\n" .. minetest.colorize(color, upper(name) .. " Crate Loot"))
        return returned
      end
    end
  })
end

--loot = {"jumpdrive:engine 16", "jumpdrive:fleet_controller 2", "jumpdrive:backbone 99", "xtraores:helmet_chromium", "xtraores:chestplate_chromium", "xtraores:leggings_chromium", "xtraores:boots_chromium", "xtraores:pickaxe_chromium"}
loot = {"jumpdrive:engine 16", "jumpdrive:fleet_controller 2", "jumpdrive:backbone 99"}
register_key("silver", loot, "#808080")
register_key("gold", loot, "#FFDF00")
register_key("vfium", loot)
register_key("rainbow", loot)
