
#if !defined _Core_Util_
#define _Core_Util_

stock hexToString(x) {
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

#endif