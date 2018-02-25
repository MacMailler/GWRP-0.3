
#if !defined _Core_Init_
#define _Core_Init_

#include <fix_Kick>
#include <ctime>
#include <a_mysql>
#include <sscanf2>
#include <foreach>
#include <streamer>
#include <regex>
#include <sort-0.2>
#include <container>
#include <mloader>
#include <dc_cmd>
#include <mxINI>
#include <zones>
#include <gate>

// Global string`s
new src[512];
new query[2048];
new temp[255];
new plname[24];
new dialog[2048];
new string_ah[512];
new dialogtext[3000];

#include "GWRP/Namespace.pwn"
#include "GWRP/Macro.pwn"
#include "GWRP/Color.pwn"
#include "GWRP/Util.pwn"
#include "GWRP/Database.pwn"
#include "GWRP/Iterator.pwn"

#include "GWRP/System/Init.pwn"
#include "GWRP/System/Commands/Init.pwn"

#include "GWRP/CallbackHandler.pwn"

stock core::Init() {
	new time = GetTickCount();
	
	if(GetMaxPlayers() > MAX_PLAYERS) {
		print(">> Количество слотов больше MAX_PLAYERS, старт игрового режима невозможен!");
	} else if(!db::Init()) print(">> Не удалось подключится к базе данных, старт игрового режима невозможен!");
	else {
		Iter::Init(GangSolders);
		Iter::Init(JobPlayers);
		Iter::Init(JobVehicles);
		Iter::Init(TeamPlayers);
		Iter::Init(TeamVehicles);
		Iter::Init(ExtraVehicles);
		Iter::Init(inStreamPlayers);
		Iter::Init(inStreamVehicles);
		Iter::Init(vehiclePassengers);
	
		print(" ");
	
		LoadGas();
		LoadATM();
		LoadBizz();
		prop::Load();
		LoadSkins();
		LoadRanks();
		LoadMaps();
		LoadGates();
		LoadSpawns();
		LoadHouses();
		LoadHGarages();
		LoadPortals();
		LoadVehicles();
		LoadAntiDmZones();
		LoadFracInfo();
		LoadGangInfo();
		LoadFracVehicles();
	
		print(" ");
		
		Veh::Init();
		Td::Init();
		Mnu::Init();
		Obj::Init();
		Pup::Init();
		T3d::Init();
		Area::Init();
		
		print(" ");
		
		ShowPlayerMarkers				(2);
		LimitGlobalChatRadius			(T_DIST);
		SetNameTagDrawDistance			(T_DIST);
		EnableStuntBonusForAll			(false );
		LimitPlayerMarkerRadius			(T_DIST);
		DisableInteriorEnterExits		();
		ManualVehicleEngineAndLights	();
	
		foreach(new i : Frac) {
			FracPay[i] = 0;
			GangOnBattle[i] = INVALID_BIZ_ID;
		}
	
		ValidText = regex_build("[а-яА-Яa-zA-Z0-9_,!\\.\\?\\-\\+\\(\\)\\ ]+");
		ValidRPName = regex_build("([A-Z]{1,1})[a-z]{2,9}+_([A-Z]{1,1})[a-z]{2,9}");
		ADBlock = regex_build("(((\\w+):\\/\\/)|(www\\.|\\,|))+(([\\w\\.\\,_-]{2,}(\\.|\\,)[\\w]{2,6})|(([\\d]{1,3}(\\b))(\\s+|)(\\.|\\,|\\s)(\\s+|)[\\d]{1,3}(\\s+|)(\\.|\\,|\\s)(\\s+|)[\\d]{1,3}(\\s+|)(\\.|\\,|\\s)(\\s+|)[\\d]{1,3}))(((\\s+|)(\\:|\\;|\\s)(\\s+|)[\\d\\s]{2,}(\\b))|\\b)(\\/[\\w\\&amp\\;\\%_\\.\\/\\-\\~\\-]*)?");
	
		new m, s;
		gettime(ghour, m, s);
		FixHour(ghour);
		ghour = shifthour;
		SetWorldTime(ghour);
		SetWeather(1 + random(5));

		serverUpdate = SetTimer(""#server::"Thread", SEC_TIMER, true);

		debug("core::Init() - Ok! latency: %i (ms)", GetTickCount()-time);

		print(" ");
		print(">> "#__GamemodeName__" "#__GamemodeVersion__" loaded!");
		print(">>  "#__GamemodeCopyright__"");
		print(" ");
	}
	
	return 1;
}

#endif