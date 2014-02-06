/***************** CAM **********************/
stock IsPlayerAimingAt(playerid, Float:x, Float:y, Float:z, Float:radius)
{
  	new Float:camera_x,Float:camera_y,Float:camera_z,Float:vector_x,Float:vector_y,Float:vector_z;
  	GetPlayerCameraPos(playerid, camera_x, camera_y, camera_z);
  	GetPlayerCameraFrontVector(playerid, vector_x, vector_y, vector_z);
	new Float:vertical, Float:horizontal;
	switch (GetPlayerWeapon(playerid))
	{
	  	case 34,35,36:
	  	{
	  		if (DistanceCameraTargetToLocation(camera_x, camera_y, camera_z, x, y, z, vector_x, vector_y, vector_z) < radius) return true;
	  		return false;
	  	}
	  	case 30,31: {vertical = 4.0; horizontal = -1.6;}
	  	case 33: {vertical = 2.7; horizontal = -1.0;}
	  	default: {vertical = 6.0; horizontal = -2.2;}
	}
  	new Float:angl = GetPointAngleToPoint(0, 0, floatsqroot(vector_x*vector_x+vector_y*vector_y), vector_z) - 270.0;
  	new Float:resize_x, Float:resize_y, Float:resize_z = floatsin(angl+vertical, degrees);
  	GetXYInFrontOfPoint(resize_x, resize_y, GetPointAngleToPoint(0, 0, vector_x, vector_y)+horizontal, floatcos(angl+vertical, degrees));
  	if (DistanceCameraTargetToLocation(camera_x, camera_y, camera_z, x, y, z, resize_x, resize_y, resize_z) < radius) return true;
  	return false;
}

stock GetXYInFrontOfPoint(&Float:x, &Float:y, Float:angl, Float:dist)
{
	x += (dist * floatsin(-angl, degrees));
	y += (dist * floatcos(-angl, degrees));
}

stock: Float:DistanceCameraTargetToLocation(Float:CamX, Float:CamY, Float:CamZ, Float:ObjX, Float:ObjY, Float:ObjZ, Float:FrX, Float:FrY, Float:FrZ) {
	new Float:TGTDistance;
	TGTDistance = floatsqroot((CamX - ObjX) * (CamX - ObjX) + (CamY - ObjY) * (CamY - ObjY) + (CamZ - ObjZ) * (CamZ - ObjZ));
	new Float:tmpX, Float:tmpY, Float:tmpZ;
	tmpX = FrX * TGTDistance + CamX;
	tmpY = FrY * TGTDistance + CamY;
	tmpZ = FrZ * TGTDistance + CamZ;
	return floatsqroot((tmpX - ObjX) * (tmpX - ObjX) + (tmpY - ObjY) * (tmpY - ObjY) + (tmpZ - ObjZ) * (tmpZ - ObjZ));
}

stock: Float:GetPointAngleToPoint(Float:x2, Float:y2, Float:X, Float:Y) {
  	new Float:DX, Float:DY;
  	new Float: angl;

  	DX = floatabs(floatsub(x2,X));
  	DY = floatabs(floatsub(y2,Y));

  	if (DY == 0.0 || DX == 0.0)
	{
	    if(DY == 0 && DX > 0) angl = 0.0;
	    else if(DY == 0 && DX < 0) angl = 180.0;
	    else if(DY > 0 && DX == 0) angl = 90.0;
	    else if(DY < 0 && DX == 0) angl = 270.0;
	    else if(DY == 0 && DX == 0) angl = 0.0;
  	}
  	else
	{
    	angl = atan(DX/DY);
    	if(X > x2 && Y <= y2) angl += 90.0;
    	else if(X <= x2 && Y < y2) angl = floatsub(90.0, angl);
    	else if(X < x2 && Y >= y2) angl -= 90.0;
    	else if(X >= x2 && Y > y2) angl = floatsub(270.0, angl);
  	}
  	return floatadd(angl, 90.0);
}

stock IsPlayerAimingAtPlayer(playerid, targetplayerid)
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(targetplayerid, x, y, z);
	return IsPlayerAimingAt(playerid, x, y, z, 1.1);
}

stock IsHeadshot(playerid, targetplayerid)
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(targetplayerid, x, y, z);
	return IsPlayerAimingAt(playerid, x, y, z+0.8, 0.2);
}

stock bool:IsPointInTriangle(Float: x, Float: y, Float:trian[3][2]) {//by frog163? o_0 
    new Float:a = (trian[0][0] - x) * (trian[1][1] - trian[0][1]) - (trian[1][0] - trian[0][0]) * (trian[0][1] - y); 
    new Float:b = (trian[1][0] - x) * (trian[2][1] - trian[1][1]) - (trian[2][0] - trian[1][0]) * (trian[1][1] - y); 
    new Float:c = (trian[2][0] - x) * (trian[0][1] - trian[2][1]) - (trian[0][0] - trian[2][0]) * (trian[2][1] - y); 
    return ((a >= 0 && b >= 0 && c >= 0) || (a <= 0 && b <= 0 && c <= 0)) 
}  

stock GetVehicleRotation(vehicleid, &Float:x, &Float:y, &Float:z) {
    new Float:quat_w,Float:quat_x,Float:quat_y,Float:quat_z;
    GetVehicleRotationQuat(vehicleid,quat_w,quat_x,quat_y,quat_z);
    x = atan2(2*((quat_x*quat_y)+(quat_w+quat_z)),(quat_w*quat_w)+(quat_x*quat_x)-(quat_y*quat_y)-(quat_z*quat_z));
    y = atan2(2*((quat_y*quat_z)+(quat_w*quat_x)),(quat_w*quat_w)-(quat_x*quat_x)-(quat_y*quat_y)+(quat_z*quat_z));
    z = asin(-2*((quat_x*quat_z)+(quat_w*quat_y)));
    return 1;
}

stock Float:PointToPoint2D(Float:x1,Float:y1,Float:x2,Float:y2)
{
	return floatsqroot(floatadd(floatpower(x2-x1,2),floatpower(y2-y1,2)));
}
stock Float:PointToPoint3D(Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2)
{
	return floatsqroot(floatadd(floatadd(floatpower(x2-x1,2),floatpower(y2-y1,2)),floatpower(z2-z1,2)));
}

stock Float:GetPlayerDistanceToPlayer(playerid, targetid) {
    new Float:x, Float:y, Float:z, Float:x2, Float:y2, Float:z2;
    GetPlayerPos(playerid, x, y, z);
    GetPlayerPos(targetid, x2, y2, z2);
    return PointToPoint2D(x, y, x2, y2);
}