local isBoosting = false

function onCreate()
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		--Check if the note is an Instakill Note
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'BoostNote' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'Boost_NOTE_assets'); --Change texture

			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Doesn't let Dad/Opponent notes get ignored
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true); --Miss has no penalties
			end
		end
	end
	--debugPrint('Script started!')
end

-- Function called when you hit a note (after note hit calculations)
-- id: The note member id, you can get whatever variable you want from this note, example: "getPropertyFromGroup('notes', id, 'strumTime')"
-- noteData: 0 = Left, 1 = Down, 2 = Up, 3 = Right
-- noteType: The note type string/tag
-- isSustainNote: If it's a hold note, can be either true or false
function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == 'BoostNote' and not isBoosting then
		if getProperty('dad.curCharacter') == 'Sonic' then -- So it doesn't crash(?) idk how lua works
		characterPlayAnim('dad', 'Boost', true);
		setProperty('dad.specialAnim', true);
		end
		if getProperty('boyfriend.curCharacter') == 'bf' then
		characterPlayAnim('boyfriend', 'hurt', true);
		setProperty('boyfriend.specialAnim', true);
		end
		setProperty('SONG.speed',5)
		setProperty('songSpeed',5)
		triggerEvent('Screen Shake','1, 0.01','1, 0.01')
		isBoosting = true
		playSound('Boost_Pickup', 0.3);
		--playMusic('Boost_Effect', 1, true);
		--soundFadeIn('', 1.75, 0, 0.8);
		runTimer('speeding', 6);
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'speeding' then
		isBoosting = false
		--soundFadeOut('', 0.5, 0);
		playSound('Boost_Ended', 0.3);
		triggerEvent('Change Scroll Speed',1,0)
	end
end