-- mods/default/stubs.lua
--
-- Заглушки для нод з видалених модів.
--
-- Потрібні, щоб mapgen не скаржився, коли в схематиках
-- (наприклад, у повалених деревах) зустрічаються ноди
-- з модів, яких у грі більше немає.
--
-- Логіка: якщо нода вже існує (хтось її зареєстрував) — не чіпаємо.
-- Якщо ні — реєструємо невидиму заглушку.
--
-- Коли повернеш справжній мод — просто видали цей файл
-- і рядок з нього в init.lua.

local stubs = {
	"flowers:mushroom_brown",
	"flowers:mushroom_red",
}

local function register_stub(name)
	minetest.register_node(":" .. name, {
		description = "Stub: " .. name,
		drawtype = "airlike",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		pointable = false,
		diggable = false,
		buildable_to = true,
		drop = "",
		groups = {not_in_creative_inventory = 1},
	})
end

minetest.register_on_mods_loaded(function()
	for _, name in ipairs(stubs) do
		if not minetest.registered_nodes[name] then
			register_stub(name)
			minetest.log("info", "[default] Registered stub for missing node: " .. name)
		end
	end
end)