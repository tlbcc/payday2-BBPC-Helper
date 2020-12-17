if not Global.game_settings or Global.game_settings.level_id ~= "big" then
	return
end

_G.BBPCHelper = _G.BBPCHelper or {}

-- 设置航标
function BBPCHelper:_set_waypoint()
	if BBPCHelper.CorrectOne then
		self:_add_waypoint('CorrectOne', BBPCHelper.CorrectOne)
	end
end

-- 添加航标
function BBPCHelper:_add_waypoint(name, position)
	if name and position then
		self:_remove_waypoint(name)
		managers.hud:add_waypoint(
			'BBPCHelperWaypoint_ThisOne_' .. name, {
			--icon = 'equipment_vial',
			icon = 'pd2_computer',
			distance = true,
			position = position,
			no_sync = true,
			present_timer = 0,
			state = "present",
			radius = 50,
			color = Color.green,
			blend_mode = "add"
		})
	end
end

-- 删除航标
function BBPCHelper:_remove_waypoint(id)
	managers.hud:remove_waypoint("BBPCHelperWaypoint_ThisOne_" .. id)
end