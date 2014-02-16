#define scf(%0,%1,%2)				format(%1,sizeof(%1),%2), strcat(%0,%1)
#define sendf(%0,%1,%2,%3)			format(%1,sizeof(%1),%3),SendClientMessage(%0,%2,%1)
#define getname(%0->%1,%2->%3)		GetPlayerName(%0,%1,24), GetPlayerName(%2,%3,24)
#define isnull(%1)					((!(%1[0])) || (((%1[0]) == '\1') && (!(%1[1]))))

#define HOLDING(%0)					((newkeys & (%0)) == (%0))
#define PRESSED(%0)					(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
#define RELEASED(%0)				(((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))

#define KEY_AIM 					(128)
#define KEY_RADIO 					(262144)

#define Send						SendClientMessage
#define SendToAll					SendClientMessageToAll
#define SPD							ShowPlayerDialog

#define issqlnull(%0)				(strcmp(%0,"NULL",false)==0)

#define public:%0(%1) forward %0(%1); public %0(%1)

#define stock:%0(%1) forward %0(%1); stock %0(%1)

#define BODY_PART_TORSO (3)
#define BODY_PART_GROIN (4)
#define BODY_PART_LEFT_ARM (5)
#define BODY_PART_RIGHT_ARM (6)
#define BODY_PART_LEFT_LEG (7)
#define BODY_PART_RIGHT_LEG (8)
#define BODY_PART_HEAD (9)


#define COLOR_BOX   			0x00000050
#define COLOR_OOC				0xE0FFFFAA
#define COLOR_USE				0x60A000AA
#define COLOR_GOV				0xEA8DF7AA
#define COLOR_RED				0xAA3333AA
#define COLOR_ADD				0x63FF60AA
#define COLOR_TELA				0x17302FFF
#define COLOR_PINK				0xFF66FFAA
#define COLOR_GREY				0xAFAFAFAA
#define COLOR_LRED				0xF65B00AA
#define COLOR_BLUE				0x1111BBAA
#define COLOR_LIME				0x10F441AA
#define COLOR_NAVY				0x100080AA
#define COLOR_AQUA				0xF0F8FFAA
#define COLOR_GOLD				0xB8860BAA
#define COLOR_NEWS				0xFFA500AA
#define COLOR_SPEC				0xBFC0C200
#define COLOR_CYAN				0xFF8282AA
#define COLOR_ALPHA				0xFFFFFF00
#define COLOR_IVORY				0xFFFF82AA
#define COLOR_OLIVE				0x808000AA
#define COLOR_DBLUE				0x2641FEAA
#define COLOR_BROWN				0xA52A2AAA
#define COLOR_CORAL				0xFF7F50AA
#define COLOR_BLACK				0x000000AA
#define COLOR_WHITE				0xFFFFFFAA
#define COLOR_FADE1				0xE6E6E6E6
#define COLOR_FADE2				0xC8C8C8C8
#define COLOR_FADE3				0xAAAAAAAA
#define COLOR_FADE4				0x8C8C8C8C
#define COLOR_FADE5				0x6E6E6E6E
#define COLOR_GRAD1				0xB4B5B7FF
#define COLOR_GRAD2				0xBFC0C2FF
#define COLOR_GRAD3				0xCBCCCEFF
#define COLOR_GRAD4				0xD8D8D8FF
#define COLOR_GRAD5				0xE3E3E3FF
#define COLOR_GRAD6				0xF0F0F0FF
#define COLOR_GREEN				0x33AA33AA
#define COLOR_INVIS				0xAFAFAF00
#define COLOR_RADIO				0x8D8DFF00
#define COLOR_GROVE				0x00D900C8
#define COLOR_FLBLUE			0x6495EDAA
#define COLOR_BISQUE			0xFFE4C4AA
#define COLOR_SYSTEM			0xEFEFF7AA
#define COLOR_FRENCH			0x29DBFFFF
#define COLOR_CHEATS			0xCDFFFFFF
#define COLOR_YELLOW			0xFFFF00AA
#define COLOR_PURPLE			0xC2A2DAAA
#define COLOR_ORANGE			0xFF9900AA
#define COLOR_INDIGO			0x4B00B0AA
#define COLOR_TOMATO			0xFF6347AA
#define COLOR_MAROON			0x800000AA
#define COLOR_AZTECAS			0x01FCFFC8
#define COLOR_ALLDEPT			0xFF8282AA
#define COLOR_MAGENTA			0xFF00FFFF
#define COLOR_CRIMSON			0xDC143CAA
#define COLOR_BANKOMAT			0x6053F3FF
#define COLOR_LIGHTRED			0xFF6347AA
#define COLOR_LIGHTRED2			0xFF0000FF
#define COLOR_LIGHTBLUE			0x33CCFFAA
#define COLOR_ORANGERED			0xFF4500AA
#define COLOR_LAWNGREEN			0x7CFC00AA
#define COLOR_LIMEGREEN			0x32CD32AA
#define COLOR_BRIGHTRED			0xDC143CAA
#define COLOR_BUS_PRICE			0x00AAFFEE
#define COLOR_TAXI_PRICE		0xFFCC00FF
#define COLOR_CHARTREUSE		0x7FFF00AA
#define COLOR_MEDIUMAQUA		0x83BFBFAA
#define COLOR_LIGHTGREEN		0x9ACD32AA
#define COLOR_GREENYELLOW		0xADFF2FAA
#define COLOR_YELLOWGREEN		0x9ACD32AA
#define COLOR_SPRINGGREEN		0x10FF7FAA
#define COLOR_MIDNIGHTBLUE		0x191970AA
#define COLOR_MEDIUMMAGENTA		0x8B008BAA


#pragma tabsize 0
#define FOREACH_NO_BOTS


#include "..\include\kickfix"
#include "..\include\ctime"
#include "..\include\a_mysql"
#include "..\include\encrypt"
#include "..\include\sscanf2"
#include "..\include\foreach"
#include "..\include\streamer"
#include "..\include\regex"
#include "..\include\sort-0.2"
#include "..\include\container"
#include "..\include\mloader"
#include "..\include\dc_cmd"
#include "..\include\a_cam"
#include "..\include\mxINI"


native IsValidVehicle(vehicleid);


stock hexToString(x)
{
	new i, j, s[11];
	while (i < sizeof(s) && j < 8)
	{
		new n = x >> (7 - j) * 4 & 0xF;
		switch (n) {
		case 0x0..0x9:
			s[i] = n + '0';
		case 0xA..0xF:
			s[i] = n + 'A' - 0xA;
		}
		i++;
		j++;
	}
	return s;
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

stock LoadFile(const path[], dest[], len = sizeof dest) {
	if(fexist(path)) {
		new File:handle, hBuf[256];
		handle = fopen(path, io_read);
		if(handle) {
			dest[0] = '\0';
			while(fread(handle, hBuf)) {
				strcat(dest, hBuf, len);
			}
			fclose(handle);
		}
	} else {
		printf("[debug] LoadFile(): File \"%s\" is not found!", path);
	}
	return 1;
}

stock SendLog(const log[], dest[]) {
	static patch[64], buffer[255];
	static h, m, s; gettime(h, m, s);
	static y, __m, d; getdate(y, __m, d);
	format(patch, sizeof patch, "logs/%s/%02d-%02d-%04d.log", log, d, __m, y);
	format(buffer, sizeof buffer, "[%02i:%02i:%02i] %s\r\n", h, __m, s, dest);
	return writeFile(patch, buffer, true);
}

stock to_timestamp(dest[], timestamp=0, format[]="%d-%m-%y, %H:%M:%S",maxlen=sizeof dest) {
	new tm <tmToday>;
    localtime(Time:timestamp, tmToday);
	return strftime(dest, maxlen, format, tmToday);
}