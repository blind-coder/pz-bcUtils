# bcUtils #

This is a collection of helper functions useful for modding Project Zomboid.

## Custom Classes ##
### BCUGenericTA ###
This is an extensible TimedAction that can be used to implement timed actions without having to implement an entire class for it. Simple things can be done using this action in very little code.  
Example:

    ta = BCUGenericTA:new(getPlayer(), 60); -- new TimedAction with current player and a duration of 60
    ta:setIsValid(taIsValid, param1, param2, param3); -- before this TA is created, the function taIsValid is called with the parameters param1, param2 and param3. If this function does not return true, the TA is not created.
    ta:setOnStart(taOnStart, param1); -- at the start of this TA, the function taOnStart is called with the parameter param1.
    ta:setOnStop(taOnStop); -- if this TA is interrupted (not finished), the function taOnStop is called without parameters.
    ta:setOnUpdate(taOnUpdate); -- Every updatetick, the function taOnUpdate is called without parameters.
    ta:setOnPerform(taOnPerform, param1); -- When the TA finishes successfully, the function taOnPerform is called with parameter param1
    ISTimedActionQueue.add(ta); -- add this TA to the queue and start it.

Every set\* parameter can take a variable number of arguments, from 0 arguments to a - theoretically - infinite number of arguments. **ta:setOnStart(taOnStart);** is just as valid as **ta:setOnStart(taOnStart, param1, param2, param3, param4, param5, param6, param7, param8, param9);**.  
The function set via the set\* function will have their **self** variable set to the TimedAction object, so this is valid:

    function taOnUpdate()
      self.counter = self.counter + 1;
    end
    ta = BCUGenericTA:new(getPlayer(), 60);
    ta.counter = 0;
    ta:setOnUpdate(taOnUpdate);

## Generic functions ##
### bcUtils.dump ###
This funtion returns the contents of a variable or table in a human readable format useful for debugging.  
Example:

    t = {}
    t.a = 123
    t.b = "abc"
    t.c = {}
    t.c.d = 456
    t.c.e = "def"
    print(bcUtils.dump(variable));

Result:

    {
    [a] = 123,
    [c] = {
     [a] = 456,
     [b] = "def",
    }
    ,
    [b] = "abc",
    },

### bcUtils.pline ###
This function simply prints its parameter to the logfile, converting it to a string first.  
Example:

    bcUtils.pline(getPlayer());

### bcUtils.cloneTable ###
This function creates a deep copy of a table. The return value is a copy of the original table, instead of a pointer to it.  
Example:

    table1 = { a = 123, b = 456 };
    table2 = table1;
    table2.a = 1000;
    print(table1.a); -- prints 1000
    print(table2.a); -- prints 1000

    table1 = { a = 123, b = 456 };
    table2 = bcUtils.cloneTable(table1);
    table2.a = 1000;
    print(table1.a); -- prints 123
    print(table2.a); -- prints 1000

### bcUtils.tableIsEmpty ###
This function checks if a table is empty, ie: has no key at all.  
Example:

    table1 = {};
    table1 == {} -- returns false, because these are two different tables
    bcUtils.tableIsEmpty(table1); -- returns true, because table1 has no keys
    table1.a = 123;
    bcUtils.tableIsEmpty(table1); -- returns false, because table1 has a key "a"

### bcUtils.tableIsEqual ###
This function does a deep comparison of two tables and checks if all their keys exist in the other and all values of all keys are identical.  
Example:

    table1 = { a = 1, b = 2, c = 3};
    table2 = { a = 1, b = 2, c = 3};
    table1 == table2 -- returns false, because these are two different tables
    bcUtils.tableIsEqual(table1, table2); -- returns true, because the tables have identical keys and these have identical values


### bcUtils.hasDirtRoad ###
This function checks an IsoGridSquare for the existance of a dirtroad tile.  
Example:

    bcUtils.hasDirtRoad(getCell():getGridSquare(x, y, z));

### bcUtils.hasStreet ###
This function checks an IsoGridSquare for the existance of a street tile.  
Example:

    bcUtils.hasStreet(getCell():getGridSquare(x, y, z));

### bcUtils.isContainer ###
This function checks if a worlditem is a container (eg: shelf, cabinet).  
Example:

    objects = gridsquare:getObjects();
    for x=0,objects:size()-1 do
      if bcUtils.isContainer(objects:get(x)) then
        bcUtils.pline(bcUtils.dump(objects:get(x))); -- print a dump of the container object
      end
    end

### bcUtils.isDirtRoad ###
This function checks if a worlditem is a dirtroad. The hasDirtRoad function uses this. Example:

    objects = gridsquare:getObjects();
    for x=0,objects:size()-1 do
      if bcUtils.isDirtRoad(objects:get(x)) then
        bcUtils.pline(bcUtils.dump(objects:get(x))); -- print a dump of the dirtroad object
      end
    end

### bcUtils.isStreet ###
This function checks if a worlditem is a street. The hasStreet function uses this. Example:

    objects = gridsquare:getObjects();
    for x=0,objects:size()-1 do
      if bcUtils.isStreet(objects:get(x)) then
        bcUtils.pline(bcUtils.dump(objects:get(x))); -- print a dump of the street object
      end
    end

### bcUtils.isDoor ###
This function checks if a worlditem is a door.  
Example:

    objects = gridsquare:getObjects();
    for x=0,objects:size()-1 do
      if bcUtils.isDoor(objects:get(x)) then
        bcUtils.pline(bcUtils.dump(objects:get(x))); -- print a dump of the door object
      end
    end

### bcUtils.isStove ###
This function checks if a worlditem is a stove.  
Example:

    objects = gridsquare:getObjects();
    for x=0,objects:size()-1 do
      if bcUtils.isStove(objects:get(x)) then
        bcUtils.pline(bcUtils.dump(objects:get(x))); -- print a dump of the stove object
      end
    end

### bcUtils.isWindow ###
This function checks if a worlditem is a window.  
Example:

    objects = gridsquare:getObjects();
    for x=0,objects:size()-1 do
      if bcUtils.isWindow(objects:get(x)) then
        bcUtils.pline(bcUtils.dump(objects:get(x))); -- print a dump of the window object
      end
    end

### bcUtils.isTree ###
This function checks if a worlditem is a tree.  
Example:

    objects = gridsquare:getObjects();
    for x=0,objects:size()-1 do
      if bcUtils.isTree(objects:get(x)) then
        bcUtils.pline(bcUtils.dump(objects:get(x))); -- print a dump of the tree object
      end
    end

### bcUtils.realDist ###
This function returns the real, direct distance between two coordinates using the pythagorean formula.  
Example:

    if bcUtils.realDist(player:getX(), player:getY(), gridsquare:getX(), gridsquare:getY()) <= range then
      -- do something
    end

### bcUtils.split ###
Splits a string into an array using a provided separator.  
Example:

    bcUtils.pline(bcUtils.dump(bcUtils.split("abc,def,ghi,jkl", ",")))

Result:

    {
     [1] = abc,
     [2] = def,
     [3] = ghi,
     [4] = jkl,
    },

### bcUtils.numUses ###
This function returns the number of uses in a Drainable item, assuming a full item.
Example:

    local item = getPlayer():getInventory():FindAndReturn("Base.Twine");
    bcUtils.pline(bcUtils.numUses(item));

Result:

    5

### bcUtils.numUsesLeft ###
This function returns the remaining uses in a specific Drainable item as specified by its current fill level.
Example:

    local item = getPlayer():getInventory():FindAndReturn("Base.Twine");
    bcUtils.pline(bcUtils.numUsesLeft(item));

Result:

    3

### bcUtils.writeINI ###
This functions write a Lua table into a file in ini style.  
Example:

    local t = {};
    t.main = {};
    t.main.a = 123;
    t.main.b = "abc";
    t.secondary = {};
    t.secondary.a = 1000;
    t.secondary.b = "Hello world!";
    bcUtils.writeINI("test.ini", t);

The resulting file Zomboid/Lua/test.ini looks like this:

    [main]
    a=123
    b=abc
    [secondary]
    a=1000
    b=Hello world!

Note that this isn't really 100% INI style, but close enough to be usable.

### bcUtils.readINI ###
This functions reads an ini style file and returns its content as a Lua table.  
Example (reading the file created above):

    local t = bcUtils.readINI("test.ini");
    t.main.a == "123"; -- true
    t.main.b == "abc"; -- true
    t.secondary.a == "1000"; -- true
    t.secondary.b == "Hello world!"; -- true

Note that all read values are returned as strings. No implicit number conversion is done.
