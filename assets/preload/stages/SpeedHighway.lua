function onCreate()
	-- background shit
	makeLuaSprite('city_SpeedHighway', 'city_SpeedHighway', -600, -303);
	setLuaSpriteScrollFactor('city_SpeedHighway', 0.9, 0.9);
	
	makeLuaSprite('road_SpeedHighway', 'road_SpeedHighway', -650, 600);
	setLuaSpriteScrollFactor('road_SpeedHighway', 0.9, 0.9);
	scaleObject('stagefront', 1.1, 1.1);

	-- sprites that only load if Low Quality is turned off
	if not lowQuality then
		makeLuaSprite('NotUsed_SpeedHighway', 'NotUsed_SpeedHighway', -550, -200);
		setLuaSpriteScrollFactor('NotUsed_SpeedHighway', 1.3, 1.3);
		scaleObject('NotUsed_SpeedHighway', 0.96, 0.96);
	end

	addLuaSprite('city_SpeedHighway', false);
	addLuaSprite('road_SpeedHighway', false);
	addLuaSprite('NotUsed_SpeedHighway', false);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end