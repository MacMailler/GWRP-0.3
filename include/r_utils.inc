#define halt; fclose(File:-1);

stock getweek(timestamp, oldtimestamp=0) {
	#define WEEK (604800)
	return ((timestamp-oldtimestamp)/WEEK);
}

stock getday(timestamp, oldtimestamp=0) {
	#define DAY (86400)
	return ((timestamp-oldtimestamp)/DAY);
}

stock gethour(timestamp, oldtimestamp=0) {
	#define HOUR (3600)
	return ((timestamp-oldtimestamp)/HOUR);
}

stock getmin(timestamp, oldtimestamp=0) {
	#define MIN (60)
	return ((timestamp-oldtimestamp)/MIN);
}

stock getsec(timestamp, oldtimestamp=0) {
	#define SEC (1)
	return ((timestamp-oldtimestamp)/SEC);
}

stock Float:GetPlayerPosAsArray(playerid) {
	new Float:position[3];
	GetPlayerPos(playerid, position[0], position[1], position[3]);
	return position;
}

stock GetPlayerCameraLookAt(playerid, Float:dist, &Float:x, &Float:y, &Float:z) {
	new Float:cmrX, Float:cmrY, Float:cmrZ;
	new Float:vctX, Float:vctY, Float:vctZ;
	GetPlayerCameraPos(playerid, cmrX, cmrY, cmrZ);
	GetPlayerCameraFrontVector(playerid, vctX, vctY, vctZ);
	x = cmrX + dist * vctX;
	y = cmrY + dist * vctY;
	z = cmrZ + dist * vctZ;
	return 1;
}

stock GetVehicleType(model) {
	#define VEHICLE_TYPE_AIRPLANE	(0)
	#define VEHICLE_TYPE_BIKE		(1)
	#define VEHICLE_TYPE_BOAT		(2)
	#define VEHICLE_TYPE_HELICOPTER	(3)
	#define VEHICLE_TYPE_VELLO		(4)
	#define VEHICLE_TYPE_TRAILER	(5)
	#define VEHICLE_TYPE_TRAIN		(6)
	#define VEHICLE_TYPE_AUTO		(7)
	#define VEHICLE_TYPE_UNKNOWN	(-1)
	
	if(400 <= model <= 611) {
		switch(model) {
			case 460, 476, 511, 512, 513, 519, 520, 553, 577, 592, 593		: return VEHICLE_TYPE_AIRPLANE ;
			case 448, 461, 462, 463, 468, 471, 521, 522, 523, 581, 586		: return VEHICLE_TYPE_BIKE ;
			case 446, 452, 453, 454, 472, 473, 484, 493, 530, 595			: return VEHICLE_TYPE_BOAT ;
			case 417, 425, 447, 469, 487, 488, 497, 548, 563				: return VEHICLE_TYPE_HELICOPTER ;
			case 481, 509, 510												: return VEHICLE_TYPE_VELLO ;
			case 435, 450, 569, 570, 584, 590, 591, 606, 607, 608, 610, 611	: return VEHICLE_TYPE_TRAILER ;
			case 449, 537													: return VEHICLE_TYPE_TRAIN ;
			default															: return VEHICLE_TYPE_AUTO ;
		}
	}
	return VEHICLE_TYPE_UNKNOWN ;
}


stock CopyArray({Float, _}:buffer[], const {Float, _}:source[], size) {
	for(new i; i < size; i++) {
		buffer[i] = source[i];
	}
}

stock PlayerToKvadrat(playerid,Float:min_x,Float:min_y,Float:max_x,Float:max_y) {
    new Float:xxp,Float:yyp,Float:zzp;
    GetPlayerPos(playerid, xxp, yyp, zzp);
    if((xxp <= max_x && xxp >= min_x) && (yyp <= max_y && yyp >= min_y)) return true;
    return false;
}

stock IsVehicleInRangeOfPoint(vehicleid, Float:range, Float:x, Float:y, Float:z) {
	GetVehiclePos(vehicleid, vehx, vehy, vehz);
	vehx -= x; vehy -= y; vehz -= z;
	return (((vehx * vehx) + (vehy * vehy) + (vehz * vehz)) < (range * range));
}

stock IsPointInRangeOfPoint(Float:range, Float:x1, Float:y1, Float:z1, Float:x2, Float:y2, Float:z2) {
	x1 -= x2; x1 -= y2; z1 -= z2;
	return ((x1 * x1) + (y1 * y1) + (z1 * z1)) < (range * range);
}

stock TurnPlayerFaceToPlayer(playerid, facingtoid) {
	new Float:misc = 5.0;
	new Float: x1, Float: y1, Float: z1;
	new Float: x2, Float: y2, Float: z2;
	
	GetPlayerPos(facingtoid, x1, y1, z1);
	GetPlayerPos(playerid, x2, y2, z2);
	angle = 180.0 - atan2(x2 - x1, y2 - y1);
	angle += misc;
	misc *= -1;
	SetPlayerFacingAngle(playerid, angle+misc);
}

stock VehicleToKvadrat(carid,Float:min_x,Float:min_y,Float:max_x,Float:max_y) {
	new Float:xxp,Float:yyp,Float:zzp;
	GetVehiclePos(carid, xxp, yyp, zzp);
	if((xxp <= max_x && xxp >= min_x) && (yyp <= max_y && yyp >= min_y)) return 1;
	return 0;
}

stock binarySearch(const dest[], val, len=sizeof dest) {
	new f = 0;
	new l = len;
	new mid; 
 
	if(dest[0] > val || dest[len - 1] < val) {
		return -1;
	}
 
	while(f < l) {
		mid = f + (l - f) / 2;
		if(val <= dest[mid]) {
			l = mid;
		} else {
			f = mid + 1;
		}
	}

	if(l < len && dest[l] == val) {
		return l;
	}
	return -1;
}

stock binarySearch2D(const dest[][], val, elem, size = sizeof dest) {
	new f = 0;
	new l = size;
	new mid; 
 
	if(dest[0][elem] > val || dest[size - 1][elem] < val) {
		return -1;
	}
 
	while(f < l) {
		mid = f + (l - f) / 2;
		if(val <= dest[mid][elem]) {
			l = mid;
		} else {
			f = mid + 1;
		}
	}

	if(l < size && dest[l][elem] == val) {
		return l;
	}
	return -1;
}

stock interpolationSearch(const dest[], val, len=sizeof dest) {
	new mid;
	new low = 0;
	new high = len - 1;
	
	while(dest[low] < val && dest[high] > val) {
		mid = low + ((val - dest[low]) * (high - low)) / (dest[high] - dest[low]);
		
		if(dest[mid] < val) {
			low = mid + 1;
		} else if (dest[mid] > val) {
			high = mid - 1;
		} else {
			return mid;
		}
	}

	if(dest[low] == val) {
		return low;
	} else if(dest[high] == val) {
		return high;
	}
	return -1;
}

stock interpolationSearch2D(const dest[][], val, elem, len=sizeof dest) {
	new mid;
	new low = 0;
	new high = len - 1;
	
	while(dest[low][elem] < val && dest[high][elem] > val) {
		mid = low + ((val - dest[low][elem]) * (high - low)) / (dest[high][elem] - dest[low][elem]);
		
		if(dest[mid][elem] < val) {
			low = mid + 1;
		} else if (dest[mid][elem] > val) {
			high = mid - 1;
		} else {
			return mid;
		}
	}

	if(dest[low][elem] == val) {
		return low;
	} else if(dest[high][elem] == val) {
		return high;
	}
	return -1;
}


stock linearSearch(const dest[], val, l=0, r=sizeof dest) {
	if(l < r) {
		for(new i=l; i < r; i++) {
			if(dest[i] == val) {
				return i ;
			}
		}
	}
	return -1 ;
}

stock arrayToBin(const input[], maxlen=sizeof input) {
	new output=0;
	for(new i; i < maxlen; i++) {
		if(input[i] > 0) {
			output += 1 << i;
		}
	}
	return output;
}

stock binToArray(input, output[], maxlen=sizeof output) {
	for(new i; i < maxlen; ++i) {
		output[i] = input >>> i & 1 != 0;
	}
}

stock Float:vehicleSize(vehicleid) {
	new Float:x, Float:y, Float:z;
	GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_SIZE, x, y, z);
	return y;
}

#if defined Streamer_IncludeFileVersion
	#define Streamer:: Streamer_
	
	stock Float:GetPlayerDistanceFromPickup(playerid, pickupid) {
		new Float:x, Float:y, Float:z, Float:dist;
		GetPlayerPos(playerid, x, y, z);
		Streamer::GetDistanceToItem(x, y, z, STREAMER_TYPE_PICKUP, pickupid, dist);
		return dist;
	}
	
	stock isPlayerInPickup(playerid, pickupid)
	{
		new Float:x, Float:y, Float:z, Float:dist; GetPlayerPos(playerid, x, y, z);
		new type = Streamer::GetIntData(STREAMER_TYPE_PICKUP, pickupid, E_STREAMER_TYPE);
		Streamer::GetDistanceToItem(x, y, z, STREAMER_TYPE_PICKUP, pickupid, dist);
		
		if( type != 14 )
		{
			if( dist <= 3.0 )
				return 1 ;
		}
		else
		{
			if( dist <= 9.0 )
				return 1 ;
		}
		
		return 0 ;
	}
	
	stock getPickupPos(pickupid, &Float:x, &Float:y, &Float:z) {
		Streamer::GetFloatData(STREAMER_TYPE_PICKUP, pickupid, E_STREAMER_X, x);
		Streamer::GetFloatData(STREAMER_TYPE_PICKUP, pickupid, E_STREAMER_Y, y);
		Streamer::GetFloatData(STREAMER_TYPE_PICKUP, pickupid, E_STREAMER_Z, z);
		return 1 ;
	}

	stock setPickupPos(pickupid, Float:x, Float:y, Float:z) {
		Streamer::SetFloatData(STREAMER_TYPE_PICKUP, pickupid, E_STREAMER_X, x);
		Streamer::SetFloatData(STREAMER_TYPE_PICKUP, pickupid, E_STREAMER_Y, y);
		Streamer::SetFloatData(STREAMER_TYPE_PICKUP, pickupid, E_STREAMER_Z, z);
		return 1 ;
	}
	
	stock getPickupModel(pickupid) {
		return Streamer::SetIntData(STREAMER_TYPE_PICKUP, pickupid, E_STREAMER_MODEL_ID);
	}
	
	stock setPickupModel(pickupid, model) {
		Streamer::SetIntData(STREAMER_TYPE_PICKUP, pickupid, E_STREAMER_MODEL_ID, model);
		return 1 ;
	}
	
	stock x_DestroyDynamicCP(&checkpointid) {
		DestroyDynamicCP(checkpointid);
		checkpointid = -1;
		return 1;
	}
	
	stock x_DestroyDynamicRaceCP(&checkpointid) {
		DestroyDynamicRaceCP(checkpointid);
		checkpointid = -1;
		return 1;
	}
	
	stock x_DestroyDynamicPickup(&pickupid) {
		DestroyDynamicPickup(pickupid);
		pickupid = -1;
		return 1;
	}
	
	stock x_DestroyDynamic3DTextLabel(&Text3D:id) {
		DestroyDynamic3DTextLabel(id);
		id = Text3D:-1;
		return 1;
	}
	
	stock x_DestroyDynamicMapIcon(&iconid) {
		DestroyDynamicMapIcon(iconid);
		iconid = -1;
		return 1;
	}
	#define DestroyDynamicCP	 		x_DestroyDynamicCP
	#define DestroyDynamicRaceCP 		x_DestroyDynamicRaceCP
	#define DestroyDynamicPickup 		x_DestroyDynamicPickup
	#define DestroyDynamicMapIcon		x_DestroyDynamicMapIcon
	#define DestroyDynamic3DTextLabel	x_DestroyDynamic3DTextLabel
#endif

stock x_Delete3DTextLabel(&Text3D:id) {
	Delete3DTextLabel(id);
	id = Text3D:-1;
	return 1;
}
#define Delete3DTextLabel	x_Delete3DTextLabel

stock GetSquarePos(Float:x, Float:y, Float:radius, &Float:minx, &Float:miny, &Float:maxx, &Float:maxy) {
	minx = x - radius;
	miny = y - radius;
	maxx = x + radius;
	maxy = y + radius;
	return 1;
}

stock GetSquare3DPos(Float:x, Float:y, Float: z, Float:radius, &Float:minx, &Float:miny, &Float: minz, &Float:maxx, &Float:maxy, &Float:maxz) {
	minx = x - radius;
	miny = y - radius;
	minz = z - radius;
	maxx = x + radius;
	maxy = y + radius;
	maxz = z + radius;
	return 1;
}

stock GetPlayerSquare(playerid, Float:radius, &Float:minx, &Float:miny, &Float:maxx, &Float:maxy) {
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	minx = x - radius;
	miny = y - radius;
	maxx = x + radius;
	maxy = y + radius;
	return 1;
}

stock IsPlayerInSquare2D(playerid, Float:size, Float:x, Float:y, virtualworld = -1) {
	if(virtualworld == -1 || GetPlayerVirtualWorld(playerid) == virtualworld) {
		new Float:x1, Float:y1, Float:z1;
		GetPlayerPos(playerid, x1, y1, z1);
		return (((x - size) <= x1 <= (x + size)) && ((y - size) <= y1 <= (y + size)));
	}
	return 0;
}

stock IsPlayerInSquare3D(playerid, Float:size, Float:x, Float:y, Float:z, virtualworld = -1) {
	if(virtualworld == -1 || GetPlayerVirtualWorld(playerid) == virtualworld) {
		new Float:x1, Float:y1, Float:z1;
		GetPlayerPos(playerid, x1, y1, z1);
		return (((x - size) <= x1 <= (x + size)) && ((y - size) <= y1 <= (y + size)) && ((z - size) <= z1 <= (z + size)));
	}
	return 0;
}


stock GetCoordVehicleParams(vehicleid, paramid, &Float:x, &Float:y, &Float:z) //paramid: 0/1 - левая/правая дверь, 2/3 - капот/багажник 
{
    new modelid = GetVehicleModel(vehicleid); 
	
	if(!modelid) return 0;
	
    if(paramid > 3) paramid %= 4;
	
    new Float:a, Float:dist;
	
    switch( paramid )
	{ 
        case 0 : GetVehicleModelInfo(modelid, VEHICLE_MODEL_INFO_SIZE, dist, a, a), modelid = 1; 
        case 1 : GetVehicleModelInfo(modelid, VEHICLE_MODEL_INFO_SIZE, dist, a, a), modelid = -1, paramid = 0; 
        case 2 : GetVehicleModelInfo(modelid, VEHICLE_MODEL_INFO_SIZE, a, dist, a), modelid = 1,  paramid = 1; 
        case 3 : GetVehicleModelInfo(modelid, VEHICLE_MODEL_INFO_SIZE, a, dist, a), modelid = -1, paramid = 1; 
    }
	
    dist /= 2.0, GetVehiclePos(vehicleid, x, y, z), GetVehicleZAngle(vehicleid, a); 
    if(paramid)x += modelid*dist*floatsin(a+180.0,degrees),y += modelid*dist*floatcos(a+180.0,degrees); 
    else x += modelid*dist*floatsin(a+90.0,degrees),y += modelid*dist*floatcos(a+90.0,degrees);
	
    return true; 
}

stock ReturnUser(text[]) {
	new userid;
	if(sscanf(text, "u", userid)) return INVALID_PLAYER_ID;
	return userid;
}

stock GetXYInFrontOfPoint(&Float:x, &Float:y, Float:angl, Float:dist) {
	x += (dist * floatsin(-angl, degrees));
	y += (dist * floatcos(-angl, degrees));
}

stock GetVehicleRotation(vehicleid, &Float:x, &Float:y, &Float:z) {
    new Float:quat_w,Float:quat_x,Float:quat_y,Float:quat_z;
    GetVehicleRotationQuat(vehicleid,quat_w,quat_x,quat_y,quat_z);
    x = atan2(2*((quat_x*quat_y)+(quat_w+quat_z)),(quat_w*quat_w)+(quat_x*quat_x)-(quat_y*quat_y)-(quat_z*quat_z));
    y = atan2(2*((quat_y*quat_z)+(quat_w*quat_x)),(quat_w*quat_w)-(quat_x*quat_x)-(quat_y*quat_y)+(quat_z*quat_z));
    z = asin(-2*((quat_x*quat_z)+(quat_w*quat_y)));
    return 1;
}

stock split(dest[], const string[], &index, seperator=' ') { 
	if(index != 0 && string[index] != '\0') index++; 
	new i = 0; 
	for(;;) {
		if (i == 0) {
			for(;;) { 
				if(string[index] == seperator) { 
					index++; 
				} else { 
					switch(string[index]) { 
						case '\0', '\a', '\b', '\f', '\n', '\r', '\t', '\v': index++; 
						default: break; 
					} 
				} 
			} 
		} 
		if(string[index] == seperator) break; 
		
		switch(string[index]) { 
			case '\0', '\a', '\b', '\f', '\n', '\r', '\t', '\v': break; 
			default: dest[i++] = string[index++]; 
		} 
	} 
	dest[i] = '\0'; 
}

#define MD5_HASH_LEN (33)
#define SHA1_HASH_LEN (41)
#define SHA2_HASH_LEN (65)