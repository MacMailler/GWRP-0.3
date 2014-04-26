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


#if !defined _samp_included
	#error Please include 'a_samp.inc'
#endif
#if defined KICKFIX_INC
	#endinput
#endif
#define KICKFIX_INC

#define fix-> fix_			/// fake class
#define VALID_PLAYER_ID(%0) if(!(0 <= playerid < MAX_PLAYERS)) return 0
#define PLAYER_KICKED(%0) if(KickedPlayer{playerid} > 0) return 0


static KickedPlayer[MAX_PLAYERS char]={0, ...};
static BannedReason[MAX_PLAYERS][64];


stock fix_Kick(playerid, delay=100) {
	VALID_PLAYER_ID(playerid);
	PLAYER_KICKED(playerid);
	
	KickedPlayer{playerid} = 1;
	return SetTimerEx("onKicked", delay, false, "i", playerid);
}

stock fix_KickEx(playerid, reason[], color=-1, delay=100) {
	VALID_PLAYER_ID(playerid);
	PLAYER_KICKED(playerid);
	
	KickedPlayer{playerid} = 1;
	SendClientMessage(playerid, color, reason);
	return SetTimerEx("onKicked", delay, false, "i", playerid);
}

stock fix_Ban(playerid, delay=100)  {
	VALID_PLAYER_ID(playerid);
	PLAYER_KICKED(playerid);
	
	KickedPlayer{playerid} = 2;
	return SetTimerEx("onKicked", delay, false, "i", playerid);
}

stock fix_BanEx(playerid, reason[], delay=100) {
	VALID_PLAYER_ID(playerid);
	PLAYER_KICKED(playerid);
	
	KickedPlayer{playerid} = 3;
	strmid(BannedReason[playerid], reason, 0, strlen(reason), 64);
	return SetTimerEx("onKicked", delay, false, "i", playerid);
}

forward onKicked(playerid);
public  onKicked(playerid) {
	switch(KickedPlayer{playerid}) {
		case 1 : Kick(playerid);
		case 2 : Ban(playerid);
		case 3 : BanEx(playerid, BannedReason[playerid]);
	}
	KickedPlayer{playerid} = 0;
	BannedReason[playerid][0] = '\0';
}

#define Kick	fix_Kick
#define KickEx	fix_KickEx
#define Ban		fix_Ban
#define BanEx	fix_BanEx