require "bcUtils"
require "OptionScreens/MainScreen"
require "ISUI/ISButton"

if not bcUtils then bcUtils = {} end

bcUtils.reloadLua = function() -- {{{
	getCore():ResetLua(true, "modsChanged") -- Boom!
end
-- }}}
bcUtils.initMainMenu = function() -- {{{
	bcUtils.forceReloadLuaButton = ISButton:new(MainScreen.instance.width-150, 50, 150, 25, "Forcereload LUA", nil, bcUtils.reloadLua);
	bcUtils.forceReloadLuaButton.borderColor = {r=1, g=1, b=1, a=0.1};
	bcUtils.forceReloadLuaButton:ignoreWidthChange();
	bcUtils.forceReloadLuaButton:ignoreHeightChange();
	bcUtils.forceReloadLuaButton:setAnchorLeft(false);
	bcUtils.forceReloadLuaButton:setAnchorRight(true);
	bcUtils.forceReloadLuaButton:setAnchorTop(true);
	bcUtils.forceReloadLuaButton:setAnchorBottom(false);

	MainScreen.instance:addChild(bcUtils.forceReloadLuaButton);
end
-- }}}
Events.OnMainMenuEnter.Add(bcUtils.initMainMenu);

--          TODO These MUST go elsewhere TODO
-- These are hotfixes for missing functionality in Kahlua
if table.pack == nil then
	table.pack = function(...)
		return { n = select("#", ...), ... }
	end
end
if table.unpack == nil then
	table.unpack = function(t, i)
		i = i or 1;
		if t[i] then
			return t[i], unpack(t, i + 1)
		end
	end
end

