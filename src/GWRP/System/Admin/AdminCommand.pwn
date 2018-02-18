/***
	The MIT License (MIT)

	Copyright (c) 2014 MacMailler

	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in all
	copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
	SOFTWARE.
***/

#if defined __AdminCommand__
	#endinput
#endif
#define __AdminCommand__


CMD:maps(playerid, params[]) {
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GREY, "* Недастаточно прав!");
	dialog[0] = '\0';
	foreach(new i : Maps) scf(dialog, temp, "%i. %s\n", i, MapInfo[i][MapFile]);
	strcat(dialog, "------------\nДобавить");
	SPD(playerid, D_EDIT_MAPS, DIALOG_STYLE_LIST, "Maps", dialog, "SELECT", "CANCEL");
	return 1;
}

CMD:setzahvattime(playerid, params[]) { new string[144];
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GREY, "* Недастаточно прав!");
	if(sscanf(params, "ii", params[0], params[1])) return Send(playerid, COLOR_GREY, "Введите: /setzahvattime [fracid] [time]");
	if(!(2 <= params[1] <= 240)) return Send(playerid, COLOR_GREY, "* Неверное время!");
	if(!IsAGangF(params[0])) return Send(playerid, COLOR_GREY, "* Только для банд!");
	if(!IsValidBiz(GangOnBattle[params[0]])) return Send(playerid, COLOR_GREY, "* Эта банда не участвует в захвате!");
	BizzInfo[GangOnBattle[params[0]]][bZahvatTime] = params[1];
	format(string, sizeof string, "[AdmWarn] * %s применил команду /setzahvattime к банде %s", FracInfo[params[0]][fName]);
	SendToAdmin(COLOR_YELLOW, string, SUPERMODER, 3);
	return 1;
}

CMD:addhouse(playerid, params[]) { new string[144], lvl, price;
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(sscanf(params, "ii", lvl, price)) return Send(playerid, COLOR_GREY, "Ведите: /addhouse [lvl] [price]");
	if(GetPlayerInterior(playerid) != 0) return Send(playerid, COLOR_GREY, "* Дом можно добавлять только в 0-ом интерьере!");
	if(GetPlayerVirtualWorld(playerid) != 0) return Send(playerid, COLOR_GREY, "* Дом можно добавлять только в 0-ом виртуальном мире!");
	new Float:pos[4];
	GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	GetPlayerFacingAngle(playerid, pos[3]);
	new house = AddHouse(lvl, price, pos);
	if(house != INVALID_HOUSE_ID) {
		format(string, sizeof string, "* Дом был добавлен, его ид: %i", house);
		Send(playerid, COLOR_LIGHTBLUE, string);
	} else {
		Send(playerid, COLOR_LIGHTBLUE, "* Произошла ошибка!");
	}
	return 1;
}

CMD:deletehouse(playerid, params[]) { new string[144];
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(sscanf(params, "i", params[0])) return Send(playerid, COLOR_GREY, "Ведите: /deletehouse [houseid]");
	if(!Iter::Contains(Houses, params[0])) return Send(playerid, COLOR_GREY, "* Нет такого дома!");
	DeleteHouse(params[0]);
	format(string, sizeof string, "* Дом №%i был удален!", params[0]);
	Send(playerid, COLOR_LIGHTBLUE, string);
	return 1;
}

CMD:dopcar_add(playerid, params[]) { new string[144], sendername[24];
	if(!Pl::isAdmin(playerid, SUPERMODER)) return Send(playerid, COLOR_GREY, "* Недастаточно прав!");
	if(sscanf(params, "uiI(-1)I(-1)", params[0], params[1], params[2], params[3])) return Send(playerid, COLOR_GREY, "Введите: /dopcar_add [id/name] [model] (optional [color1] [color2])");
	if(!Pl::isLogged(params[0])) return Send(playerid, COLOR_GREY, "* Этот игрок не авторизован!");
	if(!(400 <= params[1] <= 611)) return Send(playerid, COLOR_GREY, "* Invalid model ID!");
	if(!(TotalExtraVehicles[params[0]] < MAX_EXTRA_VEHICLES)) return Send(playerid, COLOR_GREY, "* Для этого игрока создано макс. количество доп. транспорта!");
	new Float:x, Float:y, Float:z, Float:a;
	GetPlayerPos(params[0], x, y, z);
	GetPlayerFacingAngle(params[0], a);
	new id = AddExtraVehicle(params[0], params[1], x, y, z, a, params[2], params[3]);
	if(id != INVALID_VEHICLE_ID) {
		Rac::PutPlayerInVehicle(params[0], ExtraVehicles[params[0]][id][evID2], 0);
		GetPlayerName(playerid, sendername, 24);
		format(string, sizeof string, "[AdmWarn] * %s применил команду /dopcar_add", sendername);
		SendToAdmin(COLOR_LIGHTBLUE, string, 4, 3);
		Send(playerid, COLOR_YELLOW, "* Доп. траспорт был создан!");
	}
	return 1;
}

CMD:dopcar_del(playerid, params[]) {
	if(!Pl::isAdmin(playerid, SUPERMODER)) return Send(playerid, COLOR_GREY, "* Недастаточно прав!");
	if(sscanf(params, "u", params[0])) return Send(playerid, COLOR_WHITE, "Введите: /dopcar_del [id/name])");
	if(!Pl::isLogged(params[0])) return Send(playerid, COLOR_GREY, "* Этот игрок не авторизован!");
	dialog[0] = '\0';
	new listitem;
	SetPVarInt(playerid, "SelectedPlayer", params[0]);
	foreach(new i : ExtraVehicles[params[0]]) {
		format(temp, sizeof temp, "extra[%i]", listitem++), SetPVarInt(playerid, temp, i);
		if(ExtraVehicles[params[0]][i][evID2] != INVALID_VEHICLE_ID) {
			scf(dialog, temp, "%s %s %s\n", VehicleNames[ExtraVehicles[params[0]][i][evModel] - 400],\
			ExtraVehicles[params[0]][i][evPark] == PARK_HOME ? ("{33AA33}[домашний]") : (" "));
		} else {
			scf(dialog, temp, "%s {AA3333} [в гараже]\n", VehicleNames[ExtraVehicles[params[0]][i][evModel] - 400]);
		}
	}
	if(!strlen(dialog)) return Send(playerid, COLOR_GREY, "* У игрока нет доп. машин!");
	SPD(playerid, D_EV_MENU+3, DIALOG_STYLE_LIST, "Ваш личный транспорт", dialog, "SELECT", "CANCEL");
	return 1;
}

CMD:put(playerid, params[]) {
	if(!Pl::isAdmin(playerid, SUPERMODER)) return Send(playerid, COLOR_GREY, "* Недастаточно прав!");
	if(GetPlayerVehicleID(playerid)) return Send(playerid, COLOR_GREY, "* Вы уже в транспорте!");
	new vehicleid = ClosestVeh(playerid, 3.0);
	if(vehicleid == INVALID_VEHICLE_ID) return Send(playerid, COLOR_GREY, "Нет машин поблизости");
	return Rac::PutPlayerInVehicle(playerid, vehicleid, 0);
}

CMD:fakekill(playerid, params[]) {
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GREY, "* Недастаточно прав!");
	if(sscanf(params, "ui", params[0], params[1])) return Send(playerid, COLOR_GREY, "Введите: /fakekill [ид/часть имени] [причина]");
	SyncInfo[playerid][sKillerID] = params[0];
	SyncInfo[playerid][sReasonID] = params[1];
	return Rac::SetPlayerHealth(playerid, 0.0);
}

CMD:loadmap(playerid, params[]) { new string[144], mapfile[24], worldid, interiorid, player;
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GREY, "* Недастаточно прав!");
	if(sscanf(params, "s[24]I(-1)I(-1)I(-1)", mapfile, worldid, interiorid, player))
	return Send(playerid, COLOR_GREY, "Введите: /loadmap [mapfile] (example: maps/file.map)");
	new mapid = map::Load(mapfile, worldid, interiorid, player);
	if(mapid == INVALID_MAP_ID) return Send(playerid, COLOR_GREY, "* Map file not found!");
	format(string, sizeof string, "* Карта загружена! [id:%i]", mapid);
	Send(playerid, COLOR_YELLOW, string);
	return 1;
}

CMD:unloadmap(playerid, params[]) { new string[144];
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GREY, "* Недастаточно прав!");
	if(sscanf(params, "i", params[0])) return Send(playerid, COLOR_GREY, "Введите: /unloadmap [mapid]");
	if(!map::Destroy(params[0])) return Send(playerid, COLOR_GREY, "* Invalid map id!");
	format(string, sizeof string, "* Карта выгружена! [id:%i]", params[0]);
	Send(playerid, COLOR_YELLOW, string);
	return 1;
}
	
CMD:togglereg(playerid, params[]) {
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GREY, "* Недастаточно прав!");
	switch(Gm::Info[Gm::EnableReg]) {
		case 0 : {
			Send(playerid, COLOR_YELLOW, "* Регистрация включена!");
			Gm::Info[Gm::EnableReg] = 1;
		}
		case 1 : {
			Send(playerid, COLOR_YELLOW, "* Регистрация отключена!");
			Gm::Info[Gm::EnableReg] = 0;
		}
	}
	SaveStuff();
	return 1;
}

CMD:sobcheck(playerid, params[]) { new string[144], sendername[24], playername[24];
	if(!Pl::isAdmin(playerid, MODER1LVL)) return Send(playerid, COLOR_GREY, "* Недастаточно прав!");
	if(sscanf(params, "u", params[0])) return Send(playerid, COLOR_GREY, "Введите: /sobcheck [id/part name]");
	if(!Pl::isLogged(params[0])) return Send(playerid, COLOR_GREY, "* Этот игрок не залогинен!");
	if(AFKInfo[params[0]][afk_State]) return Send(playerid, COLOR_GREY, "* Игрок в AFK!");
	if(GetPlayerVehicleID(params[0])) return Send(playerid, COLOR_GREY, "* Игрок не должен быть в транспорте!");
	new Float:x, Float:y, Float:z;
	GetPlayerCameraPos(params[0], x, y, z);
	Rac::TogglePlayerControllable(params[0], false);
	SetTimerEx("onSobeitCheck", 4000, false, "if", params[0], z);
	getname(playerid -> sendername,params[0] -> playername);
	format(string, sizeof string, "[AdmWarn] * %s применил команду /sobcheck к игроку %s[%s]", sendername, playername, FracInfo[Pl::FracID(params[0])][fName]);
	SendToAdmin(COLOR_YELLOW, string, 1, 3);
	return 1;
}

CMD:ptmcheck(playerid, params[]) { new string[144], sendername[24], playername[24];
	if(!Pl::isAdmin(playerid, MODER1LVL)) return Send(playerid, COLOR_GREY, "* Недастаточно прав!");
	if(Rac::GetPlayerState(playerid) != 9) return Send(playerid, COLOR_GREY, "* Только в режиме спектирования!");
	if(sscanf(params, "u", params[0])) return Send(playerid, COLOR_GREY, "* Введите: /ptmcheck [id/part name]");
	if(!Pl::isLogged(params[0])) return Send(playerid, COLOR_GREY, "* Этот игрок не залогинен!");
	new targetid = GetPlayerTargetPlayer(params[0]);
	if(targetid != INVALID_PLAYER_ID && Rac::GetPlayerState(params[0]) == 1) {
		new Float:x[2], Float:y[2], Float:z[2], Float:a;
		GetPlayerPos(params[0], x[0], y[0], z[0]);
		GetPlayerFacingAngle(params[0], a);
		GetXYInFrontOfPoint(x[0], y[0], a, -3.0);
		GetPlayerPos(targetid, x[1], y[1], z[1]);
		Rac::SetPlayerPos(targetid, x[0], y[0], z[0]);
		SetTimerEx("onPTMCheck", 2000, false, "iifff", params[0], targetid, x[1], y[1], z[1]);
		getname(playerid -> sendername, params[0] -> playername);
		format(string, sizeof string, "[AdmWarn] * %s применил команду /ptmpcheck к игроку %s[%s]", sendername, playername, FracInfo[Pl::FracID(params[0])][fName]);
		SendToAdmin(COLOR_YELLOW, string, 3, 3);
	} else {
		Send(playerid, COLOR_GREY, "* Недостаточно условий!");
	}
	return 1;
}

CMD:payday(playerid, params[]) {
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GREY, "* Недастаточно прав!");
	SetTimer("onPayDay", 100, false);
	return 1;
}

CMD:int(playerid, params[]) {
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return 1 ;
	if(sscanf(params, "i", params[0])) return 1;
	if(params[0] <= -1 || params[0] >= sizeof SAInteriors) {
		params[0] = GetPVarInt(playerid, "SelectedItem");
		if(params[0] <= -1) params[0] = 0;
	}
	Rac::SetPlayerPos(playerid, SAInteriors[params[0]][iX], SAInteriors[params[0]][iY], SAInteriors[params[0]][iZ]);
	SetPlayerFacingAngle(playerid, SAInteriors[params[0]][iA]);
	Rac::SetPlayerInterior(playerid, SAInteriors[params[0]][iI]);
	Rac::SetPlayerVirtualWorld(playerid, 100+playerid);
	SetPVarInt(playerid, "SelectedItem", params[0]);
	ShowMenuForPlayer(SAInteriorsMenu, playerid);
	return 1;
}


CMD:addskin(playerid, params[]) {
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GREY, "* Недастаточно прав!");
	if(sscanf(params, "ii", params[0], params[1])) return Send(playerid, COLOR_GREY, "Введите: /fracname [fracid] [skinid]");
	if(!Container::Find(params[0], params[1])) return Send(playerid, COLOR_GREY, "* Skin found!");
	Container::Add(params[0], params[1]);
	format(query, sizeof query, "INSERT INTO `"#__TableFracSkins__"` (`f_id`,`skin_id`) VALUES ('%i','%i')", params[0], params[1]);
	Db::tquery(connDb, query, "", "");
	Send(playerid, COLOR_YELLOW, "* Скин добавлен!");
	return 1;
}

CMD:delskin(playerid, params[]) {
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GREY, "* Недастаточно прав!");
	if(sscanf(params, "ii", params[0], params[1])) return Send(playerid, COLOR_GREY, "Введите: /fracname [fracid] [skinid]");
	if(!Container::Find(params[0], params[1])) return Send(playerid, COLOR_GREY, "* Skin not found!");
	Container::Remove(params[0], params[1]);
	format(query, sizeof query, "DELETE FROM `"#__TableFracSkins__"` WHERE `f_id` = '%i' AND `skin_id` = '%i'", params[0], params[1]);
	Db::tquery(connDb, query, "", "");
	Send(playerid, COLOR_YELLOW, "* Скин удален!");
	return 1;
}

CMD:fracname(playerid, params[]) {
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GREY, "* Недастаточно прав!");
	if(sscanf(params, "is[36]", params[0], params[1])) return Send(playerid, COLOR_GREY, "Введите: /fracname [fracid] [name]");
	if(!regex_match_exid(params[1], ValidText)) return Send(playerid, COLOR_GREY, "* Недопустимое название!");
	SetFracName(params[0], params[1]);
	Send(playerid, COLOR_YELLOW, "* Название фракции изменено!");
	return 1;
}

CMD:fractag(playerid, params[]) {
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GREY, "* Недастаточно прав!");
	if(sscanf(params, "is[16]", params[0], params[1])) return Send(playerid, COLOR_GREY, "Введите: /fracname [fracid] [name]");
	if(!regex_match_exid(params[1], ValidText)) return Send(playerid, COLOR_GREY, "* Недопустимое название!");
	SetFracTag(params[0], params[1]);
	Send(playerid, COLOR_YELLOW, "* Тэг фракции изменен!");
	return 1;
}

CMD:netstat(playerid, params[]) {
	if(!Pl::isAdmin(playerid, MODER1LVL)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(sscanf(params, "i", params[0])) return Send(playerid, COLOR_GREY, "Введите: /netstat [playerid]");
	if(params[0] == 999) Pl::NetStats[playerid] = params[0];
	else if(params[0] == 1000) Pl::NetStats[playerid] = params[0];
	else if(Pl::isLogged(params[0])) Pl::NetStats[playerid] = params[0];
	else Send(playerid, COLOR_GREY, "* Этот игрок не подключен!");

	return 1;
}

CMD:savecam(playerid, params[]) { new string[144];
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	new Float:player[4], Float:camera[3], Float:vector[3];
	GetPlayerPos(playerid, player[0], player[1], player[2]);
	GetPlayerFacingAngle(playerid, player[3]);
	GetPlayerCameraPos(playerid, camera[0], camera[1], camera[2]);
	GetPlayerCameraFrontVector(playerid, vector[0], vector[1], vector[2]);
	format(string, sizeof string, "SetPlayerPos(playerid, %.4f, %.4f, %.4f, %.4f); // %s\n", player[0], player[1], player[2], player[3], params);
	writeFile("campos.txt", string);
	format(string, sizeof string, "SetPlayerCameraPos(playerid, %.4f, %.4f, %.4f);\n", camera[0], camera[1], camera[2]);
	writeFile("campos.txt", string);
	format(string, sizeof string, "SetPlayerCameraLookAt(playerid, %.4f, %.4f, %.4f);\n", camera[0]+(vector[0]*4), camera[1]+(vector[1]*4), camera[2]+(vector[2]*4));
	writeFile("campos.txt", string);		
	Send(playerid, COLOR_YELLOW, "* Camera pos saved");
	return 1;
}

CMD:velocity(playerid, params[]) { new string[144], sendername[24], playername[24];
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(sscanf(params, "ucf", params[0], params[1], distance)) return Send(playerid, COLOR_GREY, "Used: /superjmp [id] [] [float]");
	if(!Pl::isLogged(params[0])) return Send(playerid, COLOR_GREY, "* Этот игрок не залогинен!");
	if(GetPlayerState(params[0]) == 2 || GetPlayerState(params[0]) == 3) {
		new v_id = GetPlayerVehicleID(params[0]);
		GetVehicleVelocity(v_id, posx, posy, posz);
		switch(params[1]) {
			case 'x' : SetVehicleVelocity(v_id, distance, posy, posz);
			case 'y' : SetVehicleVelocity(v_id, posx, distance, posz);
			case 'z' : SetVehicleVelocity(v_id, posx, posy, distance);
			
		}
	} else {
		GetPlayerVelocity(params[0], posx, posy, posz);
		switch(params[1]) {
			case 'x' : SetPlayerVelocity(params[0], distance, posy, posz);
			case 'y' : SetPlayerVelocity(params[0], posx, distance, posz);
			case 'z' : SetPlayerVelocity(params[0], posx, posy, distance);
		}
	}
	getname(playerid -> sendername, params[0] -> playername);
	format(string, sizeof string, "[AdmWarn] * %s применил команду /velocity к игроку %s[%s]", sendername, playername, FracInfo[Pl::FracID(params[0])][fName]);
	SendToAdmin(COLOR_YELLOW, string, 3, 3);
	return 1;
}

CMD:addcar(playerid, params[]) { new string[144], sendername[24];
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(IsPlayerInAnyVehicle(playerid)) return Send(playerid, COLOR_GREY, "* Вы не должны сидеть в машине!");
	if(sscanf(params, "iiii", params[0], params[1], params[2], params[3])) return Send(playerid, COLOR_GREY, "Введите: /addcar [model] [vColor1] [vColor2] [vRespTime time]");
	if(params[0] < 400 || params[0] > 611) return Send(playerid, COLOR_GREY, "* Неверный ID моднли!");
	if(params[1] < -1 || params[1] > 126) return Send(playerid, COLOR_GREY, "* ID цвета не может быть ниже 0 или выше 126!");
	if(params[2] < -1 || params[2] > 126) return Send(playerid, COLOR_GREY, "* ID цвета не может быть ниже 0 или выше 126 !");

	new idx = TOTAL_VEHICLES; TOTAL_VEHICLES++;
	GetPlayerPos(playerid, VehicleInfo[idx][vPosX], VehicleInfo[idx][vPosY], VehicleInfo[idx][vPosZ]);
	GetPlayerFacingAngle(playerid, VehicleInfo[idx][vPosA]);
	VehicleInfo[idx][vModel] = params[0]; VehicleInfo[idx][vColor1] = params[1];
	VehicleInfo[idx][vColor2] = params[2]; VehicleInfo[idx][vRespTime] = params[3];
	VehicleInfo[idx][cID] = Veh::Create(
		VehicleInfo[idx][vModel],
		VehicleInfo[idx][vPosX],
		VehicleInfo[idx][vPosY],
		VehicleInfo[idx][vPosZ],
		VehicleInfo[idx][vPosA],
		VehicleInfo[idx][vColor1],
		VehicleInfo[idx][vColor2],
		VehicleInfo[idx][vRespTime]
	);
	
	Iter::Add(JobVehicles[VehicleInfo[idx][vJob]], VehicleInfo[idx][cID]);
	SetVehicleNumber(VehicleInfo[idx][cID]);
	SaveToSQL(idx,2);
	
	Rac::PutPlayerInVehicle(playerid, VehicleInfo[idx][cID], 0);
	GetPlayerName(playerid, sendername, 24);
	format(string, sizeof string, "[AdmWarn] * %s применил команду /addcar", sendername);
	SendToAdmin(COLOR_LIGHTBLUE, string, 4, 3);
	return 1;
}

CMD:parkcar(playerid, params[]) { new string[144], sendername[24];
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(GetPlayerState(playerid) != 2) return Send(playerid, COLOR_GREY, "* Вы не сидите в машине!");

	for(new idx; idx < TOTAL_VEHICLES; idx++) {
		if(IsPlayerInVehicle(playerid, VehicleInfo[idx][cID])) {
			AutoInfo[0][aMileage] = AutoInfo[VehicleInfo[idx][cID]][aMileage];
			GetVehiclePos(VehicleInfo[idx][cID], VehicleInfo[idx][vPosX], VehicleInfo[idx][vPosY], VehicleInfo[idx][vPosZ]);
			GetVehicleZAngle(VehicleInfo[idx][cID], VehicleInfo[idx][vPosA]);
			Veh::Destroy(VehicleInfo[idx][cID]);
			VehicleInfo[idx][cID] = Veh::Create(
				VehicleInfo[idx][vModel],
				VehicleInfo[idx][vPosX],
				VehicleInfo[idx][vPosY],
				VehicleInfo[idx][vPosZ],
				VehicleInfo[idx][vPosA],
				VehicleInfo[idx][vColor1],
				VehicleInfo[idx][vColor2],
				VehicleInfo[idx][vRespTime]
			);
			AutoInfo[VehicleInfo[idx][cID]][aMileage] = AutoInfo[0][aMileage];
			SetVehicleNumber(VehicleInfo[idx][cID]);
			UpdateToSQL(idx, 0);
			Rac::PutPlayerInVehicle(playerid, VehicleInfo[idx][cID], 0);
			return Send(playerid, COLOR_YELLOW, "* Машина была припаркована!");
		}
	}
	GetPlayerName(playerid, sendername, 24);
	format(string, sizeof string, "[AdmWarn] * %s применил команду /parkcar.", sendername);
	SendToAdmin(COLOR_LIGHTBLUE, string, 4, 3); return 1;
}

CMD:destcar(playerid, params[]) {
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(GetPlayerState(playerid) != 2) return Send(playerid, COLOR_GREY, "* Вы не сидите в машине!");

	for(new i; i < TOTAL_VEHICLES; i++) {
		if(IsPlayerInVehicle(playerid, VehicleInfo[i][cID])) {
			AutoInfo[VehicleInfo[i][cID]][aMileage] = 0.0;
			Veh::Destroy(VehicleInfo[i][cID]);
			RemoveInSQL(i, 2);
			TOTAL_VEHICLES --;
			Iter::Remove(JobVehicles[VehicleInfo[i][vJob]], VehicleInfo[i][cID]);
			VehicleInfo[i][vID] = VehicleInfo[TOTAL_VEHICLES][vID];
			VehicleInfo[i][cID] = VehicleInfo[TOTAL_VEHICLES][cID];
			VehicleInfo[i][vModel] = VehicleInfo[TOTAL_VEHICLES][vModel];
			VehicleInfo[i][vPosX] = VehicleInfo[TOTAL_VEHICLES][vPosX];
			VehicleInfo[i][vPosY] = VehicleInfo[TOTAL_VEHICLES][vPosY];
			VehicleInfo[i][vPosZ] = VehicleInfo[TOTAL_VEHICLES][vPosZ];
			VehicleInfo[i][vPosA] = VehicleInfo[TOTAL_VEHICLES][vPosA];
			VehicleInfo[i][vColor1] = VehicleInfo[TOTAL_VEHICLES][vColor1];
			VehicleInfo[i][vColor2] = VehicleInfo[TOTAL_VEHICLES][vColor2];
			VehicleInfo[i][vRespTime] = VehicleInfo[TOTAL_VEHICLES][vRespTime];
			return Send(playerid, COLOR_YELLOW, "* Машина была удалена!");
		}
	}

	return 1;
}

CMD:changehc(playerid, params[]) {
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GRAD1, "* Недостаточно прав!");
	if(sscanf(params, "iiii", params[0], params[1], params[2], params[3])) return Send(playerid, COLOR_GREY, "Введите: /changehc [houseid] [model] [vColor1] [vColor2]");
	if(!IsValidHouse(params[0])) return Send(playerid, COLOR_GREY, "* Неверный ID дома!");
	if(params[1] < 400 || params[1] > 611) return Send(playerid, COLOR_GREY, "* Неверный ID моднли!");
	if(params[2] < 0 || params[2] > 126) return Send(playerid, COLOR_GREY, "* ID цвета не может быть ниже 0 или выше 126!");
	if(params[3] < 0 || params[3] > 126) return Send(playerid, COLOR_GREY, "* ID цвета не может быть ниже 0 или выше 126 !");
	if(HouseInfo[params[0]][hvModel] >= 400 && HouseInfo[params[0]][hvModel] <= 611) ResetTuning(HouseInfo[params[0]][hAuto], 1, params[0]);
	AutoInfo[0][aMileage] = AutoInfo[HouseInfo[params[0]][hAuto]][aMileage];
	GetPlayerPos(playerid, HouseInfo[params[0]][hvSpawn][0], HouseInfo[params[0]][hvSpawn][1], HouseInfo[params[0]][hvSpawn][2]);
	GetPlayerFacingAngle(playerid, HouseInfo[params[0]][hvSpawn][3]);
	Veh::Destroy(HouseInfo[params[0]][hAuto]);
	HouseInfo[params[0]][hvModel] = params[1];
	HouseInfo[params[0]][hvColor][0] = params[2];
	HouseInfo[params[0]][hvColor][0] = params[3];
	HouseInfo[params[0]][hAuto] = Veh::Create(HouseInfo[params[0]][hvModel],
	HouseInfo[params[0]][hvSpawn][0], HouseInfo[params[0]][hvSpawn][1],
	HouseInfo[params[0]][hvSpawn][2], HouseInfo[params[0]][hvSpawn][3],
	HouseInfo[params[0]][hvColor][0], HouseInfo[params[0]][hvColor][1], 18000);
	AutoInfo[HouseInfo[params[0]][hAuto]][aMileage] = AutoInfo[0][aMileage];
	SetVehicleNumber(HouseInfo[params[0]][hAuto]);
	Rac::PutPlayerInVehicle(playerid, HouseInfo[params[0]][hAuto], 0);
	ToggleVehicleDoor(HouseInfo[params[0]][hAuto], false);
	UpdateHouse(params[0]);
	return Send(playerid, COLOR_YELLOW, "* Машина была создана!");
}

CMD:destroyhc(playerid, params[]) {
	if(!Pl::isLogged(playerid)) return Send(playerid, COLOR_GREY, "* Вы не авторизованы!");
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GRAD1, "* Недостаточно прав!");
	if(sscanf(params, "i", params[0])) return Send(playerid, COLOR_GREY, "Введите: /destroyhc [houseid]");
	if(!IsValidHouse(params[0])) return Send(playerid, COLOR_GREY, "* Неверный ID дома!");
	if(HouseInfo[params[0]][hvModel] < 400 || HouseInfo[params[0]][hvModel] > 611) return Send(playerid, COLOR_GREY, "* У этого дома нет машины!");
	AutoInfo[HouseInfo[params[0]][hAuto]][aMileage] = 0.0; HouseInfo[params[0]][hvModel] = 0;
	Veh::Destroy(HouseInfo[params[0]][hAuto]); UpdateHouse(params[0]);
	return Send(playerid, COLOR_YELLOW, "* Машина была удалена!");
}

CMD:apark(playerid, params[]) {
	if(!Pl::isLogged(playerid)) return Send(playerid, COLOR_GREY, "* Вы не авторизованы!");
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GRAD1, "* Недостаточно прав!");
	new veh = GetPlayerVehicleID(playerid);
	foreach(new i : Houses) {
		if(HouseInfo[i][hAuto] == veh) {
			AutoInfo[0][aMileage] = AutoInfo[HouseInfo[i][hAuto]][aMileage];
			GetVehiclePos(HouseInfo[i][hAuto], HouseInfo[i][hvSpawn][0], HouseInfo[i][hvSpawn][1], HouseInfo[i][hvSpawn][2]);
			GetVehicleZAngle(HouseInfo[i][hAuto], HouseInfo[i][hvSpawn][3]);
			Veh::Destroy(HouseInfo[i][hAuto]);
			HouseInfo[i][hAuto] = Veh::Create(HouseInfo[i][hvModel],
			HouseInfo[i][hvSpawn][0], HouseInfo[i][hvSpawn][1],
			HouseInfo[i][hvSpawn][2], HouseInfo[i][hvSpawn][3],
			HouseInfo[i][hvColor][0], HouseInfo[i][hvColor][1], 18000);
			AutoInfo[HouseInfo[i][hAuto]][aMileage] = AutoInfo[0][aMileage];
			SetVehicleNumber(HouseInfo[i][hAuto]);
			AddTuning(HouseInfo[i][hAuto]);
			Rac::PutPlayerInVehicle(playerid, HouseInfo[i][hAuto], 0);
			return Send(playerid, COLOR_YELLOW, "* Машина была припаркована в этом месте!");
		}
	}
	Send(playerid, COLOR_GREY, "* Это не домашная машина!");
	return 1;
}

CMD:antidmzone(playerid, params[]) { new string[144];
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(TOTAL_ANTIDM_ZONES >= sizeof AntiDmInfo) return Send(playerid, COLOR_GREY, "* Создано макс. кол-во зон!");
	if(sscanf(params, "f", distance)) return Send(playerid, COLOR_GREY, "Введите: /antidmzone [radius]");
	format(string, sizeof string, "INSERT INTO `"#__TableAntidmzones__"` (`coord`) VALUES ('0.0,0.0,0.0,%.4f')", params[0]);
	new Cache:result = Db::query(connDb, string, true);
	if(cache_affected_rows()) {
		new zone = TOTAL_ANTIDM_ZONES++;
		AntiDmInfo[zone][e_AntiDmZoneId] = cache_insert_id();
		AntiDmInfo[zone][e_AntiDmWorld] = GetPlayerVirtualWorld(playerid);
		AntiDmInfo[zone][e_AntiDmCoord][3] = distance;
		GetPlayerPos (
			playerid,
			AntiDmInfo[zone][e_AntiDmCoord][0],
			AntiDmInfo[zone][e_AntiDmCoord][1],
			AntiDmInfo[zone][e_AntiDmCoord][2]
		);
		AntiDmInfo[zone][e_AntiDmZone] = CreateDynamicSphere(
			AntiDmInfo[zone][e_AntiDmCoord][0],
			AntiDmInfo[zone][e_AntiDmCoord][1],
			AntiDmInfo[zone][e_AntiDmCoord][2],
			AntiDmInfo[zone][e_AntiDmCoord][3],
			AntiDmInfo[zone][e_AntiDmWorld]
		);
		updateAntiDmZone(zone);
		Send(playerid, -1, "* Анти-дм зона создана!");
	}
	cache_delete(result);
	return 1;
}

CMD:addpic(playerid, params[]) { new string[144];
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(Iter::Count(Portal) >= sizeof Ptl::Info) return Send(playerid, COLOR_GREY, "* Создано макс. кол-во пикапов!");	
	if(sscanf(params, "iI(-1)I(23)", params[0], params[1],params[2]))
		return Send(playerid, COLOR_GREY, "Введите: /addpickup [modelid] (optional [vw] [type])");

	format(string, sizeof string, "INSERT INTO `"#__TablePickups__"` (`models`) VALUES ('%i,0')", params[0]);
	new Cache:result = Db::query(connDb, string, true);
	if(cache_affected_rows()) {
		if(params[1] == -1) params[1] = GetPlayerVirtualWorld(playerid);
		
		new i = Iter::Count(Portal);
		Iter::Add(Portal, i);
		Ptl::Info[i][Ptl::Id] = cache_insert_id();
		Ptl::Info[i][Ptl::Type][0] = params[2];
		Ptl::Info[i][Ptl::Model][0] = params[0];
		Ptl::Info[i][Ptl::Inter][0] = GetPlayerInterior(playerid);
		Ptl::Info[i][Ptl::World][0] = params[1];
		GetPlayerPos(
			playerid,
			Ptl::Info[i][Ptl::Portal1][0],
			Ptl::Info[i][Ptl::Portal1][1],
			Ptl::Info[i][Ptl::Portal1][2]
		);
		if(params[2] == 14) GetVehicleZAngle(GetPlayerVehicleID(playerid), Ptl::Info[i][Ptl::Portal1][3]);
		else GetPlayerFacingAngle(playerid, Ptl::Info[i][Ptl::Portal1][3]);
		Ptl::Info[i][Ptl::Pickup][0]=_AddPickup(Ptl::Info[i][Ptl::Model][0],Ptl::Info[i][Ptl::Type][0],Ptl::Info[i][Ptl::Portal1],Ptl::Info[i][Ptl::World][0]);
		updatePickup(i);
		Send(playerid, -1, "* Пикап входа создан!");
	}
	cache_delete(result);
	return 1;
}

CMD:setpic1(playerid, params[]) {
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	new teleport = GetPVarInt(playerid, "selectTeleport");
	if(teleport == INVALID_ID) return Send(playerid, COLOR_GREY, "* Вы не выбрали портал!");
	if(sscanf(params, "iI(-1)I(23)", params[0], params[1],params[2]))
		return Send(playerid, COLOR_GREY, "Введите: /setpic1 [modelid]");
		
	if( params[1] == -1 ) params[1] = GetPlayerVirtualWorld(playerid);
	Ptl::Info[teleport][Ptl::Type][0] = params[2];
	Ptl::Info[teleport][Ptl::Model][0] = params[0];
	Ptl::Info[teleport][Ptl::Inter][0] = GetPlayerInterior(playerid);
	Ptl::Info[teleport][Ptl::World][0] = params[1];
	GetPlayerPos(
		playerid,
		Ptl::Info[teleport][Ptl::Portal1][0],
		Ptl::Info[teleport][Ptl::Portal1][1],
		Ptl::Info[teleport][Ptl::Portal1][2]
	);
	if(params[2] == 14) GetVehicleZAngle(GetPlayerVehicleID(playerid), Ptl::Info[teleport][Ptl::Portal1][3]);
	else GetPlayerFacingAngle(playerid, Ptl::Info[teleport][Ptl::Portal1][3]);
	DestroyDynamicPickup(Ptl::Info[teleport][Ptl::Pickup][0]);
	Ptl::Info[teleport][Ptl::Pickup][0]=_AddPickup(Ptl::Info[teleport][Ptl::Model][0],Ptl::Info[teleport][Ptl::Type][0],Ptl::Info[teleport][Ptl::Portal1],Ptl::Info[teleport][Ptl::World][0]);
	updatePickup(teleport);
	Rac::SetPlayerVirtualWorld(playerid,params[1]);
	SetPVarInt(playerid, "selectTeleport", INVALID_ID);
	Send(playerid, COLOR_GREY, "Позиция пикапа изменина!");

	return 1;
}

CMD:setpic2(playerid, params[]) {
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	new teleport = GetPVarInt(playerid, "selectTeleport");
	if(teleport == INVALID_ID) return Send(playerid, COLOR_GREY, "* Вы не выбрали портал!");
	if(sscanf(params, "iI(-1)I(23)", params[0], params[1],params[2]))
		return Send(playerid, COLOR_GREY, "Введите: /setpic2 [modelid]");
	
	if( params[1] == -1 ) params[1] = GetPlayerVirtualWorld(playerid);
	Ptl::Info[teleport][Ptl::Type][1] = params[2];
	Ptl::Info[teleport][Ptl::Model][1] = params[0];
	Ptl::Info[teleport][Ptl::Inter][1] = GetPlayerInterior(playerid);
	Ptl::Info[teleport][Ptl::World][1] = params[1];
	GetPlayerPos
	(
		playerid,
		Ptl::Info[teleport][Ptl::Portal2][0],
		Ptl::Info[teleport][Ptl::Portal2][1],
		Ptl::Info[teleport][Ptl::Portal2][2]
	);
	if(params[2] == 14) GetVehicleZAngle(GetPlayerVehicleID(playerid), Ptl::Info[teleport][Ptl::Portal2][3]);
	else GetPlayerFacingAngle(playerid, Ptl::Info[teleport][Ptl::Portal2][3]);
	DestroyDynamicPickup(Ptl::Info[teleport][Ptl::Pickup][1]);
	Ptl::Info[teleport][Ptl::Pickup][1]=_AddPickup(Ptl::Info[teleport][Ptl::Model][1],Ptl::Info[teleport][Ptl::Type][1],Ptl::Info[teleport][Ptl::Portal2],Ptl::Info[teleport][Ptl::World][1]);
	updatePickup(teleport);
	Rac::SetPlayerVirtualWorld(playerid,params[1]);
	SetPVarInt(playerid, "selectTeleport", INVALID_ID);
	Send(playerid, COLOR_GREY, "Позиция пикапа изменина!");

	return 1;
}

CMD:editmode(playerid, params[]) { new string[144];
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	EditMode{playerid} = !EditMode{playerid};
	SetPVarInt(playerid, "selectTeleport", INVALID_ID);
	format(string, sizeof string, "Режим редактирования: %s", (EditMode{playerid})?("{00cc00}Вкл."):("{ff0000}Выкл."));
	Send(playerid, -1, string);
	return 1;
}

CMD:addfc(playerid, params[]) {
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(sscanf(params, "i", params[0])) return Send(playerid, COLOR_GREY, "Use: /addfc [fracid]");
	if(params[0] < 1 || params[0] > 20) return Send(playerid, COLOR_GREY, "* Неверный ID фракции!");
	if(Fc::TOTAL >= MAX_FC) return Send(playerid, COLOR_GREY, "* Создано макс. кол-во транспорта!");
	Fc::ShowModel(playerid, params[0], D_ADD_FC);
	return 1;
}

CMD:delfc(playerid, params[]) {
	new vehid = GetPlayerVehicleID(playerid), idx, fracid;
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(!IsPlayerInAnyVehicle(playerid)) return Send(playerid, COLOR_GREY, "* Нужно быть в автомобиле!");
	if(!Fc::GetInfo(vehid, "if", idx, fracid)) return Send(playerid, COLOR_GREY, "* Это не фракционная машина!");
	Iter::Remove(TeamVehicles[fracid], vehid);
	Fc::Delete(idx);
	Send(playerid, COLOR_YELLOW, "* Машина была удалена!");
	return 1;
}

CMD:showmodel(playerid, params[]) {
	if(!Pl::isAdmin(playerid, SUPERMODER)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(sscanf(params, "i", params[0])) return Send(playerid, COLOR_GREY, "Use: /showmodel [fracid]");
	if(params[0] < 1 || params[0] > 20) return Send(playerid, COLOR_GREY, "* Неверный ID фракции!");
	Fc::ShowModel(playerid, params[0], D_SHOW_MODEL);
	return 1;
}

CMD:addrefill(playerid, params[]) {
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(Iter::Count(Refills) >= sizeof RefillInfo) return Send(playerid, COLOR_GREY, "* Создано максимальное количество заправок!");
	if(sscanf(params, "i", params[0])) return Send(playerid, COLOR_GREY, "Ведите: /addrefill [bizid]");
	if(GetIndexFromBizID(params[0]) == -1) return Send(playerid, COLOR_GREY, "* Введен не верный ID бизнеса!");
	
	new i = Iter::Count(Refills);
	Iter::Add(Refills, i);
	
	GetPlayerPos(playerid, RefillInfo[i][brPos][0], RefillInfo[i][brPos][1], RefillInfo[i][brPos][2]);
	RefillInfo[i][brBizID] = params[0];
	RefillInfo[i][brPickup] = AddPickup(1650, 14, RefillInfo[i][brPos][0], RefillInfo[i][brPos][1], RefillInfo[i][brPos][2], 0);
	
	format(query, sizeof query, "INSERT INTO `"#__TableRefills__"` (`biz`, `pos`) VALUES (%i,'%.3f,%.3f,%.3f')", params[0], RefillInfo[i][brPos][0], RefillInfo[i][brPos][1], RefillInfo[i][brPos][2]);
	new Cache:result = Db::query(connDb, query, true);
	if(cache_affected_rows()) {
		RefillInfo[i][brID] = cache_insert_id();
		Send(playerid, COLOR_GREY, "* Заправка была добавлена!");
	}
	cache_delete(result);
	return 1;
}

CMD:addbiz(playerid, params[]) {
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(sscanf(params, "ii", params[0], params[1])) {
		Send(playerid, COLOR_FADE1, "Ведите: /addbiz [lvl] [type]");
		Send(playerid, COLOR_FADE2, "Типы бизнесов:");
		Send(playerid, COLOR_FADE3, "0 - обычный, 1 - аммунация");
		Send(playerid, COLOR_FADE4, "2 - бургершот, 3 - пиццирия");
		Send(playerid, COLOR_FADE5, "4 - чикен, 5 - 24/7");
		return 1;
	}
	if(Iter::Count(Biznes) >= MAX_BIZNES) return Send(playerid, COLOR_GREY, "* Создано максимальное количество бизнесов!");
	new Float:x, Float:y, Float:z, Float:a;
	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, a);
	format(query, sizeof query, "INSERT INTO `"#__TableBusines__"` (`enter`) VALUES ('%.3f,%.3f,%.3f,%.3f')", x, y, z, a);
	new Cache:result = Db::query(connDb, query, true);
	if(cache_affected_rows()) {
		new b = Iter::Count(Biznes);
		Iter::Add(Biznes, b);
		switch(params[1]) {
			case 1..5 : {
				BizzInfo[b][bInterior] = DefaultBiz[params[1]][bInterior];
				CopyArray(BizzInfo[b][bIcon], DefaultBiz[params[1]][bIcon], 2);
				CopyArray(BizzInfo[b][bExit], DefaultBiz[params[1]][bExit], 4);
			}
			default : {
				BizzInfo[b][bInterior] = DefaultBiz[0][bInterior];
				CopyArray(BizzInfo[b][bIcon], DefaultBiz[0][bIcon], 2);
				CopyArray(BizzInfo[b][bExit], DefaultBiz[0][bExit], 4);
			}
		}
		BizzInfo[b][bID] = cache_insert_id();
		BizzInfo[b][bOwned] = 0;
		strmid(BizzInfo[b][bOwner], "The State", 0, strlen("The State"), 24);
		strmid(BizzInfo[b][bDescription], "biznes", 0, strlen("biznes"), 24);
		strmid(BizzInfo[b][bExtortion], "No-one", 0, strlen("No-one"), 24);
		BizzInfo[b][bEnter][0] = x;
		BizzInfo[b][bEnter][1] = y;
		BizzInfo[b][bEnter][2] = z;
		BizzInfo[b][bEnter][3] = a;
		BizzInfo[b][bLevel] = params[0];
		BizzInfo[b][bPrice] = 500000;
		BizzInfo[b][bEnterCost] = 500;
		BizzInfo[b][bSafe] = 10000;
		BizzInfo[b][bLocked] = 1;
		BizzInfo[b][bProds] = 250;
		BizzInfo[b][bMaxProds] = 500;
		BizzInfo[b][bPriceProd] = 100;
		BizzInfo[b][bVirtual] = BizzInfo[b][bID];
		BizzInfo[b][bFrac] = Gangs[random(sizeof Gangs)];
		BizzInfo[b][bPickupEnter] = AddPickup(1272, 23, BizzInfo[b][bEnter][0], BizzInfo[b][bEnter][1], BizzInfo[b][bEnter][2]);
		BizzInfo[b][bPickupExit] = AddPickup(1318, 23, BizzInfo[b][bExit][0], BizzInfo[b][bExit][1], BizzInfo[b][bExit][2], BizzInfo[b][bVirtual]);
		BizzInfo[b][bMapIcon] = CreateDynamicMapIcon(BizzInfo[b][bEnter][0],BizzInfo[b][bEnter][1],BizzInfo[b][bEnter][2],52, 0, -1, -1, -1, 250.0);
		GetSquarePos(BizzInfo[b][bEnter][0], BizzInfo[b][bEnter][1], MAX_ZONE_SIZE, BizzInfo[b][bzMinX], BizzInfo[b][bzMinY], BizzInfo[b][bzMaxX], BizzInfo[b][bzMaxY]);
		BizzInfo[b][bZone] = Gz::Create(BizzInfo[b][bzMinX], BizzInfo[b][bzMinY], BizzInfo[b][bzMaxX], BizzInfo[b][bzMaxY]);
		Gz::ShowForAll(BizzInfo[b][bZone], GetFracColor(BizzInfo[b][bFrac]));
		UpdateBizz(b);
		Send(playerid, COLOR_GREY, "* Бизнес создан!");
	}
	cache_delete(result);
	return 1;
}

CMD:setname(playerid, params[]) { new string[144];
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_LIGHTRED2, "* Ники не меняем!");
	if(sscanf(params, "us[24]", params[0], params[1])) return Send(playerid, COLOR_GRAD1, "Введите: /setname [playerid] [newname]");
	if(!Pl::isLogged(params[0])) return Send(playerid, COLOR_GRAD1, "* Этот игрок не залогинен!");
	if(!regex_match_exid(params[1], ValidText)) return Send(playerid, COLOR_GRAD1, "* Недопустимый ник!");
	if(NameChange{params[0]}) return Send(playerid, COLOR_GREY, "* Этому игроку уже изменили ник!");
	if(Pl::Info[params[0]][pAdmin] > Pl::Info[playerid][pAdmin]) return Send(playerid, COLOR_LIGHTRED, "Введите: Вы не можете изминить имя админу который старше вас!");
	format(string, sizeof string, "SELECT * FROM `"#__TableUsers__"` WHERE BINARY `Name`='%s'", params[1]);
	new Cache:result = Db::query(connDb, string, true);
	if(cache_num_rows()) {
		Send(playerid,COLOR_GREY,"* Такое имя уже есть на сервере!");
	} else {
		SetPVarString(params[0], "NewName", params[1]);
		NameChange{params[0]} = 5;
		Send(params[0],COLOR_LIGHTBLUE,"Админ сменил вам ник. В течении пяти секунд изменения вступят в силу");
		Send(playerid,COLOR_LIGHTBLUE,"Вы сменили ник игроку. В течении пяти секунд изменения всупят в силу");
	}
	cache_delete(result);
	return 1;
}

CMD:setskin(playerid, params[]) {
	if(!Pl::isAdmin(playerid, SUPERMODER)) return Send(playerid, COLOR_GRAD1, "* Недостаточно прав!");
	if(sscanf(params, "ud", params[0], params[1])) return Send(playerid, COLOR_GRAD1, "Используйте: /setskin [ид игрока/часть ника] [ид скина]");
	if(params[1] < 0 || params[1] > 299) return Send(playerid, COLOR_GRAD1, "* Последний скин 299, не больше.");
	Pl::Info[params[0]][pChar] = params[1]; SetPlayerSkin(params[0], Pl::Info[params[0]][pChar]);
	return 1;
}

CMD:givepas(playerid, params[]) { new string[144], sendername[24], playername[24];
	if(!Pl::isAdmin(playerid, SUPERMODER)) return Send(playerid, COLOR_GRAD2, "* Недостачточно прав!");
	if(sscanf(params, "ui", params[0], params[1])) return Send(playerid, COLOR_GRAD2, "Введите: /givepas [id/Name] [days 5-60]");
	if(!Pl::isLogged(params[0])) return Send(playerid, COLOR_GRAD2, "* Этот игрок не залогинен!");
	if(params[1] < 5 || params[1] > 60) return Send(playerid, COLOR_GRAD2, "Введите: /givepasport [id/Name] [days 5-60]");
	
	new currtime = gettime();
	Pl::Info[params[0]][pPasport][0] = 1;
	Pl::Info[params[0]][pPasport][1] = currtime;
	Pl::Info[params[0]][pPasport][2] = ( (params[1] * 86400) + currtime );
	format(string, sizeof string, "* Вам был выдан паспорт. Чтобы посмотреть его введите: /pasport");
	Send(params[0], COLOR_YELLOW, string);
	
	getname(playerid -> sendername, params[0] -> playername);
	format(string, sizeof string, "[AdmWarn] * %s выдал паспорт игроку %s[%i] на %i дней!", sendername, playername, playerid, params[1]);
	SendToAdmin(COLOR_YELLOW, string, 1, 3);
	
	return 1;
}

CMD:takepas(playerid, params[]) { new string[144], sendername[24], playername[24];
	if(!Pl::isAdmin(playerid, SUPERMODER)) return Send(playerid, COLOR_GRAD2, "* Недостачточно прав!");
	if(sscanf(params, "u", params[0])) return Send(playerid, COLOR_GRAD2, "Введите: /takepas [id/Name]");
	if(!Pl::isLogged(params[0])) return Send(playerid, COLOR_GRAD2, "* Этот игрок не залогинен!");
	if(!Pl::Info[params[0]][pPasport][0]) return Send(playerid, COLOR_GRAD2, "* У этого инрока нет паспорта!");
	for(new i; i < 3; i++) Pl::Info[params[0]][pPasport][i] = 0;
	
	getname(playerid -> sendername, params[0] -> playername);
	format(string, sizeof string, "* Администратор %s забрал ваш паспорт!", sendername);
	Send(params[0], COLOR_YELLOW, string);
	format(string, sizeof string, "[AdmWarn] * %s забрал паспорт у игрока %s[%i]", sendername, playername, playerid);
	SendToAdmin(COLOR_YELLOW, string, 1, 3);
	return 1;
}

CMD:agl(playerid, params[]) { new string[144], sendername[24], playername[24];
	if(!Pl::isAdmin(playerid, MODER1LVL)) return Send(playerid, COLOR_GRAD2, "* Недостачточно прав!");
	if(sscanf(params, "s[15]u", params[1], params[0])) {
		Send(playerid, COLOR_WHITE, "Введите: /agl [лицензия] [id/Name]");
		Send(playerid, COLOR_WHITE, "* Доступные лицензии: Driving, Pilots, Sailing, Weapon.");
		return 1;
	}
	if(!Pl::isLogged(params[0])) return Send(playerid, COLOR_GRAD2, "* Этот игрок не залогинен!");
	getname(playerid -> sendername, params[0] -> playername);
	
	if(strcmp(params[1], "all", true) == 0) {
		AshQueue(playerid, 1);
		Pl::Info[params[0]][pTest] = 0;
		Pl::Info[params[0]][pLic][0] = 1;
		Pl::Info[params[0]][pLic][1] = 1;
		Pl::Info[params[0]][pLic][3] = 1;
		Pl::Info[params[0]][pLic][2] = 1;
		
		format(string, sizeof string, "[AdmWarn] * %s применил команду /agl к игроку %s[%s]. Тип: %s",
		sendername, playername, FracInfo[Pl::FracID(params[0])][fName], params[1]);
		SendToAdmin(COLOR_YELLOW, string, 1, 3);
		format(string, sizeof string, "* Администратор %s дал вам все лицензии.", sendername);
		Send(params[0], COLOR_LIGHTBLUE, string);
	
	} else if(strcmp(params[1], "driving",true) == 0) {
		AshQueue(playerid, 1);
		
		Pl::Info[params[0]][pTest] = 0;
		Pl::Info[params[0]][pLic][0] = 1;
		
		format(string, sizeof string, "[AdmWarn] * %s применил команду /agl к игроку %s[%s]. Тип: %s",
		sendername, playername, FracInfo[Pl::FracID(params[0])][fName], params[1]);
		SendToAdmin(COLOR_YELLOW, string, 1, 3);
		format(string, sizeof string, "* Администратор %s Дал вам лицензию на вождение.", sendername);
		Send(params[1], COLOR_LIGHTBLUE, string);
	
	} else if(strcmp(params[1],"pilots",true) == 0) {
		Pl::Info[params[0]][pLic][1] = 1;
		format(string, sizeof string, "[AdmWarn] * %s применил команду /agl к игроку %s[%s]. Тип: %s",
		sendername, playername, FracInfo[Pl::FracID(params[0])][fName], params[1]);
		SendToAdmin(COLOR_YELLOW, string, 1, 3);
		format(string, sizeof string, "* Администратор %s Дал вам лицензию на управление воздушным транспортом.", sendername);
		Send(params[0], COLOR_LIGHTBLUE, string);
	
	} else if(strcmp(params[1],"sailing",true) == 0) {
		Pl::Info[params[1]][pLic][2] = 1;
		format(string, sizeof string, "[AdmWarn] * %s применил команду /agl к игроку %s[%s]. Тип: %s",
		sendername, playername, FracInfo[Pl::FracID(params[0])][fName], params[1]);
		SendToAdmin(COLOR_YELLOW, string, 1, 3);
		format(string, sizeof string, "* Администратор %s Дал вам лицензию на управление водным транспортом.", sendername);
		Send(params[0], COLOR_LIGHTBLUE, string);
	
	} else if(strcmp(params[1],"weapon",true) == 0) {
		Pl::Info[params[0]][pLic][3] = 1;
		format(string, sizeof string, "[AdmWarn] * %s применил команду /agl к игроку %s[%s]. Тип: %s",
		sendername, playername, FracInfo[Pl::FracID(params[0])][fName], params[1]);
		SendToAdmin(COLOR_YELLOW, string, 1, 3);
		format(string, sizeof string, "* Администратор %s Дал вам лицензию на оружие.", sendername);
		Send(params[0], COLOR_LIGHTBLUE, string);
	}
	return 1;
}

CMD:atl(playerid, params[]) { new string[144], sendername[24], playername[24];
	if(!Pl::isAdmin(playerid, MODER2LVL)) return Send(playerid, COLOR_GRAD2, "* Недостачточно прав!");
	if(sscanf(params, "s[15]u", params[1], params[0])) {
		Send(playerid, COLOR_WHITE, "Введите: /atl [лицензия] [playerid]");
		Send(playerid, COLOR_WHITE, "* Доступные лицензии: Driving, Pilots, Sailing, Weapon.");
		return 1;
	}
	if(!Pl::isLogged(params[0])) return Send(playerid, COLOR_GRAD2, "* Этот игрок не залогинен!");
	
	getname(playerid -> sendername, params[0] -> playername);
	
	if(strcmp(params[1], "all", true) == 0) {
		Pl::Info[params[0]][pLic][0] = 0;
		Pl::Info[params[0]][pLic][1] = 0;
		Pl::Info[params[0]][pLic][3] = 0;
		Pl::Info[params[0]][pLic][2] = 0;
		format(string, sizeof string, "[AdmWarn] * %s применил команду /atl к игроку %s[%s]. Тип: %s",
		sendername, playername, FracInfo[Pl::FracID(params[0])][fName], params[1]);
		SendToAdmin(COLOR_YELLOW, string, 1, 3);
		format(string, sizeof string, "* Администратор %s забрал у Вас все лицензии.", sendername);
		Send(params[0], COLOR_LIGHTBLUE, string);
	
	} else if(strcmp(params[1], "driving",true) == 0) {
		Pl::Info[params[0]][pLic][0] = 0;
		format(string, sizeof string, "[AdmWarn] * %s применил команду /atl к игроку %s[%s]. Тип: %s",
		sendername, playername, FracInfo[Pl::FracID(params[0])][fName], params[1]);
		SendToAdmin(COLOR_YELLOW, string, 1, 3);
		format(string, sizeof string, "* Администратор %s забрал у вас лицензию на вождение.", sendername);
		Send(params[0], COLOR_LIGHTBLUE, string);
	
	} else if(strcmp(params[1], "pilots",true) == 0) {
		Pl::Info[params[0]][pLic][1] = 0;
		format(string, sizeof string, "[AdmWarn] * %s применил команду /atl к игроку %s[%s]. Тип: %s",
		sendername, playername, FracInfo[Pl::FracID(params[0])][fName], params[1]);
		SendToAdmin(COLOR_YELLOW, string, 1, 3);
		format(string, sizeof string, "* Администратор %s забрал у вас лицензию на управление воздушным транспортом.", sendername);
		Send(params[0], COLOR_LIGHTBLUE, string);
	
	} else if(strcmp(temp,"sailing",true) == 0) {
		Pl::Info[params[0]][pLic][2] = 0;
		format(string, sizeof string, "[AdmWarn] * %s применил команду /atl к игроку %s[%s]. Тип: %s",
		sendername, playername, FracInfo[Pl::FracID(params[0])][fName], temp);
		SendToAdmin(COLOR_YELLOW, string, 1, 3);
		format(string, sizeof string, "* Администратор %s забрал у вас лицензию на управление водным транспортом.", sendername);
		Send(params[1], COLOR_LIGHTBLUE, string);
	
	} else if(strcmp(temp, "weapon",true) == 0) {
		Pl::Info[params[0]][pLic][3] = 0;
		format(string, sizeof string, "[AdmWarn] * %s применил команду /atl к игроку %s[%s]. Тип: %s",
		sendername, playername, FracInfo[Pl::FracID(params[0])][fName], temp);
		SendToAdmin(COLOR_YELLOW, string, 1, 3);
		format(string, sizeof string, "* Администратор %s забрал у вас лицензию на оружие.", sendername);
		Send(params[0], COLOR_LIGHTBLUE, string);
	}
	return 1;
}

CMD:skydive(playerid, params[]) {
	if(!Pl::isAdmin(playerid, MODER2LVL)) return Send(playerid, COLOR_GRAD1, "* Недостаточно прав!");
	if(GetPlayerInterior(playerid) > 0) return Send(playerid, COLOR_GREY, "*  Вы не можете прыгать с парашютом в помещении!");
	GetPlayerPos(playerid, posx, posy, posz);
	Rac::SetPlayerPos(playerid, posx, posy, posz+1000);
	Rac::GivePlayerWeapon(playerid, 46, 1);
	return 1;
}

CMD:check(playerid, params[]) {
	if(!Pl::isAdmin(playerid, MODER1LVL)) return Send(playerid, COLOR_GRAD1, "* Недостаточно прав!");
	if(sscanf(params, "u", params[0])) return Send(playerid, COLOR_GREY, "Введите: /check [id]");
	if(!Pl::isLogged(params[0])) return Send(playerid, COLOR_GREY, "* Этот игрок не авторизован!");
	if(Pl::isAdmin(params[0], ADMINISTRATOR) && !Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_RED, "* Вы не может выполнить это действие!");
	return ShowStats(playerid, params[0], 1);
}

CMD:checkw(playerid, params[]) { new string[144];
	if(!Pl::isAdmin(playerid, MODER1LVL)) return Send(playerid, COLOR_GRAD1, "* Недостаточно прав!");
	if(sscanf(params, "u", params[0])) return Send(playerid, COLOR_GREY, "Введите: /checkw [id/Name]");
	if(!Pl::isLogged(playerid)) return Send(playerid, COLOR_RED, "* Этот игрок не залогинен!");
	new isw, weapon, ammo, wname[24]; dialog[0]='\0';
	for(new i; i < 13; i++) {
		GetPlayerWeaponData(params[0], i, weapon, ammo);
		if(weapon != 0 && ammo != 0) {
			isw ++;
			GetWeaponName(weapon, wname, 24);
			if(Rac::GetPlayerAmmo(params[0], weapon) < ammo && !Rac::IsGreenWeapon(weapon)) {
				scf(dialog, string, ""#_GREY_ARROW"%s[ID: %i] | Патроны: %d\n", wname, weapon, ammo);
			} else {
				scf(dialog, string, ""#_GREY_ARROW"%s[ID: %i] | Патроны: %d\n", wname, weapon, ammo);
			}
		}
	}
	format(string, sizeof string, "%s имеет следующие оружие:", GetName(params[0]));
	if(isw > 0) SPD(playerid, D_NONE, DIALOG_STYLE_LIST, string, dialog, "OK", "");
	else SPD(playerid, D_NONE, 0, string, "У этого игрока нет оружия!", "OK", "");

	return 1;
}

CMD:savetun(playerid, params[]) {
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(GetPlayerState(playerid) != 2) return Send(playerid, COLOR_GREY,"* Вы должны сидеть в машине!");
	if(sscanf(params, "s[10]", params[0])) return Send(playerid, COLOR_GREY,"/savetun [name]");
	new vehid = GetPlayerVehicleID(playerid);
	if(strcmp(params[0], "house", true) == 0) {
		foreach(new i : Houses) {
			if(HouseInfo[i][hAuto] == vehid) {
				UpdateTuning(HouseInfo[i][hAuto], 1, i);
				return Send ( playerid, COLOR_YELLOW, "* Тюниг домашней машины был сохранен!");
			}
		}
	
	} else if(strcmp(params[0], "veh", true) == 0) {
		for(new i; i < TOTAL_VEHICLES; i++) {
			if(VehicleInfo[i][cID] == vehid) {
				UpdateTuning(VehicleInfo[i][cID], 2, VehicleInfo[i][vID]);
				return Send ( playerid, COLOR_YELLOW, "* Тюниг машины был сохранен!");
			}
		}
	}
	return Send(playerid, COLOR_YELLOW, "* Ошибка, у этой машины нельзя сохранить тюнинг!");
}

CMD:deltun(playerid, params[]) {
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(GetPlayerState(playerid) != 2) return Send(playerid, COLOR_GREY,"* Вы должны сидеть в машине!");
	if(sscanf(params, "s[10]", params[0])) return Send(playerid, COLOR_GREY,"/deltun [name]");
	new vehid = GetPlayerVehicleID(playerid);
	if(strcmp(params[0], "house", true) == 0) {
		foreach(new i : Houses) {
			if(HouseInfo[i][hAuto] == vehid) {
				ResetTuning(HouseInfo[i][hAuto], 1, i);
				return Send ( playerid, COLOR_YELLOW, "* Тюниг домашней машины был удален!");
			}
		}
	}
	else if(strcmp(params[0], "veh", true) == 0) {
		for(new i; i < TOTAL_VEHICLES; i++) {
			if(VehicleInfo[i][cID] == vehid) {
				ResetTuning(VehicleInfo[i][cID], 2, VehicleInfo[i][vID]);
				return Send ( playerid, COLOR_YELLOW, "* Тюниг машины был удален!");
			}
		}
	}
	return Send(playerid, COLOR_YELLOW, "* Ошибка, у этой машины нельзя удалить тюнинг!");
}

CMD:asetpass(playerid, params[]) { new string[144], uname[24], ukey[36], uhash[SHA2_HASH_LEN];
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(sscanf(params, "s[24]s[36]", uname, ukey)) return Send(playerid, COLOR_GREY, "Введите: /asetpass [name] [password]");
	new pid=ReturnUser(uname);
	if(Pl::isLogged(pid)) {
		SHA256_PassHash(ukey, Db::Conf[Db::KeySult], uhash, SHA2_HASH_LEN);
		format(query, sizeof query, "UPDATE `"#__TableUsers__"` SET `Key`='%s' WHERE `ID`='%i'", uhash, Pl::Info[pid][pID]);
		Db::tquery(connDb, query, "", "");
	
		format(string, sizeof string, "* Вы изменили пароль %s, новый пароль; %s", uname, ukey);
		Send(playerid, COLOR_LIGHTRED, string);
		format(string, sizeof string, "* Администратор %s изменили ваш пароль, новый пароль %s", GetName(playerid), ukey);
		Send(pid, COLOR_LIGHTRED, string);
		Send(playerid, COLOR_LIGHTRED,"* ОБЯЗАТЕЛЬНО сделайте скриншот с новым паролем, для этого нажмите F8");
		
		format(string, sizeof string, "[AdmWarn] * %s изменил пароль %s[uid:%i]", GetName(playerid), uname, Pl::Info[pid][pID]);
		SendLog(LOG_ADMWARN, string);
	} else {
		new uid = GetIDFromName(uname);
		if(uid == -1) return Send(playerid, COLOR_GREY, "* Нет такого юзера!");
		SHA256_PassHash(ukey, Db::Conf[Db::KeySult], uhash, SHA2_HASH_LEN);
		format(query, sizeof query, "UPDATE `"#__TableUsers__"` SET `Key`='%s' WHERE `ID`='%i'", uhash, uid);
		Db::tquery(connDb, query, "", "");
		
		format(string, sizeof string, "* Вы изменили пароль %s, новый пароль %s", uname, ukey);
		Send(playerid, COLOR_LIGHTRED, string);
		
		format(string, sizeof string, "[AdmWarn] * %s изменил пароль %s[uid:%i]", GetName(playerid), uname, uid);
		SendLog(LOG_ADMWARN, string);
	}
	return 1;
}

CMD:setage(playerid, params[]) {
	if(!Pl::isAdmin(playerid, MODER2LVL)) return Send(playerid,COLOR_GREY,"* Недостаточно прав!");
	if(sscanf(params, "ud", params[0], params[1])) return Send(playerid, COLOR_GREY, "Введите: /setage [id] [возраст]");
	if(!Pl::isLogged(params[0])) return Send(playerid, COLOR_GREY, "* Этот игрок не авторизован!");
	Pl::Info[params[0]][pAge] = params[1];
	return 1;
}

CMD:noooc(playerid, params[]) { new string[144];
	if(!Pl::isAdmin(playerid, MODER3LVL)) return Send(playerid, COLOR_GRAD1, "* Недостаточно прав!");
	noooc = !noooc;
	format(string, sizeof string, "** OOC чат %s администратором.", (noooc)?("выключен"):("включен"));
	SendToAll(COLOR_GREY, string);
	return 1;
}

CMD:bigears(playerid, params[]) { new string[144];
	if(!Pl::isAdmin(playerid, MODER3LVL)) return Send(playerid, COLOR_GRAD1, "* Недостаточно прав!");
	BigEar{playerid} = !BigEar{playerid};
	format(string, sizeof string, "* Ваши уши %s!", (BigEar{playerid})?("выросли"):("стали нормальными"));
	Send(playerid, COLOR_GREY, string);
	return 1;
}

CMD:togtp(playerid, params[]) { new string[144];
	if(!Pl::isAdmin(playerid, MODER1LVL)) return Send(playerid, COLOR_LIGHTRED2, "* Недостаточно прав!");
	TogTP{playerid} = !TogTP{playerid};
	format(string, sizeof string, "* Вы %s телепортироватся к себе!", (TogTP{playerid})?("разрешили"):("запретили"));
	Send(playerid, COLOR_LIGHTBLUE, string);
	return 1;
}

CMD:ao(playerid, params[]) { new string[144], sendername[24];
	if(IsPMuted(playerid)) return Send(playerid,COLOR_GREY,"* У Вас молчанка!");
	if(!Pl::isAdmin(playerid, SUPERMODER)) return Send(playerid, COLOR_GRAD2, "* OOC канал отключен админом!");
	if(isnull(params) || params[0] == ' ') return Send(playerid, COLOR_GREY, "Введите: /ao [текст]");
	GetPlayerName(playerid, sendername, 24);
	format(string, sizeof string, "[ADMIN] %s: %s " , sendername, params);
	OOCOff(COLOR_LIGHTGREEN,string);
	return 1;
}

CMD:ot(playerid, params[]) { new string[144], sendername[24], playername[24];
	if(!Pl::isAdmin(playerid, MODER1LVL)) return Send(playerid,COLOR_GREY,"* Недостаточно прав!");
	if(sscanf(params, "us[90]", params[0], params[1])) return Send(playerid, COLOR_GRAD2, "Введите: /ot [id] [ответ]");
	if(!Pl::isLogged(params[0])) return Send(playerid, COLOR_GREY, "* Этот игрок не авторизован!");
	getname(playerid->sendername,params[0]->playername);
	format(string, sizeof string, "*Ответ от %s: %s", sendername, params[1]);
	Send(params[0], COLOR_YELLOW, string);
	format(string, sizeof string, "*Ответ от %s > %s[%i]: %s", sendername, playername, params[0], params[1]);
	SendToAdmin(COLOR_LIGHTBLUE, string, 1, 2);
	return 1;
}

CMD:aduty(playerid, params[]) { new string[144], sendername[24];
	if(!Pl::Info[playerid][pAdmin]) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	AdminDuty{playerid} = !AdminDuty{playerid};
	GetPlayerName(playerid, sendername, 24);
	format(string, sizeof string, "(( [A] Админ %s %s ))", sendername, (AdminDuty{playerid})?("заступил на дежурство! (/report)"):("ушел с дежурства."));
	SendToAll(COLOR_OOC,string);
	return 1;
}

CMD:spawncars(playerid, params[]) { new string[144];
	if(!Pl::isAdmin(playerid, SUPERMODER)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	format(string, sizeof string, "* Администратор %s[%i] зареспавнил все автомобили.", GetName(playerid), playerid);
	RespawnUnoccupiedVehicles();
	SendToAll(COLOR_LIGHTRED, string);
	return 1;
}

CMD:restart(playerid, params[]) {
	if(Pl::Info[playerid][pAdmin] != 5 && !IsPlayerAdmin(playerid)) return 1;
	SendToAll(COLOR_LIGHTRED2,"* Администратор перезагрузил сервер!");
	GameModeInitExitFunc(0); return 1;
}

CMD:autorestart(playerid, params[]) {
	if(Pl::Info[playerid][pAdmin] != 5 && !IsPlayerAdmin(playerid)) return 1;
	SendToAll(COLOR_LIGHTRED2,"* Администратор перезагрузил сервер!");
	GameModeInitExitFunc(1); return 1;
}

CMD:updateprop(playerid, params[]) { new string[144];
	if(Pl::Info[playerid][pAdmin] != 5 && !IsPlayerAdmin(playerid)) return 1;
	new time=GetTickCount();
	UpdateProp();
	format(string, sizeof string, "* Property updated %i (ms)", GetTickCount()-time);
	Send(playerid, COLOR_LIGHTBLUE, string);
	return 1 ;
}

CMD:asellbiz(playerid, params[]) { new string[144];
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(sscanf(params, "d", params[0])) return Send(playerid, COLOR_GRAD1, "Введите: /asellbiz [bizid]");
	new bidx = GetIndexFromBizID(params[0]);
	ClearBiz(bidx);
	PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
	format(string, sizeof string, "~w~You have sold the ~g~Business");
	GameTextForPlayer(playerid, string, 10000, 3);
	format(string, sizeof string, "[Новости недвижимости] Бизнес %s был выставлен на продажу! Цена: $%i", BizzInfo[bidx][bDescription], BizzInfo[bidx][bPrice]);
	SendToAll(COLOR_NEWS, string);
	return 1;
}

CMD:asellhouse(playerid, params[]) { new string[144];
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(sscanf(params, "d", params[0])) return Send(playerid, COLOR_GREY, "Введите: /asellhouse");
	if(!IsValidHouse(params[0])) return Send(playerid, COLOR_GREY, "* Неверный ID дома!");
	ClearHouse(params[0]);
	PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
	format(string, sizeof string, "[Новости недвижимости] Был выставлен дом на продажу! Цена: $%d", HouseInfo[params[0]][hPrice]);
	SendToAll(COLOR_NEWS, string);
	format(string, sizeof string, "~w~You have sold this ~g~property", HouseInfo[params[0]][hPrice]);
	GameTextForPlayer(playerid, string, 10000, 3);
	UpdateHouse(params[0]);
	return 1;
}

CMD:asellhouseall(playerid, params[]) {
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	foreach(new i : Houses) {
		ClearHouse(i);
		UpdateHouse(i);
	}
	SendToAll(COLOR_NEWS, "[RP]GrandWorld: Все дома штата были выставлены на продажу!");
	return 1;
}

CMD:asellbizall(playerid, params[]) {
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return 1;
	foreach(new i : Biznes) {
		ClearBiz(i);
		UpdateBizz(i);
	}
	SendToAll(COLOR_NEWS, ""#__SERVER_PREFIX""#__SERVER_NAME_LC": Все бизнесы штата были выставлены на продажу!");
	return 1;
}

CMD:house(playerid, params[]) {
	if(!Pl::isAdmin(playerid, MODER3LVL)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(sscanf(params, "d", params[0])) return Send(playerid, COLOR_GREY, "Введите: /house [housenumber]");
	if(!IsValidHouse(params[0])) return Send(playerid, COLOR_GREY, "Invalid house id!");
	EnterHouse(playerid, params[0]);
	GameTextForPlayer(playerid, "~w~Teleporting", 5000, 1);
	Pl::Info[playerid][pLocal] = OFFSET_HOUSE + params[0];
	return 1;
}

CMD:houseo(playerid, params[]) {
	if(!Pl::isAdmin(playerid, MODER3LVL)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(sscanf(params, "d", params[0])) return Send(playerid, COLOR_GREY, "Используйте: /houseo [housenumber]");
	if(!IsValidHouse(params[0])) return Send(playerid, COLOR_GREY, "Invalid house id!");
	ExitHouse(playerid, params[0]);
	GameTextForPlayer(playerid, "~w~Teleporting", 5000, 1);
	return 1;
}

CMD:biz(playerid, params[]) {
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(sscanf(params, "i", params[0])) return Send(playerid, COLOR_GREY, "Введите: /biz [biznumber]");
	new bidx = GetIndexFromBizID(params[0]);
	if(!IsValidBiz(bidx)) return Send(playerid, COLOR_GREY, "* Нет такого бизнеса!");
	if(BizzInfo[bidx][bInterior] == -1) {
		ExitBiz(playerid, bidx);
	} else {
		EnterBiz(playerid, bidx);
	}
	GameTextForPlayer(playerid, "~w~Teleporting", 5000, 1);
	return 1;
}

CMD:edit(playerid, params[]) {
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	ShowDialog(playerid, D_EDIT, DIALOG_STYLE_INPUT, "EDIT", "dialog/edit.txt", "OK", "ОТМЕНА");
	return 1;
}

CMD:exit(playerid, params[]) {
	if(Pl::CarInt[playerid] != INVALID_VEHICLE_ID) {
		GetVehiclePos(Pl::CarInt[playerid], vehx, vehy, vehz);
		Rac::SetPlayerInterior(playerid, 0);
		Rac::SetPlayerVirtualWorld(playerid, 0);
		Rac::SetPlayerPos(playerid, vehx+5.0, vehy, vehz);
		Pl::CarInt[playerid] = INVALID_VEHICLE_ID;
	} else {
		new i = Pl::Info[playerid][pLocal] - OFFSET_HOUSE;
		if(IsValidHouse(i)) {
			if(IsPlayerInRangeOfPoint(playerid, 2.0, HouseInfo[i][hExit][0], HouseInfo[i][hExit][1], HouseInfo[i][hExit][2])
				&& HouseInfo[i][hVirtual] == GetPlayerVirtualWorld(playerid)) {
				SetPVarInt(playerid, "PlayerHouse", i);
				return SPD(playerid, D_EX_HOUSE, 0, "EXIT", "Вы хотите выйти?", "ДА", "НЕТ");
			}
		}
	}
	return 1;
}

CMD:home(playerid, params[]) {
	if(Pl::Info[playerid][pHouseKey] == INVALID_HOUSE_ID) {
		GameTextForPlayer(playerid, "~w~You are homeless", 5000, 1);
	} else {
		DestroyDynamicCP(checkpoints[playerid]);
		checkpoints[playerid] = CreateDynamicCP(HouseInfo[Pl::Info[playerid][pHouseKey]][hEnter][0], HouseInfo[Pl::Info[playerid][pHouseKey]][hEnter][1], HouseInfo[Pl::Info[playerid][pHouseKey]][hEnter][2], 4.0,-1,-1,playerid,99999.9);
		GameTextForPlayer(playerid, "~w~Waypoint set ~r~Home", 5000, 1);
		Pl::CheckpointStatus[playerid] = CHECKPOINT_HOME;
	}
	return 1;
}

CMD:bizinfo(playerid, params[]) {
	if(!Pl::isAdmin(playerid, MODER2LVL)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(sscanf(params, "d", params[0])) return Send(playerid, COLOR_GREY, "Введите: /bizinfo [bizid]");
	if(!IsValidBiz(params[0])) return Send(playerid, COLOR_GREY, "* Неверный ID бизнеса!");
	PrintBizInfo(playerid, params[0]);
	return 1;
}

CMD:houseinfo(playerid, params[]) {
	if(!Pl::isAdmin(playerid, MODER2LVL)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(sscanf(params, "i", params[0])) return Send(playerid, COLOR_GREY, "Введите: /houseinfo [houseid]");
	if(!IsValidHouse(params[0])) return Send(playerid, COLOR_GREY, "* Неверный ID дома!");
	PrintHouseInfo(playerid, params[0], 1);
	return 1;
}


CMD:bizname(playerid, params[]) { new string[144];
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GREY, "* Недастаточно прав!");
	if(sscanf(params, "is[24]", params[0], temp)) return Send(playerid, COLOR_GREY, "Введите: /bizname [biz] [name]");
	new i = GetIndexFromBizID(params[0]);
	strmid(BizzInfo[i][bDescription], temp, 0, strlen(temp), 24);
	format(string, sizeof string, "Названия бизнеса номер %d изменино на [%s]", BizzInfo[i][bID], BizzInfo[i][bDescription]);
	Send(playerid, COLOR_WHITE, string)
	;
	return 1;
}

CMD:mole(playerid, params[]) { new string[144];
	if(IsPMuted(playerid)) return Send(playerid, COLOR_GREY, "* У Вас молчанка!");
	if(!Pl::isAdmin(playerid, SUPERMODER)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(sscanf(params, "s[90]", params[0])) return Send(playerid, COLOR_GRAD1, "Введите: /mole [текст]");
	format(string, sizeof string, "*SMS: %s. Отправитель: "#__SERVER_PREFIX""#__SERVER_NAME_LC"", params[0]);
	SendToAll(COLOR_YELLOW, string);
	return 1;
}

CMD:id(playerid, params[]) { new string[144], playername[24];
	if(sscanf(params, "u", params[0])) return Send(playerid, COLOR_GREY, "Введите: /id [id/PartOfName]");
	if(!IsPlayerConnected(params[0])) return Send(playerid, COLOR_GREY, "* Этот игрок не подключекн!");
	GetPlayerName(params[0], playername, 24);
	switch(AFKInfo[params[0]][afk_State]) {
		case 0 : format(string, sizeof string, "ID: (%i) %s", params[0], playername);
		case 1 : format(string, sizeof string, "ID: (%i) %s {33CCFF}<PAUSE: %i sec.>", params[0], playername, AFKInfo[params[0]][afk_Time][0]);
	}
	Send(playerid, COLOR_GRAD1, string);
	return 1;
}


CMD:tv(playerid, params[]) { new string[144], playername[24];
	new hkey = Pl::Info[playerid][pHouseKey];
	if(sscanf(params, "s[24]", params[0])) return Send(playerid, COLOR_GREY, "Введите: /tv [id] (off - перестать смотреть тв)");
	if(strcmp("off", params[0], true) == 0) {
		if(WatchingTV{playerid}) {
			WatchingTV{playerid} = false;
			Pl::SpecInfo[playerid][pSpecID] = 999;
			Pt::Hide(playerid, Pt::Spec[playerid]);
			GameTextForPlayer(playerid, "~w~                TV~n~~r~                Off", 5000, 6);
			PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
		} else {
			Send(playerid, COLOR_GREY, "* Вы не смотрите TV.");
		}
	} else if(Pl::isAdmin(playerid, 1) || (Pl::Info[playerid][pLocal] == (OFFSET_HOUSE + hkey) && IsValidHouse(hkey))) {
		new specid = ReturnUser(params[0]);
		if(specid == playerid) return Send(playerid, COLOR_GREY, "* Вы не можете следить сами за собой!");
		if(!Pl::isLogged(specid)) return Send(playerid, COLOR_GREY, "* Игрок не авторизирован!");
		if(WatchingTV{specid}) return Send(playerid, COLOR_GREY, "* Этот игрок сам в ТВ!");
		if(!Pl::isAdmin(playerid, 1) && HouseInfo[hkey][hTv] != 1) return GameTextForPlayer(playerid, "~r~This upgrade isn't installed", 5000, 1);
		if(Pl::Info[specid][pAdmin] > 0 && !Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GREY, "* Этот канал не работает!");
		GetPlayerName(specid, playername, 24);
		if(!Pl::isAdmin(playerid, MODER1LVL)) Rac::TogglePlayerControllable(playerid, 0);
		Pl::SpecInfo[playerid][pSpecID] = specid;
		format(string, sizeof string, "[TV] Канал: (%i) %s", specid, playername);
		Send(playerid, COLOR_GREEN, string);
		SetPlayerColor(playerid, COLOR_ALPHA);

		Pl::SpecInfo[specid][pSpecVw]		[0] = GetPlayerVirtualWorld(specid);
		Pl::SpecInfo[specid][pSpecInt]		[0] = GetPlayerInterior(specid);
		Pl::SpecInfo[specid][pSpecState]	[0] = GetPlayerState(specid);
		
		Rac::TogglePlayerSpectating(playerid, true);
		switch(Pl::SpecInfo[specid][pSpecState][0]) {
			case 2, 3 : {
				PlayerSpectateVehicle(playerid, GetPlayerVehicleID(specid));
			}
			default : {
				PlayerSpectatePlayer(playerid, specid);
			}
		}
		Pt::Show(playerid, Pt::Spec[playerid]);
		Rac::SetPlayerInterior(playerid, Pl::SpecInfo[specid][pSpecInt][0]);
		Rac::SetPlayerVirtualWorld(playerid, Pl::SpecInfo[specid][pSpecVw][0]);
		WatchingTV{playerid} = true;
	}
	else Send(playerid, COLOR_GREEN, "* Вы не дома.");

	return 1;
}

CMD:a(playerid, params[]) { new string[144];
	if(IsPMuted(playerid)) return Send(playerid, COLOR_GREY, "* У Вас молчанка!");
	if(!Pl::isAdmin(playerid, MODER1LVL)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(isnull(params) || params[0] == ' ') return Send(playerid, COLOR_GREY, "Введите: /(a)dmin [чат]");
	GetPlayerName(playerid, plname, 24);
	format(string, sizeof string, "*%s %s: %s", GetAdminRank(Pl::Info[playerid][pAdmin]), plname, params);
	SendToAdmin(COLOR_ORANGE, string, 1);
	return 1;
}

CMD:cnn(playerid, params[]) { new string[144];
	if(IsPMuted(playerid)) return Send(playerid, COLOR_GREY, "* У Вас молчанка!");
	if(!Pl::isAdmin(playerid, MODER3LVL)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(sscanf(params, "iis[90]", params[0], params[1], params[3])) return Send(playerid, COLOR_GRAD1, "Введите: /cnn [type] [time] [text]");
	if(params[0] < 0 || params[0] == 2 || params[0] > 6) return Send(playerid, COLOR_GREY, "* Вы не можите использовать этот тип текста!");
	format(string, sizeof string, "~w~%s", params[3]);
	GameTextForPlayer(playerid, string, params[1], params[0]);
	return 1;
}

CMD:prison(playerid, params[]) { new string[144], sendername[24], playername[24];
	if(!Pl::isAdmin(playerid, MODER2LVL)) return Send(playerid, COLOR_GRAD1, "* Недостаточно прав!");
	if(sscanf(params, "us[64]", params[0], params[1])) return Send(playerid, COLOR_GREY, "Введите: /prison [id/Name] [reason]");
	if(!Pl::isLogged(params[0])) return Send(playerid, COLOR_GREY, "* Этот игрок не авторизован!");
	if(Pl::Info[params[0]][pJailed] == 2) return Send(playerid, COLOR_GREY, "* Этот игрок уже в присоне!");
	if(Pl::Info[playerid][pAdmin] < Pl::Info[params[0]][pAdmin]) return Send(playerid, COLOR_LIGHTRED, "* Вы не можите посадить администратора в Демоган!");
	Jailed(params[0], 2800, 2);
	getname(playerid->sendername,params[0]->playername);
	format(string, sizeof string, "[AdmWarn] * %s применил команду /prison к игроку %s[%i]. Причина: %s", sendername, playername, params[0], params[1]);
	SendToAdmin(COLOR_YELLOW, string, 1, 3);
	format(string, sizeof string, "* Вы были размещены в Форт Деморган администратаром %s. Причина: %s", sendername, params[1]);
	Send(params[0], COLOR_LIGHTRED, string);
	GameTextForPlayer(params[0], "~w~Welcome to ~n~~r~Fort DeMorgan", 5000, 3);
	return 1;
}

CMD:unprison(playerid, params[]) { new string[144], sendername[24], playername[24];
	if(!Pl::isAdmin(playerid, MODER2LVL)) return Send(playerid, COLOR_GRAD1, "* Недостаточно прав!");
	if(sscanf(params, "u", params[0])) return Send(playerid, COLOR_GREY, "Введите: /unprison [id/Name]");
	if(!Pl::isLogged(params[0])) return Send(playerid, COLOR_GREY, "* Этот игрок не авторизован!");
	if(Pl::Info[params[0]][pJailed] != 2) return Send(playerid, COLOR_GREY, "* Этот игрок не в присоне!");
	if(playerid == params[0] && !Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GREY, "* Вы не можите оправдаться!");
	getname(playerid->sendername,params[0]->playername);
	format(string, sizeof string, "[AdmWarn] * %s применил команду /unprison к игроку %s[%i].", sendername, playername, params[0]);
	SendToAdmin(COLOR_YELLOW, string, 1, 3);
	UnJail(params[0], 2);
	Send(params[0],COLOR_RED,"* Вы были выпущены из Деморгана!");
	return 1;
}

CMD:jail(playerid, params[]) { new string[144], sendername[24], playername[24];
	if(!Pl::isAdmin(playerid, MODER3LVL)) return Send(playerid, COLOR_GRAD1, "* Недостаточно прав!");
	if(sscanf(params, "uds[36]", params[0], params[1], params[2])) return Send(playerid, COLOR_GREY, "Введите: /jail [id/Name] [time] [reason]");
	if(!Pl::isLogged(params[0])) return Send(playerid, COLOR_GREY, "* Этот игрок не авторизован!");
	if(Pl::Info[params[0]][pJailed] >= 1) return Send(playerid, COLOR_GREY, "* Этот игрок уже находится в тюрьме!");
	if(params[1] < 60 || params[1] > 3600) return Send(playerid, COLOR_GREY, "* Срок ареста может быть от 1 минуты и до 1 часа!");
	if(Pl::Info[playerid][pAdmin] < Pl::Info[params[0]][pAdmin]) return Send(playerid, COLOR_LIGHTRED, "* Вы не можете посадить в тюрьму администратора!");
	Jailed(params[0], params[1], 3);
	getname(playerid->sendername,params[0]->playername);
	format(string, sizeof string, "<< Админ %s арестовал нарушителя %s. Причина: %s >>", sendername, playername, params[2]);
	OOCNews(COLOR_LIGHTRED, string);
	format(string, sizeof string, "* Вы были заключены в тюрьму на %d секунд.", params[1]);
	Send(params[0], COLOR_LIGHTRED, string);
	return 1;
}

CMD:unjail(playerid, params[]) { new string[144], sendername[24], playername[24];
	if(!Pl::isAdmin(playerid, MODER3LVL)) return Send(playerid, COLOR_GRAD1, "* Недостаточно прав!");
	if(sscanf(params, "u", params[0])) return Send(playerid, COLOR_GREY, "Введите: /unjail [id/Name]");
	if(!Pl::isLogged(params[0])) return Send(playerid, COLOR_GREY, "* Этот игрок не авторизован!");
	if(playerid == params[0] && !Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GREY, "* Вы не можите оправдаться!");
	if(Pl::Info[params[0]][pJailed] != 1) return Send(playerid, COLOR_GREY, "* Этот игрок не в тюрьме!");
	UnJail(params[0], 1);
	getname(playerid->sendername,params[0]->playername);
	format(string, sizeof string, "[AdmWarn] * %s применил команду /unjail к игроку %s[%i].", sendername, playername, params[0]);
	SendToAdmin(COLOR_YELLOW, string, 1, 3);
	format(string, sizeof string, "* Администратор %s выпустил вас из тюрьмы!", sendername);
	Send(params[0], COLOR_LIGHTBLUE, string);
	return 1;
}

CMD:setstat(playerid, params[]) {
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GRAD1, "* Недостаточно прав!");
	ShowDialog(playerid, D_SETSTAT, DIALOG_STYLE_INPUT, "SETSTAT", "dialog/setstat.txt", "Ввод", "Отмена");
	return 1;
}

CMD:fs(playerid, params[]) {
	if(!Pl::isAdmin(playerid, MODER2LVL)) return Send(playerid, COLOR_GRAD1, "* Недостаточно прав!");
	if(sscanf(params, "u", params[0])) return Send(playerid, COLOR_GREY, "Введите: /fs [id]");
	if(!Pl::isLogged(params[0])) return Send(playerid, COLOR_GREY, "* Этот игрок не авторизован!");
	SPD(params[0], D_FIGHTSTYLE, DIALOG_STYLE_LIST, "Выберите стиль боя","БОКС\nКУНГ-ФУ\nСАМБО\nУЛИЧНЫЙ","Выбрать","Отмена");
	return 1;
}

CMD:ainvite(playerid, params[]) { new string[144], sendername[24], playername[24];
	if(!Pl::isAdmin(playerid, MODER3LVL)) return Send(playerid, COLOR_GRAD1, "* Недостаточно прав!");
	if(sscanf(params, "ud", params[0], params[1])) return Send(playerid, COLOR_GREY, "Введите: /ainvite [id] [fracid]");
	if(!Pl::isLogged(params[0])) return Send(playerid, COLOR_GREY, "* Этот игрок не авторизован!");
	if(Pl::FracID(params[0]) != 0) return Send(playerid, COLOR_GREY, "* Этот игрок уже состоит в другой организации!");
	if(params[1] < 1 || params[1] > 20) return Send(playerid, COLOR_GREY, "* Неверный ID фракции!");
	if(params[1] == 8 && !Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GREY, "* Неверный ID фракции!");
	Pl::Info[params[0]][pMember] = params[1];
	Pl::Info[params[0]][pRank] = 1;
	Rac::SetPlayerInterior(params[0], 3);
	Rac::SetPlayerVirtualWorld(params[0], Bizz_ProLaps);
	Rac::SetPlayerPos(params[0],207.4872,-129.2266,1003.5078);
	Pl::Info[params[0]][pLocal] = OFFSET_BIZZ + GetIndexFromBizID(Bizz_ProLaps);
	SelectCharPlace[params[0]] = 0;
	Pl::SetFracColor(params[0]);
	Iter::Add(TeamPlayers[params[1]], params[0]);
	getname(playerid->sendername,params[0]->playername);
	format(string, sizeof string, "[AdmWarn] * %s применил команду /ainvite к игроку %s[%d][%s]", sendername, playername, params[0], FracInfo[params[1]][fName]);
	SendToAdmin(COLOR_YELLOW, string, 1, 3);
	format(string, sizeof string, "* Вы были приняты в %s админом %s", FracInfo[params[1]][fName], sendername);
	Send(params[0], COLOR_LIGHTBLUE, string);
	return 1;
}

CMD:unleader(playerid, params[]) { new string[144], sendername[24], playername[24];
	if(!Pl::isAdmin(playerid, MODER3LVL)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(sscanf(params, "s[24]S(не указана)[64]", playername, temp)) return Send(playerid, COLOR_GREY, "Введите: /unadmin [name] [reason]");
	params[0] = ReturnUser(playername);
	if(IsPlayerConnected(params[0])) {
		if(Pl::isLogged(params[0])) {
			format(string, sizeof string, "* Этот игрок сейчас онлайн. Используйте: /makeleader %i 0", params[0]);
			Send(playerid, COLOR_GREY, string);
		}
	} else {
		format(string, sizeof string, "UPDATE `"#__TableUsers__"` SET `Leader`='0' WHERE BINARY `Name`='%s'", playername);
		new Cache:result = Db::query(connDb, string, true);
		if(cache_affected_rows()) {
			GetPlayerName(playerid, sendername, 24);
			format(string, sizeof string, "[AdmWarn] * %s применил команду /unleader к лидеру %s, причина: %s", sendername, playername, temp);
			SendToAdmin(COLOR_YELLOW, string, 4, 3);
		} else {
			Send(playerid, COLOR_GREY, "* Такого игрока не существует!");
		}
		cache_delete(result);
	}
	return 1;
}

CMD:unhelper(playerid, params[]) { new string[144], sendername[24], playername[24];
	if(!IsPHelper(playerid, 3) && !Pl::isAdmin(playerid, MODER3LVL)) return Send(playerid, COLOR_GRAD1, "* Недостаточно прав!");
	if(sscanf(params, "s[24]S(не указана)[64]", playername, temp)) return Send(playerid, COLOR_GREY, "Введите: /unhelper [name] [reason]");
	params[0] = ReturnUser(playername);
	if(IsPlayerConnected(params[0])) {
		if(Pl::isLogged(params[0])) {
			format(string, sizeof string, "* Этот игрок сейчас онлайн. Используйте: /makehelper %i 0", params[0]);
			Send(playerid, COLOR_GREY, string);
		}
	} else {
		format(string, sizeof string, "UPDATE `"#__TableUsers__"` SET `Helper`='0' WHERE BINARY `Name`='%s'", playername);
		new Cache:result = Db::query(connDb, string, true);
		if(cache_affected_rows()) {
			GetPlayerName(playerid, sendername, 24);
			format(string, sizeof string, "[AdmWarn] * %s применил команду /unhelper к хелперу %s, причина: %s", sendername, playername, temp);
			SendToAdmin(COLOR_YELLOW, string, 4, 3);
		} else {
			Send(playerid, COLOR_GREY, "* Такого игрока не существует!");
		}
		cache_delete(result);
	}
	return 1;
}

CMD:unadmin(playerid, params[]) { new string[144], sendername[24], playername[24];
	if(!IsPHelper(playerid, 3) && !Pl::isAdmin(playerid, MODER3LVL)) return Send(playerid, COLOR_GRAD1, "* Недостаточно прав!");
	if(sscanf(params, "s[24]S(не указана)[64]", playername, temp)) return Send(playerid, COLOR_GREY, "Введите: /unadmin [name] [reason]");
	params[0] = ReturnUser(playername);
	if(IsPlayerConnected(params[0])) {
		if(Pl::isLogged(params[0])) {
			format(string, sizeof string, "* Этот игрок сейчас онлайн. Используйте: /makeadmin %i 0", params[0]);
			Send(playerid, COLOR_GREY, string);
		}
	} else {
		format(string, sizeof string, "UPDATE `"#__TableUsers__"` SET `Admin`='0' WHERE BINARY `Name`='%s'", playername);
		new Cache:result = Db::query(connDb, string, true);
		if(cache_affected_rows()) {
			GetPlayerName(playerid, sendername, 24);
			format(string, sizeof string, "[AdmWarn] * %s применил команду /unhelper к админу %s, причина: %s", sendername, playername, temp);
			SendToAdmin(COLOR_YELLOW, string, 4, 3);
		} else {
			Send(playerid, COLOR_GREY, "* Такого игрока не существует!");
		}
		cache_delete(result);
	}
	return 1;
}

CMD:makeleader(playerid, params[]) { new string[144], sendername[24], playername[24];
	if(!Pl::isAdmin(playerid, MODER3LVL)) return Send(playerid, COLOR_GRAD1, "* Недостаточно прав!");
	if(sscanf(params, "ui", params[0], params[1])) return Send(playerid, COLOR_GREY, "Введите: /makeleader [id] [fracid]");
	if(!Pl::isLogged(params[0])) return Send(playerid, COLOR_GREY, "* Этот игрок не авторизован!");
	if(Pl::Info[params[0]][pAdmin] && !Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GREY, "* Нельзя менять лидерку админу!");
	if(params[1] < 0 || params[1] > 20) return Send(playerid, COLOR_GREY, "* Не ниже 0, и не выше 20!");
	if(params[1] == 8 && !Pl::isAdmin(playerid, ADMINISTRATOR))  return Send(playerid, COLOR_GREY, "* Не ниже 0, и не выше 20!");
	if(Pl::FracID(params[0]) == params[1])  return Send(playerid, COLOR_GREY, "* Этот игрок уже лидер!");
	getname(playerid -> sendername,params[0] -> playername);
	if(params[1] == 0) {
		if(Pl::Info[params[0]][pLeader]) {
			Iter::Remove(LeaderPlayers, params[0]);
			Iter::Remove(TeamPlayers[Pl::Info[params[0]][pLeader]], params[0]);
		}
		Pl::Info[params[0]][pMember] = 0;
		Pl::Info[params[0]][pLeader] = 0;
		Pl::Info[params[0]][pRank] = 0;
		switch(Pl::Info[params[0]][pSex]) {
			case 1: Pl::Info[params[0]][pChar] = 60;
			case 2: Pl::Info[params[0]][pChar] = 55;
			default: Pl::Info[params[0]][pChar] = 60;
		}
		MedicBill{params[0]} = false;
		Pl::SetSpawnInfo(params[0]);
		Rac::SpawnPlayer(params[0]);
		format(string, sizeof string, "* Вы были сняты с лидерки администратором %s", sendername);
		Send(params[0], COLOR_LIGHTBLUE, string);
	} else {
		if(!Pl::Info[params[0]][pLeader]) Iter::Add(LeaderPlayers, params[0]);
		Iter::Remove(TeamPlayers[Pl::FracID(params[0])], params[0]);
		Iter::Add(TeamPlayers[params[1]], params[0]);
		
		Pl::Info[params[0]][pLeader] = params[1];
		Pl::Info[params[0]][pMember] = 0;
		Pl::Info[params[0]][pRank] = RankNums[params[1]];
		
		Rac::SetPlayerInterior(params[0], 3);
		Rac::SetPlayerVirtualWorld(params[0], Bizz_ProLaps);
		Pl::Info[params[0]][pLocal] = OFFSET_BIZZ + GetIndexFromBizID(Bizz_ProLaps);
		Rac::SetPlayerPos(params[0], 207.4872, -129.2266, 1003.5078);
		SetPlayerWeapons(params[0]);
		Pl::SetFracColor(params[0]);
		Pl::SetSpawnInfo(params[0]);
		
		format(string, sizeof string, "* Вы были назначены лидером фракции %s, администратором %s", FracInfo[params[1]][fName], sendername);
		Send(params[0], COLOR_LIGHTBLUE, string);
	}
	format(string, sizeof string, "[AdmWarn] * %s применил команду /makeleader к игроку %s[%s]",
	sendername, playername, FracInfo[params[1]][fName]);
	SendToAdmin(COLOR_YELLOW, string, 4, 3);

	return 1;
}

CMD:agiverank(playerid, params[]) { new string[144], sendername[24], playername[24];
	if(!Pl::isAdmin(playerid, MODER3LVL)) return Send(playerid, COLOR_GREY, "* Вы не лидер фракции!");
	if(sscanf(params, "ud", params[0], params[1])) return Send(playerid, COLOR_GREY, "Введите: /giverank [id] [ранг]");
	if(!Pl::isLogged(params[0])) return Send(playerid, COLOR_GREY, "* Этот игрок не залогинен!");
	new fracid = Pl::FracID(params[0]);
	if(fracid <= 0) return Send(playerid, COLOR_GREY, "* Этот игрок не состоит в организациях!");
	if(params[1] <= 0 || params[1] > RankNums[fracid]) {
		format(string, sizeof string, "* В этой фракции всего %d рангов!", RankNums[fracid]);
		Send(playerid, COLOR_GREY, string);
		return 1;
	}
	Pl::Info[params[0]][pRank] = params[1];
	getname(playerid->sendername,params[0]->playername);
	format(string, sizeof string, "* Вы были повышены/понижены в ранге админом %s, ваш ранг: %i", sendername, params[1]);
	Send(params[0], COLOR_LIGHTBLUE, string);
	format(string, sizeof string, "[AdmWarn] * %s применил команду /agiverank к игроку %s[%d][%s]", sendername, playername, params[0], FracInfo[fracid][fName]);
	SendToAdmin(COLOR_YELLOW, string, 1, 3);
	return 1;
}

CMD:achangerank(playerid, params[]) {
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(sscanf(params, "d", params[0])) return Send(playerid, COLOR_GREY, "Введите: /aranklist [fracid]");
	if(params[0] < 1 || params[0] > 20) return Send(playerid, COLOR_GREY, "* Неверный ID фракции!");
	ShowRankList(playerid, params[0]);
	return 1;
}

CMD:setspawn(playerid, params[]) { new string[144];
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(sscanf(params, "i", params[0])) return Send(playerid, COLOR_GREY, "Введите: /changespawn [fracid]");
	if(params[0] < 1 || params[0] > sizeof(SpawnInfo)) return Send(playerid, COLOR_GREY, "Неверный ID спавна!");
	GetPlayerPos(playerid, SpawnInfo[params[0]][spX], SpawnInfo[params[0]][spY], SpawnInfo[params[0]][spZ]);
	GetPlayerFacingAngle(playerid, SpawnInfo[params[0]][spA]);
	SpawnInfo[params[0]][spInt] = GetPlayerInterior(playerid);
	SpawnInfo[params[0]][spVirt] = GetPlayerVirtualWorld(playerid);
	format(query, sizeof query, "UPDATE `"#__TableSpawns__"` SET ");
	scf(query, string, "`interior`='%i',", SpawnInfo[params[0]][spInt]);
	scf(query, string, "`virtualworld`='%i',", SpawnInfo[params[0]][spVirt]);
	scf(query, string, "`spawn_x`='%.3f',", SpawnInfo[params[0]][spX]);
	scf(query, string, "`spawn_y`='%.3f',", SpawnInfo[params[0]][spY]);
	scf(query, string, "`spawn_z`='%.3f',", SpawnInfo[params[0]][spZ]);
	scf(query, string, "`spawn_a`='%.3f' ", SpawnInfo[params[0]][spA]);
	scf(query, string, "WHERE `ID` = '%i'", params[0]);
	Db::tquery(connDb, query, "", "");
	Send(playerid, COLOR_YELLOW, "* Место спавна было изменино!");
	return 1;
}

CMD:fraccolor(playerid, params[]) {
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(sscanf(params,"ih",params[0], params[1])) return Send(playerid, COLOR_GREY, "Введите: /fraccolor [id] [color]");
	if(!IsValidFrac(params[0])) return Send(playerid, COLOR_GREY, "Invalid frac id!");
	FracInfo[params[0]][fColor] = params[1];
	UpdateFracInfo(params[0]);
	Send(playerid, COLOR_YELLOW, "* Цвет фракции был изминен!");
	return 1;
}

CMD:fracspawn(playerid, params[]) { new string[144];
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(sscanf(params, "i", params[0])) return Send(playerid, COLOR_GREY, "Введите: /changespawn [fracid]");
	if(!IsValidFrac(params[0])) return Send(playerid, COLOR_GREY, "Неверный ID фракции!");
	
	GetPlayerPos(playerid,
		FracInfo[params[0]][fSpawn][fSpawnPos][0],
		FracInfo[params[0]][fSpawn][fSpawnPos][1],
		FracInfo[params[0]][fSpawn][fSpawnPos][2]
	);
	GetPlayerFacingAngle(playerid, FracInfo[params[0]][fSpawn][fSpawnPos][3]);
	
	FracInfo[params[0]][fSpawn][fSpawnInt][0] = GetPlayerInterior(playerid);
	FracInfo[params[0]][fSpawn][fSpawnInt][1] = GetPlayerVirtualWorld(playerid);
	
	format(query, sizeof query, "UPDATE `"#__TableFracInfo__"` SET ");
	scf(query, string, "`fSpawn`='%i,%i,", FracInfo[params[0]][fSpawn][fSpawnInt][0], FracInfo[params[0]][fSpawn][fSpawnInt][1]);
	scf(query, string, "%.3f,%.3f,", FracInfo[params[0]][fSpawn][fSpawnPos][0], FracInfo[params[0]][fSpawn][fSpawnPos][1]);
	scf(query, string, "%.3f,%.3f'", FracInfo[params[0]][fSpawn][fSpawnPos][2], FracInfo[params[0]][fSpawn][fSpawnPos][3]);
	scf(query, string, " WHERE `fID` = '%i'", params[0]);
	Db::tquery(connDb, query, "", "");
	Send(playerid, COLOR_YELLOW, "* Место спавна было изменино!");
	return 1;
}

CMD:mark(playerid, params[]) {
	if(!Pl::isAdmin(playerid, MODER3LVL)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(Pl::Info[playerid][pJailed] > 0) return Send(playerid, COLOR_GRAD1, "* Сиди блять!");
	TeleportDest[playerid][tpInt] = GetPlayerInterior(playerid);
	TeleportDest[playerid][tpVw] = GetPlayerVirtualWorld(playerid);
	TeleportDest[playerid][tpLocal] = Pl::Info[playerid][pLocal];
	GetPlayerFacingAngle(playerid, TeleportDest[playerid][tpPos][3]);
	GetPlayerPos(playerid, TeleportDest[playerid][tpPos][0], TeleportDest[playerid][tpPos][1], TeleportDest[playerid][tpPos][2]);
	return Send(playerid, COLOR_GRAD1, "* Вы установили маркер для телепорта (используйте /gotomark для телепорта туда)");
}

CMD:gotomark(playerid, params[]) {
	if(!Pl::isAdmin(playerid, MODER3LVL)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(Pl::Info[playerid][pJailed] > 0) return Send(playerid, COLOR_GRAD1, "* Сиди блять!");
	if(GetPlayerState(playerid) == 2 && GetPlayerInterior(playerid)) return Send(playerid, COLOR_GREY, "* Нельзя телепортироватся в интерьер!");
	Rac::SetPlayerPos(playerid, TeleportDest[playerid][tpPos][0], TeleportDest[playerid][tpPos][1], TeleportDest[playerid][tpPos][2]);
	Rac::SetPlayerFacingAngle(playerid, TeleportDest[playerid][tpPos][3]);
	Pl::Info[playerid][pLocal] = TeleportDest[playerid][tpLocal];
	Rac::SetPlayerInterior(playerid, TeleportDest[playerid][tpInt]);
	Rac::SetPlayerVirtualWorld(playerid, TeleportDest[playerid][tpVw]);
	return Send(playerid, COLOR_LIGHTBLUE, "* Вы были телепортированы!");
}

CMD:tp(playerid, params[]) {
	if(!Pl::isAdmin(playerid, MODER1LVL)) return Send(playerid, COLOR_GRAD1, "* Недостаточно прав!");
	if(Pl::Info[playerid][pJailed] > 0) return Send(playerid, COLOR_GRAD1, "* Вы заключенный!");
	SPD(playerid, D_GOTO, DIALOG_STYLE_LIST, ""#__SERVER_PREFIX""#__SERVER_NAME_LC": Телепорты", "— Популярные места\n— Респы банд\n— Респы фракций", "SELECT", "CANCEL");
	return 1;
}

CMD:gotoc(playerid, params[]) {
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	new Float:pos[3];
	if(sscanf(params, "P<,>a<f>[3]I(0)I(0)", pos, params[0], params[1])) return Send(playerid, COLOR_GREY, "Введите: /gotoc [interior] [vitualworld] [posX,posY,posZ]");
	Rac::SetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	Rac::SetPlayerVirtualWorld(playerid, params[1]);
	Rac::SetPlayerInterior(playerid, params[0]);
	Send(playerid, COLOR_WHITE, "Вы бвли телепортированы по своим координатам!");
	return 1;
}

CMD:goto(playerid, params[]) {
	if(!Pl::isAdmin(playerid, MODER1LVL)) return Send(playerid, COLOR_GRAD1, "* Недостаточно прав!");
	if(Pl::Info[playerid][pJailed] > 0) return Send(playerid, COLOR_GRAD1, "* Это вевозможно!");
	if(sscanf(params, "u", params[0])) return Send(playerid, COLOR_GREY, "Введите: /goto [id]");
	if(!Pl::isLogged(params[0])) return Send(playerid, COLOR_GREY, "* Этот игрок не авторизован!");
	if(!TogTP{params[0]} && !Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid,COLOR_GREY,"* Админ запретил к нему телепортироваться!");
	GetPlayerPos(params[0], posx, posy, posz);
	if(GetPlayerState(playerid) == 2) Rac::SetVehiclePos(GetPlayerVehicleID(playerid), posx, posy+4, posz);
	else Rac::SetPlayerPos(playerid,posx, posy+2, posz);
	Rac::SetPlayerInterior(playerid,GetPlayerInterior(params[0]));
	Rac::SetPlayerVirtualWorld(playerid,GetPlayerVirtualWorld(params[0]));
	Pl::Info[playerid][pLocal] = Pl::Info[params[0]][pLocal];
	Send(playerid, COLOR_LIGHTBLUE, "* Вы были телепортированы!");
	return 1;
}

CMD:gethere(playerid, params[]) { new string[144], sendername[24], playername[24];
	if(!Pl::isAdmin(playerid, MODER2LVL)) return Send(playerid, COLOR_GRAD1, "* Недостаточно прав!");
	if(Pl::Info[playerid][pJailed] > 0) return Send(playerid, COLOR_GRAD1, "* Сиди блять!");
	if(sscanf(params, "u", params[0])) return Send(playerid, COLOR_GREY, "Введите: /gethere [id]");
	if(!Pl::isLogged(params[0])) return Send(playerid, COLOR_GREY, "* Этот игрок не авторизован!");
	if(Pl::Info[params[0]][pJailed]) return Send(playerid, COLOR_GRAD1, "* Это вевозможно!");
	if(Pl::Info[params[0]][pAdmin] > Pl::Info[playerid][pAdmin] && !Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid,COLOR_GREY,"* Скажите админу чтобы он Телепортировался к вам.");
	GetPlayerPos(playerid, posx, posy, posz);
	if (GetPlayerState(params[0]) == 2) Rac::SetVehiclePos(GetPlayerVehicleID(params[0]), posx, posy+3, posz);
	else Rac::SetPlayerPos(params[0],posx, posy+1, posz);
	Rac::SetPlayerInterior(params[0], GetPlayerInterior(playerid));
	Rac::SetPlayerVirtualWorld(params[0], GetPlayerVirtualWorld(playerid));
	Pl::Info[params[0]][pLocal] = Pl::Info[playerid][pLocal];
	Send(params[0], COLOR_LIGHTRED2, "* Вы были телепортированы администрацией!");
	
	getname(playerid -> sendername,params[0] -> playername);
	format(string, sizeof string, "[AdmWarn] * %s применил команду /gethere к игроку %s[%s]", sendername, playername, FracInfo[Pl::FracID(params[0])][fName]);
	SendToAdmin(COLOR_YELLOW, string, 1, 3);
	
	return 1;
}

CMD:getcar(playerid, params[]) {
	if(!Pl::isAdmin(playerid, MODER3LVL)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(Pl::Info[playerid][pJailed] > 0) return Send(playerid, COLOR_GRAD1, "* Сиди блять!");
	if(sscanf(params, "d", params[0])) return Send(playerid, COLOR_GREY, "Введите: /getcar [carid]");
	GetPlayerPos(playerid, posx, posy, posz);
	SetVehiclePos(params[0], posx+4, posy+4, posz);
	return 1;
}

CMD:gethousecar(playerid, params[]) {
	if(!Pl::isAdmin(playerid, MODER3LVL)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(sscanf(params, "d", params[0])) return Send(playerid, COLOR_GREY, "Введите: /getcar [carid]");
	if(!IsValidHouse(params[0])) return Send(playerid, COLOR_GREY, "* Неверный ID дома!");
	GetPlayerPos(playerid, posx, posy, posz);
	SetVehiclePos(HouseInfo[params[0]][hAuto], posx+4, posy+4, posz);
	return 1;
}

CMD:oldcar(playerid, params[]) { new string[144];
	format(string, sizeof string, "* Ваш старый автомобиль был: %d", gLastCar[playerid]);
	Send(playerid, COLOR_GREY, string);
	return 1;
}

CMD:givegun(playerid, params[]) { new string[144], sendername[24], playername[24];
	if(!Pl::isAdmin(playerid, MODER3LVL)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(!sscanf(params, "uii", params[0], params[1], params[2])) {
		if(!Pl::isLogged(params[0])) return Send(playerid, COLOR_GREY, "* Этот игрок не авторизован!");
		if(IsWrongWeponID(params[1]) && !Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GREY, "* Не правельный ID оружия!");
		if(params[2] < 1 || params[2] > 999 && !Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GREY, "* Не ниже 1 и не выше 999 патронов!");
		Rac::GivePlayerWeapon(params[0], params[1], params[2]);
		getname(playerid -> sendername, params[0] -> playername);
		format(string, sizeof string, "[AdmWarn] * %s применил команду /givegun к игроку %s[%s]", sendername, playername, FracInfo[Pl::FracID(params[0])][fName]);
		SendToAdmin(COLOR_YELLOW, string, 1, 3);
	} else {
		ShowDialog(playerid, D_GGUN, DIALOG_STYLE_INPUT, "GIVEGUN", "dialog/ggun.txt", "Ввод", "Отмена");
	}
	return 1;
}

CMD:resetgun(playerid, params[]) { new string[144], sendername[24], playername[24];
	if(!Pl::isAdmin(playerid, MODER1LVL)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(sscanf(params, "u", params[0])) return Send(playerid, COLOR_GREY, "Введите: /resetgun [id]");
	if(!Pl::isLogged(params[0])) return Send(playerid, COLOR_GREY, "* Этот игрок не залогинен!");
	getname(playerid -> sendername,params[0] -> playername);
	format(string, sizeof string, "[AdmWarn] * %s применил команду /resetgun к игроку %s[%s]", sendername, playername, FracInfo[Pl::FracID(params[0])][fName]);
	SendToAdmin(COLOR_YELLOW, string, 1, 1);
	Rac::ResetPlayerWeapons(params[0]);
	return 1;
}

CMD:sethp(playerid, params[]) { new string[144], sendername[24], playername[24];
	if(!Pl::isAdmin(playerid, SUPERMODER)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(sscanf(params, "ud", params[0], params[1])) return Send(playerid, COLOR_GREY, "Введите: /sethp [id] [amount]");
	if(!Pl::isLogged(params[0])) return Send(playerid, COLOR_GREY, "* Этот игрок не залогинен!");
	Rac::SetPlayerHealth(params[0], params[1]);
	getname(playerid -> sendername,params[0] -> playername);
	format(string, sizeof string, "[AdmWarn] * %s применил команду /sethp к игроку %s[%s]", sendername, playername, FracInfo[Pl::FracID(params[0])][fName]);
	SendToAdmin(COLOR_YELLOW, string, 1, SUPERMODER);
	return 1;
}

CMD:setarmour(playerid, params[]) { new string[144], sendername[24], playername[24];
	if(!Pl::isAdmin(playerid, SUPERMODER)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(sscanf(params, "ui", params[0], params[1])) return Send(playerid, COLOR_GREY, "Введите: /setarmour [id]");
	if(!Pl::isLogged(params[0])) return Send(playerid, COLOR_GREY, "* Этот игрок не залогинен!");
	if(!IsACop(params[0]) && !Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GREY, "* Только для закона!");
	Rac::SetPlayerArmour(params[0], params[1]);
	getname(playerid -> sendername,params[0] -> playername);
	format(string, sizeof string, "[AdmWarn] * %s применил команду /setarmour к игроку %s[%s]", sendername, playername, FracInfo[Pl::FracID(params[0])][fName]);
	SendToAdmin(COLOR_YELLOW, string, 1, SUPERMODER);
	return 1;
}

CMD:veh(playerid, params[]) { new string[144];
	if(!Pl::isAdmin(playerid, SUPERMODER)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(sscanf(params, "iI(0)I(0)", params[0], params[1], params[2])) return Send(playerid, COLOR_GREY, "Введите: /veh [model] [color1] [color2]");
	if(!(400 <= params[0] <= 611)) return Send(playerid, COLOR_GREY, "* ID транспортного средства не может быть ниже 400 или выше 611 !");
	if((params[0] == 425 || params[0] == 520 || params[0] == 432) && !Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GREY, "* Вы не можите создать этот транспорт!");
	if(Iter::Count(CreatedCars) >= 50) return Send(playerid, COLOR_GREY, "* Создано максемальное кол-во транспорта!");
	new vehid, Float:x, Float:y, Float:z;
	GetPlayerCameraLookAt(playerid, 5.0, x, y, z);
	GetPlayerPos(playerid, z, z, z);
	vehid = Veh::Create(params[0], x, y, z, 0.0, params[1], params[2], 1200);
	Iter::Add(CreatedCars, vehid);
	SetVehicleNumber(vehid);
	format(string, sizeof string, "[AdmWarn] * %s применил команду /veh. Созданный транспорт [ID: %i; Model: %s]", GetName(playerid), vehid, VehicleNames[GetVehicleModel(vehid)-400]);
	SendToAdmin(COLOR_YELLOW, string, 1, SUPERMODER);
	return 1;
}

CMD:setbenz(playerid, params[]) {
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(!IsPlayerInAnyVehicle(playerid)) return Send(playerid, COLOR_GREY, "* Вы не находитесь в транспорте!");
	if(sscanf(params, "i", params[0])) return Send(playerid, COLOR_GREY, "Введите: /setbenz!");
	AutoInfo[GetPlayerVehicleID(playerid)][aFuel] = float(params[0]);
	return 1;
}

CMD:fuelcars(playerid, params[]) { new string[144];
	if(!Pl::isAdmin(playerid, MODER3LVL)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	for(new veh; veh < MAX_VEHICLES; veh++) if(IsValidVehicle(veh)) AutoInfo[veh][aFuel] = MAX_GAS;
	format(string, sizeof string,"* Авдинистратор %s заправил весь транспорт на сервере", GetName(playerid));
	SendToAdmin(COLOR_LIGHTRED, string, 3);
	GameTextForAll("~w~BCE ABЏO–OЂ…‡… ~g~Filled ~w~Ђ‘‡… ~p~€AЊPAB‡Eм‘!",5000,1);
	Send(playerid, COLOR_LIGHTBLUE, "* Все машины были заправлены");
	return 1;
}

CMD:fixveh(playerid, params[]) { new string[144], sendername[24], playername[24];
	if(!Pl::isAdmin(playerid, MODER2LVL)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(sscanf(params, "i", params[0])) {
		if(!IsPlayerInAnyVehicle(playerid)) return Send(playerid, COLOR_GREY, "* Вы не находитесь в транспорте!");
		Rac::RepairVehicle(GetPlayerVehicleID(playerid)); Send(playerid, COLOR_LIGHTBLUE, "* Транспорт был починен!");
	} else {
		if(!IsPlayerInAnyVehicle(params[0])) return Send(playerid, COLOR_GREY, "* Вы не находитесь в транспорте!");
		Rac::RepairVehicle(GetPlayerVehicleID(params[0]));
		
		getname(playerid -> sendername,params[0] -> playername);
		format(string, sizeof string, "* Администратор %s починил ваш транспорт!", sendername);
		Send(params[0], COLOR_LIGHTBLUE, string);
		format(string, sizeof string, "[AdmWarn] * %s применил команду /fixveh к игроку %s[%s]",
		sendername, playername, FracInfo[Pl::FracID(params[0])][fName]);
		SendToAdmin(COLOR_YELLOW, string, 1, 3);
	}
	return 1;
}

CMD:fillveh(playerid, params[]) { new string[144], sendername[24], playername[24];
	if(!Pl::isAdmin(playerid, MODER2LVL)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(sscanf(params, "u", params[0])) {
		new veh = GetPlayerVehicleID(playerid);
		if(!veh) return Send(playerid, COLOR_GREY, "* Вы не находитесь в транспорте!");
		AutoInfo[veh][aFuel] = 99.0;
		updateBenzinTD(playerid, veh);
		Send(playerid, COLOR_LIGHTBLUE, "* Транспорт был заправлен!");
	} else {
		new veh = GetPlayerVehicleID(params[0]);
		if(!veh) return Send(playerid, COLOR_GREY, "* Тот игрок не находится в транспорте!");
		AutoInfo[veh][aFuel] = 99.0;
		updateBenzinTD(playerid, veh);
		getname(playerid -> sendername,params[0] -> playername);
		format(string, sizeof string, "* Администратор %s починил ваш транспорт!", sendername);
		Send(params[0], COLOR_LIGHTBLUE, string);
		format(string, sizeof string, "[AdmWarn] * %s применил команду /fillveh к игроку %s[%s]",
		sendername, playername, FracInfo[Pl::FracID(params[0])][fName]);
		SendToAdmin(COLOR_YELLOW, string, 1, 3);
	}
	return 1;
}

CMD:weatherall(playerid, params[]) {
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GRAD1, "* Вам не доступна эта функция");
	if(sscanf(params, "d", params[0])) return Send(playerid, COLOR_WHITE, "Введите: /weatherall [номер погоды]");
	SetWeather(params[0]);
	return 1;
}

CMD:worldtime(playerid, params[]) {
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GRAD1, "* Вам не доступна эта функция");
	if(sscanf(params, "i", params[0])) return Send(playerid, COLOR_WHITE, "Введите: /worldtime [0-11]");
	SetWorldTime(params[0]);
	return 1;
}

CMD:weather(playerid, params[]) {
	if(!Pl::isAdmin(playerid, MODER3LVL)) return Send(playerid, COLOR_GRAD1, "* Вам не доступна эта функция");
	if(sscanf(params, "d", params[0])) return Send(playerid, COLOR_WHITE, "Введите: /weather [номер погоды] (0 - 45)");
	if(params[0] < 0 || params[0] > 45) return SendClientMessage(playerid, COLOR_GREY, "* Погодное удостоверение личности не может быть ниже 0 или выше 45!");
	SetPlayerWeather(playerid, params[0]);
	Send(playerid, COLOR_LIGHTBLUE, "* Вы установили для себя погоду.");
	return 1;
}

CMD:setmoney(playerid, params[]) { new string[144], sendername[24], playername[24];
	if(!Pl::isLogged(playerid)) return Send(playerid, COLOR_GREY, "* Вы не авторизованы!");
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(sscanf(params, "ud", params[0], params[1])) return Send(playerid, COLOR_GREY, "Введите: /setmoney [номер погоды]");
	if(!Pl::isLogged(params[0])) return Send(playerid, COLOR_GREY, "* Этот игрок не авторизован!");
	params[3] = Rac::GetPlayerMoney(params[0]); Rac::SetPlayerMoney(params[0], params[1]);
	getname(playerid -> sendername,params[0] -> playername);
	format(string, sizeof string, "[AdmWarn] * %s применил команду /setmoney к игроку %s[%d]. Было:$%d; Стало: $%d",
	sendername, playername, params[0], params[3], Rac::GetPlayerMoney(params[0])); SendToAdmin(COLOR_YELLOW, string, 1, 3);
	return 1;
}

CMD:givemoney(playerid, params[]) { new string[144], sendername[24], playername[24];
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GRAD1, "* Вам не доступна эта функция");
	if(sscanf(params, "ui", params[0], params[1])) return Send(playerid, COLOR_WHITE, "Введите: /givemoney [id] [money]");
	if(!Pl::isLogged(params[0])) return Send(playerid, COLOR_GREY, "* Этот игрок не авторизован!");
	Rac::GivePlayerMoney(params[0], params[1]);
	getname(playerid -> sendername,params[0] -> playername);
	format(string, sizeof string, "[AdmWarn] * %s применил команду /givecash к игроку %s[%d]. Кол-во: $%d", sendername, playername, params[0], params[1]);
	SendToAdmin(COLOR_YELLOW, string, 1, 3);
	format(string, sizeof string, "* Администратор %s дал вам $%i", sendername, params[1]);
	Send(params[0], COLOR_LIGHTBLUE, string);
	return 1;
}

CMD:slap(playerid, params[]) { new string[144], sendername[24], playername[24];
	if(!Pl::isAdmin(playerid, MODER1LVL)) return Send(playerid, COLOR_GRAD1, "* Недостаточно прав!");
	if(Pl::Info[playerid][pJailed] > 0) return Send(playerid, COLOR_GRAD1, "* Сиди блять!");
	if(sscanf(params, "u", params[0])) return Send(playerid, COLOR_GREY, "Введите: /slap [id]");
	if(!Pl::isLogged(params[0])) return Send(playerid, COLOR_GREY, "* Этот игрок не авторизован!");
	Rac::GivePlayerHealth(params[0], -5), SlapPlayer(params[0], 4.5), PlayerPlaySound(params[0], 1130, posx, posy, posz+5);
	if(params[0] != playerid)
	{
		getname(playerid -> sendername,params[0] -> playername);
		format(string, sizeof string, "[AdmWarn] * %s применил команду /slap к игроку %s[%s]", sendername, playername, FracInfo[Pl::FracID(params[0])][fName]);
		SendToAdmin(COLOR_YELLOW, string, 1, 3);
	}
	return 1;
}

CMD:mute(playerid, params[]) { new string[144];
	if(!Pl::isAdmin(playerid, MODER1LVL)) return Send(playerid, COLOR_GRAD1, "* Недостаточно прав!");
	if(sscanf(params, "uds[64]", params[0], params[1], params[2])) return Send(playerid, COLOR_GREY, "Введите: /mute [id] [time] [reason]");
	if(!Pl::isLogged(params[0])) return Send(playerid, COLOR_GREY, "* Этот игрок не авторизован!");
	switch(Pl::Info[params[0]][pMuted]) {
		case 0 : {
			if(params[1] < 1 || params[1] > 60) return Send(playerid, COLOR_LIGHTRED, "* Минуты 1, и максимум 60 минут!");
			Pl::Info[params[0]][pMuted] = 1;
			Pl::Info[params[0]][pMutedTime] = params[1]*60;
			format(string, sizeof string, ""#__SERVER_PREFIX""#__SERVER_NAME_LC": %s получил молчанку от администратора %s. Причина: %s", GetName(params[0]), GetName(playerid), params[2]);
			SendToAll(COLOR_LIGHTRED, string);
		}
		case 1..2 : {
			Pl::Info[params[0]][pMuted] = 0;
			Pl::Info[params[0]][pMutedTime] = 0;
			format(string, sizeof string, ""#__SERVER_PREFIX""#__SERVER_NAME_LC": Администратор %s снял молчанку с %s.", GetName(playerid), GetName(params[0]));
			SendToAll(COLOR_LIGHTRED, string);
		}
	}
	return 1;
}

CMD:exp(playerid, params[]) { new string[144], sendername[24], playername[24];
	if(!Pl::isAdmin(playerid, MODER2LVL)) return Send(playerid, COLOR_GRAD1, "* Недостаточно прав!");
	if(sscanf(params, "u", params[0])) return Send(playerid, COLOR_GREY, "Введите: /exp [id]");
	if(!Pl::isLogged(params[0])) return Send(playerid, COLOR_GREY, "* Этот игрок не подлючен!");
	if(Pl::Info[params[0]][pAdmin] > Pl::Info[playerid][pAdmin]) return Send(playerid, COLOR_LIGHTRED, "* Вы не можете подорвать администратора!");
	Rac::SetPlayerHealth(params[0], 10.0);
	GetPlayerPos(params[0], posx, posy, posz);
	CreateExplosion(posx, posy, posz, 7, 10);
	getname(playerid -> sendername,params[0] -> playername);
	format(string, sizeof string, "[AdmWarn] * %s применил команду /exp к игроку %s[%s]", sendername, playername, FracInfo[Pl::FracID(params[0])][fName]);
	SendToAdmin(COLOR_YELLOW, string, 1, 3);
	return 1;
}

CMD:gmtest(playerid, params[]) { new string[144], sendername[24], playername[24];
	if(!Pl::isAdmin(playerid, MODER2LVL)) return Send(playerid, COLOR_GRAD1, "* Недостаточно прав!");
	if(sscanf(params, "u", params[0])) return Send(playerid, COLOR_GREY, "Введите: /gmtest [id]");
	if(!Pl::isLogged(params[0])) return Send(playerid, COLOR_GREY, "* Этот игрок не подлючен!");
	if(Pl::Info[params[0]][pAdmin] > Pl::Info[playerid][pAdmin]) return Send(playerid, COLOR_LIGHTRED, "* Вы не можете подорвать администратора!");
	GMTest{params[0]} = true;
	GetPlayerPos(params[0], posx, posy, posz);
	CreateExplosion(posx, posy, posz, 7, 10);
	SetTimerEx("onGMTest", 1000, false, "i", params[0]);
	getname(playerid -> sendername,params[0] -> playername);
	format(string, sizeof string, "[AdmWarn] * %s применил команду /gmtest к игроку %s[%s]", sendername, playername, FracInfo[Pl::FracID(params[0])][fName]);
	SendToAdmin(COLOR_YELLOW, string, 1, 3);
	return 1;
}

CMD:kick(playerid, params[]) { new string[144], sendername[24], playername[24];
	if(!Pl::isAdmin(playerid, MODER1LVL)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(sscanf(params, "us[64]", params[0], params[1])) return Send(playerid, COLOR_GREY, "Введите: /kick [id] [reason]");
	if(!IsPlayerConnected(params[0])) return Send(playerid, COLOR_GREY, "* Этот игрок не подлючен!");
	getname(playerid->sendername,params[0]->playername);
	format(string, sizeof string, ""#__SERVER_PREFIX""#__SERVER_NAME_LC": %s кикнут администратором %s, причина: %s", playername, sendername, params[1]);
	SendToAll(COLOR_LIGHTRED, string);
	printf("%s", string);
	Kick(params[0]);
	return 1;
}

CMD:skick(playerid, params[]) { new string[144], sendername[24], playername[24];
	if(!Pl::isLogged(playerid)) return Send(playerid, COLOR_GREY, "* Вы не авторизованы!");
	if(!Pl::isAdmin(playerid, SUPERMODER)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(sscanf(params, "us[64]", params[0], params[1])) return Send(playerid, COLOR_GREY, "Введите: /skick [id] [reason]");
	if(!IsPlayerConnected(params[0])) return Send(playerid, COLOR_GREY, "* Этот игрок не подлючен!");
	getname(playerid->sendername,params[0]->playername);
	format(string, sizeof string, "[AdmWarn] * %s применил команду /skick к игроку %s[%i], причина: %s", sendername, playername, params[0], params[1]);
	SendToAdmin(COLOR_YELLOW, string, 1, 3);
	Kick(params[0]);
	return 1;
}

CMD:kickers(playerid, params[]) { new string[144], sendername[24], playername[24];
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GRAD1, "* Недостаточно прав!");
	if(sscanf(params, "ds[64]", params[0], params[1])) return Send(playerid, COLOR_GREY, "Введите: /kickers [lvl] [reason]");
	GetPlayerName(playerid, sendername, 24);
	foreach(new p: Player) {
		if(Pl::isLogged(p)) {
			if(Pl::Info[p][pLevel] == params[0]) {
				GetPlayerName(playerid, playername, 24);
				format(string, sizeof string, "*"#__SERVER_PREFIX""#__SERVER_NAME_LC" %s кикнут администратором %s, причина: %s", playername, sendername, params[1]);
				SendToAll(COLOR_LIGHTRED, string);
				Kick(p);
			}
		}
	}
	return 1;
}

CMD:setlocal(playerid, params[]) { new string[144], sendername[24], playername[24];
	if(!Pl::isAdmin(playerid, MODER2LVL)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(sscanf(params, "ui", params[0], params[1])) return Send(playerid, COLOR_GREY, "Введите: /setlocal [id]");
	if(!Pl::isLogged(params[0])) return Send(playerid, COLOR_GREY, "* Этот игрок не авторизован!");
	Pl::Info[params[0]][pLocal] = params[1];
	getname(playerid->sendername,params[0]->playername);
	format(string, sizeof string, "[AdmWarn] * %s применил команду /setlocal к игроку %s[%d]", sendername, playername, params[0]);
	SendToAdmin(COLOR_YELLOW, string, 1, 3);
	return 1;
}

CMD:setvw(playerid, params[]) { new string[144], sendername[24], playername[24];
	if(!Pl::isAdmin(playerid, MODER2LVL)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(sscanf(params, "ui", params[0], params[1])) return Send(playerid, COLOR_GREY, "Введите: /setvw [id] [virtualworld]");
	if(!Pl::isLogged(params[0])) return Send(playerid, COLOR_GREY, "* Этот игрок не авторизован!");
	Rac::SetPlayerVirtualWorld(params[0], params[1]);
	getname(playerid->sendername,params[0]->playername);
	format(string, sizeof string, "[AdmWarn] * %s применил команду /setvw к игроку %s[%d]", sendername, playername, params[0]);
	SendToAdmin(COLOR_YELLOW, string, 1, 3);
	return 1;
}

CMD:setint(playerid, params[]) { new string[144], sendername[24], playername[24];
	if(!Pl::isAdmin(playerid, MODER2LVL)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(sscanf(params, "ui", params[0], params[1])) return Send(playerid, COLOR_GREY, "Введите: /setint [id] [interior]");
	if(!Pl::isLogged(params[0])) return Send(playerid, COLOR_GREY, "* Этот игрок не авторизован!");
	Rac::SetPlayerInterior(params[0], params[1]);
	getname(playerid->sendername,params[0]->playername);
	format(string, sizeof string, "[AdmWarn] * %s применил команду /setint к игроку %s[%d]", sendername, playername, params[0]);
	SendToAdmin(COLOR_YELLOW, string, 1, 3);
	return 1;
}

CMD:spcars(playerid, params[]) {
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return SendClientMessage(playerid, COLOR_GREY, "* Недостаточно прав!");
	for(new i; i < MAX_VEHICLES; i++) if(IsValidVehicle(i)) SetVehicleToRespawn(i);
	return 1;
}

CMD:vehid(playerid, params[]) { new string[144];
	if(!Pl::isAdmin(playerid, SUPERMODER)) return SendClientMessage(playerid, COLOR_GREY, "* Недостаточно прав!");
	
	new vehicle;
	if(IsPlayerInAnyVehicle(playerid)) {
		vehicle = GetPlayerVehicleID(playerid);
		format(string, sizeof string, "Vehicle [Model: %i; ID: %i]", GetVehicleModel(vehicle), vehicle);
		Send(playerid, COLOR_YELLOW, string);
	} else {
		vehicle = ClosestVeh(playerid, 3.0);
		format(string, sizeof string, "Vehicle [Model: %i; ID: %i]", GetVehicleModel(vehicle), vehicle);
		Send(playerid, COLOR_YELLOW, string);
	}
	return 1;
}

CMD:spcar(playerid, params[]) {
	if(!Pl::isAdmin(playerid, MODER2LVL)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(sscanf(params, "i", params[0])) return Send(playerid, COLOR_GREY, "Введите: /spcar [carid]");
	if(params[0] < 1 || params[0] > MAX_VEHICLES) return Send(playerid, COLOR_GREY, "* Транспорта с таким ID не существует!");
	SetVehicleToRespawn(params[0]);
	return 1;
}

CMD:dc(playerid, params[]) {
	if(!Pl::isAdmin(playerid, MODER2LVL)) return Send(playerid, COLOR_GREY,"* Недостаточно прва!");
	if(sscanf(params, "i", params[0])) {
		if(!IsPlayerInAnyVehicle(playerid)) return Send(playerid, COLOR_GREY,"Введите: /dc [vehid]");
		new vehid = GetPlayerVehicleID(playerid);
		Iter::Remove(CreatedCars, vehid);
		Veh::Destroy(vehid);
		Send(playerid, COLOR_YELLOW, "* Машина удалена!");
		return 1;
	}
	if(params[0] < 1 || params[0] > MAX_VEHICLES) return Send(playerid, COLOR_GREY, "* Транспорта с таким ID не существует!");
	Iter::Remove(CreatedCars, params[0]); Veh::Destroy(params[0]);
	Send(playerid, COLOR_YELLOW, "* Машина удалена!");
	
	return 1;
}

CMD:alldc(playerid, params[]) {
	if(!Pl::isAdmin(playerid, SUPERMODER)) return Send(playerid,COLOR_RED,"* Недостаточно прва!");
	new temp_veh;
	foreach(new veh : CreatedCars) {
		temp_veh = veh;
		Veh::Destroy(temp_veh);
	}
	Iter::Clear(CreatedCars);
	Send(playerid, COLOR_YELLOW, "* Машины были унечтожены!");
	return 1;
}

CMD:warn(playerid, params[]) { new string[144], sendername[24], playername[24];
	if(!Pl::isAdmin(playerid, MODER2LVL)) return Send(playerid, COLOR_GRAD2, "* Недостаточно прав!");
	if(sscanf(params, "us[64]", params[0], params[1])) return Send(playerid, COLOR_GRAD2, "Введите: /warn [id] [reason]");
	if(Pl::isAdmin(params[0], 1) && !Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GRAD2, "* Вы не можите выдать варн админу!");
	if(!Pl::isLogged(params[0])) return Send(playerid, COLOR_GREY, "* Игрок не авторизирован!");
	Pl::Info[params[0]][pWarns] += 1;
	if(Pl::Info[params[0]][pWarns] >= 3) {
		format(string, sizeof string, "%s (3 Warns)", params[1]);
		Pl::Info[params[0]][pWarns] = 0;
		AddBanList(params[0], playerid, 3*1440, string, 1);
		return 1;
	}
	getname(playerid -> sendername, params[0] -> playername);
	format(string, sizeof string, "[AdmWarn] * %s применил команду /warn к игроку %s[%d]. Причина: %s", sendername, playername, params[0], params[1]);
	SendToAdmin(COLOR_YELLOW, string, 1, 3);
	format(string, sizeof string, "* Администратор %s выдал Вам предупреждение. Причина: %s", sendername, params[1]);
	Send(params[0], COLOR_LIGHTRED, string);
	return 1;
}

CMD:clearwarn(playerid, params[]) { new string[144], sendername[24], playername[24];
	if(!Pl::isAdmin(playerid, SUPERMODER)) return Send(playerid, COLOR_GRAD2, "* Недостаточно прав!");
	if(sscanf(params, "u", params[0])) return Send(playerid, COLOR_GRAD2, "Введите: /clearwarn [id]");
	if(Pl::isAdmin(params[0], 1) && !Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GRAD2, "* Вы не можите снимать варн с админа!");
	if(!Pl::isLogged(params[0])) return Send(playerid, COLOR_GREY, "* Игрок не авторизирован!");
	if(Pl::Info[params[0]][pWarns] <= 0) return Send(playerid, COLOR_GREY,"* У игрока нет варнов!");
	Pl::Info[params[0]][pWarns] = 0;
	getname(playerid -> sendername, params[0] -> playername);
	format(string, sizeof string, "[AdmWarn] * %s применил команду /clearwarn к игроку %s[%i].", sendername, playername, params[0]);
	SendToAdmin(COLOR_YELLOW, string, 1, 3);
	format(string, sizeof string, "* Администратор %s снял с Вас все предупреждения.", sendername);
	Send(params[0], COLOR_LIGHTBLUE, string);
	return 1;
}

CMD:cc(playerid, params[]) { new string[144], sendername[24];
	if(!Pl::isAdmin(playerid, SUPERMODER)) return Send(playerid, COLOR_GRAD2, "* Недостаточно прав!");
	for(new i; i != 50; i++) SendToAll(COLOR_WHITE," ");
	GetPlayerName(playerid, sendername, 24);
	format(string, sizeof string, "* Администратор %s[%i] очистил все чаты сервера!", sendername, playerid);
	SendToAll(COLOR_USE, string);
	return 1;
}

CMD:banacc(playerid, params[]) { new string[144], sendername[24], playername[24];
	if(!Pl::isAdmin(playerid, SUPERMODER)) return Send(playerid, COLOR_GRAD1, "* Недостаточно прав!");
	if(sscanf(params, "s[24]s[24]", playername, temp)) return Send(playerid, COLOR_GREY, "Введите: /banacc [id] [reason]");
	params[0] = ReturnUser(playername);
	if(!IsPlayerConnected(params[0])) {
		format(query, sizeof query, "UPDATE `"#__TableUsers__"` SET `Banned` = '1' WHERE BINARY `Name` = '%s'", playername);
		new Cache:result = Db::query(connDb, query, true);
		if(cache_affected_rows()) {
			GetPlayerName(playerid, sendername, 24);
			format(string, sizeof string, "[AdmWarn] * %s заблокировал аккаунт %s, причина: %s", sendername, playername, temp);
			SendToAdmin(COLOR_YELLOW, string, 3, 3);
		} else {
			Send(playerid, COLOR_GREY, "* Нет такого аккаунта!");
		}
		cache_delete(result);
	} else {
		getname(playerid->sendername, params[0]->playername);
		format(string, sizeof string, "*"#__SERVER_PREFIX""#__SERVER_NAME_LC": %s был заблокирован администратором %s, причина: %s", playername, sendername, temp);
		SendToAll(COLOR_LIGHTRED, string);
		Pl::Info[params[0]][pBanned] = 1;
		Kick(params[0]);
	}
	return 1;
}

CMD:unbanacc(playerid, params[]) { new string[144], sendername[24], playername[24];
	if(!Pl::isAdmin(playerid, SUPERMODER)) return Send(playerid, COLOR_GRAD1, "* Недостаточно прав!");
	if(sscanf(params, "s[24]s[24]", playername, temp)) return Send(playerid, COLOR_GREY, "Введите: /unbanacc [id] [reason]");
	params[0] = ReturnUser(playername);
	if(!IsPlayerConnected(params[0])) {
		format(query, sizeof query, "UPDATE `"#__TableUsers__"` SET `Banned` = '0' WHERE BINARY `Name` = '%s'", playername);
		new Cache:result = Db::query(connDb, query, true);
		if(cache_affected_rows()) {
			GetPlayerName(playerid, sendername, 24);
			format(string, sizeof string, "[AdmWarn] * %s разблокировал аккаунт %s. Причина: %s", sendername, playername, temp);
			SendToAdmin(COLOR_YELLOW, string, 3, 3);
		} else {
			Send(playerid, COLOR_GREY, "* Нет такого аккаунта!");
		}
		cache_delete(result);
	} else {
		Send(playerid, COLOR_GREY, "* Этот аккаунт не заблокирован!");
	}
	return 1;
}

CMD:ban(playerid, params[]) { new string[144];
	if(!Pl::isAdmin(playerid, MODER2LVL)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(sscanf(params, "uis[64]", params[0], params[1], temp)) return Send(playerid, COLOR_GREY, "Введите: /ban [id] [days (1-360)] [reason]");
	if(!IsPlayerConnected(params[0])) return Send(playerid, COLOR_GREY, "* Этот игрок не подлючен!");
	if(Pl::Info[params[0]][pID] == -1) return Send(playerid, COLOR_GREY, "* Этот игрок не зарегистрирован!");
	if(Pl::isAdmin(params[0], 1) && !IsPlayerAdmin(playerid)) return Send(playerid, COLOR_GREY, "* Нельзя банить админа!");
	static const maxdays[] = {0, 10, 20, 60, 90, 360};
	if(!(1 <= params[1] <= maxdays[Pl::Info[playerid][pAdmin]])) {
		format(string, sizeof string, "* Кол-во дней бана может быть от 1 до %i!", maxdays[Pl::Info[playerid][pAdmin]]);
		Send(playerid, COLOR_GREY, string);
	} else {
		AddBanList(params[0], playerid, params[1]*1440, temp, 1);
	}
	return 1;
}

CMD:sban(playerid, params[]) { new string[144];
	if(!Pl::isAdmin(playerid, SUPERMODER)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(sscanf(params, "uis[64]", params[0], params[1], temp)) return Send(playerid, COLOR_GREY, "Введите: /sban [id] [days (1-360)] [reason]");
	if(!IsPlayerConnected(params[0])) return Send(playerid, COLOR_GREY, "* Этот игрок не подлючен!");
	if(Pl::Info[params[0]][pID] == -1) return Send(playerid, COLOR_GREY, "* Этот игрок не зарегистрирован!");
	if(Pl::isAdmin(params[0], 1) && !IsPlayerAdmin(playerid)) return Send(playerid, COLOR_RED, "* Нельзя банить админа!");
	static const maxdays[] = {0, 10, 20, 60, 90, 360};
	if(!(1 <= params[1] <= maxdays[Pl::Info[playerid][pAdmin]])) {
		format(string, sizeof string, "* Кол-во дней бана может быть от 1 до %i!", maxdays[Pl::Info[playerid][pAdmin]]);
		Send(playerid, COLOR_GREY, string);
	} else {
		AddBanList(params[0], playerid, params[1]*1440, temp, -1);
	}
	return 1;
}

CMD:oban(playerid, params[]) { new string[144], sendername[24], playername[24];
	if(!Pl::isAdmin(playerid, SUPERMODER)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(sscanf(params, "s[24]is[64]", playername, params[0], temp)) return Send(playerid, COLOR_GREY, "Введите: /oban [id] [days (1-360)] [reason]");
	if(IsPlayerConnected(ReturnUser(playername))) return Send(playerid, COLOR_GREY, "* Этот игрок подлючен!");
	static const maxdays[] = {0, 10, 20, 60, 90, 360};
	if(!(1 <= params[0] <= maxdays[Pl::Info[playerid][pAdmin]])) {
		format(string, sizeof string, "* Кол-во дней бана может быть от 1 до %i!", maxdays[Pl::Info[playerid][pAdmin]]);
		Send(playerid, COLOR_GREY, string);
	}
	
	new banid = GetIDFromName(playername);
	if(banid == -1) return Send(playerid, COLOR_GREY, "* Нет такого игрока на сервере!");
	if(isBanned(banid)) return Send(playerid, COLOR_GREY, "* Этот игрок уже забанен!");
	
	new unbandate, currdate = gettime(), reason[64];
	unbandate = currdate + (params[0]*1440)*60;
	Db::escape_string(temp, reason);
	GetPlayerName(playerid, sendername, 24);
	format(query, sizeof query, "INSERT INTO `"#__TableBanned__"` (`user_id`,`admin_id`,`date`,`unbandate`,`reason`) VALUES (");
	scf(query, src, "'%i','%i',", banid, Pl::Info[playerid][pID]);
	scf(query, src, "'%i','%i','%s')", currdate, unbandate, reason);
	Db::tquery(connDb, query, "", "");
	
	format(query, sizeof query, "[OFFBAN] Админ %s забанил игрока %s, причина: %s", sendername, playername, reason);
	SendToAdmin(COLOR_LIGHTBLUE, query, 1, 3);
	return 1;
}

CMD:unban(playerid, params[]) {
	if(!Pl::isAdmin(playerid, MODER1LVL)) return Send(playerid, COLOR_GRAD1, "* Недостаточно прав!");
	if(sscanf(params, "s[24]", params[0])) return Send(playerid, COLOR_GREY, "Введите: /unban [Name]");
	ShowPlayerBanList(playerid, params[0]);
	return 1;
}

CMD:reloadbans(playerid, params[]) {
	if(!Pl::isLogged(playerid)) return Send(playerid, COLOR_GREY, "* Вы не авторизованы!");
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GRAD1, "* Недостаточно прав!");
	SendRconCommand("reloadbans");
	return Send(playerid,COLOR_LIGHTBLUE, "* File \"samp.ban\" successfully reloaded!");
}

CMD:getip(playerid, params[]) { new string[144];
	if(!Pl::isAdmin(playerid, SUPERMODER)) return Send(playerid, COLOR_GRAD1, "* Недостаточно прав!");
	if(sscanf(params, "u", params[0])) return Send(playerid, COLOR_GREY, "Введите: /getip [id]");
	if(!IsPlayerConnected(params[0])) return Send(playerid, COLOR_GREY, "* Этот игрок не подлючен!");
	if(Pl::isAdmin(params[0], ADMINISTRATOR) && !Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GREY, "* Вы не может узнавать IP адрес этого игрока");
	format(string, sizeof string, "* %s[ID: %i] IP: %s", GetName(params[0]), params[0], GetPIP(params[0]));
	return Send(playerid,COLOR_LIGHTBLUE,string);
}

CMD:banip(playerid, params[]) { new string[144], sendername[24];
	if(!Pl::isAdmin(playerid, MODER3LVL)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(sscanf(params, "s[16]", params[0])) return Send(playerid, COLOR_GREY, "Введите: /banip [ip]");
	format(string,sizeof string,"banip %s", params[0]);
	SendRconCommand(string);
	GetPlayerName(playerid, sendername, 24);
	format(string, sizeof string, "[AdmWarn] * %s забанил IP-адрес %s", sendername, params[0]);
	SendToAdmin(COLOR_LIGHTRED, string, 1, 3);
	return 1;
}

CMD:unbanip(playerid, params[]) { new string[144], sendername[24];
	if(!Pl::isAdmin(playerid, MODER3LVL)) return Send(playerid, COLOR_GRAD1, "* Недостаточно прав!");
	if(sscanf(params, "s[16]", params[0])) return Send(playerid, COLOR_GREY, "Введите: /unbanip [ip]");
	format(string,sizeof string,"unbanip %s", params[0]);
	SendRconCommand(string);
	SendRconCommand("reloadbans");
	GetPlayerName(playerid, sendername, 24);
	format(string, sizeof string, "[AdmWarn] * %s разбанил IP-адрес %s", sendername, params[0]);
	SendToAdmin(COLOR_YELLOW, string, 1, 3);
	return 1;
}

CMD:gotocar(playerid, params[]) {
	if(!Pl::isAdmin(playerid, SUPERMODER)) return Send(playerid, COLOR_GRAD1, "* Недостаточно прав!");
	if(sscanf(params, "d", params[0])) return Send(playerid, COLOR_GRAD1, "Введите: /gotocar [carid]");
	GetVehiclePos(params[0], posx, posy, posz);
	if(GetPlayerState(playerid) == 2) Rac::SetVehiclePos(GetPlayerVehicleID(playerid), posx+3, posy+3, posz);
	else Rac::SetPlayerPos(playerid, posx+3, posy+3, posz);
	Rac::SetPlayerVirtualWorld(playerid, 0); Rac::SetPlayerInterior(playerid, 0);
	Send(playerid, COLOR_GRAD1, " Вы были телепортированы");
	return 1;
}

CMD:freeze(playerid, params[]) { new string[144], sendername[24], playername[24];
	if(!Pl::isAdmin(playerid, MODER1LVL)) return Send(playerid, COLOR_GRAD1, "* Недостаточно прав!");
	if(sscanf(params, "u", params[0])) return Send(playerid, COLOR_GRAD2, "Введите: /freeze [playerid]");
	if(!Pl::isLogged(params[0])) return Send(playerid, COLOR_GREY, "* Этот игрок не авторизован!");
	if(Pl::isAdmin(params[0], 1) && !Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GREY, "* Администратор не может быть заморожен!");
	getname(playerid -> sendername,params[0] -> playername);
	if(params[0] != playerid) {
		format(string, sizeof string, "[AdmWarn] * %s применил команду /freeze к игроку %s[%s]", sendername, playername, FracInfo[Pl::FracID(params[0])][fName]);
		SendToAdmin(COLOR_YELLOW, string, 1, 3);
	}
	Rac::TogglePlayerControllable(params[0], 0);
	format(string, sizeof string, "* Вы были заморожены администратором %s", sendername);
	Send(params[0], COLOR_LIGHTRED, string);
	return 1;
}

CMD:unfreeze(playerid, params[]) { new string[144], sendername[24], playername[24];
	if(!Pl::isAdmin(playerid, MODER1LVL)) return Send(playerid, COLOR_GRAD1, "* Недостаточно прав!");
	if(sscanf(params, "u", params[0])) return Send(playerid, COLOR_GRAD2, "Введите: /unfreeze [playerid]");
	if(!Pl::isLogged(params[0])) return Send(playerid, COLOR_GREY, "* Этот игрок не авторизован!");
	Rac::TogglePlayerControllable(params[0], 1);
	getname(playerid->sendername,params[0]->playername);
	if(params[0] != playerid) {
		format(string, sizeof string, "[AdmWarn] * %s применил команду /unfreeze к игроку %s[%s]", sendername, playername, FracInfo[Pl::FracID(params[0])][fName]);
		SendToAdmin(COLOR_YELLOW, string, 1, 3);
	}
	format(string, sizeof string, "* Вы были разморожены администратором %s", sendername);
	Send(params[0],COLOR_LIGHTRED,string);
	return 1;
}

CMD:gmx(playerid, params[]) {
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GRAD1, "* Недостаточно прав!");
	SendToAll(COLOR_LIGHTGREEN, "ВНИМАНИЕ! Происходит рестарт сервера!");
	SetTimerEx("GameModeInitExitFunc", 10000, false, "i", 0);
	return 1;
}

CMD:makeadmin(playerid, params[]) { new string[144], sendername[24], playername[24];
	if(!Pl::isAdmin(playerid, 4) && !IsPlayerAdmin(playerid)) return Send(playerid, COLOR_GRAD1, "* Недостаточно прав!");
	if(sscanf(params, "ui", params[0], params[1])) return Send(playerid, COLOR_GRAD2, "Введите: /makeadmin [id/Name] [level(1-4)]");
	if(!Pl::isLogged(params[0])) return Send(playerid, COLOR_GREY, "* Этот игрок не авторизован!");
	if(params[1] > 3 && !IsPlayerAdmin(playerid)) return Send(playerid, COLOR_GREY, "* Уровень админа может быть от 0 до 3!");
	if(!params[1] && Pl::Info[params[0]][pAdmin]) Iter::Remove(AdminPlayers, params[0]);
	else if(params[1] && !Pl::Info[params[0]][pAdmin]) Iter::Add(AdminPlayers, params[0]);
	Pl::Info[params[0]][pAdmin] = params[1]; 
	getname(playerid -> sendername, params[0] -> playername);
	format(string, sizeof string, "* You have been promoted to a level %d admin by %s.", params[1], sendername);
	Send(params[0], COLOR_LIGHTBLUE, string);
	format(string, sizeof string, "* You are promoted %s to admin level %d.", playername, params[1]);
	Send(playerid, COLOR_LIGHTBLUE, string);
	return 1;
}

CMD:ganginfo(playerid, params[]) { 
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GREY,  "* Недостаточно прав!");
	if(sscanf(params, "d", params[0])) return Send(playerid, COLOR_GREY,  "Введите: /ganginfo [fracid]");
	for(new g; g < sizeof(GangInfo); g++) {
		if(GangInfo[g][fID] == params[0]) {
			DestroyDynamic3DTextLabel(GangInfo[g][gText]);
			GetPlayerPos(playerid, GangInfo[g][gPosX], GangInfo[g][gPosY], GangInfo[g][gPosZ]);
			format(temp, sizeof(temp), "*** GANG INFO ***\n\n.::%s::.\nБизнесы: %d\nУважение: %d\n Банк: $%d\nЗахват с %d ранга",
			GetGangName(GangInfo[g][fID]), GangBiznes{GangInfo[g][fID]}, GangInfo[g][gRespect], GetFracMoney(GangInfo[g][fID]), GetZRank(GangInfo[g][fID]));
			GangInfo[g][gText] = Add3DText(temp, GetFracColor(GangInfo[g][fID]), GangInfo[g][gPosX], GangInfo[g][gPosY], GangInfo[g][gPosZ], 15.0);
			break;
		}
	}
	return 1;
}

CMD:setskill(playerid, params[]) { new string[144];
	if(!Pl::isAdmin(playerid, MODER3LVL)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(sscanf(params, "udd", params[0], params[1], params[2])) {
		Send(playerid, COLOR_WHITE, "| Skill Info |");
		Send(playerid, COLOR_GREY,  "| 1: Детектив      | 6: Репортер");
		Send(playerid, COLOR_GREY,  "| 2: Адвокат       | 7: Механник");
		Send(playerid, COLOR_GREY,  "| 3: Шлюха         | 8: Продователь тачек");
		Send(playerid, COLOR_GREY,  "| 4: Наркоторговец | 9: Боксер");
		Send(playerid, COLOR_GREY,  "| 5: Угонщик тачек | 10: Рыбак");
		Send(playerid, COLOR_WHITE, "||");
		Send(playerid, COLOR_WHITE, "Введите: /setskill [playerid] [number] [уровень]");
		return 1;
	}
	if(!Pl::isLogged(params[0])) return Send(playerid, COLOR_GREY, "* Этот игрок не в игре!");
	if( params[2] < 1 || params[2] > 5 ) return Send(playerid, COLOR_GREY, "* Значение скилла может быть от 1 и до 5!");
	switch(params[1]) {
		case 1: {
			Pl::Info[params[0]][pSkill][0] = ( params[2] * 100 );
			format(string,sizeof string," Его скилл детектива теперь %d", Pl::Info[params[0]][pSkill][0]);
		}
		case 2: {
			Pl::Info[params[0]][pSkill][2] = ( params[2] * 100 );
			format(string,sizeof string," Его скилл адвоката теперь %d",Pl::Info[params[0]][pSkill][2]);
		}
		case 3: {
			Pl::Info[params[0]][pSkill][1] = ( params[2] * 100 );
			format(string,sizeof string," Его скилл шлюхи теперь %d",Pl::Info[params[0]][pSkill][1]);
		}
		case 4: {
			Pl::Info[params[0]][pSkill][7] = ( params[2] * 100 );
			format(string,sizeof string," Его скилл наркодиллера теперь %d",Pl::Info[params[0]][pSkill][7]);
		}
		case 5: {
			Pl::Info[params[0]][pSkill][4] = ( params[2] * 100 );
			format(string,sizeof string," Его скилл угонщика теперь %d",Pl::Info[params[0]][pSkill][4]);
		}
		case 6: {
			Pl::Info[params[0]][pSkill][3] = ( params[2] * 100 );
			format(string,sizeof string," Его скилл механника теперь %d",Pl::Info[params[0]][pSkill][3]);
		}
		case 7: {
			Pl::Info[params[0]][pSkill][6] = ( params[2] * 100 );
			format(string,sizeof string," Его скилл репортера теперь %d",Pl::Info[params[0]][pSkill][6]);
		}
		case 8: {
			Pl::Info[params[0]][pSkill][5] = ( params[2] * 100 );
			format(string,sizeof string," Его скилл продовальника тачек теперь %d",Pl::Info[params[0]][pSkill][5]);
		}
		default: format(string,sizeof string," Неверный ID скила!");
	}
	Send(playerid, COLOR_GREY, string);
	return 1;
}

CMD:fracs(playerid, params[]) { new string[144];
	if(!Pl::isAdmin(playerid, SUPERMODER)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	Send(playerid, COLOR_WHITE, "______________|FRAC|______________");
	for(new i; i < sizeof FracID; i++) {
		format(string, sizeof string,
			"%i. %s [Казна: $%i; Онлайн: %i]",
			i+1,
			FracInfo[FracID[i]][fName],
			GetFracMoney(FracID[i]),
			Iter::Count(TeamPlayers[FracID[i]])
		);
		Send(playerid, GetFracColor(FracID[i]), string);
	}
	return 1;
}

CMD:fracbank(playerid, params[]) { new string[144];
	if(!Pl::isAdmin(playerid, SUPERMODER)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(sscanf(params, "i", params[0])) return Send(playerid, COLOR_GREY, "Введите: /checkbank [fracid]");
	if(!IsValidFrac(params[0])) return Send(playerid, COLOR_GREY, "* Неверный ID фракции!");
	format(string, sizeof string, "* Банк %s состовляет: $%i", FracInfo[params[0]][fName], GetFracMoney(params[0]));
	Send(playerid, COLOR_YELLOW, string);
	return 1;
}

CMD:spawn(playerid, params[]) { new string[144], sendername[24], playername[24];
	if(!Pl::isAdmin(playerid, MODER2LVL)) return Send(playerid, COLOR_GREY, "Недостаточно прав!");
	if(sscanf(params, "u", params[0])) return Send(playerid, COLOR_GREY, "Введите: /spawn [id/Name]");
	if(!Pl::isLogged(params[0])) return Send(playerid, COLOR_GREY, "* Этот игрок не залогинен!");
	getname(playerid -> sendername,params[0] -> playername);
	format(string, sizeof string, "[AdmWarn] * %s применил команду /spawn к игроку %s[%s]", sendername, playername, FracInfo[Pl::FracID(params[0])][fName]);
	SendToAdmin(COLOR_YELLOW, string, 3, 3); Rac::SpawnPlayer(params[0]);
	
	return 1;
}

CMD:forceskin(playerid, params[]) {
	if(!Pl::isAdmin(playerid, MODER2LVL)) return Send(playerid, COLOR_GREY, "Недостаточно прав!");
	if(sscanf(params, "u", params[0])) return Send(playerid, COLOR_GREY, "Введите: /forceskin [id/Name]");
	if(!Pl::isLogged(playerid)) return Send(playerid, COLOR_GREY, "* Этот игрок не залогинен!");
	
	new bidx = GetIndexFromBizID(Bizz_ProLaps);
	Rac::SetPlayerInterior(params[0], 3);
	Rac::SetPlayerVirtualWorld(params[0], BizzInfo[bidx][bVirtual]);
	Pl::Info[params[0]][pLocal] = OFFSET_BIZZ + bidx;
	Rac::SetPlayerPos(params[0], 207.4872,-129.2266,1003.5078);
	Container::At( Pl::FracID(params[0]), Container::First, SelectCharPlace[params[0]], ChosenSkin[params[0]]);
	SetPlayerSkin(params[0], ChosenSkin[params[0]]);
	ShowMenuForPlayer(ClothesMenu, params[0]);
	Rac::TogglePlayerControllable(params[0], 0);
	
	return 1;
}

CMD:henter(playerid, params[]) { new string[144];
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(sscanf(params, "i", params[0])) return Send(playerid, COLOR_GREY, "Введите: /houseenter [houseid]");
	if(!IsValidHouse(params[0])) return Send(playerid,COLOR_RED,"* Неверный ид дома");
	GetPlayerPos(playerid, HouseInfo[params[0]][hEnter][0], HouseInfo[params[0]][hEnter][1], HouseInfo[params[0]][hEnter][2]);
	GetPlayerFacingAngle(playerid, HouseInfo[params[0]][hEnter][3]);
	
	DestroyDynamicPickup(HouseInfo[params[0]][hPickup]);
	DestroyDynamicMapIcon(HouseInfo[params[0]][hMapIcon]);
	if(HouseInfo[params[0]][hOwned] == 1) {
		HouseInfo[params[0]][hPickup] = AddPickup(1318, 23, HouseInfo[params[0]][hEnter][0], HouseInfo[params[0]][hEnter][1], HouseInfo[params[0]][hEnter][2]);
		HouseInfo[params[0]][hMapIcon] = CreateDynamicMapIcon(HouseInfo[params[0]][hEnter][0], HouseInfo[params[0]][hEnter][1], HouseInfo[params[0]][hEnter][2],32,0,-1,-1,-1,350.0);
	} else {
		HouseInfo[params[0]][hPickup] = AddPickup(1273, 23, HouseInfo[params[0]][hEnter][0], HouseInfo[params[0]][hEnter][1], HouseInfo[params[0]][hEnter][2]);
		HouseInfo[params[0]][hMapIcon] = CreateDynamicMapIcon(HouseInfo[params[0]][hEnter][0], HouseInfo[params[0]][hEnter][1], HouseInfo[params[0]][hEnter][2],31,0,-1,-1,-1,350.0);
	}
	format(string,sizeof string,"* Вход дома №%i был перенесен в %.3f, %.3f, %.3f координаты.", params[0], HouseInfo[params[0]][hExit][0], HouseInfo[params[0]][hExit][1], HouseInfo[params[0]][hExit][2]);
	Send(playerid, COLOR_YELLOW, string);
	return 1;
}

CMD:hexit(playerid, params[]) { new string[144];
	if(!Pl::isLogged(playerid)) return Send(playerid, COLOR_GREY, "* Вы не залогинены!");
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(sscanf(params, "d", params[0])) return Send(playerid, COLOR_GREY, "* Введите: /houseeexit [houseid]");
	if(!IsValidHouse(params[0])) return Send(playerid,COLOR_RED,"* Неверный ID дома");

	GetPlayerPos(playerid, HouseInfo[params[0]][hExit][0], HouseInfo[params[0]][hExit][1], HouseInfo[params[0]][hExit][2]);
	GetPlayerFacingAngle(playerid, HouseInfo[params[0]][hExit][3]);
	HouseInfo[params[0]][hInt] = GetPlayerInterior(playerid);
	SetPlayerVirtualWorld(playerid, params[0]);
	format(string,sizeof string,"* Выход дома №%i был перенесен в %.3f, %.3f, %.3f координаты.", params[0], HouseInfo[params[0]][hExit][0], HouseInfo[params[0]][hExit][1], HouseInfo[params[0]][hExit][2]);
	Send(playerid, COLOR_YELLOW, string);
	return 1;
}

CMD:bizicon(playerid, params[]) {
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(sscanf(params, "iiI(0)", params[0], params[1], params[2])) return Send(playerid, COLOR_GREY, "* Введите: /bizenter [bizid] [iconid]");
	if(!IsValidBiz(params[0])) return Send(playerid,COLOR_WHITE,"* Неправильный id бизнеса!");
	new bidx = GetIndexFromBizID(params[0]);
	BizzInfo[bidx][bIcon][params[2]] = params[1];
	UpdateBizzPickups(bidx);
	Send(playerid, COLOR_YELLOW, "* Иконка была изменина!");
	return 1;
}

CMD:bizenter(playerid, params[]) { new string[144];
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(sscanf(params, "d", params[0])) return Send(playerid, COLOR_GREY, "* Введите: /bizenter [bizid]");
	if(!IsValidBiz(params[0])) return Send(playerid,COLOR_WHITE,"* Неправильный id бизнеса!");

	new bidx = GetIndexFromBizID(params[0]);
	GetPlayerPos(playerid, BizzInfo[bidx][bEnter][0], BizzInfo[bidx][bEnter][1], BizzInfo[bidx][bEnter][2]);
	GetPlayerFacingAngle(playerid, BizzInfo[bidx][bEnter][3]);

	// Пресоздаем гангзону
	Gz::Destroy(BizzInfo[bidx][bZone]);
	GetSquarePos(BizzInfo[bidx][bEnter][0], BizzInfo[bidx][bEnter][1], MAX_ZONE_SIZE, BizzInfo[bidx][bzMinX], BizzInfo[bidx][bzMinY], BizzInfo[bidx][bzMaxX], BizzInfo[bidx][bzMaxY]);
	BizzInfo[bidx][bZone] = Gz::Create(BizzInfo[bidx][bzMinX], BizzInfo[bidx][bzMinY], BizzInfo[bidx][bzMaxX], BizzInfo[bidx][bzMaxY]);
	Gz::ShowForAll(BizzInfo[bidx][bZone], GetFracColor(BizzInfo[bidx][bFrac]));

	// Пересоздаем пикап и иконку
	UpdateBizzPickups(bidx);
	format(string,sizeof string,"* Вход в %d бизнес был перенесен!", BizzInfo[bidx][bID]);
	Send(playerid, COLOR_YELLOW, string);
	return 1;
}

CMD:bizexit(playerid, params[]) {
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(sscanf(params, "d", params[0])) return Send(playerid, COLOR_GREY, "Введите: /bizexit [id]!");
	if(!IsValidBiz(params[0])) return Send(playerid,COLOR_WHITE,"* Неправильный id бизнеса!");

	new l = GetIndexFromBizID(params[0]);
	GetPlayerPos(playerid, BizzInfo[l][bExit][0], BizzInfo[l][bExit][1], BizzInfo[l][bExit][2]);
	GetPlayerFacingAngle(playerid, BizzInfo[l][bExit][3]);
	BizzInfo[l][bInterior] = GetPlayerInterior(playerid);
	DestroyDynamicPickup(BizzInfo[l][bPickupExit]);
	BizzInfo[l][bPickupExit] = AddPickup(1318, 23, BizzInfo[l][bExit][0], BizzInfo[l][bExit][1], BizzInfo[l][bExit][2], BizzInfo[l][bVirtual]);
	Rac::SetPlayerVirtualWorld(playerid, BizzInfo[l][bVirtual]);
	Send(playerid, COLOR_GREY, "* Пикап выхода из бизнеса был перенесен!");
	return 1;
}

CMD:bizgang(playerid, params[]) { new string[144];
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(sscanf(params, "i", params[0])) return Send(playerid, COLOR_GREY, "* Введите: /bizgang [gangid]");
	if(!IsAGangF(params[0])) return Send(playerid,COLOR_LIGHTRED,"Неправильный ид банды!");
	foreach(new i : Biznes) {
		if(IsPlayerInSquare2D(playerid, MAX_ZONE_SIZE, BizzInfo[i][bEnter][0], BizzInfo[i][bEnter][1], 0) && !BizzInfo[i][bOnBattle]) {
			GangBiznes{params[0]} ++;
			GangBiznes{BizzInfo[i][bFrac]} --;
			BizzInfo[i][bFrac] = params[0];
			Gz::StopFlashForAll(BizzInfo[i][bZone]);
			Gz::HideForAll(BizzInfo[i][bZone]);
			Gz::ShowForAll(BizzInfo[i][bZone], GetFracColor(params[0]));
			UpdateGangInfo();
			
			format(string, sizeof string, "* Теперь бизнез будут крышивать %s.", GetGangName(params[0]));
			Send(playerid, COLOR_YELLOW, string);
			
			return 1;
		}
	}
	return 1;
}

CMD:makehelper(playerid, params[]) { new string[144], sendername[24], playername[24];
	if(!IsPHelper(playerid, 3) && !Pl::isAdmin(playerid, 4)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(sscanf(params, "ud", params[0], params[1])) return Send(playerid, COLOR_GRAD1, "Введите: /makehelper [id] [lvl]");
	if(!Pl::isLogged(params[0])) return Send(playerid, COLOR_GREY, "* Этот игрок не залогинен!");
	if(params[1] < 0 || params[1] > 3) return Send(playerid, COLOR_GREY, "Не меньше '0' и не больше '3'.");
	if(params[1] == 0 && Pl::Info[params[0]][pHelper] > 0) Iter::Remove(HelperPlayers, params[0]);
	else if(Pl::Info[params[0]][pHelper] == 0 && params[1] > 0) Iter::Add(HelperPlayers, params[0]);
	getname(playerid -> sendername, params[0] -> playername);
	Pl::Info[params[0]][pHelper] = params[1];
	format(string, sizeof string, "You have been promoted to a level %d helper by %s.", params[1], sendername);
	Send(params[0], COLOR_LIGHTBLUE, string);
	format(string, sizeof string, "You are promoted %s to helper level %d.", playername, params[1]);
	Send(playerid, COLOR_LIGHTBLUE, string);
	return 1;
}

CMD:hirecar(playerid, params[]) { new string[144];
	if(!Pl::isAdmin(playerid, MODER3LVL)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	new vehicle = ClosestVeh(playerid, 3.0);
	if(vehicle == INVALID_VEHICLE_ID) return Send(playerid, COLOR_GREY, "* С вами рядом нет машин!");
	HireCar[playerid] = vehicle;
	format(string, sizeof string, "* Вы сделали ключи для машины %i.", vehicle);
	Send(playerid, COLOR_GRAD4, string);
	Send(playerid, COLOR_WHITE, "* Используйте: /lock.");
	return 1;
}

CMD:setmats(playerid, params[]) { new string[144], sendername[24], playername[24];
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return 1;
	if(sscanf(params, "ud", params[0], params[1])) return Send(playerid, COLOR_WHITE, "Введите: /makemats [playerid] [кол-во]");
	if(!Pl::isLogged(params[0])) return Send(playerid, COLOR_GREY, "* Этот игрок не авторизован!");
	getname(playerid -> sendername,params[0] -> playername);
	format(string, sizeof string, "[AdmWarn] * %s применил команду /setmats к игроку %s[%s]. Было: %i; Стало: %i",
	sendername, playername, FracInfo[Pl::FracID(params[0])][fName], Pl::Info[params[0]][pMats], params[1]);
	SendToAdmin(COLOR_YELLOW, string, 1, 3); Pl::Info[params[0]][pMats] = params[1];
	return 1;
}

CMD:setdrugs(playerid, params[]) { new string[144], sendername[24], playername[24];
	if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return 1;
	if(sscanf(params, "ud", params[0], params[1])) return Send(playerid, COLOR_WHITE, "Введите: /makedrugs [playerid] [кол-во]");
	if(!Pl::isLogged(params[0])) return Send(playerid, COLOR_GREY, "* Этот игрок не авторизован!");
	getname(playerid -> sendername,params[0] -> playername);
	format(string, sizeof string, "[AdmWarn] * %s применил команду /makedrugs к игроку %s[%s]. Было: %i; Стало: %i",
	sendername, playername, FracInfo[Pl::FracID(params[0])][fName], Pl::Info[params[0]][pDrugs], params[1]);
	SendToAdmin(COLOR_YELLOW, string, 1, 3); Pl::Info[params[0]][pDrugs] = params[1];
	return 1;
}

CMD:kickjob(playerid, params[]) { new string[144], sendername[24], playername[24];
	if(!Pl::isAdmin(playerid, MODER1LVL)) return Send(playerid,COLOR_GREY,"* Вам не доступна эта функция");
	if(sscanf(params, "u", params[0])) return Send(playerid, COLOR_GRAD2, "Введите: /kickjob [id/Name]");
	if(!Pl::isLogged(params[0])) return Send(playerid, COLOR_GREY, "* Этот игрок не авторизован!");
	Iter::Remove(JobPlayers[Pl::Info[params[0]][pJob]], playerid);
	Pl::Info[params[0]][pJob] = JOB_NONE;
	Pl::Info[params[0]][pContractTime] = 0;
	getname(playerid -> sendername,params[0] -> playername);
	format(string, sizeof string, "[AdmWarn] * %s применил команду /kickjob к игроку %s[%d]", sendername, playername, params[0]);
	SendToAdmin(COLOR_YELLOW, string, 1, 3);
	format(string, sizeof string, "* Администратор %s уволил вас с работы!", sendername);
	Send(params[0], COLOR_LIGHTBLUE, string);
	
	return 1;
}

CMD:uval(playerid, params[]) { new string[144], sendername[24], playername[24];
	if(!Pl::isAdmin(playerid, SUPERMODER)) return Send(playerid,COLOR_GREY,"* Вам не доступна эта функция");
	if(sscanf(params, "u", params[0])) return Send(playerid, COLOR_GRAD2, "Введите: /uval [id/Name]");
	if(!Pl::isLogged(params[0])) return Send(playerid, COLOR_GREY, "* Этот игрок не авторизован!");
	if(!Pl::Info[params[0]][pMember]) return Send(playerid, COLOR_GREY, "* Этот не состоит не где!");
	new fracid = Pl::Info[params[0]][pMember];
	Pl::Info[params[0]][pMember] = 0;
	Pl::Info[params[0]][pRank] = 0;
	switch(Pl::Info[params[0]][pSex]) {
		case 1: Pl::Info[params[0]][pChar] = 72;
		case 2: Pl::Info[params[0]][pChar] = 55;
		default: Pl::Info[params[0]][pChar] = 79;
	}
	MedicBill{params[0]} = false;
	Pl::SetSpawnInfo(playerid);
	Rac::SpawnPlayer(params[0]);
	Iter::Remove(TeamPlayers[fracid], params[0]);
	getname(playerid -> sendername,params[0] -> playername);
	format(string, sizeof string, "[AdmWarn] * %s применил команду /uval к игроку %s[%d][%s]", sendername, playername, params[0], FracInfo[fracid][fName]);
	SendToAdmin(COLOR_YELLOW, string, 1, 3);
	format(string, sizeof string, "* Администратор %s уволил вас из фракции!", sendername);
	Send(params[0], COLOR_LIGHTBLUE, string);
	return 1;
}

CMD:aclear(playerid, params[]) { new string[144], sendername[24], playername[24];
	if(!Pl::isAdmin(playerid, MODER3LVL)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(sscanf(params, "u", params[0])) return Send(playerid, COLOR_GREY, "Ввелите: /clear [id/Name]");
	if(!Pl::isLogged(params[0])) return Send(playerid, COLOR_GREY, "* Этот игрок не залогинен!");
	if(params[0] == playerid) return Send(playerid, COLOR_GREY, "* Вы не можете оправдаться!");

	// Очищаем розыск
	Pl::SetWantedLevel(params[0], 0);
	ClearCrime(params[0]);

	// Выводим сообщение
	getname(playerid -> sendername,params[0] -> playername);
	format(string, sizeof string, "* Вы очистили уровень розыска подозреваемого %s.", playername);
	Send(playerid, COLOR_LIGHTBLUE, string);
	format(string, sizeof string, "* Администратор %s очистил ваш уровень розыска.", sendername);
	Send(params[0], COLOR_LIGHTBLUE, string);
	return 1;
}
