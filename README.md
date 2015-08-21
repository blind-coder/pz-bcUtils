# bcUtils #

This is a collection of helper functions useful for modding Project Zomboid.

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

bcUtils.isWindow
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

