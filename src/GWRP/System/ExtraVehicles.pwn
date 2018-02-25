#if !defined _System_ExtraVehicles_
#define _System_ExtraVehicles_

#define PARK_GARAGE (1)
#define PARK_HOME (2)
#define PARK_HOME_GARAGE (3)
#define MAX_EXTRA_VEHICLES (5)
enum e_ExtraVehicles {
	evID1,
	evID2,
	evOwner,
	evModel,
	evPark,
	evColor1,
	evColor2,
	Float:evSpawnX,
	Float:evSpawnY,
	Float:evSpawnZ,
	Float:evSpawnA,
}
new ExtraVehicles[MAX_PLAYERS][MAX_EXTRA_VEHICLES][e_ExtraVehicles];
new TotalExtraVehicles[MAX_PLAYERS];
new Iterator:ExtraVehicles[MAX_PLAYERS]<MAX_EXTRA_VEHICLES>;
new VehicleInGarage[MAX_PLAYERS][MAX_EXTRA_VEHICLES];
new TotalVehicleInGarage[MAX_PLAYERS];


public: LoadExtraVehicles(playerid) {
	new rows = cache_num_rows();
	if(rows) {
		for(new i; i < rows; i++) {
			cache_get_int(i, 0, ExtraVehicles[playerid][i][evID1]);
			cache_get_int(i, 1, ExtraVehicles[playerid][i][evOwner]);
			cache_get_int(i, 2, ExtraVehicles[playerid][i][evModel]);
			cache_get_int(i, 3, ExtraVehicles[playerid][i][evPark]);
			cache_get_scn(i, 4, "p<,>ii", ExtraVehicles[playerid][i][evColor1], ExtraVehicles[playerid][i][evColor2]);
			cache_get_scn(i, 5, "p<,>ffff", ExtraVehicles[playerid][i][evSpawnX], ExtraVehicles[playerid][i][evSpawnY], ExtraVehicles[playerid][i][evSpawnZ], ExtraVehicles[playerid][i][evSpawnA]);
			
			if(ExtraVehicles[playerid][i][evPark] == PARK_HOME) {
				ExtraVehicles[playerid][i][evID2] = Veh::Create(
					ExtraVehicles[playerid][i][evModel],
					ExtraVehicles[playerid][i][evSpawnX],
					ExtraVehicles[playerid][i][evSpawnY],
					ExtraVehicles[playerid][i][evSpawnZ],
					ExtraVehicles[playerid][i][evSpawnA],
					ExtraVehicles[playerid][i][evColor1],
					ExtraVehicles[playerid][i][evColor2],
					INFINITY
				);
				AutoInfo[ExtraVehicles[playerid][i][evID2]][aOwner] = playerid;
				SetVehicleNumber(ExtraVehicles[playerid][i][evID2]);
				SetVehicleNumber(ExtraVehicles[playerid][i][evID2]);
				ToggleVehicleDoor(ExtraVehicles[playerid][i][evID2], false);
				
			} else if((ExtraVehicles[playerid][i][evPark] / Pl::Info[playerid][pHouseKey]) == PARK_HOME_GARAGE) {
				ExtraVehicles[playerid][i][evID2] = Veh::Create(
					ExtraVehicles[playerid][i][evModel],
					ExtraVehicles[playerid][i][evSpawnX],
					ExtraVehicles[playerid][i][evSpawnY],
					ExtraVehicles[playerid][i][evSpawnZ],
					ExtraVehicles[playerid][i][evSpawnA],
					ExtraVehicles[playerid][i][evColor1],
					ExtraVehicles[playerid][i][evColor2],
					INFINITY
				);
				AutoInfo[ExtraVehicles[playerid][i][evID2]][aOwner] = playerid;
				SetVehicleNumber(ExtraVehicles[playerid][i][evID2]);
				ToggleVehicleDoor(ExtraVehicles[playerid][i][evID2], false);
				LinkVehicleToInterior(ExtraVehicles[playerid][i][evID2], 3);
				SetVehicleVirtualWorld(ExtraVehicles[playerid][i][evID2], Pl::Info[playerid][pHouseKey]);
			
			} else {
				AddExtraVehicleToGarage(playerid, i);
				ExtraVehicles[playerid][i][evID2] = INVALID_VEHICLE_ID;
			}
			Iter::Add(ExtraVehicles[playerid], i);
		}
		TotalExtraVehicles[playerid] = rows;
	}
	return 1;
}

stock AddExtraVehicle(playerid, model, Float:spawn_x, Float:spawn_y, Float:spawn_z, Float:spawn_a, color1, color2, park = PARK_GARAGE, create = 1, resptime = INFINITY) {
	if(Pl::isLogged(playerid)) {
		if(TotalExtraVehicles[playerid] < MAX_EXTRA_VEHICLES) {
			new id = TotalExtraVehicles[playerid] ++;			
			format(query, sizeof query, "INSERT INTO `"#__TableExtraVehicles__"` (`owner`,`model`,`park`,`color`,`spawn`) VALUES (");
			scf(query, temp, "'%i',", Pl::Info[playerid][pID]);
			scf(query, temp, "'%i',", model);
			scf(query, temp, "'%i',", park);
			scf(query, temp, "'%i,%i',", color1, color2);
			scf(query, temp, "'%.3f,%.3f,%.3f,%.3f')", spawn_x, spawn_y, spawn_z, spawn_a);
			new Cache:result = db::query(db::Handle, query, true);
			
			ExtraVehicles[playerid][id][evID1] = cache_insert_id();
			ExtraVehicles[playerid][id][evModel] = model;
			ExtraVehicles[playerid][id][evOwner] = Pl::Info[playerid][pID];
			ExtraVehicles[playerid][id][evPark] = park;
			ExtraVehicles[playerid][id][evColor1] = color1;
			ExtraVehicles[playerid][id][evColor2] = color2;
			ExtraVehicles[playerid][id][evSpawnX] = spawn_x;
			ExtraVehicles[playerid][id][evSpawnY] = spawn_y;
			ExtraVehicles[playerid][id][evSpawnZ] = spawn_z;
			ExtraVehicles[playerid][id][evSpawnA] = spawn_a;
			
			if(create) {
				ExtraVehicles[playerid][id][evID2] = Veh::Create(model, spawn_x, spawn_y, spawn_z, spawn_a, color1, color2, resptime);
				AutoInfo[ExtraVehicles[playerid][id][evID2]][aOwner] = playerid;
				SetVehicleNumber(ExtraVehicles[playerid][id][evID2]);
			} else {
				AddExtraVehicleToGarage(playerid, id);
				ExtraVehicles[playerid][id][evID2] = INVALID_PLAYER_ID;
			}
			
			Iter::Add(ExtraVehicles[playerid], id);
			cache_delete(result);
			return id;
		}
	}
	return INVALID_VEHICLE_ID;
}

stock AddExtraVehicleToGarage(playerid, slot) {
	if(TotalVehicleInGarage[playerid] < MAX_EXTRA_VEHICLES) {
		for(new i; i < TotalVehicleInGarage[playerid]; i++) {
			if(VehicleInGarage[playerid][i] == slot) return 1;
		}
		VehicleInGarage[playerid][TotalVehicleInGarage[playerid]++] = slot;
	}
	return 1;
}

stock RemoveExtraVehicleFromGarage(playerid, slot) {
	if(0 <= slot < MAX_EXTRA_VEHICLES) {
		for(new i; i < TotalVehicleInGarage[playerid]; i++) {
			if(VehicleInGarage[playerid][i] == slot) {
				VehicleInGarage[playerid][i] = VehicleInGarage[playerid][--TotalVehicleInGarage[playerid]];
				return 1;
			}
		}
	}
	return 1;
}

stock RemoveExtraVehicle(playerid, slot) {
	if(0 <= slot < MAX_EXTRA_VEHICLES) {
		format(query, sizeof query, "DELETE FROM `"#__TableExtraVehicles__"` WHERE `owner` = '%i' AND `id` = '%i'", Pl::Info[playerid][pID], ExtraVehicles[playerid][slot][evID1]);
		db::tquery(db::Handle, query, "", "");
		
		Veh::Destroy(ExtraVehicles[playerid][slot][evID2]);
		new i = --TotalExtraVehicles[playerid];

		ExtraVehicles[playerid][slot][evID1] = ExtraVehicles[playerid][i][evID1];
		ExtraVehicles[playerid][slot][evID2] = ExtraVehicles[playerid][i][evID2];
		ExtraVehicles[playerid][slot][evOwner] = ExtraVehicles[playerid][i][evOwner];
		ExtraVehicles[playerid][slot][evModel] = ExtraVehicles[playerid][i][evModel];
		ExtraVehicles[playerid][slot][evPark] = ExtraVehicles[playerid][i][evPark];
		ExtraVehicles[playerid][slot][evColor1] = ExtraVehicles[playerid][i][evColor1];
		ExtraVehicles[playerid][slot][evColor2] = ExtraVehicles[playerid][i][evColor2];
		ExtraVehicles[playerid][slot][evSpawnX] = ExtraVehicles[playerid][i][evSpawnX];
		ExtraVehicles[playerid][slot][evSpawnY] = ExtraVehicles[playerid][i][evSpawnY];
		ExtraVehicles[playerid][slot][evSpawnZ] = ExtraVehicles[playerid][i][evSpawnZ];
		ExtraVehicles[playerid][slot][evSpawnA] = ExtraVehicles[playerid][i][evSpawnA];
		RemoveExtraVehicleFromGarage(playerid, i);
		Iter::Remove(ExtraVehicles[playerid], i);
		
		if(ExtraVehicles[playerid][slot][evPark] == PARK_GARAGE) {
			AddExtraVehicleToGarage(playerid, slot);
		} else {
			RemoveExtraVehicleFromGarage(playerid, slot);
		}
		return 1;
	}
	return 0;
}

stock UpdateExtraVehicle(playerid, slot) {
	if(0 <= slot < MAX_EXTRA_VEHICLES) {
		format(query, sizeof query, "UPDATE `"#__TableExtraVehicles__"` SET ");
		scf(query, temp, "`owner`='%i',", ExtraVehicles[playerid][slot][evOwner]);
		scf(query, temp, "`model`='%i',", ExtraVehicles[playerid][slot][evModel]);
		scf(query, temp, "`park`='%i',", ExtraVehicles[playerid][slot][evPark]);
		scf(query, temp, "`color`='%i,%i',", ExtraVehicles[playerid][slot][evColor1], ExtraVehicles[playerid][slot][evColor2]);
		scf(query, temp, "`spawn`='%.3f,%.3f,%.3f,%.3f' ", ExtraVehicles[playerid][slot][evSpawnX], ExtraVehicles[playerid][slot][evSpawnY], ExtraVehicles[playerid][slot][evSpawnZ], ExtraVehicles[playerid][slot][evSpawnA]);
		scf(query, temp, "WHERE `id` = '%i'", ExtraVehicles[playerid][slot][evID1]);
		db::tquery(db::Handle, query, "", "");
	}
	return 1;
}

stock ShowExtraVehiclesMenu(playerid, dialogid=D_EV_MENU) {
	switch(dialogid) {
		case D_EV_MENU : {
			dialog[0] = '\0';
			new listitem;
			foreach(new i : ExtraVehicles[playerid]) {
				format(temp, sizeof temp, "extra[%i]", listitem++), SetPVarInt(playerid, temp, i);
				if(ExtraVehicles[playerid][i][evID2] != INVALID_VEHICLE_ID) {
					scf(dialog, temp, "%s %s %s\n", VehicleNames[ExtraVehicles[playerid][i][evModel] - 400],\
					gCarLock{ExtraVehicles[playerid][i][evID2]} ? ("{AA3333}[закрыт]") : ("{33AA33}[открыт]"),\
					ExtraVehicles[playerid][i][evPark] == PARK_HOME ? ("{33AA33}[домашний]") : (" "));
				} else {
					scf(dialog, temp, "%s {AA3333}[закрыт] [в гараже]\n", VehicleNames[ExtraVehicles[playerid][i][evModel] - 400]);
				}
			}
			if(!strlen(dialog)) return Send(playerid, COLOR_GREY, "* У Вас нет доп. машин!");
			SPD(playerid, D_EV_MENU, DIALOG_STYLE_LIST, "Ваш личный транспорт", dialog, "SELECT", "CANCEL");
		}
	}
	return 1;
}

stock IsPlayerTakeExtraVehicle(playerid) {
	foreach(new i : ExtraVehicles[playerid]) {
		if(ExtraVehicles[playerid][i][evID2] != INVALID_VEHICLE_ID && ExtraVehicles[playerid][i][evPark] == PARK_GARAGE) {
			return 1;
		}
	}
	return 0;
}

stock GetIdxExtraVehicleFromVehicleID(playerid, vehicleid) {
	foreach(new i : ExtraVehicles[playerid]) {
		if(ExtraVehicles[playerid][i][evID2] == vehicleid) {
			return i;
		}
	}
	return -1;
}

#endif