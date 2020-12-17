core:module("CoreElementRandom")
core:import("CoreMissionScriptElement")
core:import("CoreTable")
ElementRandom = ElementRandom or class(CoreMissionScriptElement.MissionScriptElement)

_G.BBPCHelper = _G.BBPCHelper or {}

BBPCHelper = _G.BBPCHelper or {}
if not Global.game_settings or Global.game_settings.level_id ~= "big" then
	return
end

function ElementRandom:_get_random_elements()
	local rand = math.random(#self._unused_randoms)
	if Global.game_settings then
		local _level_id = tostring(Global.game_settings.level_id)
		if _level_id == "big" then
--[[			log('CoreElementRandom.lua#ElementRandom#_get_random_elements.self._id: ' .. self._id)
			log('CoreElementRandom.lua#ElementRandom#_get_random_elements.self._editor_name: ' .. self._editor_name)
			log('CoreElementRandom.lua#ElementRandom#_get_random_elements.self.rand: ' .. rand)
			log('CoreElementRandom.lua#ElementRandom#_get_random_elements.self._get_random_elements: ' .. dumpTab(self._unused_randoms))
			log('CoreElementRandom.lua#ElementRandom#_get_random_elements.self._values: ' .. dumpTab(self._values))]]
			-- _logic_random_022
			if self._id == 103246 then
				BBPCHelper.rightPCIndex = rand
			end
		end
	end
	return table.remove(self._unused_randoms, rand)
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