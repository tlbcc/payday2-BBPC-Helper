core:module("CoreMissionScriptElement")
core:import("CoreXml")
core:import("CoreCode")
core:import("CoreClass")

_G.BBPCHelper = _G.BBPCHelper or {}

BBPCHelper = _G.BBPCHelper or {}
BBPCHelper.start = false
BBPCHelper.id_list = {}

if not Global.game_settings or Global.game_settings.level_id ~= "big" then
	return
end

local BBPCHelper_GetCorrectOne = MissionScriptElement.on_executed

function MissionScriptElement:on_executed(...)
	if not Global.game_settings or Global.game_settings.level_id ~= "big" or not BBPCHelper then

	else
		if BBPCHelper and BBPCHelper.start then
			local _id = 'id_' .. self._id
			--local _editor_name = self._editor_name
			--local _values = self._values
			if not BBPCHelper.id_list[_id] then
				--log('BBPCHelper start id log')
				BBPCHelper.id_list[_id] = _id
--[[				log('GetRightOne#MissionScriptElement#on_executed.self._id: ' .. self._id)
				log('GetRightOne#MissionScriptElement#on_executed.self._editor_name: ' .. _editor_name)
				log('GetRightOne#MissionScriptElement#on_executed.self._values: ' .. dumpTab(_values))
				if startWith(tostring(_editor_name), "used_staff_keyboard") then
					local player = managers.player:local_player()
					if player then
						local result = player:movement():current_state()._fwd_ray
						if result then
							log('GetRightOne#MissionScriptElement#on_executed._fwd_ray: ' .. dumpTab(result))
						end
					end
				end]]
				if self._id == 103182 and BBPCHelper.rightPCIndex then
					log("start add waypoint")
					local PC_INDEX_Vector3 = {
						[1] = Vector3(2754.6, 1420.57, -919.285), 	-- 001_103176
						[2] = Vector3(2084.2, 1413.8, -919.057), 	-- 002_103185
						[3] = Vector3(1941.59, 1336.07, -919.057), 	-- 003_103218
						[4] = Vector3(1592.57, 1419.96, -919.057), 	-- 004_103284
						[5] = Vector3(2557.31, 1854.69, -919.057), 	-- 005_103297
						[6] = Vector3(2445.92, 1849.54, -919.057), 	-- 006_103312
						[7] = Vector3(1856.79, 1827.83, -919.057), 	-- 007_103321
						[8] = Vector3(1731.95, 1811.14, -919.285), 	-- 008_103226
						[9] = Vector3(1086.64, 1220.85, -519.057), 	-- 009_13331
						[10] = Vector3(1292.62, 1220.58, -519.057),	-- 010_103347
						[11] = Vector3(1909.12, 1393.11, -519.047),	-- 011_103360
						[12] = Vector3(1919.6, 1586.53, -519.047), 	-- 012_103373
						[13] = Vector3(2318.58, 1616.38, -519.047),	-- 013_103393
						[14] = Vector3(2320.34, 1308.84, -519.047),	-- 014_103404
						[15] = Vector3(2723.95, 1224.08, -519.057),	-- 015_103444
						[16] = Vector3(2895.41, 1785.57, -519.057),	-- 016_103455
						[17] = Vector3(2921.47, 1222.56, -519.057) 	-- 017_103470
					}
					--log("right pc index: " .. BBPCHelper.rightPCIndex)
					--log("right pc vector3: " .. tostring(PC_INDEX_Vector3[BBPCHelper.rightPCIndex]))
					if PC_INDEX_Vector3[BBPCHelper.rightPCIndex] then
						--log("right pc vector3: " .. tostring(PC_INDEX_Vector3[BBPCHelper.rightPCIndex]))
						BBPCHelper.CorrectOne = PC_INDEX_Vector3[BBPCHelper.rightPCIndex]
						BBPCHelper:_set_waypoint()
					end
				end
			end
		end
	end
	return BBPCHelper_GetCorrectOne(self, ...)
end

---
-- @function: 获取table的字符串格式内容，递归
-- @tab： table
-- @ind：不用传此参数，递归用（前缀格式（空格））
-- @return: format string of the table
function dumpTab(tab,ind)
	if(tab==nil)then return "nil" end;
	local str="{";
	if(ind==nil)then ind="  "; end;
	--//each of table
	for k,v in pairs(tab) do
		--//key
		if(type(k)=="string")then
			k=tostring(k).." = ";
		else
			k="["..tostring(k).."] = ";
		end;--//end if
		--//value
		local s="";
		if(type(v)=="nil")then
			s="nil";
		elseif(type(v)=="boolean")then
			if(v) then s="true"; else s="false"; end;
		elseif(type(v)=="number")then
			s=v;
		elseif(type(v)=="string")then
			s="\""..v.."\"";
		elseif(type(v)=="table")then
			s=dumpTab(v,ind.."  ");
			s=string.sub(s,1,#s-1);
		elseif(type(v)=="function")then
			s="function : "..v;
		elseif(type(v)=="thread")then
			s="thread : "..tostring(v);
		elseif(type(v)=="userdata")then
			s="userdata : "..tostring(v);
		else
			s="nuknow : "..tostring(v);
		end;--//end if
		--//Contact
		str=str.."\n"..ind..k..s.." ,";
	end --//end for
	--//return the format string
	local sss=string.sub(str,1,#str-1);
	if(#ind>0)then ind=string.sub(ind,1,#ind-2) end;
	sss=sss.."\n"..ind.."}\n";
	return sss;--string.sub(str,1,#str-1).."\n"..ind.."}\n";
end;--//end function


--//网摘,直接打印到屏幕
function printTable(t, n)
	if "table" ~= type(t) then
		return 0;
	end
	n = n or 0;
	local str_space = "";
	for i = 1, n do
		str_space = str_space.."  ";
	end
	print(str_space.."{");
	for k, v in pairs(t) do
		local str_k_v
		if(type(k)=="string")then
			str_k_v = str_space.."  "..tostring(k).." = ";
		else
			str_k_v = str_space.."  ["..tostring(k).."] = ";
		end
		if "table" == type(v) then
			print(str_k_v);
			printTable(v, n + 1);
		else
			if(type(v)=="string")then
				str_k_v = str_k_v.."\""..tostring(v).."\"";
			else
				str_k_v = str_k_v..tostring(v);
			end
			print(str_k_v);
		end
	end
	print(str_space.."}");
end

function startWith(str, substr)
	if str == nil or substr == nil then
		return nil, "the string or the sub-stirng parameter is nil"
	end
	if string.find(str, substr) ~= 1 then
		return false
	else
		return true
	end
end