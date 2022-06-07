function onCreate()
	-- background shit
	makeLuaSprite('BG', 'GreenHill2', 0, 0);
	setLuaSpriteScrollFactor('BG', 0.9, 0.9);
	scaleObject('BG', 1.1, 1.1);
	
	makeLuaSprite('FG', 'GreenHill', 0, 0);
	scaleObject('FG', 1.1, 1.1);
	
	addLuaSprite('BG', false);
	addLuaSprite('FG', false);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end