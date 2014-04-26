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

#if defined _mloader_included
	#endinput
#endif
#define _mloader_included

#define map:: MAP_ 			// fake class
#define INVALID_MAP_ID		(0xFFFF)
#define MAX_DYNAMIC_MAP		(255)
#define MAP_IsValid(%0)		(0<=%0<=TotalDynamicMaps)


forward map::Load(const mapfile[], worldid=-1, interiorid=-1, playerid=-1, Float:streamdistance=200.0);
forward map::SetWorld(mapid, worldid);
forward map::SetInterior(mapid, interiorid);
forward map::SetPlayer(mapid, playerid);
forward map::GetWorld(mapid);
forward map::GetInterior(mapid);
forward map::GetPlayer(mapid);
forward map::Float:GetStreamDist(mapid);
forward map::CountMaps();
forward map::Debug(dbg);
forward map::Destroy(mapid);
forward map::DestroyAllMaps(mapid);


enum e_Dynamic {
	e_MapStart,
	e_MapEnd,
	e_MapWorld,
	e_MapInterior,
	e_MapPlayer,
	Float:e_MapStreamDist,
	e_CountObjects,
};
static DynamicMaps[MAX_DYNAMIC_MAP][e_Dynamic];
static TotalDynamicMaps;
static map_debug = 0;


stock map::Debug(dbg) {
	map_debug = dbg;
	printf("map::Debug(): Debug %s", dbg ? ("activated!") : ("de-activated!"));
	return 1;
}

stock map::Load(const mapfile[], worldid=-1, interiorid=-1, playerid=-1, Float:streamdistance=200.0) {
	if(fexist(mapfile)) {
		if(TotalDynamicMaps < sizeof DynamicMaps) {
			new modelid, Float:pos[3], Float:rot[3];
			new buffer[2][170], objectid, time = GetTickCount();
			new File:fhandle = fopen(mapfile, io_read);
			
			DynamicMaps[TotalDynamicMaps][e_MapStart] = (CountDynamicObjects()+1);
			DynamicMaps[TotalDynamicMaps][e_MapWorld] = worldid;
			DynamicMaps[TotalDynamicMaps][e_MapInterior] = interiorid;
			DynamicMaps[TotalDynamicMaps][e_MapPlayer] = playerid;
			DynamicMaps[TotalDynamicMaps][e_MapStreamDist] = streamdistance;
		
			while(fread(fhandle, buffer[0])) {
				if(strcut(buffer[0], buffer[1], "(", ")")) {
					sscanf(buffer[1], "p<,>ia<f>[3]a<f>[3]", modelid, pos, rot);
					objectid = CreateDynamicObject(modelid, pos[0], pos[1], pos[2], rot[0], rot[1], rot[2], worldid, interiorid, playerid, streamdistance);
					if(objectid == INVALID_OBJECT_ID) {
						if(map_debug) {
							print("map::Load(): Error, object could not be created!");
						}
						break;
					} else {
						DynamicMaps[TotalDynamicMaps][e_CountObjects]++;
					}
				}
			}
			
			if(map_debug) {
				printf("- Map \"%s\" loaded! (Time:%i, mapid:%i)", mapfile, GetTickCount()-time, TotalDynamicMaps);
			}
			fclose(fhandle);
			DynamicMaps[TotalDynamicMaps][e_MapEnd] = CountDynamicObjects();
			return TotalDynamicMaps++;
			
		} else if(map_debug) {
			printf("map::Load(): Created the maximum number of dynamic maps!");
		}
		
	} else if(map_debug) {
		printf("map::Load(): Map \"%s\" is not found!", mapfile);
	}
	return INVALID_MAP_ID;
}

stock map::SetWorld(mapid, worldid) {
	if(map::IsValid(mapid)) {
		DynamicMaps[mapid][e_MapWorld] = worldid;
		new objectid = DynamicMaps[mapid][e_MapStart];
		for(; objectid != DynamicMaps[mapid][e_MapEnd]; objectid++) {
			Streamer_SetIntData(STREAMER_TYPE_OBJECT, objectid, E_STREAMER_WORLD_ID, worldid);
		}
		return 1;
		
	} else if(map_debug) {
		printf("map::SetWorld(): Invalid mapid (%i)", mapid);
	}
	return 0;
}

stock map::SetInterior(mapid, interiorid) {
	if(map::IsValid(mapid)) {
		DynamicMaps[mapid][e_MapInterior] = interiorid;
		new objectid = DynamicMaps[mapid][e_MapStart];
		for(; objectid != DynamicMaps[mapid][e_MapEnd]; objectid++) {
			Streamer_SetIntData(STREAMER_TYPE_OBJECT, objectid, E_STREAMER_INTERIOR_ID, interiorid);
		}
		return 1;
		
	} else if(map_debug) {
		printf("map::SetInterior(): Invalid mapid (%i)", mapid);
	}
	return 0;
}

stock map::SetPlayer(mapid, playerid) {
	if(map::IsValid(mapid)) {
		if(IsPlayerConnected(playerid)) {
			DynamicMaps[mapid][e_MapPlayer] = playerid;
			new objectid = DynamicMaps[mapid][e_MapStart];
			for(; objectid != DynamicMaps[mapid][e_MapEnd]; objectid++) {
				Streamer_SetIntData(STREAMER_TYPE_OBJECT, objectid, E_STREAMER_PLAYER_ID, playerid);
			}
			return 1;
		}
		
	} else if(map_debug) {
		printf("map::SetPlayer(): Invalid mapid (%i)", mapid);
	}
	return 0;
}

stock map::SetStreamDist(mapid, Float:streamdistance) {
	if(map::IsValid(mapid)) {
		if(IsPlayerConnected(playerid)) {
			DynamicMaps[mapid][e_MapStreamDist] = streamdistance;
			new objectid = DynamicMaps[mapid][e_MapStart];
			for(; objectid != DynamicMaps[mapid][e_MapEnd]; objectid++) {
				Streamer_SetIntData(STREAMER_TYPE_OBJECT, objectid, E_STREAMER_STREAM_DISTANCE, streamdistance);
			}
			return 1;
		}
		
	} else if(map_debug) {
		printf("map::SetStreamDist(): Invalid mapid (%i)", mapid);
	}
	return 0;
}


stock map::GetWorld(mapid) {
	if(map::IsValid(mapid)) {
		return DynamicMaps[mapid][e_MapWorld];
		
	} else if(map_debug) {
		printf("map::GetWorld(): Invalid mapid (%i)", mapid);
	}
	return -1;
}

stock map::GetInterior(mapid) {
	if(map::IsValid(mapid)) {
		return DynamicMaps[mapid][e_MapInterior];
		
	} else if(map_debug) {
		printf("map::GetInterior(): Invalid mapid (%i)", mapid);
	}
	return -1;
}

stock map::GetPlayer(mapid) {
	if(map::IsValid(mapid)) {
		return DynamicMaps[mapid][e_MapPlayer];
		
	} else if(map_debug) {
		printf("map::GetPlayer(): Invalid mapid (%i)", mapid);
	}
	return -1;
}

stock map::Float:GetStreamDist(mapid) {
	if(map::IsValid(mapid)) {
		return DynamicMaps[mapid][e_MapStreamDist];
		
	} else if(map_debug) {
		printf("map::GetStreamDist(): Invalid mapid (%i)", mapid);
	}
	return 0.0;
}

stock map::CountMaps() {
	return TotalDynamicMaps;
}

stock map::Destroy(mapid) {
	if(map::IsValid(mapid)) {
		new objectid = DynamicMaps[mapid][e_MapStart];
		for(; objectid != DynamicMaps[mapid][e_MapEnd]; objectid++) {
			DestroyDynamicObject(objectid);
		}
		TotalDynamicMaps--;
		DynamicMaps[mapid][e_MapStart]     = DynamicMaps[TotalDynamicMaps][e_MapStart];
		DynamicMaps[mapid][e_MapEnd]       = DynamicMaps[TotalDynamicMaps][e_MapEnd];
		DynamicMaps[mapid][e_MapWorld]     = DynamicMaps[TotalDynamicMaps][e_MapWorld];
		DynamicMaps[mapid][e_MapInterior]  = DynamicMaps[TotalDynamicMaps][e_MapInterior];
		DynamicMaps[mapid][e_MapPlayer]    = DynamicMaps[TotalDynamicMaps][e_MapPlayer];
		DynamicMaps[mapid][e_MapStreamDist]= DynamicMaps[TotalDynamicMaps][e_MapStreamDist];
		DynamicMaps[mapid][e_CountObjects] = DynamicMaps[TotalDynamicMaps][e_CountObjects];
		return 1;
		
	} else if(map_debug) {
		printf("map::Destroy(): Invalid mapid (%i)", mapid);
	}
	return 0;
}

stock map::DestroyAllMaps() {
	new mapid = TotalDynamicMaps;
	for(; mapid != -1; mapid--) {
		new objectid = DynamicMaps[mapid][e_MapStart];
		for(; objectid != DynamicMaps[mapid][e_MapEnd]; objectid++) {
			DestroyDynamicObject(objectid);
		}
		DynamicMaps[mapid][e_MapStart] = 0;
		DynamicMaps[mapid][e_MapEnd] = 0;
		DynamicMaps[mapid][e_MapWorld] = -1;
		DynamicMaps[mapid][e_MapInterior] = -1;
		DynamicMaps[mapid][e_MapPlayer] = -1;
		DynamicMaps[mapid][e_MapStreamDist] = 200.0;
		DynamicMaps[mapid][e_CountObjects] = 0;
		TotalDynamicMaps -- ;
	}
	return 1;
}

stock strcut(dest[], buffer[], l[], r[], maxlen=sizeof buffer) {
	new lpos = strfind(dest, l, true);
	if(lpos != -1) {
		new rpos = strfind(dest, r, true, lpos);
		if(rpos > 0) {
			if(rpos > maxlen) rpos = maxlen;
			for(new j, i=lpos+1; i < rpos; i++, j++) {
				buffer[j] = dest[i];
			}
			return 1;
		}
	}
	return 0;
}