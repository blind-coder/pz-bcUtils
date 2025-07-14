require "TimedActions/ISBaseTimedAction"

BCUGenericTA = ISBaseTimedAction:derive("BCUGenericTA");
function BCUGenericTA:isValid() -- {{{
	if self.onIsValid then return self:onIsValid(table.unpack(self.onIsValidArguments)); end
	return true;
end
-- }}}
function BCUGenericTA:setOnIsValid(func, ...) -- {{{
	self.onIsValid = func;
	self.onIsValidArguments = {};
	for i,v in pairs(table.pack(...)) do
		self.onIsValidArguments[i] = v;
	end
end
-- }}}

function BCUGenericTA:update() -- {{{
	if self.onUpdate then self:onUpdate(table.unpack(self.onUpdateArguments)); end
end
-- }}}
function BCUGenericTA:setOnUpdate(func, ...) -- {{{
	self.onUpdate = func;
	self.onUpdateArguments = {};
	for i,v in pairs(table.pack(...)) do
		self.onUpdateArguments[i] = v;
	end
end
-- }}}

function BCUGenericTA:start() -- {{{
	if self.onStart then self:onStart(table.unpack(self.onStartArguments)); end
end
-- }}}
function BCUGenericTA:setOnStart(func, ...) -- {{{
	self.onStart = func;
	self.onStartArguments = {};
	for i,v in pairs(table.pack(...)) do
		self.onStartArguments[i] = v;
	end
end
-- }}}

function BCUGenericTA:stop() -- {{{
	if self.onStop then self:onStop(table.unpack(self.onStopArguments)); end
	ISBaseTimedAction.stop(self);
end
-- }}}
function BCUGenericTA:setOnStop(func, ...) -- {{{
	self.onStop = func;
	self.onStopArguments = {};
	for i,v in pairs(table.pack(...)) do
		self.onStopArguments[i] = v;
	end
end
-- }}}

function BCUGenericTA:perform() -- {{{
	if self.onPerform then self:onPerform(table.unpack(self.onPerformArguments)); end
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end
-- }}}

function BCUGenericTA:setOnPerform(func, ...) -- {{{
	self.onPerform = func;
	self.onPerformArguments = {};
	for i,v in pairs(table.pack(...)) do
		self.onPerformArguments[i] = v;
	end
end
-- }}}

function BCUGenericTA:new(character, time) -- {{{
    local o = {}

    setmetatable(o, self)
    self.__index = self
    o.character = character;
    o.stopOnWalk = true;
    o.stopOnRun = true;
    o.maxTime = time;

    return o;
end
-- }}}
