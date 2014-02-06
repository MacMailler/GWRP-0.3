#define clear(%0)					%0[ 0 ] = '\0'
#define scf(%0,%1,%2)				format(%1,sizeof(%1),%2), strcat(%0,%1)
#define sendf(%0,%1,%2,%3)			format(%1,sizeof(%1),%3),SendClientMessage(%0,%2,%1)
#define getname(%0->%1,%2->%3)		GetPlayerName(%0,%1,24), GetPlayerName(%2,%3,24)
#define GetTrueEnd(%1,%2,%3,%4)		((%1)%(10)==1&&(%1)%(100)!=11?(%2):(%1)%(10)>=2&&(%1)%(10)<=4&&((%1)%(100)<10||(%1)%(100)>=20)?(%3):(%4))
#define isnull(%1)					((!(%1[0])) || (((%1[0]) == '\1') && (!(%1[1]))))

#define HOLDING(%0)					((newkeys & (%0)) == (%0))
#define PRESSED(%0)					(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
#define RELEASED(%0)				(((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))

#define KEY_AIM 					(128)
#define KEY_RADIO 					(262144)

#define cells *4
#define BYTES_PER_CELL				(cellbits / 8)
#define SPACE_CHARS 				' ', '\t', '\r', '\n'

#define Send						SendClientMessage
#define SendToAll					SendClientMessageToAll
#define SPD							ShowPlayerDialog

#define issqlnull(%0)				(strcmp(%0,"NULL",false)==0)

#define public:%0(%1) forward %0(%1); \
		public %0(%1)
		
#define stock:%0(%1) forward %0(%1); \
		stock %0(%1)
		
		
stock random_ex(num) {
	static lastrnd, rnd;
	do { rnd = random(num); } while(rnd == lastrnd);
	lastrnd = rnd;
	return rnd;
}

stock DeleteAllAttachedObject(playerid) {
	for(new i; i < MAX_PLAYER_ATTACHED_OBJECTS; ++i)
		if(IsPlayerAttachedObjectSlotUsed(playerid, i))
			RemovePlayerAttachedObject(playerid, i);
	
	return 1;
}

stock writeFile(const filename[], dest[], bool:is_rus=false) {
	new File:fhandle = fopen(filename, fexist(filename)?io_append:io_write);
	if(fhandle) {
		if(is_rus) {
			for(new i, len = strlen(dest); i < len; i++) {
				fputchar(fhandle, dest[i], false);
			}
		} else {
			fwrite(fhandle, dest);
		}
		return fclose(fhandle);
	}
	return 0;
}

stock SendLog(const log[], dest[]) {
	static patch[64], buffer[255];
	static h, m, s; gettime(h, m, s);
	static y, __m, d; getdate(y, __m, d);
	format(patch, sizeof patch, "logs/%s/%02d-%02d-%04d.log", log, d, __m, y);
	format(buffer, sizeof buffer, "[%02i:%02i:%02i] %s\r\n", h, __m, s, dest);
	return writeFile(patch, buffer, true);
}

native IsValidVehicle(vehicleid);

stock to_timestamp(dest[], timestamp=0, format[]="%d-%m-%y, %H:%M:%S",maxlen=sizeof dest) {
	new tm <tmToday>;
    localtime(Time:timestamp, tmToday);
	return strftime(dest, maxlen, format, tmToday);
}