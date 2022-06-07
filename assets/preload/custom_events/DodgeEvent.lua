local buzzCharge = false

function onCreate()
    --variables
	Dodged = false;
    canDodge = false;
	died = false;
    DodgeTime = 0;
	
	makeAnimatedLuaSprite('buzz', 'BuzzBomber', defaultOpponentX, defaultOpponentY-85);
    luaSpriteAddAnimationByPrefix('buzz', 'idle', 'BuzzBomber Idle', 24, false);
	luaSpriteAddAnimationByPrefix('buzz', 'charge', 'BuzzBomber GetReady', 24, false);
	luaSpriteAddAnimationByPrefix('buzz', 'shoot', 'BuzzBomber Shoot', 24, false);
	setObjectOrder('buzz', getObjectOrder('dadGroup') + 1);
	addLuaSprite('buzz', false);
	
	makeAnimatedLuaSprite('dodge-icon', 'DangerSign', defaultBoyfriendX-260, defaultBoyfriendY+265);
    luaSpriteAddAnimationByPrefix('dodge-icon', 'alert', 'DangerSign Alarm', 24, false);
	luaSpriteAddAnimationByPrefix('dodge-icon', 'shot', 'DangerSign Shoot', 30, false);
	setProperty('dodge-icon.visible', false);
	setObjectOrder('dodge-icon', getObjectOrder('boyfriendGroup') + 1);
    addLuaSprite('dodge-icon', false);
	
	--[[makeAnimatedLuaSprite('bfdodge', 'DangerSign', defaultBoyfriendX-230.5, defaultBoyfriendY+250);
	luaSpriteAddAnimationByPrefix('bfdodge', 'dodge', 'DangerSign Bf Dodge', 40, false);
	setProperty('bfdodge.visible', false);
	setObjectOrder('bfdodge', getObjectOrder('boyfriendGroup') + 1);
    addLuaSprite('bfdodge', false);]]--
end

function onEvent(name, value1, value2)
    if name == "DodgeEvent" then
    --Get Dodge time
	canDodge = true;
    DodgeTime = (value1); 
	--Set values so you can dodge
	buzzCharge = true
	objectPlayAnimation('buzz', 'charge', true)
	playSound('BuzzBomber_Charging', 0.45);
	runTimer('readyToDodge', 1.5);
	runTimer('Died', 3);
	
	end
end

function onUpdate()
   if canDodge == true and keyJustPressed('space') then
   
   Dodged = true;
   canDodge = false
   
   end
end

function onBeatHit()
	if curBeat % 2 == 0 and not buzzCharge then
		objectPlayAnimation('buzz', 'idle', false);
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
   if tag == 'Died' and Dodged == false then
   playSound('BuzzBomber_Shoot', 1);
   buzzCharge = false
   objectPlayAnimation('buzz', 'shoot', true)
   objectPlayAnimation('dodge-icon', 'shot', false)
   runTimer('kill', 0.35);
   died = true
   
   elseif tag == 'Died' and Dodged == true then
   playSound('BuzzBomber_Shoot', 1);
   buzzCharge = false
   objectPlayAnimation('buzz', 'shoot', true)
   objectPlayAnimation('dodge-icon', 'shot', false)
   --[[setProperty('bfdodge.visible', true);
   objectPlayAnimation('bfdodge', 'dodge', false)]]--
   characterPlayAnim('boyfriend', 'dodge', false);
   setProperty('boyfriend.specialAnim', true);
   --setProperty('boyfriend.visible', false);
   runTimer('reset', 0.7);
   Dodged = false
   died = false
   
   end
   
   if tag == 'reset' then
   setProperty('dodge-icon.visible', false);
   setProperty('bfdodge.visible', false);
   setProperty('boyfriend.visible', true);
   end
   
   if tag == 'kill' then
		setProperty('health', 0);
   end
   
   if tag == 'readyToDodge' then
   setProperty('dodge-icon.visible', true);
   objectPlayAnimation('dodge-icon', 'alert', true)
   end
end