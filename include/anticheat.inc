/***
	Reality-Anticheat Include
	
	© MacMailler, 2012—2014.
***/
#if defined __rac_included
	#endinput
#endif
#define __rac_included
#pragma library __rac_included

#define __AC_DEBUG					1
#define __AC_TITLE					"Reality-Anticheat"
#define __AC_VERSION				"0.4-alpha"
#define __AC_COPYRIGHT				"(c) MacMailler, 2012—2014"
#define __MP_VERSION 				"0.3x"


#define MAX_WARNS 					(2)
#define MAX_WEAPONS					(47)
#define MAX_WEAPON_SLOTS			(13)
#define MAX_AIM_TICKS				(3)
#define MAX_PLAYER_SKILLS			(11)

#define R::							R_
#define AC::						AC_
#define Rac::						AC_

#define R_MAX_CHEATS				(21)
#define R_NONE						(0xFFFF)
#define R_JOYPAD					(0)
#define R_CAR_TP					(1)
#define R_MINIGUN					(2)
#define R_DRIVEBY					(3)
#define R_TELEPORT					(4)
#define R_FLY_HACK					(5)
#define R_CAR_SPAM					(6)
#define R_SANDBOXIE					(7)
#define R_FLOOD_CMD					(8)
#define R_FLOOD_KILL				(9)
#define R_SPEED_HACK				(10)
#define R_REMOVE_VEH				(11)
#define R_REPAIR_HACK				(12)
#define R_TUNING_HACK				(13)
#define R_COLORS_HACK				(14)
#define R_WEAPON_HACK				(15)
#define R_HEALTH_HACK				(16)
#define R_ARMOUR_HACK				(17)
#define R_ANTI_FREEZE				(18)
#define R_UNLIM_AMMO				(19)
#define R_SPECHACK					(20)

#define AC_HEALTH					(0)
#define AC_ARMOUR					(1)

#define AC_isValidPlayer(%0)		(0<=%0<MAX_PLAYERS)
#define AC_GetPlayerState(%0)		(AC::Info[%0][AC::OldState])
#define AC_GetPlayerVehicle(%0)		(AC::Info[%0][AC::OldVeh])
#define AC_IsColdWeapon(%0)			((%0>0&&%0<16)||%0==46)
#define AC_IsPlayerSync(%0)			(AC::Info[%0][AC::Sync])
#define AC_Speed(%0,%1,%2,%3,%4) 	floatround(floatsqroot((%4)?(%0*%0+%1*%1+%2*%2):(%0*%0+%1*%1))*%3*1.6)


#if defined __filterscript__

#define AC_Redirect					CallRemoteFunction
#define GivePlayerMoney				AC::GivePlayerMoney
#define SetPlayerMoney				AC::SetPlayerMoney
#define ResetPlayerMoney			AC::ResetPlayerMoney
#define SetPlayerHealth				AC::SetPlayerHealth
#define SetPlayerArmour				AC::SetPlayerArmour
#define GivePlayerWeapon			AC::GivePlayerWeapon
#define ResetPlayerWeapons			AC::ResetPlayerWeapons
#define TogglePlayerSpectating		AC::TogglePlayerSpectating
#define TogglePlayerControllable	AC::TogglePlayerControllable
#define PutPlayerInVehicle			AC::PutPlayerInVehicle
#define SetPlayerInterior			AC::SetPlayerInterior
#define SetPlayerVirtualWorld		AC::SetPlayerVirtualWorld
#define SetPlayerPos				AC::SetPlayerPos
#define SetVehiclePos				AC::SetVehiclePos
#define SetVehicleHealth			AC::SetVehicleHealth
#define RepairVehicle				AC::RepairVehicle
#define RemovePlayerFromVehicle		AC::RemovePlayerFromVehicle
#define ChangeVehicleColor			AC::ChangeVehicleColor
#define CreateVehicle				AC::CreateVehicle
#define AddStaticVehicle			AC::CreateVehicle
#define AddStaticVehicleEx			AC::CreateVehicle
#define DestroyVehicle				AC::DestroyVehicle

stock AC::GivePlayerMoney(playerid, money) return Rac::Redirect(""#AC::"GivePlayerMoney", "ii", playerid, money);
stock AC::SetPlayerMoney(playerid, money) return Rac::Redirect(""#AC::"SetPlayerMoney", "ii", playerid, money);
stock AC::ResetPlayerMoney(playerid) return Rac::Redirect(""#AC::"ResetPlayerMoney", "i", playerid);
stock AC::SetPlayerHealth(playerid, Float:health) return Rac::Redirect(""#AC::"SetPlayerHealth", "if", playerid, health);
stock AC::SetPlayerArmour(playerid, Float:armour) return Rac::Redirect(""#AC::"SetPlayerArmour", "if", playerid, armour);
stock AC::GivePlayerWeapon(playerid, weaponid, ammo) return Rac::Call(""#AC::"GivePlayerWeapon", "iii", playerid, weaponid, ammo);
stock AC::ResetPlayerWeapons(playerid) return Rac::Redirect(""#AC::"ResetPlayerWeapons", "i", playerid);
stock AC::TogglePlayerSpectating(playerid, bool:toggle) return Rac::Redirect(""#AC::"TogglePlayerSpectating", "ii", playerid, toggle);
stock AC::TogglePlayerControllable(playerid, bool:toggle) return Rac::Redirect(""#AC::"TogglePlayerControllable", "ii", playerid, toggle);
stock AC::PutPlayerInVehicle(playerid, vehicleid, seatid) return Rac::Redirect(""#AC::"PutPlayerInVehicle", "iii", playerid, vehicleid, seatid);
stock AC::SetPlayerInterior(playerid, interiorid) return Rac::Redirect(""#AC::"SetPlayerInterior", "ii", playerid, interiorid);
stock AC::SetPlayerVirtualWorld(playerid, virtualworld) return Rac::Redirect(""#AC::"SetPlayerVirtualWorld", "ii", playerid, virtualworld);
stock AC::SetPlayerPos(playerid, Float:x, Float:y, Float:z) return Rac::Redirect(""#AC::"SetPlayerPos", "ifff", playerid, x, y, z);
stock AC::SetVehiclePos(vehicleid, Float:x, Float:y, Float:z) return Rac::Redirect(""#AC::"SetVehiclePos", "ifff", vehicleid, x, y, z);
stock AC::SetVehicleHealth(vehicleid, Float:health) return Rac::Redirect(""#AC::"SetVehicleHealth", "if", vehicleid, health);
stock AC::RepairVehicle(vehicleid) return Rac::Redirect(""#AC::"RepairVehicle", "i", vehicleid);
stock AC::RemovePlayerFromVehicle(playerid) return Rac::Redirect(""#AC::"RemovePlayerFromVehicle", "i", playerid);
stock AC::ChangeVehicleColor(vehicleid, color1, color2) return Rac::Redirect(""#AC::"ChangeVehicleColor", "iii", vehicleid, color1, color2);
stock AC::CreateVehicle(model, Float:x, Float:y, Float:z, Float:a, color1, color2, resptime=600) return Rac::Redirect("VEH_Create", "iii", model, x, y, z, a, color1, color2, resptime);
stock AC::DestroyVehicle(vehicleid) return Rac::Redirect("VEH_Destroy", "i", vehicleid);

forward onPlayerBan(playerid, reason[], reasonid);
forward onPlayerKick(playerid, reason[], reasonid);

#endinput
#endif


forward onAntiCheatUpdate();
forward onPlayerBan(playerid, reason[], reasonid);
forward onPlayerKick(playerid, reason[], reasonid);


static bool:AC_OPB = false;
static bool:AC_OPK = false;
static bool:AC_OACU = false;
static AC::TimerUpdate;


new const R_Info[][] = {
	"#8693",	// JoyPad
	"#0847",	// CarTp
	"#1488",	// Minigun
	"#4748",	// DriveBy
	"#8687",	// AirBreak/Teleport
	"#2329",	// Fly
	"#1338",	// CarSpam
	"#4484",	// Sanboxie
	"#8460",	// flood in chat
	"#2056",	// Кил флуд
	"#3714",	// Спидхак
	"#5494",	// CarHack
	"#8103",	// HealCar
	"#5566",	// Tuning
	"#7660",	// ColorHack
	"#1060",	// WeaponHack
	"#0004",	// SetHP
	"#3490",	// SetArmour
	"#8283",	// AntiFreeze
	"#0730",	// UnlimAmmo
	"#6418"		// Inv/Spechack
};


enum AC::PlayerEnum {
	bool:AC::Sync,
	bool:AC::ToggleSpec,
	
	AC::NoAB,
	
	AC::OldVeh,
	AC::OldState,
	AC::OldSpeed,
	
	AC::AimTick,
	AC::AimCount,
	
	AC::Money,
	AC::Toggle,
	AC::RemoveVeh,
	
	AC::Interior,
	AC::VirtualWorld,
	
	AC::EnteredVeh,
	AC::ClearWarns,
	
	AC::Delay[R::MAX_CHEATS],
	AC::Warns[R::MAX_CHEATS],
	
	AC::Weap[MAX_WEAPON_SLOTS],
	AC::Ammo[MAX_WEAPON_SLOTS],
	AC::AmmoI[MAX_WEAPON_SLOTS],
	
	Float:AC::HealthArmor[2],
	Float:AC::OldPos[4],
	
	AC::LastUpdate,
	AC::BadRconLogin
};
new AC::Info[MAX_PLAYERS][AC::PlayerEnum];

enum AC::VehicleEnum {
	AC::Delay,
	Float:AC::VehHealth,
}
new AC::VehicleInfo[MAX_VEHICLES][AC::VehicleEnum];


static const Float:tuningPos[][] = {
	{0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
	{1041.7001,-1015.3513,32.1016, 617.5359,-1.9904,1000.4118},
	{-1935.8556,245.3984,34.4609, 617.5361,-1.9900,1000.3774},
	{-2721.0298,217.5563,4.1436, 615.2822,-124.2390,997.6202},
	{2386.8760,1050.9164,10.8203, 617.5381,-1.9900,1000.3718},
	{2644.7893,-2043.5616,13.6232, 616.7856,-74.8150,997.8645}
};
	

public OnGameModeInit() {
	AC_OPB  = funcidx("onPlayerBan"				) != -1;
	AC_OPK  = funcidx("onPlayerKick"			) != -1;
	AC_OACU = funcidx("onAntiCheatUpdate"		) != -1;
	
	if(AC_OACU) {
		AC::TimerUpdate = SetTimer("onAntiCheatUpdate", 250, true);
		print("\n>> "#__AC_TITLE" Include v"__AC_VERSION" loaded!");
		print(">> "#__AC_COPYRIGHT"\n");
	}
	return AC::OnGameModeInit();
}

public OnGameModeExit() {
	if(AC_OACU) {
		KillTimer(AC::TimerUpdate);
		print("\n>> "#__AC_TITLE" Include v"__AC_VERSION" unloaded!");
		print(">> "#__AC_COPYRIGHT"\n");
	}
	return AC::OnGameModeExit();
}

public OnPlayerConnect(playerid) {
	new ip[2][16];
	GetPlayerIp(playerid, ip[0], 16);
	foreach(new p : Player) {
		if(p != playerid) {
			GetPlayerIp(p, ip[1], 16);
			if(strcmp(ip[0], ip[1], true) == 0) {
				if(!Pl::isAdmin(p, 5) && !checkvar("bind","127.0.0.1")) {
					AC::Info[p][AC::Warns][R::SANDBOXIE] ++;
					if(AC::Info[p][AC::Warns][R::SANDBOXIE] >= 2) {
						return Rac::Ban(playerid, "Песочница", R::SANDBOXIE);
					} else {
						return Rac::Kick(playerid, "Песочница", R::SANDBOXIE);
					}
				}
				break;
			}
		}
	}
	AC::Info[playerid][AC::BadRconLogin] = 0;
	AC::ClearPlayer(playerid);
	return AC::OnPlayerConnect(playerid);
}

public OnPlayerSpawn(playerid) {
	GetPlayerPos(
		playerid,
		AC::Info[playerid][AC::OldPos][0],
		AC::Info[playerid][AC::OldPos][1],
		AC::Info[playerid][AC::OldPos][2]
	);
	AC::ClearPlayer(playerid);
	return AC::OnPlayerSpawn(playerid);
}

public OnVehicleMod(playerid, vehicleid, componentid) {
	if(!AC::IsPlayerInModShop(playerid, 0)) {
		RemoveVehicleComponent(vehicleid, componentid);
		AC::Info[playerid][AC::Warns][R::TUNING_HACK] ++;
		return Rac::Kick(playerid, "Использование читов", R::TUNING_HACK);
	}
	/*} else if(!AC::IsLegalCarMod(GetPlayerVehicleModel(playerid), componentid)) {
		RemoveVehicleComponent(vehicleid, componentid);
	}*/
	return AC::OnVehicleMod(playerid, vehicleid, componentid);
}
	
public OnEnterExitModShop(playerid, enterexit, interiorid) {
	new vehicle, index;
	if((vehicle=GetPlayerVehicleID(playerid)) != 0 && (index=AC::IsPlayerInModShop(playerid,enterexit)) != 0) {
		if(!enterexit) {
			foreach(new i : vehiclePassengers[vehicle]) {
				AC::Info[i][AC::NoAB] = 1;
				AC::Info[i][AC::Interior] = interiorid;
				AC::Info[i][AC::OldPos][0] = tuningPos[index][0];
				AC::Info[i][AC::OldPos][1] = tuningPos[index][1];
				AC::Info[i][AC::OldPos][2] = tuningPos[index][2];
				AC::Info[i][AC::Delay][R::TELEPORT] = 3;
			}
		} else {
			foreach(new i : vehiclePassengers[vehicle]) {
				AC::Info[i][AC::NoAB] = 1;
				AC::Info[i][AC::Interior] = interiorid;
				AC::Info[i][AC::OldPos][0] = tuningPos[index][3];
				AC::Info[i][AC::OldPos][1] = tuningPos[index][4];
				AC::Info[i][AC::OldPos][2] = tuningPos[index][5];
				AC::Info[i][AC::Delay][R::TELEPORT] = 3;
			}
		}
	}
}

public OnVehicleRespray(playerid, vehicleid, color1, color2) {
	if(!AC::IsPlayerInModShop(playerid, !(GetPlayerInterior(playerid)>0)) && !AC::IsPlayerAtPnSpray(playerid)) {
		AC::Info[playerid][AC::Warns][R::COLORS_HACK] ++;
		if(AC::Info[playerid][AC::Warns][R::COLORS_HACK] >= MAX_WARNS) {
			Rac::Kick(playerid, "Использование читов", R::COLORS_HACK);
		}
	} else {
		AC::Info[playerid][AC::Delay][R::REPAIR_HACK] = 3;
		AC::SetVehicleHealth(vehicleid, 1000.0);
	}
	return AC::OnVehicleRespray(playerid, vehicleid, color1, color2);
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger) {
	if(!AC::Info[playerid][AC::Toggle] && ispassenger) return ClearAnimations(playerid);
	AC::Info[playerid][AC::EnteredVeh] = vehicleid;
	
	return AC::OnPlayerEnterVehicle(playerid, vehicleid, ispassenger);
}

public OnPlayerExitVehicle(playerid, vehicleid) {
	AC::Info[playerid][AC::EnteredVeh] = INVALID_VEHICLE_ID;
}

public OnPlayerStateChange(playerid, newstate, oldstate) {
	switch(newstate) {
		case PLAYER_STATE_ONFOOT : {
			AC::Info[playerid][AC::RemoveVeh] = INVALID_VEHICLE_ID;
			AC::Info[playerid][AC::Warns][R::REMOVE_VEH] = 0;
		}
		case PLAYER_STATE_DRIVER : {
			if(AC::Info[playerid][AC::EnteredVeh] != GetPlayerVehicleID(playerid)) {
				Rac::Kick(playerid, "Использование читов", R::CAR_TP);
			}
		}
		case PLAYER_STATE_SPECTATING : {
			if(!AC::Info[playerid][AC::ToggleSpec]) {
				Rac::Kick(playerid, "Использование читов", R::SPECHACK);
			}
		}
	}
		
	switch(oldstate) {
		case PLAYER_STATE_DRIVER, PLAYER_STATE_PASSENGER : {
			AC::Info[playerid][AC::Delay][R::SPEED_HACK] = 2;
		}
	}
	return AC::OnPlayerStateChange(playerid, newstate, oldstate);
}

public OnPlayerUpdate(playerid) {
	static vehicle, playerstate;

	playerstate = GetPlayerState(playerid);
	switch(playerstate) {
		case PLAYER_STATE_DRIVER, PLAYER_STATE_PASSENGER : {
			vehicle = GetPlayerVehicleID(playerid);
			if(AC::GetPlayerVehicle(playerid) != INVALID_VEHICLE_ID && (2 <= AC::GetPlayerState(playerid) <= 3) && vehicle != AC::GetPlayerVehicle(playerid)) {
				AC::Info[playerid][AC::Warns][R::CAR_SPAM] ++;
				if(AC::Info[playerid][AC::Warns][R::CAR_SPAM] >= MAX_WARNS) {
					RespawnUnoccupiedVehicles();
					Rac::Kick(playerid, "Использование читов", R::CAR_SPAM);
				}
			}
			AC::Info[playerid][AC::OldVeh] = vehicle;
		}
	}
	AC::Info[playerid][AC::Sync] = true;
	AC::Info[playerid][AC::OldState] = playerstate;
	AC::Info[playerid][AC::LastUpdate] = GetTickCount();
	
	return AC::OnPlayerUpdate(playerid);
}

public OnPlayerText(playerid, text[]) {
	new time = GetTickCount();
	if((time-AC::Info[playerid][AC::Delay][R::FLOOD_CMD]) > 500) {
		AC::Info[playerid][AC::Warns][R::FLOOD_CMD] = 0;
		AC::Info[playerid][AC::Delay][R::FLOOD_CMD] = time;
	} else {
		AC::Info[playerid][AC::Warns][R::FLOOD_CMD] ++;
		AC::Info[playerid][AC::Delay][R::FLOOD_CMD] = time;
		if(AC::Info[playerid][AC::Warns][R::FLOOD_CMD] >= 7) {
			Rac::Kick(playerid, "Использование читов", R::FLOOD_CMD);
		} else {
			Send(playerid, 0xAFAFAFAA, "* Писать в чат можно не чаще 1 раза в секунду!");
		}
		return 0;
	}
	if(isnull(text)) {
		return 0;
	}
	return AC::OnPlayerText(playerid, text);
}
	
public OnPlayerCommandText(playerid, cmdtext[]) {
	new time = GetTickCount();
	if((time-AC::Info[playerid][AC::Delay][R::FLOOD_CMD]) > 500) {
		AC::Info[playerid][AC::Warns][R::FLOOD_CMD] = 0;
		AC::Info[playerid][AC::Delay][R::FLOOD_CMD] = time;
	} else {
		AC::Info[playerid][AC::Warns][R::FLOOD_CMD] ++;
		AC::Info[playerid][AC::Delay][R::FLOOD_CMD] = time;
		if(AC::Info[playerid][AC::Warns][R::FLOOD_CMD] >= 7) {
			Rac::Kick(playerid, "Использование читов", R::FLOOD_CMD);
		} else {
			Send(playerid, 0xAFAFAFAA, "* Команды можно вводить не чаще 1 раза в секунду!");
		}
		return 1;
	}
	if(isnull(cmdtext)) {
		return 0;
	}
	return DC_CMD(playerid, cmdtext);
}

public OnPlayerDeath(playerid, killerid, reason) {
	new time = gettime();
	if(killerid != INVALID_PLAYER_ID) {
		if((time-AC::Info[killerid][AC::Delay][R::FLOOD_KILL]) > 1) {
			AC::Info[killerid][AC::Delay][R::FLOOD_KILL] = time;
		} else {
			AC::Info[killerid][AC::Warns][R::FLOOD_KILL] ++;
			AC::Info[killerid][AC::Delay][R::FLOOD_KILL] = time;
			if(AC::Info[killerid][AC::Warns][R::FLOOD_KILL] >= 3) {
				Rac::Kick(killerid, "Использование читов", R::FLOOD_KILL);
			}
			return 1;
		}
	}
	if((time-AC::Info[playerid][AC::Delay][R::FLOOD_KILL]) > 1) {
		AC::Info[playerid][AC::Delay][R::FLOOD_KILL] = time;
	} else {
		AC::Info[playerid][AC::Warns][R::FLOOD_KILL] ++;
		AC::Info[playerid][AC::Delay][R::FLOOD_KILL] = time;
		if(AC::Info[playerid][AC::Warns][R::FLOOD_KILL] >= 3) {
			Rac::Kick(playerid, "Использование читов", R::FLOOD_KILL);
		}	
		return 1;
	}
	AC::Info[playerid][AC::Toggle] = 1;
	
	return AC::OnPlayerDeath(playerid, killerid, reason);
}

public OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid, bodypart) {	
	if(AC::isValidPlayer(playerid)) {
		if((22 <= weaponid <= 38) && weaponid != 37) {
		
			if(!(0.0 <= amount <= 100.0)) return Rac::Kick(playerid, "High/Invalid damage");

			new p_ammo, slot = Rac::GetWeaponSlot(weaponid);
			GetPlayerWeaponData(playerid, slot, weaponid, p_ammo);
			
			if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER) {
				if(AC::Info[playerid][AC::Weap][slot] != weaponid) {
					return Rac::Kick(playerid, "Использование читов", R::WEAPON_HACK);
				}
			}

			if(AC::Info[playerid][AC::AmmoI][slot] == p_ammo) {
				if(!Rac::exec(playerid, damagedid)) {
					AC::Info[playerid][AC::Warns][R::UNLIM_AMMO] ++;
					if(AFKInfo[playerid][afk_Time][0] < AFK_TEXT_SET) {
						if(AC::Info[playerid][AC::Warns][R::UNLIM_AMMO] >= 4) {
							Rac::ResetPlayerWeapons(playerid);
							Rac::Kick(playerid, R::Info[R::UNLIM_AMMO], R::UNLIM_AMMO);
						}
					}
				}
			} else {
				AC::Info[playerid][AC::Warns][R::UNLIM_AMMO] = 0;
				AC::Info[playerid][AC::AmmoI][slot] = p_ammo;
			}
			
			if(GetPlayerTargetPlayer(playerid) == INVALID_PLAYER_ID) {
				new currtick = gettime();
				if((currtick - AC::Info[playerid][AC::AimTick]) <= 10 && AC::Info[playerid][AC::AimTick] >= MAX_AIM_TICKS) {
					AC::Info[playerid][AC::AimTick] = currtick;
					AC::Info[playerid][AC::AimCount] = 0;
					
					AC::Info[playerid][AC::Warns][R::JOYPAD] ++;
					if(AC::Info[playerid][AC::Warns][R::JOYPAD] >= 3) {
						Rac::ResetPlayerWeapons(playerid);
						Rac::Kick(playerid, R::Info[R::JOYPAD], R::JOYPAD);
					}
				} else if((currtick - AC::Info[playerid][AC::AimTick]) > 10) {
					AC::Info[playerid][AC::AimTick] = currtick;
					AC::Info[playerid][AC::AimCount] = 0;
				}
				AC::Info[playerid][AC::AimTick] = currtick;
				AC::Info[playerid][AC::AimCount] ++;
			}
		}
		AC::OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid, bodypart);
	}
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid) {
	if(AC::Info[playerid][AC::Interior] != newinteriorid) {
		if(AC::Info[playerid][AC::NoAB] == 1) {
			AC::Info[playerid][AC::NoAB] = 0;
		} else {
			Rac::Kick(playerid, "Использование читов", R::TELEPORT);
		}
	}
	return AC::OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid);
}


public onAntiCheatUpdate() {
	new playerState;
	foreach(new i : Player) {
		playerState  = GetPlayerState(i);
		switch(playerState) {
			case PLAYER_STATE_ONFOOT : {
				Rac::OnfootSync(i);
			}
			case PLAYER_STATE_DRIVER, PLAYER_STATE_PASSENGER : {
				Rac::OnvehicleSync(i);
			}
			
			default : {
				new Float:fvar;
				if(AC::Info[i][AC::Delay][R::HEALTH_HACK] > 0) {
					AC::Info[i][AC::Delay][R::HEALTH_HACK] --;
				} else {
					if(AC::IsPlayerSync(i)) {
						GetPlayerHealth(i, fvar);
						if(fvar > AC::Info[i][AC::HealthArmor][AC::HEALTH]) {
							if(AFKInfo[i][afk_Time][0] < AFK_TEXT_SET) {
								if(Rac::IsAtCandySprunk(i, 4.0)) {
									Rac::GivePlayerHealth(i, ((fvar - AC::Info[i][AC::HealthArmor][AC::HEALTH]) + 1.0 ), 100.0);
								} else {
									SetPlayerHealth(i, AC::Info[i][AC::HealthArmor][AC::HEALTH]);
								}
							}
						} else {
							AC::Info[i][AC::HealthArmor][AC::HEALTH] = fvar;
						}
					}
				}
				
				if(AC::Info[i][AC::Delay][R::ARMOUR_HACK] > 0) {
					AC::Info[i][AC::Delay][R::ARMOUR_HACK] --;
				} else {
					GetPlayerArmour(i, fvar);
					if(fvar > AC::Info[i][AC::HealthArmor][AC::ARMOUR]) {
						if(AFKInfo[i][afk_Time][0] < AFK_TEXT_SET) {
							SetPlayerArmour(i, AC::Info[i][AC::HealthArmor][AC::ARMOUR]);
						}
					} else {
						AC::Info[i][AC::HealthArmor][AC::ARMOUR] = fvar;
					}
				}

				if(!(2 <= playerState <= 6)) {
					if(GetPlayerCameraMode(i) == 18 && GetPlayerSpecialAction(i) == 3) {
						Rac::Kick(i, "Disable incar data");
					}
				}
			}
		}
		
		if(gettime() - AC::Info[i][AC::ClearWarns] > 300) {
			AC::Info[i][AC::ClearWarns] = gettime();
			
			for(new j; j < R::MAX_CHEATS; j++) {
				AC::Info[i][AC::Warns][j] = 0;
			}
		}
	}
}


stock AC::OnvehicleSync(playerid) {
	new vehicle, playerspeed, Float:fvar;
	new Float:x, Float:y, Float:z;
	
	vehicle = GetPlayerVehicleID(playerid);	
	playerspeed = Rac::GetPlayerSpeed(playerid, false);
	
	if(AC::VehicleInfo[vehicle][AC::Delay] != 0) {
		AC::VehicleInfo[vehicle][AC::Delay]--;
	} else {
		if(AC::IsPlayerSync(playerid)) {
			GetVehicleHealth(vehicle, fvar);
			if(fvar > AC::VehicleInfo[vehicle][AC::VehHealth]) {
				if(AC::IsPlayerAtPnSpray(playerid)) {
					if(CallRemoteFunction("OnVehicleRespray", "iiii", playerid, vehicle, -1, -1)) {
						AC::RepairVehicle(vehicle);
					} else {
						SetVehicleHealth(vehicle, AC::VehicleInfo[vehicle][AC::VehHealth]);
					}
				} else if(AC::IsPlayerInModShop(playerid, 0)) {
					AC::VehicleInfo[vehicle][AC::VehHealth] = 1000.0;
					SetVehicleHealth(vehicle, 1000.0);
				} else {
					AC::Info[playerid][AC::Warns][R::REPAIR_HACK] ++;
					if(AC::Info[playerid][AC::Warns][R::REPAIR_HACK] >= MAX_WARNS) {
						Rac::Kick(playerid, "Использование читов", R::REPAIR_HACK);
					} else {
						if(AFKInfo[playerid][afk_Time][0] < AFK_TEXT_SET) {
							Rac::SetVehicleHealth(vehicle, AC::VehicleInfo[vehicle][AC::VehHealth]);
						}
					}
				}
			} else {
				AC::VehicleInfo[vehicle][AC::VehHealth] = fvar;
			}
		}
	}
		
	if(AC::Info[playerid][AC::Delay][R::SPEED_HACK] > 0) {
		AC::Info[playerid][AC::Delay][R::SPEED_HACK] --;
	} else {
		if((playerspeed > 230) || (playerspeed - AC::Info[playerid][AC::OldSpeed]) > 70) {
			AC::Info[playerid][AC::Warns][R::SPEED_HACK] ++;
			switch(GetVehicleType(GetVehicleModel(vehicle))) {
				case VEHICLE_TYPE_BIKE, VEHICLE_TYPE_BOAT, VEHICLE_TYPE_VELLO, VEHICLE_TYPE_AUTO : {
					if(AC::Info[playerid][AC::Warns][R::SPEED_HACK] > MAX_WARNS) {
						Rac::Kick(playerid, "Использование читов", R::SPEED_HACK);
					}
				}
			}
		}
	}
		
	GetVehiclePos(vehicle, x, y, z);
	if(x > 10000.0 || y > 10000.0 || x > 10000.0 || x < -10000.0 || y < -10000.0 || z < -10000.0) {
		SetVehicleToRespawn(vehicle);
		Rac::Kick(playerid, "Выход за границы мира");
	}
	
	new Float:xd = x - AC::Info[playerid][AC::OldPos][0];
	new Float:yd = y - AC::Info[playerid][AC::OldPos][1];
	fvar = ((xd * xd) + (yd * yd)) / (8 + (GetPlayerPing(playerid) >>> 3));
	
	if(AC::Info[playerid][AC::Delay][R::TELEPORT] > 0) {
		AC::Info[playerid][AC::Delay][R::TELEPORT] --;
	} else {
		if(AC::IsPlayerSync(playerid)) {
			if(AC::Info[playerid][AC::NoAB] == 1) {
				AC::Info[playerid][AC::NoAB] = 0;
			} else {
				if((playerspeed < 5) && (AC::Info[playerid][AC::OldSpeed] < 5)) {
					if(fvar >= 40.0) {
						AC::Info[playerid][AC::Warns][R::TELEPORT] ++;
						if(AC::Info[playerid][AC::Warns][R::TELEPORT] >= MAX_WARNS) {
							Rac::Kick(playerid, "Использование читов", R::TELEPORT);
						}
					}
				}
				AC::Info[playerid][AC::OldPos][0] = x;
				AC::Info[playerid][AC::OldPos][1] = y;
				AC::Info[playerid][AC::OldPos][2] = z;
			}
		}
	}
	
	AC::Info[playerid][AC::OldSpeed] = playerspeed;
		
	if(AC::Info[playerid][AC::Delay][R::REMOVE_VEH] != 0) {
		AC::Info[playerid][AC::Delay][R::REMOVE_VEH] --;
	} else {
		if(AC::Info[playerid][AC::RemoveVeh] != INVALID_VEHICLE_ID && AC::Info[playerid][AC::RemoveVeh] != 0) {
			if(AC::Info[playerid][AC::RemoveVeh] == vehicle) {
				AC::Info[playerid][AC::Warns][R::REMOVE_VEH] ++;
				if(AC::Info[playerid][AC::Delay][R::REMOVE_VEH] >= MAX_WARNS) {
					Rac::Kick(playerid, "Использование зарезервированного ТС");
				} else {
					_RemovePlayerFromVehicle(playerid, vehicle);
				}
			}
		}
	}
}


stock AC::OnfootSync(playerid) {
	static playerspeed, surfveh, Float:fvar;
	static Float:x, Float:y, Float:z;
	
	playerspeed = AC::GetPlayerSpeed(playerid, false);
	surfveh = GetPlayerSurfingVehicleID(playerid);
	
	if(AC::Info[playerid][AC::Delay][R::WEAPON_HACK] > 0) {
		AC::Info[playerid][AC::Delay][R::WEAPON_HACK] --;
	} else {
		if(AC::IsPlayerSync(playerid)) {
			static slot, weapon, ammo;
			if((weapon = GetPlayerWeapon(playerid)) != 0) {
				slot = AC::GetWeaponSlot(weapon);
				GetPlayerWeaponData(playerid, slot, weapon, ammo);
				if(slot != -1) {
					if(AC::Info[playerid][AC::Weap][slot] != weapon) {
						if(weapon == 46) {
							switch(GetVehicleType(GetVehicleModel(gLastCar[playerid]))) {
								case VEHICLE_TYPE_AIRPLANE, VEHICLE_TYPE_HELICOPTER : {
									if(ammo > 1) {
										SetPlayerAmmo(playerid, slot, 1);
									}
									AC::Info[playerid][AC::Weap][slot] = 46;
									AC::Info[playerid][AC::Ammo][slot] = 1;
								}
							}
						} else {
							Rac::ResetPlayerWeapons(playerid);
							Rac::Kick(playerid, "Использование читов", R::WEAPON_HACK);
						}
					} else if(AC::Info[playerid][AC::Ammo][slot] < ammo) {
						Rac::ResetPlayerWeapons(playerid);
						Rac::Kick(playerid, "Использование читов", R::WEAPON_HACK);
					} else {
						AC::Info[playerid][AC::Weap][slot] = weapon;
						AC::Info[playerid][AC::Ammo][slot] = ammo;
					}
				}
			}
		}
	}

	if(AC::Info[playerid][AC::Delay][R::SPEED_HACK] > 0) {
		AC::Info[playerid][AC::Delay][R::SPEED_HACK] --;
	} else {
		if(playerspeed >= 55) {
			switch(GetPlayerAnimationIndex(playerid)) {
				case 958, 959, 962, 961, 971, 963, 965, 978, 976 : {
					if(!Rac::CheckPlayerWeapon(playerid, 46)) {
						AC::Info[playerid][AC::Warns][R::SPEED_HACK] ++;
						if(Rac::Info[playerid][Rac::Warns][R::SPEED_HACK] >= MAX_WARNS) {
							Rac::Kick(playerid, "Использование читов", R::SPEED_HACK);
						}
					}
				}
				default : {
					AC::Info[playerid][AC::Warns][R::SPEED_HACK] ++;
					if(Rac::Info[playerid][Rac::Warns][R::SPEED_HACK] >= MAX_WARNS) {
						Rac::Kick(playerid, "Использование читов", R::SPEED_HACK);
					}
				}
			}
		}
	}
	
	if(surfveh == INVALID_VEHICLE_ID) {
		if(!Rac::IsPlayerInPool(playerid)) {
			switch(GetPlayerAnimationIndex(playerid)) {
				case 1543, 1538, 1539 : {
					if(z >= 2.0) {
						Rac::Kick(playerid, "Использование читов", R::FLY_HACK);
					}
				}
			}
		}
	}
	
	
	GetPlayerPos(playerid, x, y, z);
	new Float:xd = x - AC::Info[playerid][AC::OldPos][0];
	new Float:yd = y - AC::Info[playerid][AC::OldPos][1];
	fvar = ((xd * xd) + (yd * yd)) / (8 + (GetPlayerPing(playerid) >>> 3));
	
	if(AC::Info[playerid][AC::Delay][R::ANTI_FREEZE] != 0) {
		AC::Info[playerid][AC::Delay][R::ANTI_FREEZE]--;
	} else {
		if(!AC::Info[playerid][AC::Toggle] && AC::Info[playerid][AC::OldState] == 1) {
			if((fvar >= 0.5) && (playerspeed >= 20)) {
				AC::Info[playerid][AC::Warns][R::ANTI_FREEZE] ++;
				if(AC::Info[playerid][AC::Warns][R::ANTI_FREEZE] >= MAX_WARNS) {
					Rac::Kick(playerid, "Использование читов", R::ANTI_FREEZE);
				}
			}
		}
	}
	
	if(AC::Info[playerid][AC::Delay][R::TELEPORT] > 0) {
		AC::Info[playerid][AC::Delay][R::TELEPORT] --;
	} else {
		if(AC::IsPlayerSync(playerid)) {
			if(AC::Info[playerid][AC::NoAB] == 1) {
				AC::Info[playerid][AC::NoAB] = 0;
			} else {
				if(surfveh == INVALID_VEHICLE_ID && AC::IsPlayerOnGround(playerid)) {
					if((playerspeed < 40) && (AC::Info[playerid][AC::OldSpeed] < 40)) {
						if(fvar > 50.0) {
							Rac::Kick(playerid, "Использование читов", R::TELEPORT);
						}
						else if(fvar >= 10.0) {
							AC::Info[playerid][AC::Warns][R::TELEPORT] ++;
							if(AC::Info[playerid][AC::Warns][R::TELEPORT] >= MAX_WARNS) {
								Rac::Kick(playerid, "Использование читов", R::TELEPORT);
							}
						}
					}
				}
				AC::Info[playerid][AC::OldPos][0] = x;
				AC::Info[playerid][AC::OldPos][1] = y;
				AC::Info[playerid][AC::OldPos][2] = z;
			}
		}
	}
	
	AC::Info[playerid][AC::OldSpeed] = playerspeed;

	if(GetPlayerSkin(playerid) != 0) {
		if(GetPlayerAnimationIndex(playerid) == 1231) {
			Rac::Kick(playerid, "CJ-Run");
		}
	}
	
	if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USEJETPACK) {
		Rac::Kick(playerid, "Jetpack");
	}
}


public: AC::GivePlayerWeapon(playerid, weaponid, ammo) {
	if(AC::isValidPlayer(playerid) && (weaponid>=0||weaponid<=MAX_WEAPONS)) {
		new slot = AC::GetWeaponSlot(weaponid);
		if(slot != -1) {
			if(AC::Info[playerid][AC::Weap][slot] != weaponid) {
				AC::Info[playerid][AC::Weap][slot] = weaponid;
				AC::Info[playerid][AC::Ammo][slot] = ammo;
			} else {
				AC::Info[playerid][AC::Weap][slot] = weaponid;
				AC::Info[playerid][AC::Ammo][slot] += ammo;
			}
			AC::Info[playerid][AC::Sync] = false;
			AC::Info[playerid][AC::Delay][R::WEAPON_HACK] = 2;
			GivePlayerWeapon(playerid, weaponid, ammo);
		}
	}
	return 1;
}

public: AC::SetPlayerAmmo(playerid, weaponid, ammo) {
	if(AC::isValidPlayer(playerid) && (weaponid>=0||weaponid<=MAX_WEAPONS)) {
		new slot = AC::GetWeaponSlot(weaponid);
		if(slot != -1) {
			AC::Info[playerid][AC::Sync] = false;
			AC::Info[playerid][AC::Ammo][slot] = ammo;
			AC::Info[playerid][AC::Delay][R::WEAPON_HACK] = 2;
			return SetPlayerAmmo(playerid, weaponid, ammo);
		}
	}
	return 0;
}

public: AC::GivePlayerAmmo(playerid, weaponslot, ammo) {
	if(!AC::isValidPlayer(playerid)) return 0;
	AC::Info[playerid][AC::Sync] = false;
	AC::Info[playerid][AC::Ammo][weaponslot] += ammo;
	AC::Info[playerid][AC::Delay][R::WEAPON_HACK] = 2;
	return SetPlayerAmmo(playerid, weaponslot, AC::Info[playerid][AC::Ammo][weaponslot]);
}

public: AC::RemovePlayerWeapon(playerid, weaponid) {
	if(!AC::isValidPlayer(playerid) || weaponid < 0 || weaponid >= MAX_WEAPONS) return 0;
	new slot = AC::GetWeaponSlot(weaponid);
	if(slot != -1) {
		ResetPlayerWeapons(playerid);
		AC::Info[playerid][AC::Weap][slot] = 0;
		AC::Info[playerid][AC::Ammo][slot] = 0;
		for(new i; i < MAX_WEAPON_SLOTS; i++) {
			if(AC::Info[playerid][AC::Weap][i] != 0 && AC::Info[playerid][AC::Ammo][i] > 0) {
				GivePlayerWeapon(playerid, AC::Info[playerid][AC::Weap][i], AC::Info[playerid][AC::Ammo][i]);
			}
		}
		AC::Info[playerid][AC::Sync] = false;
		AC::Info[playerid][AC::Delay][R::WEAPON_HACK] = 2;
	}
	return 1;
}

public: AC::ResetPlayerWeapons(playerid) {
	for(new i; i < MAX_WEAPON_SLOTS; i++) {
		AC::Info[playerid][AC::Weap][i] = 0;
		AC::Info[playerid][AC::Ammo][i] = 0;
	}
	AC::Info[playerid][AC::Sync] = false;
	AC::Info[playerid][AC::Delay][R::WEAPON_HACK] = 2;
	return ResetPlayerWeapons(playerid);
}

stock AC::CheckPlayerWeapon(playerid, weaponid, &ammo=0) {
	new slot = AC::GetWeaponSlot(weaponid), weapon;
	if(slot != -1) {
		GetPlayerWeaponData(playerid, slot, weapon, ammo);
		if(weaponid == weapon) {
			return 1;
		}
	}
	return 0;
}

public: AC::GetPlayerWeapon(playerid) return AC::Info[playerid][AC::Weap][AC::GetWeaponSlot(GetPlayerWeapon(playerid))];

public: AC::GetPlayerAmmo(playerid, weaponid) return AC::Info[playerid][AC::Ammo][AC::GetWeaponSlot(weaponid)];

public: AC::GetWeaponSlot(weaponid) {
	switch(weaponid) {
		case 0, 1 		: return 0;
		case 2..9 		: return 1;
		case 10..15 	: return 10;
		case 16..19, 39	: return 8;
		case 22..24		: return 2;
		case 25..27		: return 3;
		case 28, 29, 32 : return 4;
		case 30, 31		: return 5;
		case 33, 34		: return 6;
		case 35..38		: return 7;
		case 40			: return 12;
		case 41..43		: return 9;
		case 44..46		: return 11;
	}
	return -1;
}

public: IsNotArmed(weaponid) {
	switch(weaponid) {
		case 22, 23, 28, 29, 32 : return 1;
	}
	return 0;
}

public: AC::IsWeaponForbidden(weaponid) {
	static const BWL[] = {16, 17, 18, 35, 36, 37, 38, 39, 40};
	return interpolationSearch(BWL, weaponid) == -1 ? 0 : 1;
}

public: AC::IsGreenWeapon(weaponid) {
	static const GWL[] = {3, 5, 6, 8};
	return interpolationSearch(GWL, weaponid) == -1 ? 0 : 1;
}

public: AC::SetPlayerPos(playerid, Float:x, Float:y, Float:z) {
	AC::Info[playerid][AC::NoAB] = 1;
	AC::Info[playerid][AC::Sync] = false;
	AC::Info[playerid][AC::OldPos][0] = x;
	AC::Info[playerid][AC::OldPos][1] = y;
	AC::Info[playerid][AC::OldPos][2] = z;
	AC::Info[playerid][AC::Delay][R::TELEPORT] = 2;
	
	return SetPlayerPos(playerid, x, y, z);
}

public: AC::SetPlayerFacingAngle(playerid, Float:angl) {
	AC::Info[playerid][AC::OldPos][3] = angl;
	return SetPlayerFacingAngle(playerid, angl);
}

public: AC::SetVehiclePos(vehicleid, Float:x, Float:y, Float:z) {
	if(vehicleid != INVALID_VEHICLE_ID) {
		foreach(new i : vehiclePassengers[vehicleid]) {
			AC::Info[i][AC::NoAB] = 1;
			AC::Info[i][AC::Sync] = false;
			AC::Info[i][AC::OldPos][0] = x;
			AC::Info[i][AC::OldPos][1] = y;
			AC::Info[i][AC::OldPos][2] = z;
			AC::Info[i][AC::Delay][R::TELEPORT] = 2;
		}
		return SetVehiclePos(vehicleid, x, y, z);
	}
	return 0;
}

public: AC::SetPlayerHealth(playerid, Float:health) {
	AC::Info[playerid][AC::HealthArmor][AC::HEALTH] = health;
	AC::Info[playerid][AC::Delay][R::HEALTH_HACK] = 1;
	return SetPlayerHealth(playerid, AC::Info[playerid][AC::HealthArmor][AC::HEALTH]);
}

stock AC::GivePlayerHealth(playerid, Float:health, Float:maxhealth = 200.0) {
	AC::Info[playerid][AC::HealthArmor][AC::HEALTH] += health;
	floatmax(AC::Info[playerid][AC::HealthArmor][AC::HEALTH], maxhealth);
	AC::Info[playerid][AC::Delay][R::HEALTH_HACK] = 1;
	return SetPlayerHealth(playerid, AC::Info[playerid][AC::HealthArmor][AC::HEALTH]);
}

public: AC::SetPlayerArmour(playerid, Float:armour) {
	AC::Info[playerid][AC::HealthArmor][AC::ARMOUR] = armour;
	AC::Info[playerid][AC::Delay][R::ARMOUR_HACK] = 1;
	return SetPlayerArmour(playerid, AC::Info[playerid][AC::HealthArmor][AC::ARMOUR]);
}

public: AC::GivePlayerArmour(playerid, Float:armour) {
	AC::Info[playerid][AC::HealthArmor][AC::ARMOUR] += armour;
	floatmax(AC::Info[playerid][AC::HealthArmor][AC::ARMOUR], 100.0);
	AC::Info[playerid][AC::Delay][R::ARMOUR_HACK] = 1;
	return SetPlayerArmour(playerid, AC::Info[playerid][AC::HealthArmor][AC::ARMOUR]);
}

public: Float:AC::GetPlayerHealth(playerid) {
	return AC::Info[playerid][AC::HealthArmor][AC::HEALTH];
}

public: Float:AC::GetPlayerArmour(playerid) {
	return AC::Info[playerid][AC::HealthArmor][AC::ARMOUR];
}

public: AC::SetVehicleHealth(vehicleid, Float:health)
{
	floatmax(health, 1000.0);
	AC::VehicleInfo[vehicleid][AC::Delay] = 2;
	AC::VehicleInfo[vehicleid][AC::VehHealth] = health;
	return SetVehicleHealth(vehicleid, AC::VehicleInfo[vehicleid][AC::VehHealth]);
}

public: AC::ChangeVehicleColor(vehicleid, color1, color2) {
	AC::VehicleInfo[vehicleid][AC::Delay] = 2;
	AC::VehicleInfo[vehicleid][AC::VehHealth] = 1000.0;
	return ChangeVehicleColor(vehicleid, color1, color2);
}

public: AC::RepairVehicle(vehicleid) {
	AC::VehicleInfo[vehicleid][AC::Delay] = 2;
	AC::VehicleInfo[vehicleid][AC::VehHealth] = 1000.0;
	return RepairVehicle(vehicleid);
}

public: Float:AC::GetVehicleHealth(vehicleid) {
	return AC::VehicleInfo[vehicleid][AC::VehHealth];
}

public: AC::SetPlayerMoney(playerid, amount) {
	ResetPlayerMoney(playerid);
	AC::Info[playerid][AC::Money] = amount;
	return GivePlayerMoney(playerid, AC::Info[playerid][AC::Money]);
}

public: AC::GivePlayerMoney(playerid, amount) {
	ResetPlayerMoney(playerid);
	AC::Info[playerid][AC::Money] += amount;
	return GivePlayerMoney(playerid, AC::Info[playerid][AC::Money]);
}

public: AC::ResetPlayerMoney(playerid) {
	ResetPlayerMoney(playerid);
	return GivePlayerMoney(playerid, AC::Info[playerid][AC::Money]);
}

public: AC::GetPlayerMoney(playerid) return AC::Info[playerid][AC::Money];

public: AC::IsAtCandySprunk(playerid, Float:radi) {
	static const Float:Sprunk[][3] = {
		{-2420.219, 984.578, 44.2970},
		{-2420.180, 985.945, 44.2970},
		{-16.1397,-90.8513,1003.5469},
		{-17.6730,-90.9709,1003.5469},
		{2225.203,-1153.422,1025.906},
		{2576.703,-1284.430,1061.094},
		{2155.906, 1606.773,1000.055},
		{2209.906, 1607.195,1000.055},
		{2222.203, 1606.773,1000.055},
		{495.969, -24.320, 1000.734	},
		{501.828, -1.430, 1000.734	},
		{373.828, -178.141, 1000.734},
		{330.680, 178.500, 1020.070	},
		{331.922, 178.500, 1020.070	},
		{350.906, 206.086, 1008.477	},
		{361.563, 158.617, 1008.477	},
		{371.594, 178.453, 1020.070	},
		{374.891, 188.977, 1008.477	},
		{2155.844, 1607.875,1000.063},
		{2202.453, 1617.008,1000.063},
		{2209.242, 1621.211,1000.063},
		{2222.367, 1602.641,1000.063},
		{500.563, -1.367, 1000.734	},
		{379.039, -178.883, 1000.734},
		{2480.86,-1959.27,12.9609	},
		{1634.11,-2237.53,12.8906	},
		{2139.52,-1161.48,23.3594	},
		{2153.23,-1016.15,62.2344	},
		{-1350.12,493.859,10.5859	},
		{-2229.19,286.414,34.7031	},
		{1659.46,1722.86,10.2188	},
		{2647.7,1129.66,10.2188		},
		{2845.73,1295.05,10.7891	},
		{1398.84,2222.61,10.4219	},
		{-1455.12,2591.66,55.2344	},
		{-76.0312,1227.99,19.125	},
		{662.43,-552.164,15.7109	},
		{-253.742,2599.76,62.2422	},
		{2271.73,-76.4609,25.9609	},
		{1789.21,-1369.27,15.1641	},
		{1729.79,-1943.05,12.9453	},
		{2060.12,-1897.64,12.9297	},
		{1928.73,-1772.45,12.9453	},
		{2325.98,-1645.13,14.2109	},
		{2352.18,-1357.16,23.7734	},
		{1154.73,-1460.89,15.1562	},
		{-1350.12,492.289,10.5859	},
		{-2118.97,-423.648,34.7266	},
		{-2118.62,-422.414,34.7266	},
		{-2097.27,-398.336,34.7266	},
		{-2092.09,-490.055,34.7266	},
		{-2063.27,-490.055,34.7266	},
		{-2005.65,-490.055,34.7266	},
		{-2034.46,-490.055,34.7266	},
		{-2068.56,-398.336,34.7266	},
		{-2039.85,-398.336,34.7266	},
		{-2011.14,-398.336,34.7266	},
		{-1980.79,142.664,27.0703	},
		{2319.99,2532.85,10.2188	},
		{1520.15,1055.27,10.00		},
		{2503.14,1243.7,10.2188		},
		{2085.77,2071.36,10.4531	},
		{-862.828,1536.61,21.9844	},
		{-14.7031,1175.36,18.9531	},
		{-253.742,2597.95,62.2422	},
		{201.016,-107.617,0.898438	}
	};
	for(new i; i < sizeof Sprunk; i++) {
		if(IsPlayerInRangeOfPoint(playerid, radi, Sprunk[i][0], Sprunk[i][1], Sprunk[i][2])) {
			return 1;
		}
	}
	return 0;
}

public: AC::IsPlayerInPool(playerid) {
	static const Float:Pools[][4] = {
		{300.0,-1168.11,2151.00,40.0},
		{300.0,-958.11,2401.0,40.0},
		{300.0,-1084.94,2649.50,40.04},
		{100.0,1962.16,1599.64,10.0},
		{50.0,2147.28,1131.29,10.0},
		{30.0,1237.01,-2378.30,10.0},
		{50.0,2108.07,1907.37,10.0},
		{50.0,1962.66,-1190.69,17.45},
		{28.0,1095.2384,-672.5684,111.4500},
		{28.0,1277.8842,-805.4534,86.1230},
		{56.0,2532.0527,1571.6040,8.4171},
		{54.0,2159.9509,1283.8008,7.3372},
		{54.0,1240.1476,-2383.6343,8.3145},
		{75.0,1947.6244,1613.9171,8.0484},
		{45.0,-2718.9143,-447.1990,3.3696},
		{200.0,-758.4480,-1986.5779,5.3543},
		{180.0,-568.3068,2197.2542,40.0401}
	};
	
	for(new i; i < sizeof Pools; i++) {
		if(IsPlayerInRangeOfPoint(playerid, Pools[i][0], Pools[i][1], Pools[i][2], Pools[i][3])) {
			return !Rac::IsPlayerOnGround(playerid) ? 1 : 0;
		}
	}
    return 0;
}

public: AC::IsPlayerAtPnSpray(playerid) {
	static const Float:PnS[][] = {
		{2064.2842,-1831.4736,13.5469},
		{487.6401,-1739.9479, 11.1385},
		{1024.8651,-1024.0870,32.1016},
		{617.5467, -2.0437, 1000.5823},
		{615.2847,-124.2390, 997.6888},
		{-1904.7019,284.5968, 41.0469},
		{-2425.7822,1022.1392,50.3977},
		{-1420.5195,2584.2305,55.8433},
		{-99.9417, 1117.9048, 19.7417},
		{1975.2384,2162.5088, 11.0703},
		{720.0854, -457.8807, 16.3359},
		{615.9690, -75.0127, 997.9922},
		{617.5361, -1.9889, 1000.6007}
	};
	for(new i; i < sizeof PnS; i++) {
		if(IsPlayerInRangeOfPoint(playerid, 6.0, PnS[i][0], PnS[i][1], PnS[i][2])) {
			return (!GetPlayerInterior(playerid)?1:0);
		}
	}
    return 0;
}

public: AC::IsPlayerInModShop(playerid,enterexit) {
	if(!enterexit) {
		for(new i=1; i < sizeof tuningPos; i++) {
			if(IsPlayerInRangeOfPoint(playerid, 20.0, tuningPos[i][3], tuningPos[i][4], tuningPos[i][5])) {
				return 1;
			}
		}
	} else {
		for(new i=1; i < sizeof tuningPos; i++) {
			if(IsPlayerInRangeOfPoint(playerid, 20.0, tuningPos[i][0], tuningPos[i][1], tuningPos[i][2])) {
				if(GetPlayerInterior(playerid) == 0) {
					return i;
				}
			}
		}
	}
	return 0;
}

public: AC::ClearPlayer(playerid) {
	AC::ResetPlayerWeapons(playerid);
	AC::SetPlayerArmour(playerid, 0.0);
	AC::SetPlayerHealth(playerid, 100.0);
	AC::ResetPlayerMoney(playerid);

	AC::Info[playerid][AC::Sync] = false;
	AC::Info[playerid][AC::Toggle] = 1;
	AC::Info[playerid][AC::EnteredVeh] = INVALID_VEHICLE_ID;
	AC::Info[playerid][AC::RemoveVeh] = INVALID_VEHICLE_ID;
	AC::Info[playerid][AC::OldVeh] = INVALID_VEHICLE_ID;
	AC::Info[playerid][AC::OldState] = PLAYER_STATE_NONE;
	
	AC::Info[playerid][AC::AimTick] = gettime();
	AC::Info[playerid][AC::AimCount] = 0;
	
	return 1;
}

public: AC::RemovePlayerFromVehicle(playerid) {
	AC::Info[playerid][AC::RemoveVeh] = GetPlayerVehicleID(playerid);
	AC::Info[playerid][AC::Delay][R::REMOVE_VEH] = 1;
	return RemovePlayerFromVehicle(playerid);
}

public: _RemovePlayerFromVehicle(playerid, vehicleid) {
	new seatid = GetPlayerVehicleSeat(playerid);
	if(seatid != -1) {
		switch(seatid) {
			case 0..2 : seatid = 0;
			case 3, 4 : seatid = 1;
			default : seatid = 0;
		}
		new Float: _pos[3];
		GetCoordVehicleParams(vehicleid, seatid, _pos[0], _pos[1], _pos[2]);
		SetVehicleVelocity(vehicleid, 0.0, 0.0, 0.0);
		SetPlayerPos(playerid, _pos[0], _pos[1], _pos[2]);
	}
	return 1;
}

public: AC::PutPlayerInVehicle(playerid, vehicleid, seatid) {
	AC::Info[playerid][AC::EnteredVeh] = vehicleid;
	return PutPlayerInVehicle(playerid, vehicleid, seatid);
}

public: AC::TogglePlayerControllable(playerid, toggle) {
	AC::Info[playerid][AC::Toggle] = toggle;
	return TogglePlayerControllable(playerid, toggle);
}

public: AC::IsPlayerControllable(playerid) {
	return !AC::Info[playerid][AC::Toggle];
}

public: AC::SetPlayerInterior(playerid, newinterior) {
	AC::Info[playerid][AC::Interior] = newinterior;
	return SetPlayerInterior(playerid, newinterior);
}

public: AC::SetPlayerVirtualWorld(playerid, virtualworld) {
	AC::Info[playerid][AC::VirtualWorld] = virtualworld;
	return SetPlayerVirtualWorld(playerid, virtualworld);
}

public: AC::TogglePlayerSpectating(playerid, bool:toggle) {
	AC::Info[playerid][AC::ToggleSpec] = toggle;
	return TogglePlayerSpectating(playerid, toggle);
}

public: AC::SpawnPlayer(playerid) {
	new vehicleid = GetPlayerVehicleID(playerid);
	if(vehicleid) _RemovePlayerFromVehicle(playerid, vehicleid);
	return SpawnPlayer(playerid);
}

stock AC::Kick(playerid, reason[], reasonid = R::NONE, color = 0xFF6347AA) {
	if(AC_OPK) {
		if(CallRemoteFunction("onPlayerKick", "isi", playerid, reason, reasonid)) {
			static string[144];
			format(string, sizeof string, "[AntiCheat] * Вы были кикнуты, причина: %s || AC%s", reason, reasonid == R_NONE ? ("#0000") : R::Info[reasonid]);
			Send(playerid, color, string);
		} else {
			return 1;
		}
	}
	return Kick(playerid);
}


stock AC::Ban(playerid, reason[], reasonid = R::NONE, color = 0xFF6347AA) {
	if(AC_OPB) {
		if(CallRemoteFunction("onPlayerBan", "isi", playerid, reason, reasonid)) {
			static string[144];
			format(string, sizeof string, "[AntiCheat] * Вы были забанены, причина: %s || AC%s", reason, reasonid == R_NONE ? ("#0000") : R::Info[reasonid]);
			Send(playerid, color, string);
		} else {
			return 1;
		}
	}
	return BanEx(playerid, reason);
}

stock AC::IsValidState(playerid) {
	return (1 <= GetPlayerState(playerid) <= 3);
}

stock floatmax(&Float: flt, Float: fltmax) {
	if(flt < 0.0) flt = 0.0; else if(flt > fltmax) flt = fltmax;
}


stock AC::exec(playerid, damagedid) {
	new Float:pos[3];
	GetPlayerPos(damagedid, pos[0], pos[1], pos[2]);
	return ((GetPlayerDistanceFromPoint(playerid, pos[0], pos[1], pos[2]) <= 1.0) && (GetPlayerAnimationIndex(playerid) == 1167));
}

stock AC::GetPlayerSpeed(playerid, bool:as_3d=true) {
	static vehicleid, Float:x, Float:y, Float:z;
	if((vehicleid = GetPlayerVehicleID(playerid))) {
		GetVehicleVelocity(vehicleid, x, y, z);
	} else {
		GetPlayerVelocity(playerid, x, y, z);
	}
	return AC_Speed(x, y, z, 100.0, as_3d);
}

stock AC::SetVehicleSpeed(vehicleid, speed) {
	static Float:x, Float:y, Float:z, Float:accel;
	GetVehicleVelocity(vehicleid, x, y, z);
	if(floatabs(x) > floatabs(y)) {
		if(floatabs(x) > speed * 0.006) {
			accel = speed * 0.006 / floatabs(x);
			SetVehicleVelocity(vehicleid, x * accel, y * accel, z);
		}
	} else {
		if(floatabs(y) > speed * 0.006) {
			accel = speed * 0.006  / floatabs(y);
			SetVehicleVelocity(vehicleid, x * accel, y * accel, z);
		}
	}
	return 1;
}

stock Float:AC::GetSquareDistance(Float:x1, Float:y1, Float:z1, Float:x2, Float:y2, Float:z2) {
	x1 -= x2;	x1 *= x1;
	y1 -= y2;	y1 *= y1;
	z1 -= z2;	z1 *= z1;
	return x1 + y1 + z1;
}

stock AC::IsPlayerOnGround(playerid) {
    new Float:x, Float:y, Float:z;
    GetPlayerVelocity(playerid, x, y, z);
    return floatabs(z) > 0.0 ? (false) : (true);
}

stock AC::IsPlayerInPause(playerid) {
	if(AC::isValidPlayer(playerid)) {
		return ((GetTickCount()-AC::Info[playerid][AC::LastUpdate])>=1000);
	}
	return 0;
}

stock AC::IsSwimAnim(animindex) {
	switch(animindex) {
		case 1543, 1538, 1539 : return 1;
	}
	return 0;
}


#define GivePlayerMoney				AC::GivePlayerMoney
#define SetPlayerMoney				AC::SetPlayerMoney
#define ResetPlayerMoney			AC::ResetPlayerMoney
#define SetPlayerHealth				AC::SetPlayerHealth
#define SetPlayerArmour				AC::SetPlayerArmour
#define GivePlayerWeapon			AC::GivePlayerWeapon
#define ResetPlayerWeapons			AC::ResetPlayerWeapons
#define TogglePlayerSpectating		AC::TogglePlayerSpectating
#define TogglePlayerControllable	AC::TogglePlayerControllable
#define PutPlayerInVehicle			AC::PutPlayerInVehicle
#define SetPlayerInterior			AC::SetPlayerInterior
#define SetPlayerVirtualWorld		AC::SetPlayerVirtualWorld
#define SetPlayerPos				AC::SetPlayerPos
#define SetVehiclePos				AC::SetVehiclePos
#define SetVehicleHealth			AC::SetVehicleHealth
#define RepairVehicle				AC::RepairVehicle
#define RemovePlayerFromVehicle		AC::RemovePlayerFromVehicle
#define ChangeVehicleColor			AC::ChangeVehicleColor


#if defined _ALS_OnGameModeInit
#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif
#define OnGameModeInit AC_OnGameModeInit
forward OnGameModeInit();

#if defined _ALS_OnGameModeExit
#undef OnGameModeExit
#else
	#define _ALS_OnGameModeExit
#endif
#define OnGameModeExit AC_OnGameModeExit
forward OnGameModeExit();

#if defined _ALS_OnPlayerConnect
#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect AC_OnPlayerConnect
forward OnPlayerConnect(playerid);

#if defined _ALS_OnPlayerSpawn
#undef OnPlayerSpawn
#else
	#define _ALS_OnPlayerSpawn
#endif
#define OnPlayerSpawn AC_OnPlayerSpawn
forward OnPlayerSpawn(playerid);

#if defined _ALS_OnVehicleMod
#undef OnVehicleMod
#else
	#define _ALS_OnVehicleMod
#endif
#define OnVehicleMod AC_OnVehicleMod
forward OnVehicleMod(playerid, vehicleid, componentid);

#if defined _ALS_OnEnterExitModShop
#undef OnEnterExitModShop
#else
	#define _ALS_OnEnterExitModShop
#endif
#define OnEnterExitModShop AC_OnEnterExitModShop
forward OnEnterExitModShop(playerid, enterexit, interiorid);

#if defined _ALS_OnVehicleRespray
#undef OnVehicleRespray
#else
	#define _ALS_OnVehicleRespray
#endif
#define OnVehicleRespray AC_OnVehicleRespray
forward OnVehicleRespray(playerid, vehicleid, color1, color2);

#if defined _ALS_OnPlayerEnterVehicle
#undef OnPlayerEnterVehicle
#else
	#define _ALS_OnPlayerEnterVehicle
#endif
#define OnPlayerEnterVehicle AC_OnPlayerEnterVehicle
forward OnPlayerEnterVehicle(playerid, vehicleid, ispassenger);

#if defined _ALS_OnPlayerExitVehicle
#undef OnPlayerExitVehicle
#else
	#define _ALS_OnPlayerExitVehicle
#endif
#define OnPlayerExitVehicle AC_OnPlayerExitVehicle
forward OnPlayerExitVehicle(playerid, vehicleid);

#if defined _ALS_OnPlayerStateChange
#undef OnPlayerStateChange
#else
	#define _ALS_OnPlayerStateChange
#endif
#define OnPlayerStateChange AC_OnPlayerStateChange
forward OnPlayerStateChange(playerid, newstate, oldstate);

#if defined _ALS_OnPlayerUpdate
#undef OnPlayerUpdate
#else
	#define _ALS_OnPlayerUpdate
#endif
#define OnPlayerUpdate AC_OnPlayerUpdate
forward OnPlayerUpdate(playerid);

#if defined _ALS_OnPlayerText
	#undef OnPlayerText
#else
	#define _ALS_OnPlayerText
#endif
#define OnPlayerText AC_OnPlayerText
forward AC_OnPlayerText(playerid, text[]);

#if defined _ALS_OnPlayerDeath
	#undef OnPlayerDeath
#else
	#define _ALS_OnPlayerDeath
#endif
#define OnPlayerDeath AC_OnPlayerDeath
forward AC_OnPlayerDeath(playerid, killerid, reason);

#if defined _ALS_OnPlayerGiveDamage
	#undef OnPlayerGiveDamage
#else
	#define _ALS_OnPlayerGiveDamage
#endif
#define OnPlayerGiveDamage AC_OnPlayerGiveDamage
forward AC_OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid, bodypart);

#if defined _ALS_OnPlayerInteriorChange
	#undef OnPlayerInteriorChange
#else
	#define _ALS_OnPlayerInteriorChange
#endif
#define OnPlayerInteriorChange AC_OnPlayerInteriorChange
forward AC_OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid);