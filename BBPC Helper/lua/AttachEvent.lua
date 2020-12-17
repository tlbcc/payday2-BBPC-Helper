_G.BBPCHelper = _G.BBPCHelper or {}

if not Global.game_settings or Global.game_settings.level_id ~= "big" then
	return
end

-- 钩子 对话队列
Hooks:PostHook(DialogManager, "queue_dialog", "BBPCHelper_Attach", function(self, id, ...)
	if not Global.game_settings or Global.game_settings.level_id ~= "big" or not BBPCHelper then

	else
		-- 打印对话ID
		--log('AttachEvent#PostHook.id:' .. id)
		-- 入侵机房电脑时，开始设置航标
		if id == "Play_pln_bb1_04" then
			log('AttachEvent BBPCHelper start')
			BBPCHelper.start = true
			BBPCHelper:_set_waypoint()
		end
		-- 入侵正确的电脑完成时，取消航标
		if id == "Play_pln_bb1_11" then
			BBPCHelper:_remove_waypoint('CorrectOne')
			BBPCHelper.start = false
			log('AttachEvent BBPCHelper end')
		end	
	end
end)