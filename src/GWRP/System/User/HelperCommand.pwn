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

#if defined __HelperCommand__
	#endinput
#endif
#define __HelperCommand__


CMD:hmute(playerid, params[]) { new string[144], sendername[24], playername[24];
	if(!IsPHelper(playerid, 2)) return Send(playerid, COLOR_GRAD1, "* Недостаточно прав!");
	if(sscanf(params, "us[64]", params[0], params[1])) return Send(playerid, COLOR_GREY, "Введите: /hmute [id] [reason]");
	if(!Pl::isLogged(params[0])) return Send(playerid, COLOR_GREY, "* Этот игрок не авторизован!");
	if(Pl::Info[params[0]][pMuted] == 2) return Send(playerid, COLOR_GREY, "* У игрока уже есть молчанка!");
	getname(playerid -> sendername,params[0] -> playername);
	Pl::Info[params[0]][pMuted] = 2;
	Pl::Info[params[0]][pMutedTime] = 180;
	format(string, sizeof string, "*[H] %s получил молчанку для чата /vopros от хелпера %s, причина: %s", playername, sendername, params[1]);
	SendToHelper(COLOR_ORANGE, string);
	return 1;
}

CMD:hduty(playerid, params[]) { new string[144], sendername[24];
	if(!IsPHelper(playerid, 1)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	HelperDuty{playerid} = !HelperDuty{playerid};
	GetPlayerName(playerid, sendername, 24);
	format(string, sizeof string, "(( [H] Хелпер %s %s ))", sendername, (HelperDuty{playerid})?("ждет ваши вопросы! (/вопрос)"):("не активен."));
	SendToAll(COLOR_OOC,string);
	return 1;
}

CMD:ans(playerid, params[]) { new string[144], sendername[24], playername[24];
	if(IsPMuted(playerid)) return Send(playerid,COLOR_GREY,"* У Вас молчанка!");
	if(!IsPHelper(playerid, 1)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(!IsAHelperDuty(playerid)) return Send(playerid, COLOR_GREY, "* Вы не на дежурсиве!");
	if(sscanf(params, "us[90]", params[0], params[1])) return Send(playerid, COLOR_GREY, "Введите: /ans [id/Name] [ответ]");
	if(!Pl::isLogged(params[0])) return Send(playerid, COLOR_GREY, "* Этот игрок не авторизован!");
	new answerd = GetPVarInt(params[0], "AnsweredHelper");
	if(answerd == INVALID_PLAYER_ID) return Send(playerid, COLOR_GREY, "* Этот игрок не задавал вопросов!");
	if(answerd != -1 && answerd != playerid) return Send(playerid, COLOR_GREY, "* Этому игроку уже отвечает хелпер!");
	SetPVarInt(params[0], "AnsweredHelper", playerid);
	getname(playerid -> sendername, params[0] -> playername);
	format(string, sizeof string, "*[H] %s ответил: %s", sendername, params[1]);
	Send(params[0], COLOR_ORANGE, string);
	format(string, sizeof string, "*[H] %s ответил %s[%d]: %s",sendername, playername, params[0], params[1]);
	SendToHelper(COLOR_ORANGE, string);
	return 1;
}

CMD:hc(playerid, params[]) { new string[144], sendername[24];
	if(IsPMuted(playerid)) return Send(playerid,COLOR_GREY,"* У Вас молчанка!");
	if(!IsPHelper(playerid, 1)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
	if(!IsAHelperDuty(playerid)) return Send(playerid, COLOR_GREY, "* Вы не на дежурсиве!");
	if(isnull(params) || params[0] == ' ') return Send(playerid, COLOR_GRAD1, "Введите: /hc [текст]");
	GetPlayerName(playerid, sendername, 24);
	format(string, sizeof string, "*%i %s %s: %s", Pl::Info[playerid][pHelper], GetHelperRank(Pl::Info[playerid][pHelper]), sendername, params);
	SendToHelper(COLOR_GREEN, string);
	return 1;
}
