#if defined __gate_included
	#endinput
#endif
#define __gate_included


#define INVALID_GATE_ID (0xFFFF)
#define INVALID_LEAF_ID (0xFFFF)

#define MAX_GATES (100)
#define MAX_LEAFS (4)
#define MAX_GATE_PICKUPS (3)

#define TYPE_LEAF (0)
#define TYPE_BARRIER (1)

#define STATUS_CLOSE (0)
#define STATUS_OPEN (1)


enum eGateInfo {
	eObject,
	eType,
	Float:ePos[6],
	Float:eMovePos[6]
}
static GateInfo[MAX_GATES][MAX_LEAFS][eGateInfo];

enum eGatePickupInfo {
	eArea,
	ePickup,
}
static GatePickupInfo[MAX_GATES][MAX_GATE_PICKUPS][eGatePickupInfo];
static GateStatusData[MAX_GATES];
static GateLeafCount[MAX_GATES];
static GatePickupCount[MAX_GATES];
static GateCount;

stock CreateGate() {
	if(GateCount < sizeof GateInfo) {
		return GateCount++;
	}
	return INVALID_GATE_ID;
}

stock AddLeafToGate(gateid, model, Float:pos[6], Float:movePos[6], virtualworld=-1, interiorid=-1, playerid=-1, Float:streamdist=300.0) {
	if(0 <= gateid < GateCount) {
		if(GateLeafCount[gateid] < sizeof GateInfo[]) {
			new leafid = GateLeafCount[gateid]++;
			GateInfo[gateid][leafid][eObject] = AddObject(model, pos[0], pos[1], pos[2], pos[3], pos[4], pos[5], virtualworld, interiorid, playerid, streamdist);
			GateInfo[gateid][leafid][eType] = TYPE_LEAF;
			GateStatusData[gateid] = STATUS_CLOSE;
			for(new i; i < 6; i++) {
				GateInfo[gateid][leafid][ePos][i] = pos[i];
				GateInfo[gateid][leafid][eMovePos][i] = movePos[i];
			}
			return leafid;
		}
	}
	return INVALID_LEAF_ID;
}

stock AddPickupToGate(gateid, model, Float:pos[3], virtualworld=-1, interiorid=-1, playerid=-1, Float:streamdist=100.0) {
	if(0 <= gateid < GateCount) {
		if(GatePickupCount[gateid] < sizeof GatePickupInfo[]) {
			new pickupid = GatePickupCount[gateid]++;
			GatePickupInfo[gateid][pickupid][eArea] = CreateDynamicSphere(pos[0], pos[1], pos[2], 2.0, virtualworld, interiorid, playerid);
			GatePickupInfo[gateid][pickupid][ePickup] = CreateDynamicPickup(model, 1, pos[0], pos[1], pos[2], virtualworld, interiorid, playerid, streamdist);
			return pickupid;
		}
	}
	return 0;
}

public: GateOpen(gateid) {
	if(0 <= gateid < GateCount) {
		if(GateStatusData[gateid] == STATUS_CLOSE) {
			GateStatusData[gateid] = STATUS_OPEN;
			for(new i; i < GateLeafCount[gateid]; i++) {
				switch(GateInfo[gateid][i][eType]) {
					case TYPE_LEAF : {
						MoveDynamicObject(
							GateInfo[gateid][i][eObject],
							GateInfo[gateid][i][eMovePos][0],
							GateInfo[gateid][i][eMovePos][1],
							GateInfo[gateid][i][eMovePos][2],
							3.0,
							GateInfo[gateid][i][eMovePos][3],
							GateInfo[gateid][i][eMovePos][4],
							GateInfo[gateid][i][eMovePos][5]
						);
					}
					
					case TYPE_BARRIER : {
						MoveDynamicObject(
							GateInfo[gateid][i][eObject],
							GateInfo[gateid][i][eMovePos][0],
							GateInfo[gateid][i][eMovePos][1],
							GateInfo[gateid][i][eMovePos][2] + 0.004,
							0.004,
							GateInfo[gateid][i][eMovePos][3],
							GateInfo[gateid][i][eMovePos][4],
							GateInfo[gateid][i][eMovePos][5]
						);
					}
				}
			}
			return 1;
		}
	}
	return 0;
}

public: GateClose(gateid) {
	if(0 <= gateid < GateCount) {
		if(GateStatusData[gateid] == STATUS_OPEN) {
			GateStatusData[gateid] = STATUS_CLOSE;
			for(new i; i < GateLeafCount[gateid]; i++) {
				switch(GateInfo[gateid][i][eType]) {
					case TYPE_LEAF : {
						MoveDynamicObject(
							GateInfo[gateid][i][eObject],
							GateInfo[gateid][i][ePos][0],
							GateInfo[gateid][i][ePos][1],
							GateInfo[gateid][i][ePos][2],
							3.0,
							GateInfo[gateid][i][ePos][3],
							GateInfo[gateid][i][ePos][4],
							GateInfo[gateid][i][ePos][5]
						);
					}
					
					case TYPE_BARRIER : {
						MoveDynamicObject(
							GateInfo[gateid][i][eObject],
							GateInfo[gateid][i][ePos][0],
							GateInfo[gateid][i][ePos][1],
							GateInfo[gateid][i][ePos][2] - 0.004,
							0.004,
							GateInfo[gateid][i][ePos][3],
							GateInfo[gateid][i][ePos][4],
							GateInfo[gateid][i][ePos][5]
						);
					}
				}
			}
			return 1;
		}
	}
	return 0;
}

stock SetLeafType(gateid, leafid, type) {
	if(0 <= gateid < GateCount) {
		if(0 <= leafid < sizeof GateInfo[]) {
			GateInfo[gateid][leafid][eType] = type;
			return 1;
		}
	}
	return 0;
}

stock IsPlayerInRangeOfGate(playerid, Float:radi, gateid) {
	if(0 <= gateid < GateCount) {
		for(new i; i < GateLeafCount[gateid]; i++) {
			if(IsPlayerInRangeOfObject(playerid, radi, GateInfo[gateid][i][eObject], true)) {
				return 1;
			}
		}
	}
	return 0;
}


public OnPlayerEnterDynamicArea(playerid, areaid) {
	for(new i; i < GateCount; i++) {
		for(new j; j < GatePickupCount[i]; j++) {
			if(GatePickupInfo[i][j][eArea] == areaid) {
				return CallLocalFunction("OnPlayerGatePickUp", "iii", playerid, i, j);
			}
		}
	}
	return CallLocalFunction("Gate_OnPlayerEnterDynamicArea", "ii", playerid, areaid);
}

#if defined _ALS_OnPlayerEnterDynamicArea
	#undef OnPlayerEnterDynamicArea
#else
	#define _ALS_OnPlayerEnterDynamicArea
#endif
#define OnPlayerEnterDynamicArea Gate_OnPlayerEnterDynamicArea

forward Gate_OnPlayerEnterDynamicArea(playerid, areaid);