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

stock GetPlayerFrontLookAt(playerid, Float:dist, &Float:x, &Float:y, &Float:z) {
	new Float:cmrX, Float:cmrY, Float:cmrZ;
	new Float:vctX, Float:vctY, Float:vctZ;
	GetPlayerCameraPos(playerid, cmrX, cmrY, cmrZ);
	GetPlayerCameraFrontVector(playerid, vctX, vctY, vctZ);
	x = cmrX+dist*vctX;
	y = cmrY+dist*vctY;
	z = cmrZ+dist*vctZ;
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

#define any: {Float, _}:
stock copyArray(any: buffer[], const any: source[], size) {
	for(new i; i < size; i++) {
		buffer[ i ] = source[ i ];
	}
}

stock Float:getPlayerPacketLoss(playerid) {
	static netstats[300], packetloss;
	GetPlayerNetworkStats(playerid, netstats, sizeof netstats);
	sscanf(netstat, "'Packetloss: 'f'%'", packetloss);
	return packetloss;
}

stock getPlayerMessagesReceived(playerid) {
	static netstat[300], packets;
	GetPlayerNetworkStats(playerid, netstat, sizeof netstat);
	sscanf(netstat, "'Messages received: 'i", packets);
	return packets;
}

stock getPlayerMessagesSent(playerid) {
	static netstat[300], packets;
	GetPlayerNetworkStats(playerid, netstat, sizeof netstat);
	sscanf(netstat, "'Messages sent: 'i", packets);
	return packets;
}

stock getPlayerBytesSent(playerid) {
	static netstat[300], packets;
	GetPlayerNetworkStats(playerid, netstat, sizeof netstat);
	sscanf(netstat, "'Bytes sent: 'i", packets);
	return packets;
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
	angle = 180.0-atan2(x2-x1,y2-y1);
	angle += misc; misc *= -1;
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
	new model = GetVehicleModel(vehicleid);
	if(400 <= model <= 611) {
		new Float:x, Float:y, Float:z;
		GetVehicleModelInfo(model, 1, x, y, z);
		return y;
	}
	return 0.0;
}

#if defined Streamer_IncludeFileVersion
	#define streamer:: Streamer_
	
	stock Float:GetPlayerDistanceFromPickup(playerid, pickupid) {
		new Float:x, Float:y, Float:z, Float:dist;
		GetPlayerPos(playerid, x, y, z);
		streamer::GetDistanceToItem(x, y, z, STREAMER_TYPE_PICKUP, pickupid, dist);
		return dist;
	}
	
	stock isPlayerInPickup(playerid, pickupid)
	{
		new Float:x, Float:y, Float:z, Float:dist; GetPlayerPos(playerid, x, y, z);
		new type = streamer::GetIntData(STREAMER_TYPE_PICKUP, pickupid, E_STREAMER_TYPE);
		streamer::GetDistanceToItem(x, y, z, STREAMER_TYPE_PICKUP, pickupid, dist);
		
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
		streamer::GetFloatData(STREAMER_TYPE_PICKUP, pickupid, E_STREAMER_X, x);
		streamer::GetFloatData(STREAMER_TYPE_PICKUP, pickupid, E_STREAMER_Y, y);
		streamer::GetFloatData(STREAMER_TYPE_PICKUP, pickupid, E_STREAMER_Z, z);
		return 1 ;
	}

	stock setPickupPos(pickupid, Float:x, Float:y, Float:z) {
		streamer::SetFloatData(STREAMER_TYPE_PICKUP, pickupid, E_STREAMER_X, x);
		streamer::SetFloatData(STREAMER_TYPE_PICKUP, pickupid, E_STREAMER_Y, y);
		streamer::SetFloatData(STREAMER_TYPE_PICKUP, pickupid, E_STREAMER_Z, z);
		return 1 ;
	}
	
	stock getPickupModel(pickupid) {
		return streamer::SetIntData(STREAMER_TYPE_PICKUP, pickupid, E_STREAMER_MODEL_ID);
	}
	
	stock setPickupModel(pickupid, model) {
		streamer::SetIntData(STREAMER_TYPE_PICKUP, pickupid, E_STREAMER_MODEL_ID, model);
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

stock pause(ticks) {
	new currticks = tickcount();
	while(tickcount() - currticks < ticks) {}
	
	return ;
}

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


stock GetCoordBonetVehicle(vehicleid, &Float:x, &Float:y, &Float:z) {
    GetVehicleModelInfo(GetVehicleModel(vehicleid), 1, x, distance, z); 
    distance = distance/2 + 0.1; 
    GetVehiclePos(vehicleid, x, y, z); 
    GetVehicleZAngle(vehicleid, angle); 
    x -= (distance * floatsin(-angle+180, degrees)); 
    y -= (distance * floatcos(-angle+180, degrees)); 
    return 1; 
}  

stock GetCoordBootVehicle(vehicleid, &Float:x, &Float:y, &Float:z)
{
    GetVehicleModelInfo(GetVehicleModel(vehicleid), 1, x, distance, z);
    distance = distance/2 + 0.1;
    GetVehiclePos(vehicleid, x, y, z);
    GetVehicleZAngle(vehicleid, angle);
    x += (distance * floatsin(-angle+180, degrees));
    y += (distance * floatcos(-angle+180, degrees));
    return 1;
}

stock IsClosestVehicle(Float:radi, vehicleid, closestveh) {
    if(vehicleid != INVALID_VEHICLE_ID) {
		GetVehiclePos(vehicleid, vehx, vehy, vehz);
		return (radi >= GetVehicleDistanceFromPoint(closestveh, vehx, vehy, vehz));
	}
	return 0;
}


stock GetClosestVehicle(playerid, Float:radi) {
	if(IsPlayerConnected(playerid)) {
		new vehid = 1;
		do {
			GetVehiclePos(vehid, vehx, vehy, vehz);
			GetVehicleModelInfo(GetVehicleModel(vehid), 1, posx, distance, posz);
			distance = distance/2 + 0.1; distance += radi;
			if(distance >= GetPlayerDistanceFromPoint(playerid, vehx, vehy, vehz)) return vehid;
			vehid ++;
			
		} while(vehid != MAX_VEHICLES);
	}
	return INVALID_VEHICLE_ID;
}


stock GetCoordVehicleParams(vehicleid, paramid, &Float:x, &Float:y, &Float:z) //paramid: 0/1 - левая/правая дверь, 2/3 - капот/багажник 
{
    new modelid = GetVehicleModel(vehicleid); 
	
	if( !modelid ) return 0;
	
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

stock GetVehicleClosest(vehicleid, Float:radi)
{
	new vehid = 1;
	do
	{
		if(vehid != vehicleid)
		{
			GetVehiclePos(vehid, vehx, vehy, vehz);
			GetVehicleModelInfo(GetVehicleModel(vehid), 1, posx, distance, posz);
			distance = distance/2 + 0.1; distance += radi;
			if(distance >= GetVehicleDistanceFromPoint(vehicleid, vehx, vehy, vehz)) return vehid;
		}
		vehid ++;
	}
	while(vehid != MAX_VEHICLES);
	
	return INVALID_VEHICLE_ID;
}

stock strtok(const string[], &index,seperator=' ')
{
	new length = strlen(string);
	new offset = index;
	new result[256];
	while ((index < length) && (string[index] != seperator) && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	if ((index < length) && (string[index] == seperator))
	{
		index++;
	}
	return result;
}

stock IsNumeric(const string[])
{
	for (new i = 0, j = strlen(string); i < j; i++) if(string[i] > '9' || string[i] < '0') return 0;
	return 1;
}

stock ReturnUser(text[])
{
	new userid;
	if(sscanf(text, "u", userid)) return INVALID_PLAYER_ID;
	return userid;
}

stock IsInvalidText(string[]) {
	new count=0, len = strlen( string );
	for(new i; i < len; i++) {
		switch(string[i]) {
			case '0'..'9' : continue;
			case 'a'..'z' : continue;
			case 'A'..'Z' : continue;
			case 'а'..'я' : continue;
			case 'А'..'Я' : continue;
			case ' ', '_', '-' : continue;
			case '(', ')', '.' : continue;
			default : count ++;
		}
	}
	return count;
}

stock str_check( string[], bool:isrus = false ) {
	new len = strlen( string );
	for(new i; i < len; i++) {
		if( string[i] == ' ' || string[i] == '_' || string[i] == '-' )
			continue;
			
		if( string[i] == '(' || string[i] == ')' || string[i] == '.')
			continue;

		if( '0' <= string[0] <= '9' )
			continue;			

		if( 'a' <= string[0] <= 'z' )
			continue;
			
		if( 'A' <= string[0] <= 'Z' )
			continue;
			
		if( isrus )
		{
			if( string[i] >= 'а' && string[i] <= 'я' )
				continue;
				
			if( string[i] >= 'А' && string[i] <= 'Я' )
				continue;
		}
		
		return true;
	}
	return false;
}

stock IsRPName(pname[])
{
	for(new i; i < strlen(pname); i++)
	{
		if(!((pname[i] >= 'a' && pname[i] <= 'z') || (pname[i] >= 'A' && pname[i] <= 'Z') || pname[i] == '_')) return true; // недопустимые символы в нике
	}
	new d = strfind(pname, "_");
	if(d == -1) return true; // нет _ в нике
	if(strfind(pname, "_", false, d+1) != -1) return true; // больше одного _ в нике
	new name[15], surname[15];
	strmid(name, pname, 0, d, sizeof name);
	strmid(surname, pname, d+1, strlen(pname), sizeof surname);
	if(strlen(name) < 3 || strlen(name) > 11) return true; // неверная длина имени
	if(strlen(surname) < 3 || strlen(surname) > 11) return true; // неверная длина фамилии
	if(!(name[0] >= 'A' && name[0] <= 'Z')) return true; // первая буква имени не заглавная
	if(!(surname[0] >= 'A' && surname[0] <= 'Z')) return true; // первая буква фамилии не заглавная
	for(new i = 1; i < strlen(name);i++)
	{
		if(!(name[i] >= 'a' && name[i] <= 'z')) return true; // неверные буквы в имени
	}
	for(new i = 1; i < strlen(surname);i++)
	{
		if(!(surname[i] >= 'a' && surname[i] <= 'z')) return true; // неверные буквы в фамилии
	}
	return false; // ok
}


stock Float: fparam ( const source[], delimiter = ' ', substrIndex = 0 ) 
{ 
  new dest[40], cur, pre, i = -1; 

  for ( ; ; cur++ ) // пробежимся по каждому символу в строке source 
  { 
    if ( source[cur] == 0 ) // если текущий символ в source - это символ конца строки 
    { 
      if ( ++i == substrIndex ) // если индекс текущей подстроки и есть sourceIndex 
        strmid( dest, source, pre, cur, 40 ); // скопируем в dest нужную подстроку из source 

      goto fparam_end; 
    } 

    if ( source[cur] == delimiter ) // если текущий символ в source - это символ для разделения строки 
    { 
      if ( ++i == substrIndex ) // если индекс текущей подстроки и есть sourceIndex 
      { 
        strmid( dest, source, pre, cur, 40 );// скопируем в dest нужную подстроку из source 
        goto fparam_end; 
      } 

      pre = cur + 1; 
    } 
  } 

  fparam_end: 
  return floatstr(dest); // завершим работу функции и вернем дробное значение подстроки 
} 
stock iparam ( const source[], delimiter = ' ', substrIndex = 0 ) 
{ 
  new dest[12], cur, pre, i = -1; 

  for ( ; ; cur++ ) // пробежимся по каждому символу в строке source 
  { 
    if ( source[cur] == 0 ) // если текущий символ в source - это символ конца строки 
    { 
      if ( ++i == substrIndex ) // если индекс текущей подстроки и есть sourceIndex 
        strmid( dest, source, pre, cur, 12 ); // скопируем в dest нужную подстроку из source 

      goto iparam_end; 
    } 

    if ( source[cur] == delimiter ) // если текущий символ в source - это символ для разделения строки 
    { 
      if ( ++i == substrIndex ) // если индекс текущей подстроки и есть sourceIndex 
      { 
        strmid( dest, source, pre, cur, 12 );// скопируем в dest нужную подстроку из source 
        goto iparam_end; 
      } 

      pre = cur + 1; 
    } 
  } 

  iparam_end: 
  return strval(dest); // завершим работу функции и вернем целочисленное значение подстроки 
} 
stock sparam(dest[], maxSize = sizeof(dest), const source[], delimiter  = ' ', substrIndex = 0, withRest = 0) 
{ 
  dest[0] = 0; // очистим строку назначения 

  for ( new cur, pre, i = -1; ; cur++ ) // пробежимся по каждому символу в строке source 
  { 
    if ( source[cur] == 0 ) // если текущий символ в source - это символ конца строки 
    { 
      if ( ++i == substrIndex ) // если индекс текущей подстроки и есть sourceIndex 
        // скопируем в dest нужную подстроку из source 
        strmid( dest, source, pre, ( withRest ? strlen(source) : cur ), maxSize ); 

      goto sparam_end; 
    } 

    if ( source[cur] == delimiter ) // если текущий символ в source - это символ для разделения строки 
    { 
      if ( ++i == substrIndex ) // если индекс текущей подстроки и есть sourceIndex 
      { 
        // скопируем в dest нужную подстроку из source 
        strmid( dest, source, pre, ( withRest ? strlen(source) : cur ), maxSize ); 
        goto sparam_end; 
      } 

      pre = cur + 1; 
    } 
  } 

  sparam_end: 
  return; // завершим работу функции 
}

/*#define BYTES_PER_CELL (cellbits / 8)
stock SendFormattedMessage(playerid, color, fstring[], {Float, _}:...)
{
    // This is the number of parameters which are not variable that are passed
    // to this function (i.e. the number of named parameters).
    static const
        STATIC_ARGS = 3;
    // Get the number of variable arguments.
    new
        n = (numargs() - STATIC_ARGS) * BYTES_PER_CELL;
    if (n)
    {
        new
            message[128],
            arg_start,
            arg_end;

        // Load the real address of the last static parameter. Do this by
        // loading the address of the last known static parameter and then
        // adding the value of [FRM].
        #emit CONST.alt        fstring
        #emit LCTRL          5
        #emit ADD
        #emit STOR.S.pri        arg_start

        // Load the address of the last variable parameter. Do this by adding
        // the number of variable parameters on the value just loaded.
        #emit LOAD.S.alt        n
        #emit ADD
        #emit STOR.S.pri        arg_end

        // Push the variable arguments. This is done by loading the value of
        // each one in reverse order and pushing them. I'd love to be able to
        // rewrite this to use the values of pri and alt for comparison,
        // instead of having to constantly load and reload two variables.
        do
        {
            #emit LOAD.I
            #emit PUSH.pri
            arg_end -= BYTES_PER_CELL;
            #emit LOAD.S.pri      arg_end
        }
        while (arg_end > arg_start);

        // Push the static format parameters.
        #emit PUSH.S          fstring
        #emit PUSH.C          128
        #emit PUSH.ADR         message

        // Now push the number of arguments passed to format, including both
        // static and variable ones and call the function.
        n += BYTES_PER_CELL * 3;
        #emit PUSH.S          n
        #emit SYSREQ.C         format

        // Remove all data, including the return value, from the stack.
        n += BYTES_PER_CELL;
        #emit LCTRL          4
        #emit LOAD.S.alt        n
        #emit ADD
        #emit SCTRL          4

        return SendClientMessage(playerid, color, message);
    }
    else
    {
        return SendClientMessage(playerid, color, fstring);
    }
}

delete_array(array[], maxlength)
{
    new
        arraySize,
        arrayStart,
        arrayEnd,
		size = (maxlength >> 2)
    ;
    
    #emit LOAD.S.pri        12 
    #emit STOR.S.pri        arrayStart
    
    #emit SHL.C.pri         2
    
    #emit LOAD.S.alt        size
    #emit ADD
    #emit STOR.S.pri        arrayEnd
    
    arraySize = ((arrayEnd - arrayStart) << 2);

    #emit LOAD.S.pri        arraySize
    #emit LREF.S.alt        array
    
    #emit ADD.C             4
    #emit PUSH.pri 
    
    #emit POP.alt 
    #emit SHL.C.pri         3
    
    #emit LOAD.S.alt        arrayEnd
    #emit DEC.alt
    
    #emit JZER
    #emit SREF.S.pri        arrayStart
    
    arrayStart /= 8;
    
    #emit PUSH.C            4
    #emit LCTRL             1
    #emit NEG
    
    #emit MOVE.alt
    #emit STOR.S.alt        arrayStart
    
    arraySize -= ((arrayEnd | 32) >>> (arrayStart & 16));
    
    #emit STACK             arraySize
}*/