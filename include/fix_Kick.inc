/*
	fix_Kick.inc 2.0
	
	@author MacMailler
*/
#if !defined _samp_included
	#error Please include 'a_samp.inc'
#endif
#if defined __FIX_KICK_INCLUDED__
	#endinput
#endif
#define __FIX_KICK_INCLUDED__
 
native n_Kick(playerid) = Kick;
native n_Ban(playerid) = Ban;
native n_BanEx(playerid, reason[]) = BanEx;

// **
#if defined _ALS_Ban
	#undef Ban
#else
	#define _ALS_Ban
#endif
#define Ban fix_Ban
// **
#if defined _ALS_Kick
	#undef Kick
#else
	#define _ALS_Kick
#endif
#define Kick fix_Kick
// **
#if defined _ALS_BanEx
	#undef BanEx
#else
	#define _ALS_BanEx
#endif
#define BanEx fix_BanEx


static KickedPlayer[MAX_PLAYERS char]={0, ...};
static BannedReason[MAX_PLAYERS][64];
 
stock fix_Kick(playerid, delay=100) {
	if(0 <= playerid < MAX_PLAYERS) {
		if(!KickedPlayer{playerid}) {
			KickedPlayer{playerid} = 1;
			return SetTimerEx("onKicked", delay, false, "i", playerid);
		}
	}
	return 0;
}
 
stock fix_Ban(playerid, delay=100)  {
	if(0 <= playerid < MAX_PLAYERS) {
		if(!KickedPlayer{playerid}) {
			KickedPlayer{playerid} = 2;
			return SetTimerEx("onKicked", delay, false, "i", playerid);
		}
	}
	return 0;
}
 
stock fix_BanEx(playerid, reason[], delay=100) {
	if(0 <= playerid < MAX_PLAYERS) {
		if(!KickedPlayer{playerid}) {
			KickedPlayer{playerid} = 3;
			strmid(BannedReason[playerid], reason, 0, strlen(reason), 64);
			return SetTimerEx("onKicked", delay, false, "i", playerid);
		}
	}
	return 0;
}

 
forward onKicked(playerid);
public  onKicked(playerid) {
	switch(KickedPlayer{playerid}) {
		case 1 : n_Kick(playerid);
		case 2 : n_Ban(playerid);
		case 3 : n_BanEx(playerid, BannedReason[playerid]);
	}
	KickedPlayer{playerid} = 0;
	BannedReason[playerid][0] = '\0';
}