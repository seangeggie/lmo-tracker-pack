---[[
function has(item, amount)
    local count = Tracker:ProviderCountForCode(item)
    amount = tonumber(amount)
    if not amount then
        return count > 0
    else
        return count >= amount
    end
end

function orbs(amount, n)
    if n == nil then; n = 0; end
    if n > 10 then; return false; end -- detect 10th step when trying to resolve and abort
	return has('orb', amount)
end

function swim(orbReq, n)
    if n == nil then; n = 0; end
    if n > 10 then; return false; end -- detect 10th step when trying to resolve and abort
	if has('scalesphere') then; return true; end
	return orbs(orbReq)
end

function shootablePistol()
	return has('pistol') and has('ammunition')
end

function keyFairyCombo()
	return has('msx2') and has('qbert') and has('diviner_sensation')
end

-- ports from events.yml
function subWeaponWallForward(n)
    if n == nil then; n = 0; end
    if n > 10 then; return false; end -- detect 10th step when trying to resolve and abort
	return has('shuriken') or shootablePistol() or (has('bomb') and orbs(3))
end

function reachedBackDoorOfSurface(n)
    if n == nil then; n = 0; end
    if n > 10 then; return false; end -- detect 10th step when trying to resolve and abort
	return defeatedPalenque()
end

function defeatedAmphisbaena(n)
    if n == nil then; n = 0; end
    if n > 10 then; return false; end -- detect 10th step when trying to resolve and abort
	-- local loc = Tracker:FindObjectForCode("@Ankh Jewel (Guidance)")
	return has('game_master_2')
end

function defeatedSakit()
	return has('game_master_2')
end

function floodedTempleOfTheSun()
	return has('scalesphere') or (has('knife') and orbs(6))
end

function defeatedEllmac()
	return has('game_master_2')
end

function springElevator()
	return (has('helmet') and orbs(2) and has('grail'))
	or (has('helmet') and has('scalesphere'))
	or ((has('feather') and has('grapple_claw')) and (has('scalesphere') or (orbs(4) and has('grail'))))
end

function floodedSpringInTheSky()
	return has('origin_seal') and swim(8) and (
			has('helmet')
			or (has('feather') and has('grapple_claw'))
		)
end

function defeatedBahamut() -- TODO: event:subWeaponWallForward いらなくね？
	return floodedSpringInTheSky() and subWeaponWallForward() and has('scalesphere') and has('game_master_2')
end

function defeatedViy(n)
	if n == nil then; n = 0; end
    if n > 10 then; return false; end -- detect 10th step when trying to resolve and abort
	return (
			-- reachedFrontOfGraveyardOfTheGiants()
			(reachedGrailOfGateOfIllusion(n+1) and has('mini_doll'))
		)
		and defeatedBahamut(n+1)
		and has('ice_cape') and has('bronze_mirror') and has('game_master_2')
		and orbs(3)
		and (has('spears') or has('bombs'))
end

function reachedPalenque(n) -- this is to reach palenque, not fight him
	if n == nil then; n = 0; end
    if n > 10 then; return false; end -- detect 10th step when trying to resolve and abort
	return (defeatedViy(n+1) and has('feather'))
		or (keyFairyCombo() and has('feather') and has('bronze_mirror'))
end

function defeatedPalenque(n) -- added sub weapon and sacred orb requirements # TODO: event:subWeaponWallForward いらなくね？
    if n == nil then; n = 0; end
    if n > 10 then; return false; end -- detect 10th step when trying to resolve and abort
	return reachedPalenque(n+1) and reachedUpperOfChamberOfBirth(n+1) and lightedUpChamberOfExtinction(n+1) and subWeaponWallForward(n+1) and has('pochette_key') and reachedLowerOfChamberOfBirth(n+1) and has('flywheel') and orbs(4) and has('game_master_2')
end

function releasedTwins(n)
	if n == nil then; n = 0; end
    if n > 10 then; return false; end -- detect 10th step when trying to resolve and abort
	return defeatedEllmac(n+1) and has('twin_statue')
end

function twinLabyrinthsGlitch()
	return has('[option_glitch]') and has('feather') and has('grapple_claw') -- https://youtu.be/JcKnq1GcZD4
end

function defeatedBaphomet(n)
	if n == nil then; n = 0; end
    if n > 10 then; return false; end -- detect 10th step when trying to resolve and abort
	return releasedTwins(n+1) and has('flares') and orbs(4) and has('game_master_2') -- with just flares, fight is insanely hard without some health
end

function reachedMapSpotOfShrineOfTheMother()
	return releasedTwins() and has('dragon_bone')
end

function reachedDeathSealSpot()
	return has('key_of_eternity') and has('dragon_bone') and has('bombs') and has('ocarina') and has('flares') -- need to talk to sage in Moonlight
end

function reachedFrontOfShrineOfTheMother()
  return (has('dragon_bone') and has('key_of_eternity') and has('scanner') and has('glyph_reader') and has('feather') and has('spears') and has('glove')) -- boots not necessary
  	or (has('[option_glitch]') and twinLabyrinthsGlitch() and has('twin_statue') and has('knife')) -- https://youtu.be/HxWC093flfI
end

function reachedFrontOfGateOfIllusion(n)
    if n == nil then; n = 0; end
    if n > 10 then; return false; end -- detect 10th step when trying to resolve and abort
	return reachedGrailOfTempleOfMoonlight(n+1)
end

function reachedElevatorOfGateOfIllusion(n)
    if n == nil then; n = 0; end
    if n > 10 then; return false; end -- detect 10th step when trying to resolve and abort
	return reachedFrontOfGateOfIllusion(n+1) and (
		(has('anchor') and has('knife') and swim(1))
		or has('[option_glitch]') -- https://youtu.be/VQ3e1CJxx5c
	)
end

function reachedGrailOfGateOfIllusion(n)
    if n == nil then; n = 0; end
    if n > 10 then; return false; end -- detect 10th step when trying to resolve and abort
	return reachedElevatorOfGateOfIllusion(n+1) or reachedBackDoorOfGateOfIllusion(n+1)
end

function reachedBackDoorOfGateOfIllusion(n)
    if n == nil then; n = 0; end
    if n > 10 then; return false; end -- detect 10th step when trying to resolve and abort
	return reachedTowerOfTheGoddess(n+1) and has('feather') and has('grapple_claw') and has('boots') and has('keyblade') and has('plane_model') -- need boots to climb tower
end

function escapeShu() -- this is for escaping the fight with Shu
	return has('axe') or has('life_seal') or has('grail')
end

function reachedFrontOfGraveyardOfTheGiants(n)
	if n == nil then; n = 0; end
    if n > 10 then; return false; end -- detect 10th step when trying to resolve and abort
	return (defeatedSakit(n+1) and has('bronze_mirror'))
		or (reachedBackDoorOfGraveyardOfTheGiants(n+1) and has('bombs')) -- recursive...
		or (has('[not_in_logic]') and reachedLiarOfGraveyardOfTheGiants(n+1) and has('grail')) -- not in rando logic but probably should be! You *can* get to the front from the liar!
		-- or ((reachedTowerOfTheGoddess() and has('feather, grapple_claw, boots, plane_model')) and has('bombs')) -- still recursive...
		-- or ((defeatedViy() and has('feather, grapple_claw, boots, plane_model')) and has('bombs')) -- STILL recursive
		-- or (((((reachedGrailOfGateOfIllusion(n+1) and has('mini_doll'))) and defeatedBahamut(n+1) and has('ice_cape, bronze_mirror, game_master_2') and orbs(3) and (has('spears') or has('bombs'))) and has('feather, grapple_claw, boots, plane_model')) and has('bombs'))
end

function reachedBackDoorOfGraveyardOfTheGiants(n)
	if n == nil then; n = 0; end
    if n > 10 then; return false; end -- detect 10th step when trying to resolve and abort
	return (reachedTowerOfTheGoddess(n+1) and has('feather') and has('grapple_claw') and has('boots') and has('plane_model')) -- need boots to climb tower
		or (reachedFrontOfGraveyardOfTheGiants(n+1) and has('bombs') and orbs(3)) -- can open bomb wall from left side
		-- or (((defeatedSakit(n+1) and has('bronze_mirror'))) and has('bombs, $orbs|3')) -- removed recursion
end

function reachedLiarOfGraveyardOfTheGiants(n)
	if n == nil then; n = 0; end
    if n > 10 then; return false; end -- detect 10th step when trying to resolve and abort
	return (reachedFrontOfGraveyardOfTheGiants(n+1) and has('feather'))
		or reachedFrontOfGateOfIllusion(n+1)
end

function surviveAnubis() -- need to survive anubis
	return has('book_of_the_dead') or orbs(4)
end

function reachedFrontOfTempleOfMoonlight(n)
	if n == nil then; n = 0; end
    if n > 10 then; return false; end -- detect 10th step when trying to resolve and abort
	return (defeatedEllmac(n+1) and has('bronze_mirror'))
		or reachedLiarOfGraveyardOfTheGiants(n+1)
end

function reachedGrailOfTempleOfMoonlight(n)
	if n == nil then; n = 0; end
    if n > 10 then; return false; end -- detect 10th step when trying to resolve and abort
	return (reachedFrontOfTempleOfMoonlight(n+1) and has('shuriken'))
		or (
			has('flares') and (has('grapple_claw') or has('feather'))
			and escapeFromTempleOfMoonlight(n+1)
		)
end

function escapeFromTempleOfMoonlight(n)
    if n == nil then; n = 0; end
    if n > 10 then; return false; end -- detect 10th step when trying to resolve and abort
	return has('grail')
		or (
			has('bronze_mirror') and defeatedAmphisbaena(n+1) and reachedElevatorOfGateOfIllusion(n+1)
		) or (
			has('bronze_mirror')
			and defeatedSakit(n+1)
		) or (
			has('bronze_mirror') and defeatedEllmac(n+1)
		)
end

function reachedTowerOfTheGoddess(n)
	if n == nil then; n = 0; end
    if n > 10 then; return false; end -- detect 10th step when trying to resolve and abort
	return defeatedViy(n+1) -- defeatedViy already includes bronze mirror
		or (
			reachedFrontOfGraveyardOfTheGiants(n+1) and orbs(3) and has('bombs') and has('plane_model') and has('grail')
		) -- can backdoor from Graveyard
end

function reachedFrontOfTowerOfRuin(n) -- TODO: Wouldn't the upper level need feathers or boots?
    if n == nil then; n = 0; end
    if n > 10 then; return false; end -- detect 10th step when trying to resolve and abort
	return reachedFrontOfGraveyardOfTheGiants(n+1)
		or (
			reachedGrailOfGateOfIllusion(n+1) and has('mini_doll')
		)
end

function reachedBackDoorOfTowerOfRuin(n)
    if n == nil then; n = 0; end
    if n > 10 then; return false; end -- detect 10th step when trying to resolve and abort
	return reachedBackDoorOfSurface(n+1) and defeatedBaphomet(n+1) -- reachedBackDoorOfSurface already includes bronze mirror
end

function reachedLowerOfChamberOfBirth(n) -- health is drained too fast to get through water without scalesphere
    if n == nil then; n = 0; end
    if n > 10 then; return false; end -- detect 10th step when trying to resolve and abort
	return reachedUpperOfChamberOfBirth(n+1)
		or (
			reachedTowerOfTheGoddess(n+1) and has('scanner') and has('glyph_reader') and has('plane_model') and has('scalesphere') and has('boots') and has('helmet')
		) -- need boots and helmet
end

function reachedUpperOfChamberOfBirth(n)
    if n == nil then; n = 0; end
    if n > 10 then; return false; end -- detect 10th step when trying to resolve and abort
	return reachedBackDoorOfGraveyardOfTheGiants(n+1)
		or (reachedLowerOfChamberOfBirth(n+1) and has('flywheel'))
end

function lightedUpChamberOfExtinction(n)
    if n == nil then; n = 0; end
    if n > 10 then; return false; end -- detect 10th step when trying to resolve and abort
	return (reachedUpperOfChamberOfBirth(n+1) and has('feather'))
		or has('flares')
end

function reachedDimensionalCorridor(n)
    if n == nil then; n = 0; end
    if n > 10 then; return false; end -- detect 10th step when trying to resolve and abort
	return releasedTwins(n+1)
		and has('crystal_skull') and has('bronze_mirror') and (has('feather') or (has('boots') and has('grapple_claw'))) -- can get in with boots and grapple claw
end

function defeatedTiamat()
	return reachedDimensionalCorridor() and has('keyblade') and orbs(4) and has('game_master_2') -- added health requirement
end

function reachedTrueShrineOfTheMother()
	return reachedMapSpotOfShrineOfTheMother() and reachedDeathSealSpot() and reachedFrontOfShrineOfTheMother() and defeatedAmphisbaena() and defeatedSakit() and defeatedEllmac() and defeatedBahamut() and defeatedViy() and defeatedPalenque() and defeatedBaphomet() and defeatedTiamat()
end
