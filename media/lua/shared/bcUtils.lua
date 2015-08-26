require "ISUI/ISButton"
require "luautils"

if not bcUtils then bcUtils = {} end
bcUtils.dump = function(o, lvl, ind) -- {{{ Small function to dump an object.
	if lvl == nil then lvl = 5 end
	if ind == nil then ind = 0 end

	local x;
	local pref = "";
	for x=1,ind do
		pref = pref .. " ";
	end

	if lvl < 0 then return pref .. "SO ("..tostring(o)..")" end

	if type(o) == 'table' then
		local s = '{\n';
		for k,v in pairs(o) do
			if k == "prev" or k == "next" then
				s = s .. pref .. '['..k..'] = '..tostring(v)..",\n";
			else
				if type(k) ~= 'number' then k = '"'..tostring(k)..'"' end
				s = s .. pref .. '['..k..'] = ' .. bcUtils.dump(v, lvl - 1, ind + 1) .. ',\n'
			end
		end
		pref = "";
		for x=2,ind do
			pref = pref .. " ";
		end
		return s .. pref .. '}\n'
	else
		if type(o) == "string" then return '"'..tostring(o)..'"' end
		return tostring(o)
	end
end
-- }}}
bcUtils.pline = function (text) -- {{{ Print text to logfile
	print(tostring(text));
end
-- }}}
bcUtils.isStove = function(o) -- {{{ -- Check if an item is a stove
	if not o then return false end;
	return instanceof(o, "IsoStove");
end
-- }}}
bcUtils.isWindow = function(o) -- {{{ -- check if an item is a window
	if not o then return false end;
	return instanceof(o, "IsoWindow");
end
-- }}}
bcUtils.isDoor = function(o) -- {{{ check if an item is a door
	if not o then return false end;
	return (instanceof(o, "IsoDoor") or (instanceof(o, "IsoThumpable") and o:isDoor()))
end
-- }}}
bcUtils.isTree = function(o) -- {{{ check if an item is a tree
	if not o then return false end;
	return instanceof(o, "IsoTree");
end
-- }}}
bcUtils.isContainer = function(o) -- {{{ check if an item is a container
	if not o then return false end;
	return o:getContainer();
end
-- }}}
bcUtils.isPenOrPencil = function(o) -- {{{ check if an item is a pen or pencil
	if not o then return false end;
	return o:getFullType() == "Base.Pen" or o:getFullType() == "Base.Pencil";
end
-- }}}
bcUtils.isMap = function(o) -- {{{ check if an item is a map
	if not o then return false end;
	return o:getFullType() == "BCMapMod.Map";
end
-- }}}
bcUtils.tableIsEmpty = function(o) -- {{{ check if a passed table is empty (ie: {} )
	for _,_ in pairs(o) do
		return false
	end
	return true
end
-- }}}
bcUtils.tableIsEqual = function(tbl1, tbl2) -- {{{ check if two tables have identical content
	for k,v in pairs(tbl1) do
		if type(v) == "table" and type(tbl2[k]) == "table" then
			if not bcUtils.tableIsEqual(v, tbl2[k]) then return false end
		else
			if v ~= tbl2[k] then return false end
		end
	end
	for k,v in pairs(tbl2) do
		if type(v) == "table" and type(tbl1[k]) == "table" then
			if not bcUtils.tableIsEqual(v, tbl1[k]) then return false end
		else
			if v ~= tbl1[k] then return false end
		end
	end
	return true
end
-- }}}
bcUtils.cloneTable = function(orig) -- {{{ clone a table
	local orig_type = type(orig)
	local copy
	if orig_type == 'table' then
		copy = {}
		for orig_key,orig_value in pairs(orig) do
			copy[orig_key] = bcUtils.cloneTable(orig_value)
		end
		setmetatable(copy, bcUtils.cloneTable(getmetatable(orig)))
	else -- number, string, boolean, etc
		copy = orig
	end
	return copy
end
-- }}}
bcUtils.isStreet = function(o) -- {{{ check if an item is a street
	if not o then return false end
	if not o:getTextureName() then return false end
	return luautils.stringStarts(o:getTextureName(), "blends_street");
end
-- }}}
bcUtils.hasStreet = function(o) -- {{{ chcek if a tile has a street on it
	if not o then return false end
	local objects = o:getObjects();
	for k=0,objects:size()-1 do
		local it = objects:get(k);
		if bcUtils.isStreet(it) then
			return true;
		end
	end
	return false
end
-- }}}
bcUtils.isDirtRoad = function(o) -- {{{ check if an item is a dirtroad
	if not o then return false end
	if not o:getTextureName() then return false end
	if luautils.stringStarts(o:getTextureName(), "blends_natural") then
		local m = bcUtils.split(o:getTextureName(), "_");
		return m[3] == "01" and tonumber(m[4]) <= 7;
	end
	return false
end
-- }}}
bcUtils.hasDirtRoad = function(o) -- {{{ check if a tile has a dirtroad on it
	if not o then return false end
	local objects = o:getObjects();
	for k=0,objects:size()-1 do
		local it = objects:get(k);
		if bcUtils.isDirtRoad(it) then
			return true;
		end
	end
	return false
end
-- }}}
bcUtils.realDist = function(x1, y1, x2, y2) -- {{{ check real distance between two tiles
	return math.sqrt((x1-x2)*(x1-x2) + (y1-y2)*(y1-y2))
end
-- }}}
bcUtils.split = function(string, sep) -- {{{ split a string, regex style
	sep = sep or ":";
	local pattern = string.format("([^%s]+)", sep);
	local fields = {};
	string:gsub(pattern, function(c) fields[#fields+1] = c end);
	return fields
end
-- }}}

bcUtils.numUses = function(item) -- {{{ returns number of uses in a Drainable
	if not item then return 0 end
	return math.floor(1 / item:getUseDelta());
end
-- }}}
bcUtils.numUsesLeft = function(item) -- {{{ returns remaining uses in a Drainable
	if not item then return 0 end
	return math.floor(item:getUsedDelta() / item:getUseDelta());
end
-- }}}
