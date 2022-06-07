local doDrain = false
local automaticDrain = false
local healthToRemove = 0.0036

function onCreate()
	if difficulty == 1 then
		healthToRemove = 0.0026
	elseif difficulty == 2 then
		healthToRemove = 0.0016
	end
	-- background shit
	makeLuaSprite('building_ChemicalPlant', 'building_ChemicalPlant', -600, -300);
	setLuaSpriteScrollFactor('building_ChemicalPlant', 0.9, 0.9);
	
	makeLuaSprite('flor_ChemicalPlant', 'flor_ChemicalPlant', -650, 600);
	setLuaSpriteScrollFactor('flor_ChemicalPlant', 0.9, 0.9);
	scaleObject('stagefront', 1.1, 1.1);

	-- sprites that only load if Low Quality is turned off
	if not lowQuality then
		makeLuaSprite('NotUsed_ChemicalPlant', 'NotUsed_ChemicalPlant', -550, -200);
		setLuaSpriteScrollFactor('NotUsed_ChemicalPlant', 1.3, 1.3);
		scaleObject('NotUsed_ChemicalPlant', 0.96, 0.96);
	end

	addLuaSprite('building_ChemicalPlant', false);
	addLuaSprite('flor_ChemicalPlant', false);
	addLuaSprite('NotUsed_ChemicalPlant', false);
end

function onEvent(name, value1, value2)
    if name == "Tails Health Drain" then
		playSound('TailsFly_Effect', 1);
		runTimer('daDrain', 4.4);
		doDrain = true
	end
	
	if name == "Auto Tails Drain" then
		automaticDrain = true
	end
end

function onBeatHit()
	if curBeat % 25 == 0 and automaticDrain and getProperty('health') > 0.2 then
		playSound('TailsFly_Effect', 1);
		runTimer('daDrain', 4.4);
		doDrain = true
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'daDrain' then
		doDrain = false
	end
end

function onUpdate()
	if doDrain then
		setProperty('iconP1.visible', false)
		setProperty('iconP2.visible', false)
		setProperty('tailsI.visible', true)
		setProperty('health',getProperty('health')-healthToRemove)
	else
		setProperty('iconP1.visible', true)
		setProperty('iconP2.visible', true)
		setProperty('tailsI.visible', false)
	end
end

function onCreatePost()
	makeAnimatedLuaSprite('tailsI', 'tailsPull', getProperty('iconP1.x')+50, getProperty('iconP1.y')-50)
	addAnimationByPrefix('tailsI', 'fly', 'Icon', 24, true)
	objectPlayAnimation('tailsI', 'fly', true)
	setObjectCamera('tailsI', 'hud')
	scaleObject('tailsI', 1.1, 1.1);
	addLuaSprite('tailsI', true)
	setObjectOrder('tailsI', getObjectOrder('iconP2') + 1)
	setProperty('tailsI.visible', false)
end

function onUpdatePost(elapsed)
	setProperty('tailsI.x', getProperty('iconP1.x'))
	setProperty('tailsI.y', getProperty('iconP1.y')-50)
end