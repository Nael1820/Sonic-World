function onEvent(name, value1, value2)
    if name == "Set Scroll Speed" then
		setProperty('SONG.speed', value1)
		setProperty('songSpeed', value1)
	end
end