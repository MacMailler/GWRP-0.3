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

#if defined __LeaderCommand__
	#endinput
#endif
#define __LeaderCommand__


CMD:fracpay(playerid, params[]) { new string[144];
	if(Pl::Info[playerid][pLeader] != Pl::FracID(playerid)) return Send(playerid, COLOR_GREY, "* Вы не лидер!");
	if(sscanf(params, "i", params[0])) return Send(playerid, COLOR_GREY, "Введите: /fracpay [Сумма каждому члену фракции]");
	if(!(1000 <= params[0] <= 100000)) return Send(playerid, COLOR_GREY, "* Сумма должна быть от $1000 до $100000!");
	new fracid = Pl::FracID(playerid);
	new price = (params[0] * Iter::Count(TeamPlayers[fracid]));
	if(price > GetFracMoney(fracid)) return Send(playerid, COLOR_GREY, "* В казне не хватает денег!");
	if(FracPay[fracid] != 0) return Send(playerid, COLOR_GREY, "* Зарплату можно выдавать только раз за час!");
	
	FracPay[fracid] = 1;
	GiveFracMoney(fracid, -price);
	
	if(IsAGangF(fracid)) {
		foreach(new i: TeamPlayers[fracid]) {
			Rac::GivePlayerMoney(i, params[0]);
			format(string, sizeof(string), "* Вы получили зарплату от Лидера, в размере $%i", params[0]);
			Send(i, COLOR_LIGHTBLUE, string);
		}
	} else {
		foreach(new i: TeamPlayers[fracid]) {
			GivePlayerBankMoney(i, params[0]);
			format(string, sizeof(string), "* Вы получили зарплату от Лидера, в размере $%i", params[0]);
			Send(i, COLOR_LIGHTBLUE, string);
		}
	}
	format(string, sizeof(string), " * Вы выдали зарплату членам своей фракции, в размере $%i", price);
	Send(playerid, COLOR_LIGHTBLUE, string);
	return 1;
}

CMD:invite(playerid, params[]) { new string[144], sendername[24], playername[24];
	if(IsPlayerLeader(playerid) <= 0) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(sscanf(params, "u", params[0])) return Send(playerid, COLOR_GREY, "Введите: /invite [id]");
	if(!Pl::isLogged(params[0])) return Send(playerid, COLOR_GREY, "* Этот игрок не авторизован!");
	if(Pl::FracID(params[0]) != 0) return Send(playerid, COLOR_GREY, "* Этот игрок уже сотоит в другой организации!");
	if(IsLegalFrac(Pl::FracID(params[0])) && !Pl::Info[params[0]][pPasport][0]) return Send(playerid, COLOR_GREY, "* У этого человека нет паспорта!");
	getname(playerid -> sendername, params[0] -> playername);
	SetPVarInt(params[0], "InvateFrac", Pl::Info[playerid][pLeader]);
	format(string, sizeof string, "* Вы были приглашены в %s лидером %s (пишите /accept invite чтобы согласится)", FracInfo[Pl::Info[playerid][pLeader]][fName], sendername);
	Send(params[0], COLOR_LIGHTBLUE, string);
	format(string, sizeof string, "* Вы пригласили %s в %s.", playername, FracInfo[Pl::Info[playerid][pLeader]][fName]);
	Send(playerid, COLOR_LIGHTBLUE, string);
	return 1;
}

CMD:uninvite(playerid, params[]) { new string[144], sendername[24], playername[24];
	if(IsPlayerLeader(playerid) <= 0) return Send(playerid, COLOR_GRAD1, "* Недостаточно прав!");
	if(sscanf(params, "u", params[0])) return Send(playerid, COLOR_GREY, "Введите: /invite [id]");
	if(!Pl::isLogged(params[0])) return Send(playerid, COLOR_GREY, "* Этот игрок не авторизован!");
	if(Pl::Info[params[0]][pLeader] > 0) return Send(playerid, COLOR_GREY, "* Вы не можите уволить лидера!");
	if(Pl::FracID(playerid) != Pl::FracID(params[0])) return Send(playerid, COLOR_GREY, "* Этот игрок не состоит в вашей организации!");		
	Iter::Remove(TeamPlayers[Pl::Info[params[0]][pMember]], params[0]);
	Pl::Info[params[0]][pMember] = 0;
	Pl::Info[params[0]][pRank] = 0;
	switch(Pl::Info[params[0]][pSex]) {
		case 1: Pl::Info[params[0]][pChar] = 60;
		case 2: Pl::Info[params[0]][pChar] = 55;
		default: Pl::Info[params[0]][pChar] = 60;
	}
	MedicBill{params[0]} = false;
	Pl::Info[params[0]][pJob] = JOB_NONE;
	Pl::Info[params[0]][pContractTime] = 0;
	Pl::SetSpawnInfo(params[0]);
	Rac::SpawnPlayer(params[0]);
	getname(playerid -> sendername,params[0] -> playername);
	format(string, sizeof string, "* Вы выкинули %s из своей фракции.", playername);
	Send(playerid, COLOR_LIGHTBLUE, string);
	format(string, sizeof string, "* Вы были уволены из фракции %s, лидером %s.", FracInfo[Pl::Info[playerid][pLeader]][fName], sendername);
	Send(params[0], COLOR_LIGHTBLUE, string);
	Send(params[0], COLOR_LIGHTBLUE, "* Вы теперь гражданское лицо.");
	return 1;
}


CMD:giverank(playerid, params[]) { new string[144], sendername[24], playername[24];
	if(IsPlayerLeader(playerid) <= 0) return Send(playerid, COLOR_GREY, "* Вы не лидер фракции!");
	if(sscanf(params, "ud", params[0], params[1])) return Send(playerid, COLOR_GRAD2, "Введите: /giverank [id] [ранг]");
	if(!Pl::isLogged(params[0])) return Send(playerid, COLOR_GREY, "* Этот игрок не залогинен!");
	new fracid = Pl::FracID(params[0]);
	if(fracid != Pl::Info[playerid][pLeader]) return Send(playerid, COLOR_GREY, "* Этот игрок не состоит в вашей фракции!");
	if(params[1] <= 0 || params[1] > RankNums[fracid]) {
		format(string, sizeof string, "* В вашей фракции всего %d рангов", RankNums[fracid]);
		Send(playerid, COLOR_GREY, string);
		return 1;
	}
	Pl::Info[params[0]][pRank] = params[1];
	getname(playerid->sendername,params[0]->playername);
	format(string, sizeof string, "* Вы были повышены/понижены в ранге лидером %s, ваш ранг: %i", sendername, params[1]);
	Send(params[0], COLOR_LIGHTBLUE, string);
	format(string, sizeof string, "* Вы повысели %s. Теперь его ранг %i.", playername, params[1]);
	Send(playerid, COLOR_LIGHTBLUE, string);
	return 1;
}

CMD:vigovor(playerid, params[]) { new string[144], sendername[24], playername[24];
	if(IsPlayerLeader(playerid) <= 0) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(sscanf(params, "us[24]", params[0], params[1])) return Send(playerid, COLOR_GREY, "Введите: /vigovor [id] [reason]");
	if(!Pl::isLogged(params[0])) return Send(playerid, COLOR_GREY, "* Этот игрок не авторизован!");

	new fracid = Pl::FracID(playerid);
	if(fracid != Pl::FracID(params[0])) return Send(playerid, COLOR_GREY, "* Этот игрок не состоит в вашей организации!");
	if(IsPlayerLeader(params[0]) == fracid) return Send(playerid, COLOR_GREY, "* Вы не можете дать выговор лидеру!");

	Pl::Info[params[0]][pRebuke]++;
	getname(playerid -> sendername,params[0] -> playername);
	if(Pl::Info[params[0]][pRebuke] >= 4) {
		Pl::Info[params[0]][pMember] = 0;
		Pl::Info[params[0]][pRank] = 0;
		switch(Pl::Info[params[0]][pSex])
		{
			case 1: Pl::Info[params[0]][pChar] = 60;
			case 2: Pl::Info[params[0]][pChar] = 55;
			default: Pl::Info[params[0]][pChar] = 60;
		}
		MedicBill{params[0]} = false;
		Pl::Info[params[0]][pJob] = JOB_NONE;
		Pl::Info[params[0]][pContractTime] = 0;
		Pl::Info[params[0]][pRebuke] = 0;
		SetPlayerSkin(params[0], Pl::Info[params[0]][pChar]);
		Pl::SetSpawnInfo(params[0]); Rac::SpawnPlayer(params[0]);
		
		format(string, sizeof string, "* Вы получили 4-й выговор от лидера %s и были автоматически уволены из фракции. Причина: %s", sendername, params[1]);
		Send(params[0], COLOR_LIGHTRED, string);
		format(string, sizeof string, "* Вы дали 4-й выговор игроку %s и он был автоматически уволен из вашей фракции. Причина: %s", playername, params[1]);
		Send(playerid, COLOR_LIGHTRED, string);
		Pl::Update(params[0]);
	} else {
		format(string, sizeof string, "* Вы получили выговор от лидера %s. Причина: %s", sendername, params[1]);
		Send(params[0], COLOR_LIGHTRED, string);
		format(string, sizeof string, "* Вы дали выговор игроку %s. Причина: %s", playername, params[1]);
		Send(playerid, COLOR_LIGHTRED, string);
	}
	return 1;
}

CMD:unvigovor(playerid, params[]) { new string[144], sendername[24], playername[24];
	if(!Pl::isLogged(playerid)) return Send(playerid, COLOR_GREY, "* Вы не авторизованы!");
	if(IsPlayerLeader(playerid) <= 0) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(sscanf(params, "u", params[0], params[1])) return Send(playerid, COLOR_GREY, "Введите: /unvigovor [id]");
	if(Pl::FracID(playerid) != Pl::FracID(params[0])) return Send(playerid, COLOR_GREY, "* Этот игрок не состоит в вашей организации!");
	if(Pl::Info[params[0]][pRebuke] <= 0) return Send(playerid, COLOR_GREY, "* У этого игрока нет выговоров");
	Pl::Info[params[0]][pRebuke] --;
	getname(playerid -> sendername, params[0] -> playername);
	format(string, sizeof string, "* Лидер %s снял с вас 1 выговор. ", sendername, params[1]);
	Send(params[0], COLOR_LIGHTRED, string);
	format(string, sizeof string, "* Вы сняли 1 выговор с подчиненного %s.", params[1], playername);
	Send(playerid, COLOR_LIGHTRED, string);
	return 1;
}

