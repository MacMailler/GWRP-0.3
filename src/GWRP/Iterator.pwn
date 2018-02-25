
#if !defined _Core_Iterator_
#define _Core_Iterator_

new Iterator:GangSolders[MAX_FRAC]<MAX_PLAYERS>;
new Iterator:JobPlayers[MAX_JOBS]<MAX_PLAYERS>;
new Iterator:JobVehicles[MAX_JOBS]<MAX_VEHICLES>;
new Iterator:TeamPlayers[MAX_FRAC]<MAX_PLAYERS>;
new Iterator:TeamVehicles[MAX_FRAC]<MAX_VEHICLES>;
new Iterator:inStreamPlayers[MAX_PLAYERS]<MAX_PLAYERS>;
new Iterator:inStreamVehicles[MAX_PLAYERS]<MAX_VEHICLES>;
new Iterator:vehiclePassengers[MAX_VEHICLES]<MAX_PLAYERS>;

#endif