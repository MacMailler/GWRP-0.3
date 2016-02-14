/***
	The MIT License (MIT)

	Copyright © 2014 MacMailler

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

#include <a_samp>
#include "..\include\bootstrap"

#define __GamemodeName__		"GWRP"
#define __GamemodeVersion__		"0.3"
#define __GamemodeCopyright__	"(c) MacMailler, 2012—2014"

#define __DBPrefix__			""

#define __TableUsers__			__DBPrefix__"users"
#define __TableHouses__			__DBPrefix__"houses"
#define __TableBusines__		__DBPrefix__"busines"
#define __TableStuffs__			__DBPrefix__"stuffs"
#define __TableSpawns__			__DBPrefix__"spawns"
#define __TableBanned__			__DBPrefix__"banned"
#define __TableBlacklist__		__DBPrefix__"blacklist"
#define __TableFracInfo__		__DBPrefix__"frac_info"
#define __TableFracModels__		__DBPrefix__"frac_models"
#define __TableFracVehicles__	__DBPrefix__"frac_vehicles"
#define __TableFracSkins__		__DBPrefix__"frac_skins"
#define __TableGangInfo__		__DBPrefix__"ganginfo"
#define __TableRefills__		__DBPrefix__"busines_refill"
#define __TablePickups__		__DBPrefix__"pickups"
#define __TableVehicles__		__DBPrefix__"vehicles"
#define __TableFracRanks__		__DBPrefix__"frac_ranks"
#define __TableAntidmzones__	__DBPrefix__"antidmzones"
#define __TableExtraVehicles__	__DBPrefix__"extra_vehicles"
#define __TableHouseGarages__	__DBPrefix__"houses_garage"

#define LOG_ANTICHEAT			"anticheat"
#define LOG_ADMINCHAT			"adminchat"
#define LOG_REPORT				"report"
#define LOG_ADMWARN				"admwarn"
#define LOG_PAYDAY_STATS		"debug"
#define LOG_MYSQL_ERROR			"sqlerror"
#define LOG_GOV_CHAT			"gov"
#define LOG_AD_CHAT				"ad"
#define LOG_CHANGENAME			"changename"
#define LOG_HELPER_CHAT			"helperchat"
#define LOG_HOUSE				"houses"
#define LOG_PAY					"pay"

#define __SERVER_NAME_LC		"GrandWorld"
#define __SERVER_NAME_L			"grandworld"
#define __SERVER_NAME_C			"GRANDWORLD"
#define __SERVER_PREFIX			"[RP]"
#define __SERVER_SITE			"www.gwrp.net"

#define MAX_FC					(300)
#define MAX_GAS 				(64)
#define MAX_FRAC				(19)
#define MAX_JOBS				(12)
#define MAX_RANK				(23)
#define MAX_HWEAP				(6)
#define MAX_SPAWNS				(4)
#define MAX_BIZNES				(128)
#define MAX_HOUSES				(1024)
#define MAX_PORTALS				(60)
#define MAX_AFK_TIME 			(600)
#define MAX_ZONE_SIZE			(60.0)
#define MAX_COMPONENT 			(14)
#define MAX_VEHICLESex			(200)
#define MAX_ANTIDM_ZONES		(10)
#define MAX_FRAC_GATE			(50)
#define MAX_REFILLS				(50)
#define MAX_MAPS				(64)

#define START_MONEY				(5000)
#define START_LEVEL				(1)

#define T_DIST 					(55.0)
#define AFK_TEXT_SET 			(2)
#define FC_DEF_NUMBER			"NONE"

#define CHECKPOINT_NONE			(0)
#define CHECKPOINT_HOME 		(12)

#define JAILED_MAN 				(268)
#define JAILED_WOMEN 			(69)

#define INVALID_ID				(0xFFFF)
#define INVALID_BIZ_ID			INVALID_ID
#define INVALID_HOUSE_ID		INVALID_ID

#define OFFSET_HOUSE			(INVALID_HOUSE_ID)
#define OFFSET_BIZZ				(INVALID_HOUSE_ID + MAX_HOUSES)

#define Bizz_PaintBall			(40)
#define Bizz_EstateAgency		(38)
#define Bizz_Church				(64)
#define Bizz_PowerHouse			(34)
#define Bizz_TelephoneCompany	(35)
#define Bizz_Lottery			(31)
#define Bizz_HouseService		(32)
#define Bizz_RifaSklad			(37)
#define Bizz_GarageLS			(66)
#define Bizz_GarageLV			(67)
#define Bizz_GarageSF 			(68)
#define Bizz_GarageRublovka 	(83)
#define Bizz_AutoSolonClassA	(39)
#define Bizz_AutoSolonClassB	(36)
#define Bizz_AutoSolonClassC	(51)
#define Bizz_AutoSolonClassD	(69)
#define Bizz_ProdSkladLS		(58)
#define Bizz_ProdSkladSF		(44)
#define Bizz_ProLaps			(7)

#define TelephonePrice			500
#define ScrathCardPrice			10000
#define PhoneBookPrice			5000
#define DicePrice				500
#define CarKeyPrice				5000
#define CandomPrice 			50
#define CDPlayerPrice 			2500

#define JOB_NONE 				(0)
#define JOB_DETECTIVE 			(1)
#define JOB_LAWYER 				(2)
#define JOB_WHORE 				(3)
#define JOB_DRUGDEALER			(4)
#define JOB_THEFTAUTO 			(5)
#define JOB_MECHANIC 			(6)
#define JOB_GUNDEALER 			(7)
#define JOB_AUTODEALER 			(8)
#define JOB_BUSMAN 				(9)
#define JOB_TRUCKER 			(10)

#define TEAM_CIV				(0)
#define TEAM_COP				(1)
#define TEAM_FBI				(2)
#define TEAM_ARMY				(3)
#define TEAM_MEDIC				(4)
#define TEAM_LCN				(5)
#define TEAM_YAKUZA				(6)
#define TEAM_GOV				(7)
#define TEAM_FARMERS			(8)
#define TEAM_PRESS				(9)
#define TEAM_TAXI				(10)
#define TEAM_LICENZERS			(11)
#define TEAM_STREETDOGS			(12)
#define TEAM_RUSSIAN			(13)
#define TEAM_GROVE				(14)
#define TEAM_CORONOS			(15)
#define TEAM_BALLAS				(16)
#define TEAM_RIFA				(17)
#define TEAM_VAGOS				(18)

#define D_NONE 					(10)
#define D_ATM			 		(500)
#define D_JOB			 		(600)
#define D_REF			 		(700)
#define D_WAIT					(800)
#define D_MENU					(900)
#define D_GIFT					(1000)
#define D_GGUN					(1100)
#define D_BARN					(1200)
#define D_EDIT					(1300)
#define D_GOTO					(1400)
#define D_HELP					(1500)
#define D_BANK					(1600)
#define D_AUTH 					(1700)
#define D_REGG 					(1800)
#define D_MASK					(1900)
#define D_FBANK					(2000)
#define D_RADIO					(2100)
#define D_BMENU					(2200)
#define D_HMENU					(2300)
#define D_CRANK					(2400)
#define D_COLORS				(2500)
#define D_REFILL 				(2600)
#define D_EN_BIZ				(2700)
#define D_EX_BIZ				(2800)
#define D_ARMOUR				(3000)
#define D_ONLINE 				(3100)
#define D_HEALME 				(3200)
#define D_TUNING				(3400)
#define D_OFFLINE 				(3500)
#define D_NETSTAT				(3600)
#define D_SETSTAT				(3700)
#define D_GOCLEAN				(3800)
#define D_RENTCAR				(3900)
#define D_BANLIST				(4000)
#define D_WEATHER				(4100)
#define D_PDDTEST				(4300)
#define D_PORTABLE				(4400)
#define D_EN_HOUSE 				(4500)
#define D_EX_HOUSE 				(4600)
#define D_GIVE_PASS 			(4700)
#define D_FIGHTSTYLE 			(4800)
#define D_CHANGE_PASS 			(4900)
#define D_FACTORY_JOB			(5000)
#define TP_EDIT					(5100)
#define D_LMENU					(5200)
#define D_ADD_FC				(5300)
#define D_DEL_FC				(5400)
#define D_ADD_MODEL				(5500)
#define D_SHOW_MODEL			(5600)
#define D_EDIT_MODEL			(5700)
#define D_EDIT_MAPS				(5800)
#define D_FARE					(5900)
#define D_SKILL					(6000)
#define D_SPAWN					(6100)
#define D_SERVICE				(6200)
#define D_LOGIN					(6300)
#define D_EV_MENU				(6400)

#define FIND_ICON				(0)
#define ZAHVAT_ICON				(1)

#define REFUEL_TIME				(10000)
#define NUMBER_OF_TRUCKS		(8)

#define	MODER1LVL				(1)
#define MODER2LVL				(2)
#define MODER3LVL				(4)
#define SUPERMODER				(3)
#define ADMINISTRATOR			(5)

#define ADV_TIME				(600)
#define SEC_TIMER				(900)
#define GAINS_TIME				(900)

#define Fc::					FC_
#define Td::					TextDraw
#define Pt:: 					PlayerTextDraw
#define Pl::					PL_
#define Bl::					BL_
#define Gm::					GM_
#define Gz::					GangZone
#define Db::					mysql_
#define Iter::					Iter_
#define Ptl::					TP_
#define PickupHndlr::			PH_

#define Mnu::					MNU_
#define T3d::					T3D_
#define Obj::					OBJ_
#define Veh::					VEH_
#define Pup::					PUP_
#define Area::					AREA_

#define GetIndexFromBizID(%0)	interpolationSearch2D(BizzInfo,%0,bID,Iter::Count(Biznes))
#define IsPlayerLeader(%0)		Pl::Info[%0][pLeader]
#define IsValidFrac(%0)			(1 <= %0 <= MAX_FRAC)

#define EXP(%0)					((Pl::Info[%0][pLevel]+1) * levelexp)
#define costlvl(%0)				((Pl::Info[%0][pLevel]+1) * levelcost)
#define PERCENT(%0,%1)			((%0 * %1) / 100)
#define rndNum(%0,%1) 			(%0 + random(%1))
#define PL_FracID(%0)			(Pl::Info[%0][pMember] | Pl::Info[%0][pLeader])
#define rgb<%0>					(%0>>>8)
#define GetJailedSkin(%0) 		((Pl::Info[%0][pSex]==2)?(JAILED_WOMEN):(JAILED_MAN))

#define IsACop(%0) 				(TEAM_COP<=Pl::FracID(%0)<=TEAM_ARMY)
#define IsALicenzer(%0) 		(Pl::FracID(%0)==TEAM_LICENZERS)
#define IsPHelper(%0,%1)		(Pl::Info[%0][pHelper]>=%1)
#define IsAHelperDuty(%0) 		(HelperDuty{%0})
#define IsPMuted(%0) 			(Pl::Info[%0][pMuted]==1)

#define IsAMehCar(%0)			(isJobVehicle(JOB_MECHANIC,%0))
#define IsABusCar(%0)			(isJobVehicle(JOB_BUSMAN,%0))
#define IsATruckCar(%0)			(isJobVehicle(JOB_TRUCKER,%0))
#define IsANews(%0)				(isTeamVehicle(TEAM_PRESS,%0))
#define IsATaxiCar(%0)			(isTeamVehicle(TEAM_TAXI,%0))
#define IsAnAmbulance(%0)		(isTeamVehicle(TEAM_MEDIC,%0))
#define IsATruckrifa(%0)		(isTeamVehicle(TEAM_RIFA,%0))
#define IsACopCar(%0)			(TEAM_COP <= Fc::FracID(%0) <= TEAM_ARMY)
#define IsACompTruck(%0)		(comptruck[0] <= %0 <= comptruck[1])

#define AddObject				CreateDynamicObject
#define Add3DText				CreateDynamic3DTextLabel

#define _GREY_ARROW				"{888888}» {ffffff}"

#define INFINITY 				0x7F800000
#define REPLACE_TEXT 			"**ADBlock**"


// MySQL handle 
enum Db::e_Conf {
	Db::Host[128],
	Db::User[64],
	Db::Base[64],
	Db::Pass[64],
	Db::Charset[16],
	Db::Debug,
	Db::KeySult[32]
}
new Db::Conf[Db::e_Conf];
new connDb;

enum pickupInfo {
	pOld,
	pDelay,
	Float:pOldPos[3],
}
new PickupInfo[MAX_PLAYERS][pickupInfo];

enum e_AFKInfo {
	afk_Time[2],
	afk_State,
	Float:afk_Pos,
	Text3D:afk_Text,
};
new AFKInfo[MAX_PLAYERS][e_AFKInfo];

new
	Fc::TOTAL,
	TOTAL_VEHICLES
;

// Menus`s
new Menu:MainMenu;
new Menu:IntMenu;
new Menu:BuyMenu;
new Menu:BarMenu;
new Menu:PizaMenu;
new Menu:SkinMenu;
new Menu:Ammu1Menu;
new Menu:Ammu2Menu;
new Menu:BurgerMenu;
new Menu:HitmanMenu;
new Menu:ClothesMenu;

// Global string`s
new src[512];
new query[2048];
new temp[255];
new plname[24];
new dialog[2048];
new string_ah[512];
new dialogtext[3000];

new RegEx:ADBlock;
new RegEx:ValidRPName;
new RegEx:ValidText;

// Debug
#define	TOTAL_PLAYER_PAID		(0)
#define	TOTAL_SAVE_BIZNES		(1)
#define	TOTAL_SAVE_HOUSES		(2)
#define	TOTAL_SAVE_ACCOUNT		(3)
#define	TOTAL_QUERY_ERRORS		(4)
#define	TOTAL_RCON_LOGINS		(5)
new DEBUG[6];

// Pickup`s
new boj;
new buy[2];
new Piza;
new proba;
new weapon1;
new weapon2;
new weapon3;
new weapon4;
new healash;
new healcnn;
new healfbi;
new testpdd;
new fire_ext;
new Parashut;
new saveTuning;
new givepasport;
new FactorySklad;
new FactoryPickup[3];
new EstateAgency;

new mak			[2];
new barn		[2];
new Bank		[2];
new helpp		[3];
new prolaps		[2];
new hitpickup   [2];
new ammozakona	[4];

new pickupd[MAX_PLAYERS][2];

// Area`s
new Area::ASH;
new Area::Shamal;
new Area::jailField;
new Area::poppyField;


// TextDraws`s
new Text:Time;
new Text:Copyright;
new Text:Logo[1];

new PlayerText:Pt::Spec[MAX_PLAYERS];
new PlayerText:Pt::Fuel[MAX_PLAYERS];
new PlayerText:Pt::Name[MAX_PLAYERS];
new PlayerText:Pt::Speed[MAX_PLAYERS][3];
new PlayerText:Pt::Status[MAX_PLAYERS];

// 3D Text`s
new Text3D:ah_text;
new Text3D:FactoryInfo[2];
new Text3D:AttachText[MAX_VEHICLES];


new const VehicleNames[212][20] = {
	"Landstalker"      ,"Bravura"      ,"Buffalo"  ,"Linerunner"    ,"Pereniel"       ,"Sentinel" ,"Dumper"          ,"Firetruck","Trashmaster" ,"Stretch"    ,"Manana"           ,"Infernus"         ,
	"Voodoo"           ,"Pony"         ,"Mule"     ,"Cheetah"       ,"Ambulance"      ,"Leviathan","Moonbeam"        ,"Esperanto","Taxi"        ,"Washington" ,"Bobcat"           ,"Mr Whoopee"       ,"BF Injection",
	"Hunter"           ,"Premier"      ,"Enforcer" ,"Securicar"     ,"Banshee"        ,"Predator" ,"Bus"             ,"Rhino"    ,"Barracks"    ,"Hotknife"   ,"Trailer"          ,"Previon"          ,"Coach"       ,"Cabbie"   ,
	"Stallion"         ,"Rumpo"        ,"RC Bandit","Romero"        ,"Packer"         ,"Monster"  ,"Admiral"         ,"Squalo"   ,"Seasparrow"  ,"Pizzaboy"   ,"Tram"             ,"Trailer"          ,"Turismo"     ,"Speeder"  ,
	"Reefer"           ,"Tropic"       ,"Flatbed"  ,"Yankee"        ,"Caddy"          ,"Solair"   ,"Berkley's RC Van","Skimmer"  ,"PCJ-600"     ,"Faggio"     ,"Freeway"          ,"RC Baron"         ,"RC Raider"   ,
	"Glendale"         ,"Oceanic"      ,"Sanchez"  ,"Sparrow"       ,"Patriot"        ,"Quad"     ,"Coastguard"      ,"Dinghy"   ,"Hermes"      ,"Sabre"      ,"Rustler"          ,"ZR3 50"           ,"Walton"      ,"Regina"   ,
	"Comet"            ,"BMX"          ,"Burrito"  ,"Camper"        ,"Marquis"        ,"Baggage"  ,"Dozer"           ,"Maverick" ,"News Chopper","Rancher"    ,"FBI Rancher"      ,"Virgo"            ,"Greenwood"   ,
	"Jetmax"           ,"Hotring"      ,"Sandking" ,"Blista Compact","Police Maverick","Boxville" ,"Benson"          ,"Mesa"     ,"RC Goblin"   ,"Hotring A"  ,"Hotring B"        ,
	"Bloodring Banger" ,"Rancher"      ,"Super GT" ,"Elegant"       ,"Journey"        ,"Bike"     ,"Mountain Bike"   ,"Beagle"   ,"Cropdust"    ,"Stunt"      ,"Tanker"           ,"RoadTrain"        ,
	"Nebula"           ,"Majestic"     ,"Buccaneer","Shamal"        ,"Hydra"          ,"FCR-900"  ,"NRG-500"         ,"HPV1000"  ,"Cement Truck","Tow Truck"  ,"Fortune"          ,"Cadrona"          ,"FBI Truck"   ,
	"Willard"          ,"Forklift"     ,"Tractor"  ,"Combine"       ,"Feltzer"        ,"Remington","Slamvan"         ,"Blade"    ,"Freight"     ,"Streak"     ,"Vortex"           ,"Vincent"          ,"Bullet"      ,"Clover"   ,
	"Sadler"           ,"Firetruck"    ,"Hustler"  ,"Intruder"      ,"Primo"          ,"Cargobob" ,"Tampa"           ,"Sunrise"  ,"Merit"       ,"Utility"    ,"Nevada"           ,"Yosemite"         ,"Windsor"     ,"Monster A",
	"Monster B"        ,"Uranus"       ,"Jester"   ,"Sultan"        ,"Stratum"        ,"Elegy"    ,"Raindance"       ,"RC Tiger" ,"Flash"       ,"Tahoma"     ,"Savanna"          ,"Bandito"          ,"Freight"     ,"Trailer"  ,
	"Kart"             ,"Mower"        ,"Duneride" ,"Sweeper"       ,"Broadway"       ,"Tornado"  ,"AT-400"          ,"DFT-30"   ,"Huntley"     ,"Stafford"   ,"BF-400"           ,"Newsvan"          ,"Tug"         ,"Trailer A","Emperor",
	"Wayfarer"         ,"Euros"        ,"Hotdog"   ,"Club"          ,"Trailer B"      ,"Trailer C","Andromada"       ,"Dodo"     ,"RC Cam"      ,"Launch"     ,"Police Car (LSPD)","Police Car (SFPD)",
	"Police Car (LVPD)","Police Ranger","Picador"  ,"S.W.A.T."      ,"Alpha"          ,"Phoenix"  ,"Glendale"        ,"Sadler"   ,"L Trailer A" ,"L Trailer B",
	"Stair Trailer"    ,"Boxville"     ,"Farm Plow","U Trailer"
};

new const Float:MaxVehicleSpeed[212] = { 
	160.00, 160.00, 200.00, 120.00, 150.00, 165.00, 110.00, 170.00, 110.00, 180.00, 160.00, 
	240.00, 160.00, 160.00, 140.00, 230.00, 155.00, 200.00, 150.00, 160.00, 180.00, 180.00, 
	165.00, 145.00, 170.00, 200.00, 200.00, 170.00, 170.00, 200.00, 190.00, 130.00, 80.000, 
	180.00, 200.00, 120.00, 160.00, 160.00, 160.00, 160.00, 160.00, 75.000, 150.00, 150.00, 
	110.00, 165.00, 190.00, 200.00, 190.00, 150.00, 120.00, 240.00, 190.00, 190.00, 190.00, 
	140.00, 160.00, 160.00, 165.00, 160.00, 200.00, 190.00, 260.00, 190.00, 75.000, 75.000, 
	160.00, 160.00, 190.00, 200.00, 170.00, 160.00, 190.00, 190.00, 160.00, 160.00, 200.00, 
	200.00, 150.00, 165.00, 200.00, 120.00, 150.00, 120.00, 190.00, 160.00, 100.00, 200.00, 
	200.00, 170.00, 170.00, 160.00, 160.00, 190.00, 220.00, 170.00, 200.00, 200.00, 140.00, 
	140.00, 160.00, 75.000, 260.00, 260.00, 160.00, 260.00, 230.00, 165.00, 140.00, 120.00, 
	140.00, 200.00, 200.00, 200.00, 120.00, 120.00, 165.00, 165.00, 160.00, 340.00, 340.00, 
	190.00, 190.00, 190.00, 110.00, 160.00, 160.00, 160.00, 170.00, 160.00, 60.000, 70.000, 
	140.00, 200.00, 160.00, 160.00, 160.00, 110.00, 110.00, 150.00, 160.00, 230.00, 160.00, 
	165.00, 260.00, 160.00, 160.00, 160.00, 200.00, 160.00, 160.00, 165.00, 160.00, 200.00, 
	170.00, 180.00, 110.00, 110.00, 200.00, 200.00, 200.00, 200.00, 200.00, 200.00, 75.000, 
	200.00, 160.00, 160.00, 170.00, 110.00, 110.00, 90.000, 60.000, 110.00, 60.000, 160.00, 
	160.00, 200.00, 110.00, 160.00, 165.00, 190.00, 160.00, 170.00, 120.00, 165.00, 260.00, 
	200.00, 140.00, 200.00, 260.00, 120.00, 200.00, 200.00, 60.000, 190.00, 200.00, 200.00, 
	200.00, 160.00, 165.00, 110.00, 200.00, 200.00, 260.00, 260.00, 160.00, 160.00, 160.00, 
	140.00, 160.00, 260.00 
};  

enum rInfo {
	rName[16],
	rUrl [64],
}
new RadioInfo[][rInfo] = {
	{"OFF", 			"-" },
	{"DFM", 			"http://92.50.177.134:8000/dfm.mp3"},
	{"4Life",			"http://play.radio4life.ru:8000/radio"},
	{"Europa +",		"http://webcast.emg.fm:55655/europaplus128.mp3"},
	{"Radio 13",		"http://play.radio13.ru:10000/"},
	{"Zaycev FM", 		"http://radio.zaycev.fm:9002/ZaycevFM(128)"},
	{"ENERGY FM",		"http://217.199.213.168:8000/v1_1"},
	{"Radio Record",	"http://radio01-cn03.akadostream.ru:8000/radiorecord128.mp3"}
};

new CP						[MAX_PLAYERS];
new MG2						[MAX_PLAYERS];
new Fixr					[MAX_PLAYERS char];
new Fell					[MAX_PLAYERS];
new Wait					[MAX_PLAYERS char];
new Music					[MAX_PLAYERS];
new CarID					[MAX_PLAYERS];
new Mobile					[MAX_PLAYERS];
new Condom					[MAX_PLAYERS];
new HireCar					[MAX_PLAYERS];
new gLastCar				[MAX_PLAYERS];
new CellTime				[MAX_PLAYERS];
new CarCalls				[MAX_PLAYERS];
new SexOffer				[MAX_PLAYERS];
new SexPrice				[MAX_PLAYERS];
new DrugGram				[MAX_PLAYERS];
new FindTime				[MAX_PLAYERS];
new CarOffer				[MAX_PLAYERS];
new CarPrice				[MAX_PLAYERS];
new TempSkin				[MAX_PLAYERS];
new useknock				[MAX_PLAYERS];
new UsedFind				[MAX_PLAYERS];
new LiveOffer				[MAX_PLAYERS];
new STDPlayer				[MAX_PLAYERS];
new JailPrice				[MAX_PLAYERS];
new RepairCar				[MAX_PLAYERS];
new DrugOffer				[MAX_PLAYERS];
new DrugPrice				[MAX_PLAYERS];
new AnimClear				[MAX_PLAYERS];
new ChosenSkin				[MAX_PLAYERS];
new GettingJob				[MAX_PLAYERS];
new CallLawyer				[MAX_PLAYERS];
new WantLawyer				[MAX_PLAYERS];
new ReduceTime				[MAX_PLAYERS];
new VoprosTime				[MAX_PLAYERS];
new acceptgruz				[MAX_PLAYERS char];
new WantedTime				[MAX_PLAYERS];
new TicketOffer				[MAX_PLAYERS];
new TicketMoney				[MAX_PLAYERS];
new RepairOffer				[MAX_PLAYERS];
new RepairPrice				[MAX_PLAYERS];
new RefillOffer				[MAX_PLAYERS];
new RefillPrice				[MAX_PLAYERS];
new checkpointb				[MAX_PLAYERS];
new checkpoints				[MAX_PLAYERS];
new DrugIntoxic				[MAX_PLAYERS];
new JobWaitTime				[MAX_PLAYERS];
new BusCallTime				[MAX_PLAYERS];
new BusAccepted				[MAX_PLAYERS];
new MatsHolding				[MAX_PLAYERS];
new TalkingLive				[MAX_PLAYERS];
new TaxiCallTime			[MAX_PLAYERS];
new TaxiAccepted			[MAX_PLAYERS];
new TransportTime			[MAX_PLAYERS];
new TransportCost			[MAX_PLAYERS];
new TransportDuty			[MAX_PLAYERS];
new MedicCallTime			[MAX_PLAYERS][2];
new ApprovedLawyer			[MAX_PLAYERS];
new PlayerTazeTime			[MAX_PLAYERS];
new TransportValue			[MAX_PLAYERS];
new TransportMoney			[MAX_PLAYERS];
new SelectCharPlace			[MAX_PLAYERS];
new TransportDriver			[MAX_PLAYERS];
new MechanicCallTime		[MAX_PLAYERS][2];
new PlayerCheckpoints		[MAX_PLAYERS][6];


new KG						[MAX_PLAYERS][2];
new OnJob					[MAX_PLAYERS];
new StartJob				[MAX_PLAYERS];
new PlayerObject			[MAX_PLAYERS];


new Pl::Drunk				[MAX_PLAYERS];
new Pl::CarInt				[MAX_PLAYERS];
new Pl::Stoned				[MAX_PLAYERS];
new Pl::NetStats			[MAX_PLAYERS];
new Pl::DrunkTime			[MAX_PLAYERS];
new Pl::CuffedTime			[MAX_PLAYERS];
new Pl::CheckpointStatus	[MAX_PLAYERS];


new bool:Gag				[MAX_PLAYERS char];
new bool:gOoc				[MAX_PLAYERS char];
new bool:gFam				[MAX_PLAYERS char];
new bool:gNews				[MAX_PLAYERS char];
new bool:gDice				[MAX_PLAYERS char];
new bool:OnAir				[MAX_PLAYERS char];
new bool:TogTP				[MAX_PLAYERS char];
new bool:OnDuty				[MAX_PLAYERS char];
new bool:BigEar				[MAX_PLAYERS char];
new bool:HidePM				[MAX_PLAYERS char];
new bool:EditMode			[MAX_PLAYERS char];
new bool:MedicBill			[MAX_PLAYERS char];
new bool:SwitchKey			[MAX_PLAYERS char];
new bool:AdminDuty			[MAX_PLAYERS char];
new bool:WatchingTV			[MAX_PLAYERS char];
new 	 WrongLogin			[MAX_PLAYERS];
new bool:PlayerTied			[MAX_PLAYERS char];
new bool:HelperDuty			[MAX_PLAYERS char];
new bool:SpawnChange		[MAX_PLAYERS char];
new bool:SuspectKill		[MAX_PLAYERS char];
new bool:PhoneOnline		[MAX_PLAYERS char];
new bool:MoneyMessage		[MAX_PLAYERS char];
new bool:TakingLesson		[MAX_PLAYERS char];
new bool:PlayerUseTazed		[MAX_PLAYERS char];

new bool:gCarLock			[MAX_VEHICLES char] = {false, ...};
new bool:VehicleBoot		[MAX_VEHICLES char] = {false, ...};
new bool:VehicleLight		[MAX_VEHICLES char] = {false, ...};
new bool:VehicleBonnet		[MAX_VEHICLES char] = {false, ...};

new Iterator:AshQueue<MAX_PLAYERS>;
new Iterator:CreatedCars<MAX_VEHICLES>;
new Iterator:ToglogPlayers<MAX_PLAYERS>;
new Iterator:AdminPlayers<MAX_PLAYERS>;
new Iterator:HelperPlayers<MAX_PLAYERS>;
new Iterator:WantedPlayers<MAX_PLAYERS>;
new Iterator:LeaderPlayers<MAX_PLAYERS>;
new Iterator:enginedVehicles<MAX_VEHICLES>;
new Iterator:Houses<MAX_HOUSES>;
new Iterator:Biznes<MAX_BIZNES>;
new Iterator:Refills<MAX_REFILLS>;
new Iterator:Frac<MAX_FRAC>;

new Iterator:MedicCalls<MAX_PLAYERS>;
new Iterator:MechanicCalls<MAX_PLAYERS>;
new Iterator:JobPlayers[MAX_JOBS]<MAX_PLAYERS>;
new Iterator:JobVehicles[MAX_JOBS]<MAX_VEHICLES>;
new Iterator:TeamPlayers[MAX_FRAC]<MAX_PLAYERS>;
new Iterator:TeamVehicles[MAX_FRAC]<MAX_VEHICLES>;
new Iterator:inStreamPlayers[MAX_PLAYERS]<MAX_PLAYERS>;
new Iterator:inStreamVehicles[MAX_PLAYERS]<MAX_VEHICLES>;
new Iterator:vehiclePassengers[MAX_VEHICLES]<MAX_PLAYERS>;

new GangBiznes[MAX_FRAC char];
new NameChange[MAX_PLAYERS char];
new bool:GMTest[MAX_PLAYERS char];
new bool:isEngined[MAX_VEHICLES char];
new bool:useBannyHop[MAX_PLAYERS char];
new bool:InAntiDmZone[MAX_PLAYERS char];
new bool:PlayerLogged[MAX_PLAYERS char];
new slotused[MAX_PLAYERS char];
new playerIp[MAX_PLAYERS][16];


new noooc = 1;
new OnAirMax;
new addtimer = 60000;
new levelcost = 25000;
new deathcost = 50;
new callcost = 10;
new timeshift = 0;
new levelexp = 4;
new cchargetime = 60;
new shifthour;
new ghour;
new Medics;
new Mechanics;
new TaxiDrivers, TaxiCall = INVALID_PLAYER_ID;
new BusDrivers, BusCall = INVALID_PLAYER_ID;
new bool:adds = true;

// Timer`s
static serverUpdate;

new STD1[] = {0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3};
new STD2[] = {0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3};
new STD3[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3};
new STD4[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 2, 3};
new SELLCAR1[] = {1000, 1124, 1245, 1349, 1475, 1574, 1636, 1762, 1895, 1946, 2000};
new SELLCAR2[] = {2099, 2135, 2255, 2378, 2457, 2563, 2614, 2721, 2878, 2988, 3000};
new SELLCAR3[] = {3058, 3175, 3212, 3377, 3454, 3555, 3678, 3751, 3865, 3964, 4000};
new SELLCAR4[] = {4077, 4123, 4275, 4378, 4422, 4565, 4613, 4752, 4897, 4911, 5000};

new wrongWeapon[] = { 16, 17, 18, 19, 20, 21, 26, 27, 34, 35, 36, 37, 38, 39, 40, 47 };

new Float:CargoInfo[][3] = {
	{0.0,0.0,0.0},
	{-59.0808,0.1278,3.1172},
	{-1017.7874,-681.4913,32.0078},
	{823.9176,854.6870,11.8571},
	{578.8217,1221.5995,11.7113},
	{266.3958,1407.6863,10.4828},
	{-1890.8984,-1731.3362,21.7500},
	{2783.4919,-2475.8999,13.6347}
};

new ATMp[2];
new Float:ATMs[][4] = {
	{2235.427,-1150.405,25.515,181.245},
	{1367.233,-1283.083,13.000,260.000},
	{1833.169,-1846.869,13.221,-90.622},
	{1928.606,-1768.946,13.189,-271.868},
	{1003.041,-930.357,41.971,11.327},
	{501.860,-1364.001,15.775,113.278},
	{-79.431,-1172.427,1.774,-113.278},
	{-2033.096,-52.185,35.011,90.622},
	{-1980.677,145.389,27.330,-90.622},
	{-1693.100,414.963,6.822,45.311},
	{-2281.511,-80.277,34.981,181.245},
	{157.817,-1947.213,3.416,124.606}
};

new Float:BarCoord[][4] = {
	{4.0 ,495.7801  ,-76.0305  ,998.7578} ,
	{4.0 ,499.9654  ,-20.2515  ,1000.6797},
	{4.0 ,1215.9480 ,-13.3519  ,1000.9219},
	{10.0,-2658.9749,1407.4136 ,906.2734} ,
	{7.0 ,1207.2    ,-28.4     ,1000.9}   ,
	{7.0 ,968.6     ,-47.1     ,1001.1}   ,
	{7.0 ,-224.7    ,1404.9    ,27.7}     ,
	{7.0 ,2536.1    ,-1321.2   ,1031.4}   ,
	{10.0,1257.7211 ,-791.0063 ,1084.0078},
	{10.0,1262.6    ,-794.5    ,88.3}     ,
	{10.0,-785.8726 ,500.0969  ,1371.7422},
	{10.0,-782.4619 ,500.0730  ,1371.7490},
	{10.0, 223.0705 ,1407.3998 ,27.7734}  ,
	{10.0,2537.5303 ,-1288.9594,1054.6406},
	{10.0,1487.4    ,-666.9    ,95.6}     ,
	{10.0,-328.1    ,1803.1    ,42.7}     ,
	{10.0,1257.2    ,-791.0    ,1084.0}   ,
	{10.0,1104.500  ,-824.8508 ,106.1270} ,
	{10.0,1104.9603 ,-828.8508 ,107.1270} ,
	{4.0 ,241.4241  ,1022.6302 ,1084.0194},
	{20.0,2196.1833 ,1608.6389 ,1005.0625},
	{12.0,2575.6638 ,-1682.2990,1033.7017},
	{7.0 ,825.0572  ,-2056.0303,12.8672}
};

enum e_HouseInt {
	Interior,
	InteriorPrice,
	Float:InteriorPos[4]
}
new HouseInt[][e_HouseInt] = {
	{2 , 500000,{2467.9966,-1698.2451,1013.5078,91.0528}},
	{5 , 500000,{2233.6760,-1114.7872,1050.8828,1.7116}},
	{9, 500000,{2317.8501,-1026.5812,1050.2178,1.7116}},
	{10, 500000,{2259.9468,-1135.8491,1050.6328,270.6325}},
	{3 , 500000,{235.3273,1186.8773,1080.2578,359.4516}},
	{2 , 500000,{226.1881,1240.0093,1082.1406,92.6574}},
	{1 , 500000,{223.0865,1287.4043,1082.1406,2.7299}},
	{5, 500000,{226.6887,1114.2197,1080.9950,267.6735}},
	{12 , 500000,{443.0311,509.3219,1001.4195,272.0599}},
	{10 , 500000,{24.0824,1340.3184,1084.3750,358.2274}},
	{12 , 500000,{2324.3962,-1149.1707,1050.7101,4.3257}},
	{4 , 500000,{-260.8852,1456.6240,1084.3672,95.3382}},
	{5 , 500000,{22.8612,1403.6102,1084.4297,4.3641}},
	{5 , 500000,{140.2174,1366.3024,1083.8594,2.9613}},
	{6 , 500000,{234.0868,1064.3472,1084.2113,357.9479}},
	{6 , 500000,{-68.8532,1351.4395,1080.2109,357.9479}},
	{8 , 500000,{2807.6042,-1174.1803,1025.5703,357.9479}},
	{1 , 800000,{2217.8767,-1076.3669,1050.4844,94.2871}},
	{2 , 500000,{2237.5168,-1081.3751,1049.0234,2.3346}},
	{8 , 500000,{2365.1528,-1135.1245,1050.8750,2.3346}},
	{8 , 500000,{-42.5325,1405.7850,1084.4297,357.9479}},
	{7 , 800000,{225.6805,1021.7444,1084.0168,357.8433}}
};


enum jInfo {
	jID,
	jP,
	jV,
	Float:jPos[3],
	jName[24],
}
new JobsInfo[][jInfo] = {
	{0,	-1,	0,	{0.0,	   0.0,		  0.0},		  "Безработный"},
	{1,	-1, 7,	{359.54080, 206.76930, 1008.3828}, "Детектив"},
	{2,	-1, 7,	{335.35450, 195.29080, 1014.1875}, "Адвокат"},
	{3,	-1,	0,	{2415.8638,-1220.7854, 25.273400}, "Проститутка"},
	{4,	-1,	0,	{2166.3772,-1675.3829, 15.085900}, "Наркодилер"},
	{5,	-1,	0,	{1109.3318,-1796.3042, 16.593800}, "Автоугонщик"},
	{6,	-1,	0,	{-1932.385, 276.21170, 41.039100}, "Автомеханик"},
	{7,	-1,	0,	{1366.4325,-1275.2096, 13.546900}, "Гандилер"},
	{8,	-1,	0,	{531.79300,-1292.4044, 17.242200}, "Автодилер"},
	{9,	-1,	0,	{1154.2208,-1770.8203, 16.599200}, "Автобусник"},
	{10,-1,	0,	{-77.72880,-1136.3896, 1.0781000}, "Дальнобойщик"}
};
enum dInfo {
	dPrice,
	dDrunk,
	dName[24],
	Float:dHP,
}
new DrinkInfo[][dInfo] = {
	{3,		0,	"Soda",			5.0},
	{3,		0,	"Coca-Cola",	5.0},
	{3,		0,	"Tea",			5.0},
	{2,		0,	"Water",		5.0},
	{5,		1,	"Beer",			15.0},
	{10,	3,	"Vodka",		25.0},
	{20,	2,	"Whiskey",		25.0},
	{20,	2,	"Tequila",		25.0},
	{25,	2,	"Martini",		25.0},
	{30,	4,	"Samagon",		30.0},
	{100,	4,	"Coniak",		35.0},
	{1,		0,	"Cigarette",	0.0}
};

enum burgsInfo {
	bPrice,
	bDescription[24],
	Float:bHP,
}
new BurgerInfo[][burgsInfo] = {
	{10,	"Hamburger",		5.0},
	{10,	"CheeseBurger",		5.0},
	{30,	"BigMak",			10.0},
	{35,	"RoyalCheeseBurger",15.0},
	{28,	"MakFluri",			11.0},
	{60,	"ChikenMakNafix",	25.0},
	{31,	"Vishnevi Pirojok",	18.0},
	{8,		"Rojok",			4.0}
};

new PizzaInfo[][burgsInfo] = {
	{3,		"Soda",			5.0},
	{3,		"Coca-Cola",	5.0},
	{3,		"Tea",			5.0},
	{2,		"Water",		3.0},
	{15,	"PiZZa",		15.0},
	{50,	"Big PiZZa",	25.0},
	{30,	"BigMak",		10.0}
};

new EatInfo[][burgsInfo] = {
	{10,	"Перловка",		10.0},
	{15,	"Картофель",	18.0},
	{15,	"Гречка",		15.0},
	{10,	"Компот",		10.0},
	{5,		"Чай",			10.0}
};


enum ammoInfo
{
	gID,
	gAmmo,
	gPrice,
	gName[24],
}
new Ammu1Info[][ammoInfo] = {
	{24,	50,		3500,	"Deagle"},
	{22,	100,	2000,	"Pistol 9mm"},
	{23,	100,	2200,	"Silenced 9mm"},
	{25,	30,		3000,	"ShotGun"},
	{31,	200,	7000,	"M4"},
	{29,	200,	5000,	"MP5"},
	{30,	200,	7000,	"AK-47"},
	{5,		1,		500,	"BassBall Bat"},
	{1,		1,		500,	"Brass Knuckles"},
	{7,		1,		500,	"Billiard Cue"},
	{10,	1,		600,	"Purple Dildo"}
};

new Ammu2Info[][ammoInfo] = {
	{24,	50,		1500,	"Deagle"},
	{22,	100,	1000,	"Pistol 9mm"},
	{23 ,	100,	1200,	"Silenced 9mm"},
	{25,	30,		1500,	"ShotGun"},
	{31,	500,	3500,	"M4"},
	{29,	500,	2500,	"MP5"},
	{30,	500,	3000,	"AK-47"},
	{3,		1,		500,	"Nite Stick"},
	{41,	500,	500,	"Spraycan"}
};

enum hitInfo
{
	gID,
	gAmmo,
	gRank,
	gPrice,
	gName[24],
}
new HitmanAmmo[][hitInfo] = {
	{4, 	1, 		1,	1000,	"Knife"},
	{24,	50,		1,	1500,	"Deagle"},
	{23 ,	100,	1,	1200,	"Silenced 9mm"},
	{25,	30,		1,	1500,	"ShotGun"},
	{31,	300,	3,	3500,	"M4"},
	{29,	300,	2,	2500,	"MP5"},
	{30,	300,	4,	3000,	"AK-47"},
	{34,	10,		4,	5000,	"Sniper Rifle"}
};


enum spInfo {
	spInt,
	spVirt,
	Float:spX,
	Float:spY,
	Float:spZ,
	Float:spA,
}
new SpawnInfo[MAX_SPAWNS][spInfo];

new FracID		[] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18 };
new trailerID	[] = { 435, 611, 450, 591, 606, 607, 610, 569, 590, 584, 570, 608 };
new FightStyles	[] = { 4, 5, 6, 7, 15, 16 };
static const correctAnswer[] = {
	' ',
	'b', 'c', 'b', 'b', 'c', 'b', 'c', 'd', 'd', 'b',
	'd', 'b', 'b', 'd', 'b', 'a', 'd', 'b', 'b', 'a'
};

enum tpInfo {
	tpVw,
	tpInt,
	tpLocal,
	Float:tpPos[4],
}
new TeleportDest[MAX_PLAYERS][tpInfo];

new comptruck[2];

new engine,light,alarm,doors,bonnet,boot,objective;
new Float:posx, Float:posy, Float:posz;
new Float:vehx, Float:vehy, Float:vehz;
new Float:angle,Float:distance;


enum Fc::Enum {
	Fc::Id[2],				// 0 - ид транспорта в Бд. 1 - ид созданного транспорта на сервере
	Fc::Model,
	Fc::FracId,
	Fc::RankId,
	Fc::Color[2],			// 0 - первый цет. 1 - второй цвет.
	Fc::Number[10],
	Float:Fc::RespPos[4],	// 0 - x. 1 - y. 2 - z. 3 - angle.
}
new Fc::Info[MAX_FC][Fc::Enum];

new Fc::FORBIDDEN_VEH[] = { 441, 449, 450, 470, 569, 577, 584, 590, 591, 592, 594, 606, 607, 608, 610, 611 };

new Gangs[] = { 12, 14, 15, 16, 17, 18 };
new Teams[] = { 1, 2, 3, 4, 7 };
new Mafias[] = { 5, 6, 13 };

new ZahvatDeath[MAX_PLAYERS];
new SolderOnAFK[MAX_FRAC];
new ZahvatKills[MAX_FRAC char];
new ZahvatScore[MAX_FRAC];
new GangOnBattle[MAX_FRAC];
new Iterator:GangSolder[MAX_FRAC]<MAX_PLAYERS>;


enum pInfo {
	pID,
	pVip,
	pLevel,
	pAdmin,
	pHelper,
	pTime,
	pReg,
	pSex,
	pAge,
	pOrigin,
	pMuted,
	pExp,
	pBank,
	pCrimes,
	pKills,
	pDeaths,
	pArrested,
	pWantedL,
	pWantedD,
	pPhoneBook,
	pLottoNr,
	pJob,
	pPayCheck,
	pJailed,
	pJailTime,
	pMats,
	pDrugs,
	pLeader,
	pMember,
	pRank,
	pChar,
	pContractTime,
	pSkill[8], // 0 - det, 1 - sex, 2 - law, 3 - mech, 4 - jack, 5 - car, 6 - news, 7 - drugs
	pLocal,
	pNumber,
	pHouseKey,
	pBizKey,
	pLic[4], // 0 - car, 1 - fly, 2 - boat, 3 - gun
	pCarTime,
	pPayDay,
	pPayDayHad,
	pCDPlayer,
	pWarns,
	pFuel,
	pMutedTime,
	pReport,
	pBanned,
	pTest,
	pRebuke,
	pFightstyle,
	pPasport[3],
	pLastVisit,
	
	pWait,
	pUpdate,
	pHunger,
	pCamPos,
	
	bool:pMaskOn,
	
};
new Pl::Info[MAX_PLAYERS][pInfo];


enum Bl::enum {
	Bl::Marker,
	
	Bl::Finder,
	Bl::Observe,
	
	bool:Bl::isKilled,

	Bl::onFrac[MAX_FRAC],
	Bl::Kills[MAX_FRAC],
}
new Bl::Info[MAX_PLAYERS][Bl::enum];


enum spec_enum
{
	pSpecID,
	pSpecVw		[2],
	pSpecInt	[2],
	pSpecState	[2],
}
new Pl::SpecInfo[MAX_PLAYERS][spec_enum];


enum syncInfo {
	sKillerID,
	sReasonID,
}
new SyncInfo[MAX_PLAYERS][syncInfo];

enum hInfo {
    hID,
	hOwned,
	hLock,
	hOwner[MAX_PLAYER_NAME],
	hDescription[28],
	hPrice,
	hLevel,
	hInt,
	hTv,
	hDate,
	hRent[2],
	hSafe[5],
	hGuns[MAX_HWEAP],
	hAmmos[MAX_HWEAP],
	Float:hEnter[4],
	Float:hExit[4],
	
	hvModel,
	hvColor[2],
	hvPark,
	Float:hvSpawn[4],
	
	bool:hgGarage,
	Float:hgIntPos[4],
	Float:hgStreetPos[4],
	hgPickupInt,
	hgPickupStreet,
	
	hPickup,
	hMapIcon,
	hVirtual,
	hAuto,
};
new HouseInfo[MAX_HOUSES][hInfo];

enum aInfo {
	aOwner,
	aRadio,
	aUpdate,

#define COLOR_ONE (0)
#define COLOR_TWO (1)
	aColor[2],

#define CUR_MATS (0)
#define MAX_MATS (1)
	aMats,
	aDrugs,
	aMaxMats,
	aMaxDrugs,

	aTuning[MAX_COMPONENT],
	aPaintJob,

	aLimit,
	
	Float:aFuel,
	Float:aMileage,
};
new AutoInfo[MAX_VEHICLES][aInfo];

enum bInfo {
	bID,
	bOwned,
	bLocked,
	bOwner[MAX_PLAYER_NAME],
	bExtortion[MAX_PLAYER_NAME],
	bDescription[24],
	bLevel,
	bPrice,
	bSafe,
	bProfit,
	bEnterCost,
	bFrac,
	bProds,
	bMaxProds,
	bPriceProd,
	bInterior,
	bIcon[2],
	Float:bEnter[4],
	Float:bExit[4],

	bVirtual,
	bPickupEnter,
	bPickupExit,
	bMapIcon,

	bZone,
	bAttack,
	bDefend,
	bOnBattle,
	bZahvatTime,
	bZahvatTimer,
	bZahvatArea,
	Float:bzMinX,
	Float:bzMinY,
	Float:bzMaxX,
	Float:bzMaxY,
	Text:bZahvatTD,
};
new BizzInfo[MAX_BIZNES][bInfo];

enum brInfo {
	brID,
	brBizID,
	Float:brPos[3],
	brPickup,
}
new RefillInfo[MAX_REFILLS][brInfo];


enum gInfo {
	fID,
	gRespect,
	Float:gPosX,
	Float:gPosY,
	Float:gPosZ,
	Text3D:gText,
};
new GangInfo[sizeof Gangs][gInfo];

enum fSpawnInfo {
	fSpawnInt[2],
	Float:fSpawnPos[4]
}
enum fInfo {
	fBank,
 	fRConf[3],
 	fBConf[2],
	fName[36],
	fTag [16],
	fColor,
	fSpawn[fSpawnInfo],
};
new FracInfo[MAX_FRAC][fInfo];
new RankInfo[MAX_FRAC][MAX_RANK][36];
new RankNums[MAX_FRAC];
new FracPay[MAX_FRAC];


#define MAX_GATE			(100)
#define GATE_ATTACH_NONE	(0)
#define GATE_ATTACH_FRAC	(1)
#define GATE_ATTACH_HOUSE	(2)
#define GATE_ATTACH_JOB		(3)

#define GATE_MODE_PICKUP 	(0)
#define GATE_MODE_KEY 		(1)

enum e_GateData {
	GateID,
	GateAttach,
	GateAllowed[MAX_FRAC],
	GateMode
};
new GateData[MAX_GATE][e_GateData];
new Iterator:GateModePickup<MAX_GATE>;
new Iterator:GateModeKey<MAX_GATE>;

#define zRANK	(0)
#define bRANK	(1)
#define gRANK	(2)
#define bKILLS	(0)
#define bPRICE	(1)


enum e_GmInfo {
	Gm::TaxValue,
	Gm::PritonDrugs,
	Gm::AmbarDrugs,
	Gm::FactoryMetal,
	Gm::FactoryFuel,
	Gm::FactoryProds,
	Gm::EnableReg,
	Gm::isAutoRest,
	
	Gm::Hostname[36],
	Gm::Password[36],
	Gm::Mode[36],
	Gm::Map[36],
	Gm::Status
}
new Gm::Info[e_GmInfo];


enum pHaul
{
	pCapasity,
	pLoad,
};
new PlayerHaul[NUMBER_OF_TRUCKS][pHaul];


enum pCrime_Enum {
	pVictim		[24],
	pAccused	[24],
	pAccusing	[64],
};
new Pl::Crime[MAX_PLAYERS][pCrime_Enum];


enum Ptl::e_potal
{
	Ptl::Id,
	
	Ptl::Model[2],
	Ptl::Type[2],
	Ptl::Inter[2],
	Ptl::World[2],
	
	Float:Ptl::Portal1[4],
	Float:Ptl::Portal2[4],
	
	Ptl::Allowed[MAX_FRAC],
	Ptl::Pickup[2],
};
new Iterator:Portal<MAX_PORTALS>;
new Ptl::Info[MAX_PORTALS][Ptl::e_potal];



enum vInfo {
	vID,
	vModel,
	Float:vPosX,
	Float:vPosY,
	Float:vPosZ,
	Float:vPosA,
	vColor1,
	vColor2,
	vRespTime,
	vJob,
	cID
};
new VehicleInfo[MAX_VEHICLESex][vInfo];


enum respI
{
	fId,
	Float:rMinX,
	Float:rMinY,
	Float:rMaxX,
	Float:rMaxY,
}
new RespCoord[][respI] = {
	{1,1523.4375,-1738.28125,1593.75,-1599.6},
	{2,-1703.1,642.5,-1562.5,742.1},
	{3,78.125,1750.0,388.6,2128.9},
	{4,-2748.0,576.1,-2525.3,712.8},
	{5,1083.9,-2087.8,1291.0,-1988.2},
	{6,1416.0,2722.6,1529.29,2876.9},
	{7,1382.8,-1871.0,1564.4,-1732.4},
	{8,986.3,-394.5,1111.3,-300.7},
	{9,636.7,-1392.5,789.0,-1330.07},
	{10,-1785.1,927.7,-1701.1,1109.3},
	{11,-2111.3,-287.1,-1996.0,-54.6},
	{12,647.2,-479.8,723.6,-422.2},
	{13,-2820.3,-421.875,-2599.6,-199.2},
	{14,2423.8,-1734.375,2544.9,-1599.6},
	{15,1666.0,-1968.75,1833.9,-1814.4},
	{16,804.5,-1135.7,952.6,-1061.4},
	{17,-2202.3,-281.7,-2095.5,-79.9},
	{18,2732.4,-1662.109375,2908.2,-1480.4},
	{19,1009.6,2057.3,1112.4,2212.9},
	{20,-1238.9,-1393.4,-965.2,-870.6}
};


enum camEnum
{
	musicid,
	iteriorid,
	virtworld,
	Float:p_pos[4],
	Float:c_pos[3],
	Float:c_lookAt[3],
}
new EnterPos[][camEnum] = {
	//{{0000}, {0}, {99}, {-1657.5237,1207.6644,13.6719,357.6906},	{-1657.4678,1211.2292,13.6781},		{-1657.5237,1207.6644,13.6719}}
	{{1187}, {0}, {99}, {-1494.7579,985.1379,7.1875,120.9491},		{-1399.0210,976.2402,179.3737},		{-1754.3281, 669.2344, 62.8203}}
	/*{{1185}, {0}, {99}, {-1564.6333,701.9891,7.0391,0.0000},		{-1564.6333,701.8426,146.6249},		{-1700.9147,834.9225,170.3657}},
	{{1183}, {0}, {99}, {2020.4767,1204.7135,10.8203,0.0000},		{2020.4767,1203.1107,59.2244},		{2143.4326,1135.3274,59.3245}},
	{{1183}, {0}, {99}, {-2806.6660,2233.7676,111.5226,284.5099},	{-2807.1660,2234.5759,166.1842},	{-2806.8335,2233.6262,166.1643}},
	{{1097}, {0}, {99}, {465.9904,2503.9668,22.4554,4.0220},		{465.2324,2499.6450,22.7485},		{464.2286,2499.6545,22.7884}},
	{{1185}, {0}, {99}, {2168.6704,2143.6128,10.9593,268.1124},		{2097.0530,2143.8245,37.3217},		{2098.0557,2143.8152,37.3817}},
	{{1183}, {0}, {99}, {1794.9576,1699.7588,6.7283,158.0961},		{1851.6905,1689.8480,27.7645},		{1853.4328,1693.3073,28.7634}}*/
//		звук				 Игрок									Камера								Вектор камеры
};

enum gunInfo
{
	g_id,
	g_name[15],
	g_ammo,
	g_mats,
}
new GunInfo[][gunInfo] = {
//	{ 4, "knife", 1, 100 },
	{ 21, "sdpistol", 50, 100 },
	{ 14, "flowers", 1, 25 },
	{ 24, "eagle", 50, 150 },
	{ 29, "mp5", 200, 200 },
	{ 25, "shotgun", 50, 200 },
//	{ 27, "spas12", 50, 600 },
	{ 30, "ak47", 250, 600 },
	{ 31, "m4", 250, 600 },
	{ 33, "rifle", 50, 600 }
};

enum e_SAInteriors {
	iI,
	Float:iX,
	Float:iY,
	Float:iZ,
	Float:iA,
	int_Name[40]
}
new Menu:SAInteriorsMenu;
new SAInteriors[146][e_SAInteriors] = {
	{11, 2003.1178, 1015.1948, 33.008, 351.5789, "Four Dragons' Managerial Suite"},
	{5, 770.8033, -0.7033, 1000.7267, 22.8599, "Ganton Gym"},
	{3, 974.0177, -9.5937, 1001.1484, 22.6045, "Brothel"},
	{3, 961.9308, -51.9071, 1001.1172, 95.5381, "Brothel2"},
	{3, 830.6016, 5.9404, 1004.1797, 125.8149, "Inside Track Betting"},
	{3, 1037.8276, 0.397, 1001.2845, 353.9335, "Blastin' Fools Records"},
	{3, 1212.1489, -28.5388, 1000.9531, 170.5692, "The Big Spread Ranch"},
	{18, 1290.4106, 1.9512, 1001.0201, 179.9419, "Warehouse 1"},
	{1, 1412.1472, -2.2836, 1000.9241, 114.661, "Warehouse 2"},
	{3, 1527.0468, -12.0236, 1002.0971, 350.0013, "B Dup's Apartment"},
	{2, 1523.5098, -47.8211, 1002.2699, 262.7038, "B Dup's Crack Palace"},
	{3, 612.2191, -123.9028, 997.9922, 266.5704, "Wheel Arch Angels"},
	{3, 512.9291, -11.6929, 1001.5653, 198.7669, "OG Loc's House"},
	{3, 418.4666, -80.4595, 1001.8047, 343.2358, "Barber Shop"},
	{3, 386.5259, 173.6381, 1008.3828, 63.7399, "Planning Department"},
	{3, 288.4723, 170.0647, 1007.1794, 22.0477, "Las Venturas Police Department"},
	{3, 206.4627, -137.7076, 1003.0938, 10.9347, "Pro-Laps"},
	{3, -100.2674, -22.9376, 1000.7188, 17.285, "Sex Shop"},
	{3, -201.2236, -43.2465, 1002.2734, 45.8613, "Las Venturas Tattoo parlor"},
	{17, -202.9381, -6.7006, 1002.2734, 204.2693, "Lost San Fierro Tattoo parlor"},
	{17, -25.7220, -187.8216, 1003.5469, 5.0760, "24/7 (version 1)"},
	{5, 454.9853, -107.2548, 999.4376, 309.0195, "Diner 1"},
	{5, 372.5565, -131.3607, 1001.4922, 354.2285, "Pizza Stack"},
	{17, 378.026, -190.5155, 1000.6328, 141.0245, "Rusty Brown's Donuts"},
	{7, 315.244, -140.8858, 999.6016, 7.4226, "Ammu-nation"},
	{5, 225.0306, -9.1838, 1002.218, 85.5322, "Victim"},
	{2, 611.3536, -77.5574, 997.9995, 320.9263, "Loco Low Co"},
	{10, 246.0688, 108.9703, 1003.2188, 0.2922, "San Fierro Police Department"},
	{10, 6.0856, -28.8966, 1003.5494, 5.0365, "24/7 (version 2 - large)"},
	{7, 773.7318, -74.6957, 1000.6542, 5.2304, "Below The Belt Gym (Las Venturas)"},
	{1, 621.4528, -23.7289, 1000.9219, 15.6789, "Transfenders"},
	{1, 445.6003, -6.9823, 1000.7344, 172.2105, "World of Coq"},
	{1, 285.8361, -39.0166, 1001.5156, 0.7529, "Ammu-nation (version 2)"},
	{1, 204.1174, -46.8047, 1001.8047, 357.5777, "SubUrban"},
	{1, 245.2307, 304.7632, 999.1484, 273.4364, "Denise's Bedroom"},
	{3, 290.623, 309.0622, 999.1484, 89.9164, "Helena's Barn"},
	{5, 322.5014, 303.6906, 999.1484, 8.1747, "Barbara's Love nest"},
	{1, -2041.2334, 178.3969, 28.8465, 156.2153, "San Fierro Garage"},
	{1, -1402.6613, 106.3897, 1032.2734, 105.1356, "Oval Stadium"},
	{7, -1403.0116, -250.4526, 1043.5341, 355.8576, "8-Track Stadium"},
	{2, 1204.6689, -13.5429, 1000.9219, 350.0204, "The Pig Pen (strip club 2)"},
	{10, 2016.1156, 1017.1541, 996.875, 88.0055, "Four Dragons"},
	{1, -741.8495, 493.0036, 1371.9766, 71.7782, "Liberty City"},
	{2, 2447.8704, -1704.4509, 1013.5078, 314.5253, "Ryder's house"},
	{1, 2527.0176, -1679.2076, 1015.4986, 260.9709, "Sweet's House"},
	{10, -1129.8909, 1057.5424, 1346.4141, 274.5268, "RC Battlefield"},
	{3, 2496.0549, -1695.1749, 1014.7422, 179.2174, "The Johnson House"},
	{10, 366.0248, -73.3478, 1001.5078, 292.0084, "Burger shot"},
	{1, 2233.9363, 1711.8038, 1011.6312, 184.3891, "Caligula's Casino"},
	{2, 269.6405, 305.9512, 999.1484, 215.6625, "Katie's Lovenest"},
	{2, 414.2987, -18.8044, 1001.8047, 41.4265, "Barber Shop 2 (Reece's)"},
	{2, 1.1853, -3.2387, 999.4284, 87.5718, "Angel \"Pine Trailer\""},
	{18, -30.9875, -89.6806, 1003.5469, 359.8401, "24/7 (version 3)"},
	{18, 161.4048, -94.2416, 1001.8047, 0.7938, "Zip"},
	{3, -2638.8232, 1407.3395, 906.4609, 94.6794, "The Pleasure Domes"},
	{5, 1267.8407, -776.9587, 1091.9063, 231.3418, "Madd Dogg's Mansion"},
	{2, 2536.5322, -1294.8425, 1044.125, 254.9548, "Big Smoke's Crack Palace"},
	{5, 2350.1597, -1181.0658, 1027.9766, 99.1864, "Burning Desire Building"},
	{1, -2158.6731, 642.09, 1052.375, 86.5402, "Wu-Zi Mu's"},
	{10, 419.8936, 2537.1155, 10.0, 67.6537, "Abandoned AC tower"},
	{14, 256.9047, -41.6537, 1002.0234, 85.8774, "Wardrobe/Changing room"},
	{14, 204.1658, -165.7678, 1000.5234, 181.7583, "Didier Sachs"},
	{12, 1133.35, -7.8462, 1000.6797, 165.8482, "Casino (Redsands West)"},
	{14, -1420.4277, 1616.9221, 1052.5313, 159.1255, "Kickstart Stadium"},
	{17, 493.1443, -24.2607, 1000.6797, 356.9864, "Club"},
	{18, 1727.2853, -1642.9451, 20.2254, 172.4193, "Atrium"},
	{16, -202.842, -24.0325, 1002.2734, 252.8154, "Los Santos Tattoo Parlor"},
	{5, 2233.6919, -1112.8107, 1050.8828, 8.6483, "Safe House group 1"},
	{6, 1211.2484, 1049.0234, 359.941, 170.9341, "Safe House group 2"},
	{9, 2319.1272, -1023.9562, 1050.2109, 167.3959, "Safe House group 3"},
	{10, 2261.0977, -1137.8833, 1050.6328, 266.88, "Safe House group 4"},
	{17, -944.2402, 1886.1536, 5.0051, 179.8548, "Sherman Dam"},
	{16, -26.1856, -140.9164, 1003.5469, 2.9087, "24/7 (version 4)"},
	{15, 2217.281, -1150.5349, 1025.7969, 273.7328, "Jefferson Motel"},
	{1, 1.5491, 23.3183, 1199.5938, 359.9054, "Jet Interior"},
	{1, 681.6216, -451.8933, -25.6172, 166.166, "The Welcome Pump"},
	{3, 234.6087, 1187.8195, 1080.2578, 349.4844, "Burglary House X1"},
	{2, 225.5707, 1240.0643, 1082.1406, 96.2852, "Burglary House X2"},
	{1, 224.288, 1289.1907, 1082.1406, 359.868, "Burglary House X3"},
	{5, 239.2819, 1114.1991, 1080.9922, 270.2654, "Burglary House X4"},
	{15, 207.5219, -109.7448, 1005.1328, 358.62, "Binco"},
	{15, 295.1391, 1473.3719, 1080.2578, 352.9526, "4 Burglary houses"},
	{15, -1417.8927, 932.4482, 1041.5313, 0.7013, "Blood Bowl Stadium"},
	{12, 446.3247, 509.9662, 1001.4195, 330.5671, "Budget Inn Motel Room"},
	{0, 2306.3826, -15.2365, 26.7496, 274.49, "Palamino Bank"},
	{0, 2331.8984, 6.7816, 26.5032, 100.2357, "Palamino Diner"},
	{0, 663.0588, -573.6274, 16.3359, 264.9829, "Dillimore Gas Station"},
	{18, -227.5703, 1401.5544, 27.7656, 269.2978, "Lil' Probe Inn"},
	{0, -688.1496, 942.0826, 13.6328, 177.6574, "Torreno's Ranch"},
	{0, -1916.1268, 714.8617, 46.5625, 152.2839, "Zombotech - lobby area"},
	{0, 818.7714, -1102.8689, 25.794, 91.1439, "Crypt in LS cemetery (temple)"},
	{0, 255.2083, -59.6753, 1.5703, 1.4645, "Blueberry Liquor Store"},
	{2, 446.626, 1397.738, 1084.3047, 343.9647, "Pair of Burglary Houses"},
	{5, 227.3922, 1114.6572, 1080.9985, 267.459, "Crack Den"},
	{5, 227.7559, 1114.3844, 1080.9922, 266.2624, "Burglary House X11"},
	{4, 261.1165, 1287.2197, 1080.2578, 178.9149, "Burglary House X12"},
	{4, 291.7626, -80.1306, 1001.5156, 290.2195, "Ammu-nation (version 3)"},
	{4, 449.0172, -88.9894, 999.5547, 89.6608, "Jay's Diner"},
	{4, -27.844, -26.6737, 1003.5573, 184.3118, "24/7 (version 5)"},
	{0, 2135.2004, -2276.2815, 20.6719, 318.59, "Warehouse 3"},
	{4, 306.1966, 307.819, 1003.3047, 203.1354, "Michelle's Love Nest*"},
	{10, 24.3769, 1341.1829, 1084.375, 8.3305, "Burglary House X14"},
	{1, 963.0586, 2159.7563, 1011.0303, 175.313, "Sindacco Abatoir"},
	{0, 2548.4807, 2823.7429, 10.8203, 270.6003, "K.A.C.C. Military Fuels Depot"},
	{0, 215.1515, 1874.0579, 13.1406, 177.5538, "Area 69"},
	{4, 221.6766, 1142.4962, 1082.6094, 184.9618, "Burglary House X13"},
	{12, 2323.7063, -1147.6509, 1050.7101, 206.5352, "Unused Safe House"},
	{6, 344.9984, 307.1824, 999.1557, 193.643, "Millie's Bedroom"},
	{12, 411.9707, -51.9217, 1001.8984, 173.3449, "Barber Shop"},
	{4, -1421.5618, -663.8262, 1059.5569, 170.9341, "Dirtbike Stadium"},
	{6, 773.8887, -47.7698, 1000.5859, 10.7161, "Cobra Gym"},
	{6, 246.6695, 65.8039, 1003.6406, 7.9562, "Los Santos Police Department"},
	{14, -1864.9434, 55.7325, 1055.5276, 85.8541, "Los Santos Airport"},
	{4, -262.1759, 1456.6158, 1084.3672, 82.459, "Burglary House X15"},
	{5, 22.861, 1404.9165, 1084.4297, 349.6158, "Burglary House X16"},
	{5, 140.3679, 1367.8837, 1083.8621, 349.2372, "Burglary House X17"},
	{3, 1494.8589, 1306.48, 1093.2953, 196.065, "Bike School"},
	{14, -1813.213, -58.012, 1058.9641, 335.3199, "Francis International Airport"},
	{16, -1401.067, 1265.3706, 1039.8672, 178.6483, "Vice Stadium"},
	{6, 234.2826, 1065.229, 1084.2101, 4.3864, "Burglary House X18"},
	{6, -68.5145, 1353.8485, 1080.2109, 3.5742, "Burglary House X19"},
	{6, -2240.1028, 136.973, 1035.4141, 269.0954, "Zero's RC Shop"},
	{6, 297.144, -109.8702, 1001.5156, 20.2254, "Ammu-nation (version 4)"},
	{6, 316.5025, -167.6272, 999.5938, 10.3031, "Ammu-nation (version 5)"},
	{15, -285.2511, 1471.197, 1084.375, 85.6547, "Burglary House X20"},
	{6, -26.8339, -55.5846, 1003.5469, 3.9528, "24/7 (version 6)"},
	{6, 442.1295, -52.4782, 999.7167, 177.9394, "Secret Valley Diner"},
	{2, 2182.2017, 1628.5848, 1043.8723, 224.8601, "Rosenberg's Office in Caligulas"},
	{6, 748.4623, 1438.2378, 1102.9531, 0.6069, "Fanny Batter's Whore House"},
	{8, 2807.3604, -1171.7048, 1025.5703, 193.7117, "Colonel Furhberger's"},
	{9, 366.0002, -9.4338, 1001.8516, 160.528, "Cluckin' Bell"},
	{1, 2216.1282, -1076.3052, 1050.4844, 86.428, "The Camel's Toe Safehouse"},
	{1, 2268.5156, 1647.7682, 1084.2344, 99.7331, "Caligula's Roof"},
	{2, 2236.6997, -1078.9478, 1049.0234, 2.5706, "Old Venturas Strip Casino"},
	{3, -2031.1196, -115.8287, 1035.1719, 190.1877, "Driving School"},
	{8, 2365.1089, -1133.0795, 1050.875, 177.3947, "Verdant Bluffs Safehouse"},
	{0, 1168.512, 1360.1145, 10.9293, 196.5933, "Bike School"},
	{9, 315.4544, 976.5972, 1960.8511, 359.6368, "Andromada"},
	{10, 1893.0731, 1017.8958, 31.8828, 86.1044, "Four Dragons' Janitor's Office"},
	{11, 501.9578, -70.5648, 998.7578, 171.5706, "Bar"},
	{8, -42.5267, 1408.23, 1084.4297, 172.068, "Burglary House X21"},
	{11, 2283.3118, 1139.307, 1050.8984, 19.7032, "Willowfield Safehouse"},
	{9, 84.9244, 1324.2983, 1083.8594, 159.5582, "Burglary House X22"},
	{9, 260.7421, 1238.2261, 1084.2578, 84.3084, "Burglary House X23"},
	{0, -1658.1656, 1215.0002, 7.25, 103.9074, "Otto's Autos"},
	{0, -1961.6281, 295.2378, 35.4688, 264.4891, "Wang Cars"}
};

static const MaxPassengers[27] = { // HEX смещения макс. кол-ва пассажиров на основной транспорт
	0x10331113, 0x11311131, 0x11331313, 0x80133301,
	0x1381F110, 0x10311103, 0x10001F10, 0x11113311,
	0x13113311, 0x31101100, 0x30001301, 0x11031311,
	0x11111331, 0x10013111, 0x01131100, 0x11111110,
	0x11100031, 0x11130221, 0x33113311, 0x11111101,
	0x33101133, 0x101001F0, 0x03133111, 0xFF11113F,
	0x13330111, 0xFF131111, 0x0000FF3F
};


new Float:l_FactoryCP[][] = {
	{2558.5881,-1295.8517,1044.1250},
	{2556.1011,-1295.8510,1044.1250},
	{2553.7939,-1295.8531,1044.1250},
	{2544.3843,-1295.8563,1044.1250},
	{2541.9963,-1295.8523,1044.1250}
};

new Float:r_FactoryCP[][] = {
	{2542.2380,-1290.9963,1044.1250},
	{2544.4521,-1290.9703,1044.1250},
	{2553.8679,-1291.0043,1044.1250},
	{2556.1863,-1291.0042,1044.1250},
	{2558.4622,-1290.9938,1044.1250}
};


enum e_Colors {
	e_color, e_name[16]
};
new Colors[][e_Colors] = {
	{COLOR_TELA,		"Tela"},
	{COLOR_FRENCH,		"French"},
	{COLOR_RED,			"Red"},
	{COLOR_WHITE,		"White"},
	{COLOR_NAVY,		"Navy"},
	{COLOR_AQUA,		"Aqua"},
	{COLOR_CRIMSON,		"Crimson"},
	{COLOR_BISQUE,		"Bisque"},
	{COLOR_CHARTREUSE,	"Chartreuse"},
	{COLOR_BROWN,		"Brown"},
	{COLOR_CORAL,		"Coral"},
	{COLOR_GREENYELLOW, "GreenYellow"},
	{COLOR_LAWNGREEN,	"Lawngreen"},
	{COLOR_LIMEGREEN,	"Limegreen"},
	{COLOR_OLIVE,		"Olive"},
	{COLOR_PINK,		"Pink"},
	{COLOR_SPRINGGREEN, "SpeengGreen"},
	{COLOR_TOMATO,		"Tomato"},
	{COLOR_SYSTEM,		"System"},
	{COLOR_PURPLE,		"Purple"}
};



enum e_AntiDm {
	e_AntiDmZoneId, e_AntiDmZone,
	e_AntiDmWorld, Float:e_AntiDmCoord[4]
};
new
	TOTAL_ANTIDM_ZONES,
	AntiDmInfo[MAX_ANTIDM_ZONES][e_AntiDm]
;


new const fightStyle[][] = {
	{5, "Бокс"},
	{6, "Кунг-фу"},
	{7, "Самбо"},
	{4, "Уличном стиле"}
};


enum e_BusRoute {
	stopNext,
	Float:stopX,
	Float:stopY,
	Float:stopZ,
	stopName[18],
}
new const BusRoute[][][e_BusRoute] = {
	{
		{1, 2233.6335,-1145.0454,25.7969, "Отель ЛС"},
		{2, -97.8188,-1147.8456,1.5352, "ДБ"},
		{3, -1091.4415,-1333.1506,129.3996, "Ферма"},
		{4, -1851.9949,-568.4989,21.3089, "Аэрапорт СФ"},
		{0, -2026.9414,-75.8452,35.3203, "Автошкола"}
	}, {
		{1, -2026.2756,-75.5938,35.3203, "Автошкола"},
		{2, -1825.0438,-621.1991,16.4978, "Аэрапорт СФ"},
		{3, -1066.8634,-1357.1820,129.9968, "Ферма"},
		{4, -113.7366,-1150.3976,1.7633, "ДБ"},
		{0, 2214.3008,-1139.4200,25.7969, "Отель ЛС"}
	}, {
		{1, 2622.3635,2300.7500,10.8203, "Отель ЛВ"},
		{2, 2035.5227,1655.9678,10.8203, "Калигула"},
		{3, 2040.2583,1009.1813,10.8052, "Четыре Дракона"},
		{4, -2015.0028,274.7591,32.9499, "Автосалон СФ"},
		{0, -2038.8948,-63.9849,35.3138, "Автошкола"}
	}, {
		{1, -2025.6659,-75.7442,35.3203, "Автошкола"},
		{2, -1994.7224,314.3866,35.1719, "Автосалон СФ"},
		{3, 2074.9963,997.5345,10.8052, "Четыре Дракона"},
		{4, 2080.3950,1679.1343,10.8203, "Калигула"},
		{0, 2637.7947,2345.4346,10.6719, "Отель ЛВ"}
	}
};

new BusRouteCount[] = {5, 5, 5, 5};


#define PARK_GARAGE (1)
#define PARK_HOME (2)
#define PARK_HOME_GARAGE (3)
#define MAX_EXTRA_VEHICLES (5)
enum e_ExtraVehicles {
	evID1,
	evID2,
	evOwner,
	evModel,
	evPark,
	evColor1,
	evColor2,
	Float:evSpawnX,
	Float:evSpawnY,
	Float:evSpawnZ,
	Float:evSpawnA,
}
new ExtraVehicles[MAX_PLAYERS][MAX_EXTRA_VEHICLES][e_ExtraVehicles];
new TotalExtraVehicles[MAX_PLAYERS];
new Iterator:ExtraVehicles[MAX_PLAYERS]<MAX_EXTRA_VEHICLES>;
new VehicleInGarage[MAX_PLAYERS][MAX_EXTRA_VEHICLES];
new TotalVehicleInGarage[MAX_PLAYERS];

new PlayerText:Td::AutoSolon;
new Menu:AutoSolonMenu;
new Menu:GarageMenu;
new TempVehicle[MAX_PLAYERS];
new GarageParkPickup[4];

new const ExtraVehicleLimit[] = {2, 4};
new const ASModelCount[] = {12, 9, 21, 29, 8};
new const AClassChar[] = {'A', 'B', 'C', 'D', 'E'};

new const AutoSolon[][][] = {
	{
// offroad (A)
		{424, 150000},
		{444, 444000},
		{489, 150000},
		{495, 404000},
		{500, 210000},
		{554, 140000},
		{556, 500000},
		{557, 500000},
		{568, 122000},
		{573, 430000},
		{579, 250000},
		{400, 100000},
		{0, 0},
		{0, 0},
		{0, 0},
		{0, 0},
		{0, 0},
		{0, 0},
		{0, 0},
		{0, 0},
		{0, 0},
		{0, 0},
		{0, 0},
		{0, 0},
		{0, 0},
		{0, 0},
		{0, 0},
		{0, 0},
		{0, 0}
	}, {
// moto (B)
		{461, 130000},
		{462, 3000},
		{463, 180000},
		{468, 70000},
		{471, 50000},
		{521, 200000},
		{522, 300000},
		{581, 90000},
		{586, 170000},
		{0, 0},
		{0, 0},
		{0, 0},
		{0, 0},
		{0, 0},
		{0, 0},
		{0, 0},
		{0, 0},
		{0, 0},
		{0, 0},
		{0, 0},
		{0, 0},
		{0, 0},
		{0, 0},
		{0, 0},
		{0, 0},
		{0, 0},
		{0, 0},
		{0, 0},
		{0, 0}
	}, {
// sport (C)
		{402, 400000},
		{411, 700000},
		{429, 550000},
		{451, 625000},
		{477, 477000},
		{480, 353000},
		{494, 700000},
		{496, 270000},
		{502, 700000},
		{503, 700000},
		{506, 520000},
		{541, 510000},
		{558, 420000},
		{559, 580000},
		{560, 560000},
		{562, 310000},
		{565, 240000},
		{587, 340000},
		{589, 262000},
		{602, 360000},
		{603, 470000},
		{0, 0},
		{0, 0},
		{0, 0},
		{0, 0},
		{0, 0},
		{0, 0},
		{0, 0},
		{0, 0}
	}, {
// purser (D)
		{401, 35000},
		{404, 25000},
		{405, 150000},
		{409, 500000},
		{410, 35000},
		{412, 80000},
		{413, 70000},
		{418, 60000},
		{419, 90000},
		{421, 100000},
		{423, 200000},
		{426, 97000},
		{494, 150000},
		{436, 40000},
		{439, 63000},
		{455, 87000},
		{458, 45000},
		{466, 55000},
		{467, 250000},
		{474, 65000},
		{475, 57000},
		{479, 6600},
		{482, 111000},
		{483, 220000},
		{491, 95000},
		{492, 84000},
		{504, 250000},
		{507, 44000},
		{516, 61000}
	}
};

enum eStandPos {
	Float:pPos[4],
	Float:vPos[4],
	Float:pCPos[3],
	Float:pCLookAt[3],
}
new const StandPos[][eStandPos] = {
	{{561.2763,-1292.7158,17.2482,0.0}, {544.5237,-1289.2005,16.9530,337.7358}, {550.2797,-1283.9201,18.2656}, {547.3525,-1286.6055,17.7969}},
	{{-1958.5961,267.3734,41.0471,272.4041}, {-1948.1573,265.1886,40.6213,43.1284}, {-1953.8283, 265.0975,41.7476}, {-1949.8345, 265.1616, 41.5336}},
	{{-1649.9727,1212.4740,13.6719,133.6049}, {-1659.5625,1211.7045,13.4045,303.2365}, {-1658.6960, 1218.3387, 14.4254}, {-1658.8348, 1214.3636, 14.0017}},
	{{2172.9387,1395.4965,11.0625,0.0}, {2194.0857,1391.7537,10.5558,93.1450}, {2186.0534, 1386.6127, 12.0322}, {2189.0207, 1389.2465, 11.5236}}
};

#define NONE_VEHICLE	(0) 
#define HOME_VEHICLE	(1)
#define EXTRA_VEHICLE	(2)

new HGaragePickup[2];
new const Float:HGaragePickupPos[][4] = {
	{620.0793, -119.9805, 998.8491, 176.0786},
	{609.8389, -125.3335, 997.9922, 269.7483}
};


enum e_DefaultBiz {
	bInterior,
	bIcon[2],
	Float:bExit[4]
}
new const DefaultBiz[][e_DefaultBiz] = {
	{3, {52, 36}, {293.0706, 310.0464, 999.1484, 88.3541}},
	{1, {52, 6}, {285.9240, -39.8285, 1001.5156, 269.0992}},
	{10, {52, 10}, {364.1878, -73.9688, 1001.5078, 264.0963}},
	{5, {52, 29}, {372.3589, -133.0934, 1001.4922, 4.0632}},
	{9, {52, 14}, {364.8246, -10.8034, 1001.8516, 3.5526}},
	{17, {52, 36}, {-25.8902, -187.6157, 1003.5469, 4.9643}}
};


enum e_MapInfo {
	MapID,
	MapFile[36],
	MapWorld,
	MapInt
}
new MapInfo[MAX_MAPS][e_MapInfo];
new Iterator:Maps<MAX_MAPS>;


#include "..\include\r_utils"
#include "..\include\anticheat"
#include "..\include\gate"


new cache_row[512];
#define cache_get_str(%0,%1,%2) cache_get_row(%0,%1,cache_row),sscanf(cache_row,%2)
#define cache_get_int(%0,%1,%2) %2=cache_get_row_int(%0,%1)
#define cache_get_float(%0,%1,%2) %2=cache_get_row_float(%0,%1)


main() {
	print(" ");
	print(">> "#__GamemodeName__" "#__GamemodeVersion__" loaded!");
	print(">>  "#__GamemodeCopyright__"");
	print(" ");
}


public OnGameModeInit() {
	new time;			// AntiDeAMX
	#emit LOAD.S.pri	time
	#emit SYSREQ.C		GetTickCount
	#emit STOR.S.pri	time
	
	if(GetMaxPlayers() > MAX_PLAYERS) panic("Количество слотов больше MAX_PLAYERS, старт игрового режима невозможен!");
	
	if(!LoadConf()) panic("Отсутствует файл конфигурации, старт игрового режима невозможен!");
	
	if(!Db::Init()) panic("Не удалось подключится к базе данных, старт игрового режима невозможен!");
	
	Db::Prepare();
	
	Iter::Init(GangSolder);
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
	LoadGMInfo();
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
	
	RegisterAlt("/close", "/c");
	RegisterAlt("/shout", "/s");
	RegisterAlt("/p", "/pickup");
	RegisterAlt("/h", "/hangup");
	RegisterAlt("/a", "/admin");
	RegisterAlt("/pm", "/w");
	RegisterAlt("/tp", "/tplist");
	RegisterAlt("/gl", "/givelicense");
	RegisterAlt("/sl", "/showlicenses");
	RegisterAlt("/pas", "/pasport");
	RegisterAlt("/vopros", "/вопрос");
	RegisterAlt("/givegun",	"/ggun");
	
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
	
	SetGameModeText(Gm::Info[Gm::Mode]);
	format(temp, sizeof temp, "mapname %s", Gm::Info[Gm::Map]), SendRconCommand(temp);
	SendRconCommand("weburl "#__SERVER_SITE"");
	
	if(Gm::Info[Gm::Status] == 1) {
		format(temp, sizeof temp, "hostname %s (private)", Gm::Info[Gm::Hostname]), SendRconCommand(temp);
		format(temp, sizeof temp, "password %s", Gm::Info[Gm::Password]), SendRconCommand(temp);
	} else {
		format(temp, sizeof temp, "hostname %s", Gm::Info[Gm::Hostname]), SendRconCommand(temp);
	}
	
	serverUpdate = SetTimer(""#Gm::"Thread", SEC_TIMER, true);

	debug("OnGameModeInit() - Ok! Run time: %i (ms)", GetTickCount()-time);

	return 1;
}

public OnGameModeExit() {	
	DestroyAllDynamicCPs();
	DestroyAllDynamicAreas();
	DestroyAllDynamicRaceCPs();
	DestroyAllDynamicObjects();
	DestroyAllDynamicPickups();
	DestroyAllDynamicMapIcons();
	DestroyAllDynamic3DTextLabels();
	
	regex_delete_all();
	
	for(;;) if(0 >= Db::unprocessed_queries(connDb)) break;
	Db::close(connDb);
	
	print(" ");
	print(">> "#__GamemodeName__" "#__GamemodeVersion__" unloaded!");
	print(">> "#__GamemodeCopyright__"");
	print(" ");
	
	return 1;
}

public: GameModeInitExitFunc(mode) {
	Gm::Info[Gm::isAutoRest] = mode;
	SetGameModeText("RESTART");
	SendRconCommand("hostname rebooting...");
	
	if(mode) SendToAll(COLOR_LIGHTRED, "*"#__SERVER_PREFIX""#__SERVER_NAME_LC": Все были кикнуты, причина: Рестарт сервера");
	
	foreach(new p : Player) {
		if(Pl::isLogged(p)) {
			DeleteAllAttachedObject(p);
			GameTextForPlayer(p, "~b~] ~w~PECTAPT CEPBEPA ~b~]", 4000, 5);
			Rac::SetPlayerInterior(p, 0);
			Rac::SetPlayerVirtualWorld(p, 0);
			SetPlayerCameraPos(p, 1460.0, -1324.0, 287.2);
			SetPlayerCameraLookAt(p, 1374.5, -1291.1, 239.0);
			
			Pl::Update(p);
			PlayerLogged{p} = false;
			SetPlayerColor(p, COLOR_GRAD2);
			if(mode) Kick(p);
		}
	}
	KillTimer(serverUpdate);

	switch(mode) {
		case 1: {
			Bl::Clear();
			Checkprop();
			UpdateProp();
			SetTimer("GameModeExitFunc", 1000*60, 0);
		}
		default: {
			UpdateProp();
			SetTimer("GameModeExitFunc", 10000, 0);
		}
	}

	return 1;
}

public: GameModeExitFunc() {
	if(Gm::Info[Gm::isAutoRest]) {
		SendRconCommand("exit");
	} else {
		SendRconCommand("gmx");
	}
	return 1 ;
}

public: OnPlayerAFK(playerid, newstate, oldstate) {
	new fracid = Pl::FracID(playerid);
	new biz = GangOnBattle[fracid];
	switch(newstate) {
		case 1 : {
			if(IsValidBiz(biz) && BizzInfo[biz][bAttack] == fracid) {
				if(IsPlayerInDynamicArea(playerid, BizzInfo[biz][bZahvatArea])) {
					if(++SolderOnAFK[fracid] >= Iter::Count(GangSolder[fracid])) {
						new attack = BizzInfo[biz][bAttack];
						new defend = BizzInfo[biz][bDefend];
						
						GiveGangRespect(defend, ZahvatScore[defend]);
						Gz::StopFlashForAll(BizzInfo[biz][bZone]);
						Gz::HideForAll(BizzInfo[biz][bZone]);
						Gz::ShowForAll(BizzInfo[biz][bZone], GetFracColor(BizzInfo[biz][bFrac]));
						format(temp, sizeof(temp), "~r~%s~g~~n~RESPECT~r~+%d", GetGangName(defend), ZahvatScore[defend]);
						GameTextForGangs(temp, 6000, 1);
						format(temp, sizeof(temp), "[GANG NEWS] %s[%d] удержала территорию своего бизнеса %s, %s[%d] повержены!",
						GetGangName(defend), ZahvatScore[defend], BizzInfo[biz][bDescription], GetGangName(attack), ZahvatScore[attack]);
						sendToTeam(GetFracColor(defend), temp, Gangs);

						ZahvatKills{attack} = ZahvatKills{defend} = 0;
						SolderOnAFK{attack} = SolderOnAFK{defend} = 0;
						ZahvatScore[defend] = ZahvatScore[defend] = 0;
						
						Iter::Clear(GangSolder[attack]);
						Iter::Clear(GangSolder[defend]);
						GangOnBattle[attack] = GangOnBattle[defend] = INVALID_BIZ_ID;
						BizzInfo[biz][bAttack] = BizzInfo[biz][bDefend] = 0;
						BizzInfo[biz][bOnBattle] = 0;
						DisableZahvatMapIcon(attack, defend);
						Td::HideForAll(BizzInfo[biz][bZahvatTD]);
						Td::Destroy(BizzInfo[biz][bZahvatTD]);
						DestroyDynamicArea(BizzInfo[biz][bZahvatArea]);
						KillTimer(BizzInfo[biz][bZahvatTimer]);
						UpdateBizz(biz);
						UpdateGangInfo();
					}
				}
			}
		}
		
		case 0 : {
			if(IsValidBiz(biz) && BizzInfo[biz][bAttack] == fracid) {
				if(SolderOnAFK[fracid] > 0) SolderOnAFK[fracid]--;
			}
		}
	}
	return 1;
}


public: onZahvatBizz(biz, attack, defend) {	
	if(BizzInfo[biz][bZahvatTime] > 0) {
		BizzInfo[biz][bZahvatTime] -= 2;
		foreach(new p : TeamPlayers[attack]) {
			format(temp, sizeof temp, "~r~%i", BizzInfo[biz][bZahvatTime]);
			Td::SetString(BizzInfo[biz][bZahvatTD], temp), Td::ShowForPlayer(p, BizzInfo[biz][bZahvatTD]);
		}
		foreach(new p : TeamPlayers[defend]) {
			format(temp, sizeof temp, "~r~%i", BizzInfo[biz][bZahvatTime]);
			Td::SetString(BizzInfo[biz][bZahvatTD], temp), Td::ShowForPlayer(p, BizzInfo[biz][bZahvatTD]);
		}
	} else {		
		if((Iter::Count(GangSolder[defend]) == 0 && Iter::Count(GangSolder[attack]) > 0) && (!ZahvatKills{attack} && !ZahvatKills{defend})) {
			ZahvatScore[attack] += Iter::Count(GangSolder[attack]);
			GiveGangRespect(attack, ZahvatScore[attack]);

			GangBiznes{attack} ++;
			GangBiznes{defend} --;
			BizzInfo[biz][bFrac] = attack;
			Gz::StopFlashForAll(BizzInfo[biz][bZone]);
			Gz::HideForAll(BizzInfo[biz][bZone]);
			Gz::ShowForAll(BizzInfo[biz][bZone], GetFracColor(BizzInfo[biz][bFrac]));
			format(temp, sizeof(temp), "~r~%s~g~~n~RESPECT~r~+%d", GetGangName(attack), ZahvatScore[attack]);
			GameTextForGangs(temp, 6000, 1);
			format(temp, sizeof(temp), "[GANG NEWS] %s взяли без боя территорию бизнеса %s!", GetGangName(attack), BizzInfo[biz][bDescription]);
			sendToTeam(GetFracColor(attack), temp, Gangs);
			
		} else if(!ZahvatKills{attack} && !ZahvatKills{defend}) {
			ZahvatScore[defend] += Iter::Count(GangSolder[defend]);
			GiveGangRespect(defend, ZahvatScore[defend]);
			BizzInfo[biz][bFrac] = defend;
			Gz::StopFlashForAll(BizzInfo[biz][bZone]);
			Gz::HideForAll(BizzInfo[biz][bZone]);
			Gz::ShowForAll(BizzInfo[biz][bZone], GetFracColor(BizzInfo[biz][bFrac]));
			format(temp, sizeof(temp), "~r~%s~g~~n~RESPECT~r~+%d", GetGangName(defend), ZahvatScore[defend]);
			GameTextForGangs(temp, 6000, 1);
			format(temp, sizeof(temp), "[GANG NEWS] %s удержали без боя территорию бизнеса %s!", GetGangName(defend), BizzInfo[biz][bDescription]);
			sendToTeam(GetFracColor(attack), temp, Gangs);
		
		} else {
			new totalscore = (ZahvatScore[attack] - ZahvatScore[defend]);
			if(totalscore == 0) {
				if(ZahvatKills{attack} < ZahvatKills{defend}) {
					BizzInfo[biz][bFrac] = defend;
					Gz::StopFlashForAll(BizzInfo[biz][bZone]);
					Gz::HideForAll(BizzInfo[biz][bZone]);
					Gz::ShowForAll(BizzInfo[biz][bZone], GetFracColor(BizzInfo[biz][bFrac]));
					GiveGangRespect(defend, ZahvatScore[defend]);
					format(temp, sizeof(temp), "~r~%s~g~~n~RESPECT~r~+%d", GetGangName(defend), ZahvatScore[defend]);
					GameTextForGangs(temp, 6000, 1);
					format(temp, sizeof(temp), "[GANG NEWS] %s[%d] удержала территорию своего бизнеса %s, %s[%d] повержены!",
					GetGangName(defend), ZahvatScore[defend], BizzInfo[biz][bDescription], GetGangName(attack), ZahvatScore[attack]);
					sendToTeam(GetFracColor(defend), temp, Gangs);
				
				} else if(ZahvatKills{attack} > ZahvatKills{defend}) {
					GangBiznes{attack} ++;
					GangBiznes{defend} --;
					BizzInfo[biz][bFrac] = attack;
					Gz::StopFlashForAll(BizzInfo[biz][bZone]);
					Gz::HideForAll(BizzInfo[biz][bZone]);
					Gz::ShowForAll(BizzInfo[biz][bZone], GetFracColor(BizzInfo[biz][bFrac]));
					format(temp, sizeof(temp), "~r~%s~g~~n~RESPECT~r~+%d", GetGangName(attack), ZahvatScore[attack]);
					GameTextForGangs(temp, 6000, 1);
					format(temp, sizeof(temp), "[GANG NEWS] %s[%d] захватили территорию бизнеса %s, %s[%d] повержены!",
					GetGangName(attack), ZahvatScore[attack], BizzInfo[biz][bDescription], GetGangName(defend), ZahvatScore[defend]);
					sendToTeam(GetFracColor(attack), temp, Gangs);
				
				} else {
					BizzInfo[biz][bFrac] = defend;
					GiveGangRespect(defend, ZahvatScore[defend]);
					Gz::StopFlashForAll(BizzInfo[biz][bZone]);
					Gz::HideForAll(BizzInfo[biz][bZone]);
					Gz::ShowForAll(BizzInfo[biz][bZone], GetFracColor(BizzInfo[biz][bFrac]));
					format(temp, sizeof(temp), "~r~%s~g~~n~RESPECT~r~+%d", GetGangName(defend), ZahvatScore[defend]);
					GameTextForGangs(temp, 6000, 1);
					format(temp, sizeof(temp), "[GANG NEWS] %s[%d] удержала территорию своего бизнеса %s, %s[%d] повержены!",
					GetGangName(defend), ZahvatScore[defend], BizzInfo[biz][bDescription], GetGangName(attack), ZahvatScore[attack]);
					sendToTeam(GetFracColor(defend), temp, Gangs);
				}
				
			} else if(totalscore < 0) {
				BizzInfo[biz][bFrac] = defend;
				GiveGangRespect(defend, ZahvatScore[defend]);
				Gz::StopFlashForAll(BizzInfo[biz][bZone]);
				Gz::HideForAll(BizzInfo[biz][bZone]);
				Gz::ShowForAll(BizzInfo[biz][bZone], GetFracColor(BizzInfo[biz][bFrac]));
				format(temp, sizeof(temp), "~r~%s~g~~n~RESPECT~r~+%d", GetGangName(defend), ZahvatScore[defend]);
				GameTextForGangs(temp, 6000, 1);
				format(temp, sizeof(temp), "[GANG NEWS] %s[%d] удержала территорию своего бизнеса %s, %s[%d] повержены!",
				GetGangName(defend), ZahvatScore[defend], BizzInfo[biz][bDescription], GetGangName(attack), ZahvatScore[attack]);
				sendToTeam(GetFracColor(defend), temp, Gangs);
			
			} else if(totalscore > 0) {
				GangBiznes{attack} ++;
				GangBiznes{defend} --;
				BizzInfo[biz][bFrac] = attack;
				GiveGangRespect(attack, ZahvatScore[attack]);
				Gz::StopFlashForAll(BizzInfo[biz][bZone]);
				Gz::HideForAll(BizzInfo[biz][bZone]);
				Gz::ShowForAll(BizzInfo[biz][bZone], GetFracColor(BizzInfo[biz][bFrac]));
				format(temp, sizeof(temp), "~r~%s~g~~n~RESPECT~r~+%d", GetGangName(attack), ZahvatScore[attack]);
				GameTextForGangs(temp, 6000, 1);
				
				format(temp, sizeof(temp), "[GANG NEWS] %s[%d] захватили территорию бизнеса %s, %s[%d] повержены!",
				GetGangName(attack), ZahvatScore[attack], BizzInfo[biz][bDescription], GetGangName(defend), ZahvatScore[defend]);
				sendToTeam(GetFracColor(attack), temp, Gangs);
			}
		}
		
		ZahvatKills{attack} = ZahvatKills{defend} = 0;
		SolderOnAFK{attack} = SolderOnAFK{defend} = 0;
		ZahvatScore[defend] = ZahvatScore[defend] = 0;
		Iter::Clear(GangSolder[attack]);
		Iter::Clear(GangSolder[defend]);
		GangOnBattle[attack] = GangOnBattle[defend] = INVALID_BIZ_ID;
		BizzInfo[biz][bAttack] = BizzInfo[biz][bDefend] = 0;
		BizzInfo[biz][bOnBattle] = 0;
		DisableZahvatMapIcon(attack, defend);
		Td::HideForAll(BizzInfo[biz][bZahvatTD]);
		Td::Destroy(BizzInfo[biz][bZahvatTD]);
		DestroyDynamicArea(BizzInfo[biz][bZahvatArea]);
		KillTimer(BizzInfo[biz][bZahvatTimer]);
		UpdateBizz(biz);
		UpdateGangInfo();
	}
}


stock IsInRespawn(fracid, vehid) {
	for(new i; i < sizeof RespCoord; i++) {
		if(VehicleToKvadrat(vehid, RespCoord[i][rMinX], RespCoord[i][rMinY], RespCoord[i][rMaxX], RespCoord[i][rMaxY]) && fracid == RespCoord[i][fId]) return 1;
	}
	return 0;
}

stock UnJail(playerid, type)
{
	Pl::Info[playerid][pJailed] = 0;
    Pl::Info[playerid][pJailTime] = 0;
	SetPlayerSkin(playerid, TempSkin[playerid]);
	switch(type) {
		case 1: {
			Rac::SetPlayerInterior(playerid, 6);
			Rac::SetPlayerVirtualWorld(playerid, 1);
			Rac::SetPlayerFacingAngle(playerid, 180.4);
			Rac::SetPlayerPos(playerid,246.5,67.5,1003.6);
			Send(playerid,COLOR_LIGHTRED,"Вы были выпушены из тюрьмы!");
		}
		case 2: {
			SetPlayerWorldBounds(playerid, 20000.0000, -20000.0000, 20000.0000, -20000.0000);
			Rac::SetPlayerVirtualWorld(playerid, 0);
			Rac::SetPlayerInterior(playerid, 0);
			Rac::SetPlayerPos(playerid, 1552.9265,-1675.9987,16.1953);
		}
		default:
		{
			Rac::SetPlayerInterior(playerid, 6);
			Rac::SetPlayerVirtualWorld(playerid, 1);
			Rac::SetPlayerFacingAngle(playerid,180.4);
			Rac::SetPlayerPos(playerid,246.5,67.5,1003.6);
			Send(playerid,COLOR_LIGHTRED,"Вы были выпушены из тюрьмы!");
		}
	}
	Pl::SetSpawnInfo(playerid);
	return 1;
}

stock CrimInRange(Float:radi, playerid, copid) {
    if(Pl::isLogged(playerid) && Pl::isLogged(copid)) {
		GetPlayerPos(copid, posx, posy, posz);
		return (radi >= GetPlayerDistanceFromPoint(playerid, posx, posy, posz));
	}
	return 0;
}

stock IsPlayerInRangeOfPlayer(playerid, Float:radi, targetid) {
	new Float:x, Float:y, Float:z;
	GetPlayerPos(targetid, x, y, z);
	return IsPlayerInRangeOfPoint(playerid, radi, x, y, z);
}

stock IsPlayerInRangeOfObject(playerid, Float:radi, objectid, bool:dynamic=false) {
	new Float:x, Float:y, Float:z;
	if(dynamic) {
		GetDynamicObjectPos(objectid, x, y, z);
	} else {
		GetObjectPos(objectid, x, y, z);
	}
	return IsPlayerInRangeOfPoint(playerid, radi, x, y, z);
}

stock ProxDetector(Float:radi, playerid, const message[], col1=COLOR_FADE1, col2=COLOR_FADE2, col3=COLOR_FADE3, col4=COLOR_FADE4, col5=COLOR_FADE5) {
	new Float:x, Float:y, Float:z, Float:dist;
	new playerint = GetPlayerInterior(playerid);
	new playervirt = GetPlayerVirtualWorld(playerid);
    GetPlayerPos(playerid, x, y, z);
	Send(playerid, col1, message);
	
    foreach(new i : inStreamPlayers[playerid]) {
		dist = GetPlayerDistanceFromPoint(i, x, y, z);
		if(!BigEar{i}) {
			if(radi >= dist) {
				if(GetPlayerInterior(i) == playerint && GetPlayerVirtualWorld(i) == playervirt) {
					if(dist < (radi/16)) Send(i, col1, message);
					else if(dist < (radi/8)) Send(i, col2, message);
					else if(dist < (radi/6)) Send(i, col3, message);
					else if(dist < (radi/4)) Send(i, col4, message);
					else if(dist < (radi/2)) Send(i, col5, message);
				}
			}
		} else {
			Send(i, col1, message);
		}
    }
}

stock SendToAdmin(color, string[], lvl = 1, log = 0) {
	foreach(new i : AdminPlayers) {
		if(Pl::isAdmin(i, lvl)) {
			Send(i, color, string);
		}
	}
	switch(log) {
		case 0: SendLog(LOG_ANTICHEAT, string);
		case 1: SendLog(LOG_ANTICHEAT, string);
		case 2: SendLog(LOG_REPORT, string);
		case 3: SendLog(LOG_ADMWARN, string);
		case 4: SendLog(LOG_PAYDAY_STATS, string);
		case 5: SendLog(LOG_MYSQL_ERROR, string);
	}
	return 1;
}

stock SendDeathMessageToAdmin(killer, killee, weapon) {
	foreach(new i : AdminPlayers) {
		SendDeathMessageToPlayer(i, killer, killee, weapon);
	}
}

stock SendToHelper(color, string[], lvl = 1) {
	foreach(new i : HelperPlayers) if(IsPHelper(i, lvl) && IsAHelperDuty(i)) Send(i, color, string);
	SendLog(LOG_HELPER_CHAT, string);
}

stock SendToLeader(color, string[]) {
	foreach(new i : LeaderPlayers) Send(i, color, string);
	SendLog("leaderchat", string);
}

stock EmptyMessage(playerid, rows) {
	while(rows--) {
		SendClientMessage(playerid, -1, " ");
	}
	return ;
}

stock EmptyMessageToAll(rows) {
	while(rows--) {
		SendToAll(COLOR_WHITE, " ");
	}
}

stock OOCOff(color, const string[]) {
	foreach(new i: Player) {
		if(Pl::isLogged(i)) {
			if(gOoc{i}) {
				Send(i, color, string);
			}
		}
	}
}

stock OOCNews(color, const string[]) {
	foreach(new i: Player) {
		if(Pl::isLogged(i)) {
			if(gNews{i}) {
				Send(i, color, string);
			}
		}
	}
	return ;
}

stock sendToTeam(color, const message[], forteam[] = { -1 }, size = sizeof forteam) {
	if(forteam[0] != -1) {
		for(new j; j < size; j++) {
			foreach(new i: TeamPlayers[forteam[j]]) {
				Send(i, color, message);
			}
		}
	} else {
		foreach(new i : Frac) {
			foreach(new j : TeamPlayers[i]) {
				Send(j, color, message);
			}
		}
	}
}

stock sendToFamily(family, color, const string[]) {
	foreach(new i: TeamPlayers[family]) {
		if(gFam{i}) {
			Send(i, color, string);
		}
	}
}

stock sendToFrac(fracid, color, const string[]) {
	foreach(new playerid: TeamPlayers[fracid]) {
		Send(playerid, color, string);
	}
}

stock sendToLog(color, const string[]) {
	foreach(new i: ToglogPlayers) {
		Send(i, color, string);
	}
	return 1;
}

stock SendJobMessage(job, color, const string[]) {
	foreach(new i: JobPlayers[job]) {
		Send(i, color, string);
	}
	return 1;
}

stock SendZahvatMessage(attack, defend, color, const string[]) {
	foreach(new i: TeamPlayers[attack]) Send(i, color, string);
	foreach(new i: TeamPlayers[defend]) Send(i, color, string);
}

stock PlayerPlayMusic(playerid) {
	if(IsPlayerConnected(playerid)) {
		Fixr{playerid} = 5;
		PlayerPlaySound(playerid, 1068, 0.0, 0.0, 0.0);
	}
}

stock PlayerFixRadio(playerid) {
    if(IsPlayerConnected(playerid)) {
		Fixr{playerid} = 1;
		PlayerPlaySound(playerid, 1068, 0.0, 0.0, 0.0);
	}
}

stock playerSpectateUpdate(i) {
	static string[128];
	new targetid, Float:sphealth;
	
	targetid = Pl::SpecInfo[i][pSpecID];
	if(targetid != INVALID_PLAYER_ID) {
		if(Pl::isLogged(targetid)) {
			Pl::SpecInfo[targetid][pSpecVw]		[0] = GetPlayerVirtualWorld(targetid);
			Pl::SpecInfo[targetid][pSpecInt]	[0] = GetPlayerInterior(targetid);
			Pl::SpecInfo[targetid][pSpecState]	[0] = GetPlayerState(targetid);
			GetPlayerName(targetid, plname, 24);
			
			if(Pl::isAdmin(i, 1)) {
				GetPlayerHealth(targetid, sphealth);
				format(string, sizeof(string), "~g~%s (ID:%i) ~r~HP:%.1f~n~~w~$:%d ~r~DRUGS:%i WARNS:%i",
				plname, targetid, sphealth, Rac::GetPlayerMoney(targetid), Pl::Info[targetid][pDrugs], Pl::Info[targetid][pWarns]);
				Pt::SetString(i, Pt::Spec[i], string);
			} else {
				format(string, sizeof(string), "~y~%s[%i]", plname, targetid);
				Pt::SetString(i, Pt::Spec[i], string);
			}
			
			if(Pl::SpecInfo[targetid][pSpecState][0] != Pl::SpecInfo[targetid][pSpecState][1]) {
				Pl::SpecInfo[targetid][pSpecState][1] = Pl::SpecInfo[targetid][pSpecState][0];
				switch(Pl::SpecInfo[targetid][pSpecState][0]) {
					case 2, 3 : {
						PlayerSpectateVehicle(i, GetPlayerVehicleID(targetid), SPECTATE_MODE_NORMAL);
					}
					default : {
						PlayerSpectatePlayer(i, targetid, SPECTATE_MODE_NORMAL);
					}
				}
			}
			
			if(Pl::SpecInfo[targetid][pSpecInt][0] != Pl::SpecInfo[targetid][pSpecInt][1]) {
				Pl::SpecInfo[targetid][pSpecInt][1] = Pl::SpecInfo[targetid][pSpecInt][0];
				Rac::SetPlayerInterior(i, Pl::SpecInfo[targetid][pSpecInt][0]);
			}
			
			if(Pl::SpecInfo[targetid][pSpecVw][0] != Pl::SpecInfo[targetid][pSpecVw][1]) {
				Pl::SpecInfo[targetid][pSpecVw][1] = Pl::SpecInfo[targetid][pSpecVw][0];
				Rac::SetPlayerVirtualWorld(i, Pl::SpecInfo[targetid][pSpecVw][0]);
			}
		} else {
			MedicBill{i} = false;
			WatchingTV{i} = false;
			Pt::Hide(i, Pt::Spec[i]);
			Pl::SpecInfo[i][pSpecID] = INVALID_PLAYER_ID;
			Rac::TogglePlayerControllable(i, 1);
			Rac::TogglePlayerSpectating(i, false);
			GameTextForPlayer(i, "~w~                TV~n~~r~                Off", 5000, 6);
			PlayerPlaySound(i, 1145, 0.0, 0.0, 0.0);
			Pl::SetSpawnInfo(i);
			Rac::SpawnPlayer(i);
		}
	}
	
	targetid = Bl::Info[i][Bl::Observe];
	if(targetid != INVALID_PLAYER_ID) {
		if(IsPlayerStreamedIn(targetid, i)) {
			switch(GetPlayerState(targetid)) {
				case PLAYER_STATE_ONFOOT : {
					GetPlayerPos(targetid, posx, posy, posz);
					Streamer::SetFloatData(STREAMER_TYPE_CP, Bl::Info[i][Bl::Marker], E_STREAMER_X, posx);
					Streamer::SetFloatData(STREAMER_TYPE_CP, Bl::Info[i][Bl::Marker], E_STREAMER_Y, posy);
					Streamer::SetFloatData(STREAMER_TYPE_CP, Bl::Info[i][Bl::Marker], E_STREAMER_Z, posz);
				}
			}
		} else {
			Bl::Info[i][Bl::Observe] = INVALID_PLAYER_ID;
			if(Bl::Info[targetid][Bl::Finder] == i) {
				Bl::Info[targetid][Bl::Finder] = INVALID_PLAYER_ID;
			}
			switch(GetPlayerState(targetid)) {
				case PLAYER_STATE_ONFOOT : {
					DestroyDynamicCP(Bl::Info[i][Bl::Marker]);
				}
				
				case PLAYER_STATE_DRIVER, PLAYER_STATE_PASSENGER : {
					new vehid = GetPlayerVehicleID(targetid);
					GetVehicleParamsEx(vehid, engine, light, alarm, doors, bonnet, boot, objective);
					if(objective > 0) {
						new count;
						foreach(new passenger: vehiclePassengers[vehid]) {
							if(Bl::Info[passenger][Bl::Finder] != INVALID_PLAYER_ID) {
								count ++;
							}
						}
						if(!count) {
							SetVehicleParamsEx(vehid, engine, light, alarm, doors, bonnet, boot, false);
						}
					}
				}
			}
		}
	}
	
	return 1;
}

stock IsAtBar(playerid) {
    if(Pl::isLogged(playerid)) {
		for(new i; i < sizeof(BarCoord); i ++) {
			if(IsPlayerInRangeOfPoint(playerid, BarCoord[i][0], BarCoord[i][1], BarCoord[i][2], BarCoord[i][3])) return true;
		}
  	}
	return false;
}

stock Pl::isAdmin(playerid, lvl) {
	if(Rac::isValidPlayer(playerid)) {
		if(Pl::Info[playerid][pAdmin] >= lvl) {
			if(AdminDuty{playerid} || Pl::Info[playerid][pAdmin] == ADMINISTRATOR) {
				return 1;
			}
		}
	}
	return 0;
}


public OnPlayerConnect(playerid) {
	if(IsPlayerNPC(playerid)) {
		PlayerLogged{playerid} = true;
		return 1;
	}
		
	new ip[16], currtime = gettime();
	GetPlayerIp(playerid, ip, 16);
	if(slotused{playerid} && strcmp(playerIp[playerid], ip, false) == 0) {
		return Rac::Ban(playerid, "Флуд коннектами");
	}
	
	if((currtime - GetSVarInt(ip)) < 5) {
		Send(playerid, COLOR_LIGHTRED, "* Перезаходить можно не менее чем через 5 секунд!");
		return Kick(playerid);
	}
	
	slotused{playerid} = true;
	strmid(playerIp[playerid], ip, 0, strlen(ip), 16);
	
	if(Gm::Info[Gm::isAutoRest]) {
		ShowDialog(playerid, D_NONE, 0, "RESTART", "dialog/srv_restart.txt", "OK","");
		Kick(playerid);
	} else {
		Pl::Init(playerid);
		Bl::Init(playerid);
		Pl::RemoveWorldModel(playerid);
		
		Pt::Init(playerid);
		ClearCrime(playerid);
		
		ForceClassSelection(playerid);
		Rac::TogglePlayerSpectating(playerid, true);
		Rac::TogglePlayerSpectating(playerid, false);
	
		format(dialog, sizeof dialog, "Дождитесь полной загрузки игры и нажмите ENTER!\n\
		Осталось секунд: %i", Pl::Info[playerid][pWait]);
		SPD(playerid, D_WAIT, 0, "Подождите...", dialog, "ENTER", "");
	}
	return 1;
}

public OnPlayerDisconnect(playerid, reason) {
	slotused{playerid} = false;
	SetSVarInt(playerIp[playerid], gettime());
	
	if(!Pl::isLogged(playerid)) return 1;	
	
	foreach(new i: Player) {
		if(Pl::isLogged(i)) {
			if(TaxiAccepted[i] != INVALID_PLAYER_ID) {
				if(TaxiAccepted[i] == playerid) {
					TaxiAccepted[i] = INVALID_PLAYER_ID;
					TaxiCallTime[i] = 0;
					DestroyDynamicCP(checkpoints[i]);
					GameTextForPlayer(i, "~w~Taxi Caller~n~~r~Left the game", 5000, 1);
				}
			} else if(BusAccepted[i] != INVALID_PLAYER_ID) {
				if(BusAccepted[i] == playerid) {
					BusAccepted[i] = INVALID_PLAYER_ID;
					BusCallTime[i] = 0;
					DestroyDynamicCP(checkpoints[i]);
					GameTextForPlayer(i, "~w~Bus Caller~n~~r~Left the game", 5000, 1);
				}
			}
		}
	}
	
	switch(TransportDuty[playerid]) {
		case 1 : TaxiDrivers --;
		case 2 : BusDrivers  --;
	}

	if(Pl::Info[playerid][pJob] == 6 && OnDuty{playerid}) {
		Mechanics --;
	}
	
	AFKInfo[playerid][afk_State] = 0;
	AFKInfo[playerid][afk_Time][0] = 0; 
	Delete3DTextLabel(AFKInfo[playerid][afk_Text]);
	
	Pl::Info[playerid][pMuted] = 0;
	Pl::Info[playerid][pMutedTime] = 0;
	if(TransportCost[playerid] > 0 && TransportDriver[playerid] != INVALID_PLAYER_ID) {
		new driver = TransportDriver[playerid];
	    if(Pl::isLogged(driver)) {
		    TransportMoney[driver] += TransportCost[playerid];
		    TransportTime[driver] = 0;
		    TransportCost[driver] = 0;
		    format(temp, sizeof(temp), "~w~Passenger left~n~~g~Earned $%d", TransportCost[playerid]);
		    GameTextForPlayer(driver, temp, 5000, 1);
		}
	}
		
	if(HireCar[playerid] != INVALID_VEHICLE_ID) {
		ToggleVehicleDoor(HireCar[playerid], true);
	}
	
	if(gLastCar[playerid] != INVALID_VEHICLE_ID) {
		Iter::Remove(vehiclePassengers[gLastCar[playerid]], playerid);
		if(Bl::Info[playerid][Bl::Finder] != INVALID_PLAYER_ID) {
			GetVehicleParamsEx(gLastCar[playerid], engine, light, alarm, doors, bonnet, boot, objective);
			SetVehicleParamsEx(gLastCar[playerid], engine, light, alarm, doors, bonnet, boot, false);
		}
	}
	
	if(PlayerObject[playerid] != INVALID_OBJECT_ID) {
		DestroyObject(PlayerObject[playerid]);
	}
	
	foreach(new i : ExtraVehicles[playerid]) {
		Veh::Destroy(ExtraVehicles[playerid][i][evID2]);
	}
	
	AshQueue(playerid, 1);
	Del_Of_Iterator(playerid);
	
	Pl::Update(playerid);
	DeleteAllAttachedObject(playerid);
	PlayerLogged{playerid} = false;
	
	DestroyDynamicCP(checkpoints[playerid]);
	DestroyDynamicCP(Bl::Info[playerid][Bl::Marker]);
	DestroyDynamicRaceCP(checkpointb[playerid]);
	DestroyDynamicPickup(pickupd[playerid][0]);
	DestroyDynamicMapIcon(pickupd[playerid][1]);
	
	static rsn[][] = { "Обрыв связи", "Вышел", "Кикнут", "unknown"};
	format(temp, sizeof temp, "* %s (ID: %i) сбежал(а) с ..::"#__SERVER_PREFIX""#__SERVER_NAME_LC"::.. [RUS]. (%s)", GetName(playerid), playerid, (0<=reason<=2)?(rsn[reason]):(rsn[3]));
	sendToLog(COLOR_GREY, temp);
	
	return 1;
}

public OnVehicleSpawn(vehicleid) {
	if(AutoInfo[vehicleid][aOwner] != INVALID_PLAYER_ID) {
		if(AutoInfo[vehicleid][aOwner] > INVALID_PLAYER_ID) {
			new house = AutoInfo[vehicleid][aOwner] / INVALID_PLAYER_ID;
			if(IsValidHouse(house)) {
				if(HouseInfo[house][hAuto] == vehicleid && HouseInfo[house][hvPark] == HOME_VEHICLE) {
					LinkVehicleToInterior(vehicleid, 3);
					SetVehicleVirtualWorld(vehicleid, house);
				}
			}
		} else {
			new slot = GetIdxExtraVehicleFromVehicleID(AutoInfo[vehicleid][aOwner], vehicleid);
			if(slot != -1) {
				new owner = AutoInfo[vehicleid][aOwner];
				if(ExtraVehicles[owner][slot][evPark] == PARK_GARAGE) {
					Veh::Destroy(ExtraVehicles[AutoInfo[vehicleid][aOwner]][slot][evID2]);
				}
				
				else if((ExtraVehicles[owner][slot][evPark] / Pl::Info[owner][pHouseKey]) == PARK_HOME_GARAGE) {
					LinkVehicleToInterior(vehicleid, 3);
					SetVehicleVirtualWorld(vehicleid, Pl::Info[owner][pHouseKey]);
				}
			}
		}
	}
	
	Rac::RepairVehicle(vehicleid);
	if(AutoInfo[vehicleid][aFuel] < 1.0) {
		AutoInfo[vehicleid][aFuel] = 10.0;
	}
	if(isEngined{vehicleid}) {
		ToggleVehicleEngine(vehicleid, 0);
	}
	AddTuning(vehicleid);
	return 1;
}

public OnVehicleDeath(vehicleid, killerid) {
	new Float:x, Float:y, Float:z;
	GetVehicleRotation(vehicleid, x, y, z);
	if((y < 90 && y > -90) && gLastCar[killerid] != vehicleid && killerid != INVALID_PLAYER_ID) {
		Rac::Kick(killerid, "Уничтожении тачек читами");
	}
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason) {
	if(playerid == killerid) {
		return Rac::Kick(playerid, "SelfKill");
	} else if(reason != 255) {
		if(reason < 47) {
			return Rac::Kick(playerid, "FakeKill");
		}
	} else {
		killerid = SyncInfo[playerid][sKillerID];
		reason = SyncInfo[playerid][sReasonID];
		SyncInfo[playerid][sKillerID] = INVALID_PLAYER_ID;
		SyncInfo[playerid][sReasonID] = 255;
	}
	
	if(Pl::isLogged(killerid)) {
		new killername[24], playername[24];
		new killerfrac = Pl::FracID(killerid), playerfrac = Pl::FracID(playerid);
		getname(killerid -> killername,playerid -> playername);
	
		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);
		if(IsPlayerInRangeOfPoint(killerid, 50.0, x, y, z)) {
			if(Rac::GetPlayerState(killerid) == 2 && (reason == WEAPON_UZI || reason == WEAPON_MP5 || reason == WEAPON_TEC9)) {
				format(temp, sizeof(temp),"[античит] * %s(%i) только, что совершил ДБ. Жертва:(%i)%s", killername, killerid, playerid, playername);
				SendToAdmin(COLOR_NEWS, temp, 1, 1);
			}
		} else if(!IsPlayerStreamedIn(playerid, killerid)) {
			return Rac::Kick(playerid, "FakeKill");
		}
		
		if(reason == WEAPON_MINIGUN) {
			format(temp, sizeof(temp), "[античит] * %s[%i] только что убил игрока миниганом.", killername, killerid);
			SendToAdmin(COLOR_YELLOW, temp, 1, 1);
		}
		
		Pl::Info[killerid][pKills]++;
		if(Pl::Info[playerid][pWantedL] > 0) {
			if(IsACop(killerid)) {
				new jtime	= (Pl::Info[playerid][pWantedL]*3*100);
				new jmoney	= (Pl::Info[playerid][pWantedL]*1000);
				if(CrimInRange(30.0, playerid, killerid)) {
					Rac::GivePlayerMoney(killerid, jmoney);
					Rac::GivePlayerMoney(playerid, -jmoney);
					format(temp, sizeof temp, "~w~Running Suspect~r~Killed~n~Bonus~g~$%d", jmoney);
					GameTextForPlayer(killerid, temp, 5000, 1);
					PlayerPlaySound(killerid, 1058, 0.0, 0.0, 0.0);
				}
				ClearCrime(playerid);
				Pl::Info[playerid][pWantedD] ++;
				SuspectKill{playerid} = true;
				Pl::Info[playerid][pJailTime] = jtime;
				format(temp, sizeof temp, "Вас убил законник с %d уровнем розыска. Вы посажены в тюрьму на %d минуты!", Pl::Info[playerid][pWantedL], jtime/60);
				Send(playerid, COLOR_LIGHTRED, temp);
				format(temp, sizeof temp, "Вы убили нарушителя с %d уровнем розыска. Он посажен в тюрьму на %d минуты!", Pl::Info[playerid][pWantedL], jtime/60);
				Send(killerid, COLOR_LIGHTRED, temp);
			}
		}

		// Уважения за убийство при захвате бизнеса
		#define InCapture(%0,%1) ((BizzInfo[%0][bAttack]==%1)||(BizzInfo[%0][bDefend]==%1))
		if(GangOnBattle[killerfrac] != INVALID_BIZ_ID && killerfrac != playerfrac) {
			new biz = GangOnBattle[killerfrac];
			if(BizzInfo[biz][bOnBattle] && IsPlayerInDynamicArea(killerid, BizzInfo[biz][bZahvatArea])) {
				if(!InCapture(biz, playerfrac) && InCapture(biz, killerfrac)) {
					GiveGangRespect(killerfrac, -5);
					format(temp, sizeof temp, "[GANG NEWS] %s[%s] завалил %s[%s] (уважение -5)", killername, GetGangName(killerfrac), playername, GetGangName(playerfrac));
					SendZahvatMessage(BizzInfo[biz][bAttack], BizzInfo[biz][bDefend], GetFracColor(killerfrac), temp);
				}
				
				else if(!InCapture(biz, killerfrac) && InCapture(biz, playerfrac)) {
					ZahvatDeath[playerid] = 1;
					GiveGangRespect(killerfrac, -50);
					format(temp, sizeof temp, "[GANG NEWS] %s[%s] вмешался в захват бизнеса (уважение -50)", killername, GetGangName(killerfrac));
					SendZahvatMessage(BizzInfo[biz][bAttack], BizzInfo[biz][bDefend], GetFracColor(killerfrac), temp);
					sendToFrac(killerfrac, GetFracColor(killerfrac), temp);
				}
				
				else if(InCapture(biz, killerfrac) && InCapture(biz, playerfrac)) {
					new rep;
					switch(reason) {
						case 0 									: rep = 5;
						case 22, 23 							: rep = 3;
						case 5, 6, 7, 10, 11, 12, 13, 14, 15	: rep = 10;
						default 								: rep = 1;
					}
					ZahvatDeath[playerid] = 1;
					ZahvatKills{killerfrac} ++;
					ZahvatScore[killerfrac] += rep;
					GiveGangRespect(killerfrac, rep);
					format(temp, sizeof temp, "[GANG NEWS] %s[%s] завалил %s[%s] (уважение +%i)", killername, GetGangName(killerfrac), playername, GetGangName(playerfrac), rep);
					SendZahvatMessage(BizzInfo[biz][bAttack], BizzInfo[biz][bDefend], GetFracColor(killerfrac), temp);
				}
			}
		}
		
		// Блэклист
		if(Bl::Info[playerid][Bl::onFrac][killerfrac]) {
			Bl::Info[playerid][Bl::isKilled] = true;
			Bl::Info[playerid][Bl::Finder] = INVALID_PLAYER_ID;
			Bl::Info[playerid][Bl::Kills][killerfrac] ++;
			if(Bl::Info[playerid][Bl::Kills][killerfrac] >= FracInfo[killerfrac][fBConf][bKILLS]) {
				Bl::Remove(playerid, killerfrac);
				format(temp, sizeof temp, "[BLACK LIST] %s откупился кровью и был вычеркнут из черного списка %s.", playername, FracInfo[killerfrac][fName]);
				sendToFamily(killerfrac, COLOR_AZTECAS, temp);
				format(temp, sizeof temp, "[BLACK LIST] Вы откупились кровью и были вычеркнуты из черного списка %s.", FracInfo[killerfrac][fName]);
				Send(playerid, COLOR_AZTECAS, temp);
			} else {
				Bl::Update(playerid, killerfrac);
				format(temp, sizeof temp, "[BLACK LIST] Заплати или терпи, %s помнит о тебе.", FracInfo[killerfrac][fName]);
				Send(playerid, COLOR_AZTECAS, temp);
				format(temp, sizeof temp, "[BLACK LIST] %s завалил %s. Крепись братва, в следующий раз терпила даст монету.", killername, playername);
				sendToFamily(killerfrac, COLOR_AZTECAS, temp);
			}
		}
	} else {
		if(!IsPlayerConnected(killerid) && killerid != INVALID_PLAYER_ID) {
			return Rac::Kick(playerid, "Invalid killerid");
		}
	}
	
	if(Pl::CheckpointStatus[playerid] > 4 && Pl::CheckpointStatus[playerid] < 11) {
		DestroyDynamicCP(checkpoints[playerid]);
		Pl::CheckpointStatus[playerid] = CHECKPOINT_NONE;
	}
	
	new caller = Mobile[playerid];
	if(Pl::isLogged(caller)) {
		Send(caller, COLOR_GRAD2, "* Эта линия отключина.");
		CellTime[caller] = 0;
		CellTime[playerid] = 0;
		Mobile[caller] = INVALID_PLAYER_ID;
		Mobile[playerid] = INVALID_PLAYER_ID;
		CellTime[playerid] = 0;
	}
	
	if(OnAir{playerid}) {
		OnAirMax--;
		OnAir{playerid} = false;
	}

	// *** Дальнобойщик ***
	if(acceptgruz{playerid} != 0) {
		acceptgruz{playerid} = 0;
		DestroyDynamicPickup(pickupd[playerid][0]);
		DestroyDynamicMapIcon(pickupd[playerid][1]);
	}
	
	Pl::CuffedTime[playerid] = 0;
	Pl::Info[playerid][pLocal] = 0;
	Pl::Info[playerid][pMaskOn] = false;
	
	DisablePlayerCheckpoint(playerid);
	DisablePlayerCheckpointEx(playerid, FIND_ICON);
	DestroyDynamicRaceCP(checkpointb[playerid]);
	
	if(GetPVarInt(playerid, "RouteID") != INVALID_ID) {
		SetPVarInt(playerid, "RouteID", INVALID_ID);
		SetPVarInt(playerid, "NextCP", 0);
	}

	MedicBill{playerid} = true;
	Pl::CarInt[playerid] = INVALID_VEHICLE_ID;
	SetPlayerColor(playerid, COLOR_GRAD2);
	
	SendDeathMessageToAdmin(killerid, playerid, reason);
	
	return 1;
}

public OnPlayerSpawn(playerid) {
	SetPlayerTeam(playerid, 1);
	if(!Pl::Info[playerid][pReg]) {
		Pl::setCamPos(playerid, Pl::Info[playerid][pCamPos], playerid+99);
		
	} else if(!Pl::isLogged(playerid)) {
    	Send(playerid, COLOR_LIGHTRED, "* Извините но этот сервере требует залогинится перед тем как войти в игру. (Kicked) **");
        Kick(playerid);
		
 	} else {
		SetPlayerSkin(playerid, Pl::Info[playerid][pChar]);
		if(SuspectKill{playerid}) {
			SuspectKill{playerid} = false;
			Jailed(playerid, Pl::Info[playerid][pJailTime], Pl::Info[playerid][pJailed]);
			SetCameraBehindPlayer(playerid);
		
		} else if(Pl::Info[playerid][pJailed] > 0) {
		    if(Pl::Info[playerid][pJailed] != 2) Jailed(playerid, Pl::Info[playerid][pJailTime]);
			else Jailed(playerid, Pl::Info[playerid][pJailTime], Pl::Info[playerid][pJailed]);
			Send(playerid, COLOR_LIGHTRED, "* Вы ещё не отсидели свой тюремный срок.");
			SetCameraBehindPlayer(playerid);
		
		} else if(IsValidHouse(Pl::Info[playerid][pHouseKey]) && !SpawnChange{playerid}) {
			EnterHouse(playerid, Pl::Info[playerid][pHouseKey]);
		} else {
			new fracid = Pl::FracID(playerid);
			if(IsValidFrac(fracid)) {
				Rac::SetPlayerInterior(playerid, FracInfo[fracid][fSpawn][fSpawnInt][0]);
				Rac::SetPlayerVirtualWorld(playerid, FracInfo[fracid][fSpawn][fSpawnInt][1]);
				Rac::SetPlayerPos(playerid,
					FracInfo[fracid][fSpawn][fSpawnPos][0],
					FracInfo[fracid][fSpawn][fSpawnPos][1],
					FracInfo[fracid][fSpawn][fSpawnPos][2]
				);
				Rac::SetPlayerFacingAngle(playerid, FracInfo[fracid][fSpawn][fSpawnPos][3]);
				SetCameraBehindPlayer(playerid);
			
			} else {
				new i = Pl::Info[playerid][pOrigin];
				if(1 <= i < sizeof SpawnInfo) {
					Rac::SetPlayerInterior(playerid, SpawnInfo[i][spInt]);
					Rac::SetPlayerVirtualWorld(playerid, SpawnInfo[i][spVirt]);
					Rac::SetPlayerPos(playerid, SpawnInfo[i][spX], SpawnInfo[i][spY], SpawnInfo[i][spZ]);
					Rac::SetPlayerFacingAngle(playerid, SpawnInfo[i][spA]);
					SetCameraBehindPlayer(playerid);
				} else {
					Rac::SetPlayerInterior(playerid, SpawnInfo[1][spInt]);
					Rac::SetPlayerVirtualWorld(playerid, SpawnInfo[1][spVirt]);
					Rac::SetPlayerPos(playerid, SpawnInfo[1][spX], SpawnInfo[1][spY], SpawnInfo[1][spZ]);
					Rac::SetPlayerFacingAngle(playerid, SpawnInfo[1][spA]);
					SetCameraBehindPlayer(playerid);
				}
			}
		}
		if(MedicBill{playerid} && !Pl::Info[playerid][pJailed] && !SuspectKill{playerid}) {
			MedicBill{playerid} = false;
			Pl::Info[playerid][pDeaths]++;
			new cut = Pl::Info[playerid][pLevel]*deathcost;
			GiveFracMoney(4, cut);
			Rac::GivePlayerMoney(playerid, -cut);
			Rac::SetPlayerHealth(playerid, 100.0);
			format(temp, sizeof(temp), "*Доктор: я взял с вас $%i за лечение, приятной игры.", cut);
			Send(playerid, COLOR_CYAN, temp);
		}
		
		Pl::SetFracColor(playerid);
		SetPlayerWeapons(playerid);
		PlayerFixRadio(playerid);
		SetPlayerFightingStyle(playerid, Pl::Info[playerid][pFightstyle]);
	}
	PreloadAnimlib(playerid);
	SetPlayerSkillLevel(playerid, 0, 0);
	SetPlayerSkillLevel(playerid, 6, 0);
	SetPlayerSkillLevel(playerid, 5, 0);
	SetPlayerSkillLevel(playerid, 4, 0);
	SetPlayerScore(playerid, Pl::Info[playerid][pLevel]);
    return 1;
}
//---------------------------------------------------------------------------
public OnPlayerEnterCheckpoint(playerid) {
	if(!Pl::isLogged(playerid)) return 0;
	
	new string[128];
	new Veh = GetPlayerVehicleID(playerid);
	if(TaxiCallTime[playerid] > 0 && TaxiAccepted[playerid] != INVALID_PLAYER_ID) {
		TaxiAccepted[playerid] = INVALID_PLAYER_ID;
		GameTextForPlayer(playerid, "~w~Reached destination", 5000, 1);
		TaxiCallTime[playerid] = 0;
		DisablePlayerCheckpoint(playerid);
	
	} else if(BusCallTime[playerid] > 0 && BusAccepted[playerid] != INVALID_PLAYER_ID) {
	    BusAccepted[playerid] = INVALID_PLAYER_ID;
		GameTextForPlayer(playerid, "~w~Reached destination", 5000, 1);
		BusCallTime[playerid] = 0;
		DestroyDynamicCP(checkpoints[playerid]);
	
	} else if(CP[playerid] == 1) {
	    if(IsPlayerInAnyVehicle(playerid)) {
		    new moneys, level;
			if(Pl::Info[playerid][pSkill][4] < 401) level = ++Pl::Info[playerid][pSkill][4];
			
			switch(level) {
				case 50 : Send(playerid, COLOR_YELLOW, "* Ваш скил угонщика машин увеличен до 2 уровня теперь вы можете продовать больше машин.");
				case 100 : Send(playerid, COLOR_YELLOW, "* Ваш скил угонщика машин увеличен до 3 уровня теперь вы можете продовать больше машин.");
				case 200 : Send(playerid, COLOR_YELLOW, "* Ваш скил угонщика машин увеличен до 4 уровня теперь вы можете продовать больше машин.");
				case 400 : Send(playerid, COLOR_YELLOW, "* Ваш скил угонщика машин увеличен до 5 уровня теперь вы можете продовать больше машин.");
			}
			
			if(0 <= level <= 50) {
			    new rand = random(sizeof(SELLCAR1)); moneys = SELLCAR1[rand];
			    format(string, sizeof(string), "Вы продали автомобиль за $%d, вы можете продать следующий через - 20 минут.", SELLCAR1[rand]);
				Send(playerid, COLOR_LIGHTBLUE, string);
				Pl::Info[playerid][pCarTime] = 1200;
				
			} else if(51 <= level <= 100) {
			    new rand = random(sizeof(SELLCAR2)); moneys = SELLCAR2[rand];
			    format(string, sizeof(string), "Вы продали автомобиль за $%d, вы можете продать следующий через - 18 минут.", SELLCAR2[rand]);
				Send(playerid, COLOR_LIGHTBLUE, string);
				Pl::Info[playerid][pCarTime] = 1080;
				
			} else if(101 <= level <= 200) {
			    new rand = random(sizeof(SELLCAR3)); moneys = SELLCAR3[rand];
			    format(string, sizeof(string), "Вы продали автомобиль за $%d, вы можете продать следующий через - 16 минут.", SELLCAR3[rand]);
				Send(playerid, COLOR_LIGHTBLUE, string);
				Pl::Info[playerid][pCarTime] = 960;
				
			} else if(201 <= level <= 400) {
			    new rand = random(sizeof(SELLCAR4)); moneys = SELLCAR4[rand];
			    format(string, sizeof(string), "Вы продали автомобиль за $%d, вы можете продать следующий через - 14 минут.", moneys);
				Send(playerid, COLOR_LIGHTBLUE, string);
				Pl::Info[playerid][pCarTime] = 840;
				
			} else if(level >= 401) {
				moneys = 6000;
				format(string, sizeof(string), "Вы продали автомобиль за $%d, вы можете продать следующий через - 12 минут.", moneys);
				Send(playerid, COLOR_LIGHTBLUE, string);
				Pl::Info[playerid][pCarTime] = 720;
			}
			format(string, sizeof(string), "~g~+$%i~n~~y~Sold the car", moneys);
			GameTextForPlayer(playerid, string, 7000, 1);
			CP[playerid] = 0;
			Rac::GivePlayerMoney(playerid, moneys);
			DestroyDynamicCP(checkpoints[playerid]);
			SetVehicleToRespawn(Veh);
	
		} else {
			GameTextForPlayer(playerid, "Not in a car", 5000, 1);
		}
	} else if(CP[playerid] == 5) {
		CP[playerid] = 0;
		DestroyDynamicCP(checkpoints[playerid]);
	    GameTextForPlayer(playerid, "~y~At the Missions Checkpoint", 2500, 1);
	
	} else {
		switch (Pl::CheckpointStatus[playerid]) {
			case CHECKPOINT_HOME : {
				PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
				DestroyDynamicCP(checkpoints[playerid]);
				Pl::CheckpointStatus[playerid] = CHECKPOINT_NONE;
				GameTextForPlayer(playerid, "~w~You are~n~~y~Home", 5000, 1);
		    }
		}
	}

	return 1;
}

public OnPlayerEnterDynamicCP(playerid, checkpointid) {
	if(!Pl::isLogged(playerid)) return 0;
	
	//new string[144];
	//new Veh = GetPlayerVehicleID(playerid);
	
	if(FactorySklad == checkpointid && OnJob[playerid] == 1) {
		if(IsPlayerAttachedObjectSlotUsed(playerid, 1)) {
			KG[playerid][0] =  0;
			KG[playerid][1] += 1;
			Gm::Info[Gm::FactoryProds] += 1;
			ApplyAnimation(playerid,"CARRY","putdwn",4.1,0,1,1,0,1);
			RemovePlayerAttachedObject(playerid,1);
			Send(playerid, COLOR_YELLOW, "Продукт доставлен на склад");
			UpdateFactory();
		}
	} else if(IsFactoryCP(playerid, 1)) {
		if(OnJob[playerid] == 1) {
			if(KG[playerid][0]) {
				StartJob[playerid] = 1;
				ClearAnimations(playerid);
				Rac::SetPlayerFacingAngle(playerid, 0.0);
				GetPlayerPos(playerid, posx, posy, posz);
				PlayerObject[playerid] = CreateObject(960, posx, posy+1, posz+0.3,0.00000000,0.00000000,0.00000000);
				ApplyAnimation(playerid,"INT_SHOP","shop_cashier",4.1,1,0,0,1,11000); // WEAPON_csawlo
				SetPlayerAttachedObject(playerid, 1, 18635, 14, 0.264531, 0.121060, 0.022172, 279.757507, 164.484985, 184.886245); // Даем молоток
				SetPlayerAttachedObject(playerid, 2, 18644, 13, 0.334366, 0.015833, -0.035214, 294.913085, 188.347946, 235.000213); // Даем отвертку
				SetTimerEx("OnPlayerEndJob", 8000+(random(3)*1000), false, "ii", playerid, 1);
			} else {
				Send(playerid, COLOR_GREY, "Возьмите металл раздаточного стола");
			}
		}
	} else if(IsFactoryCP(playerid, 2)) {
		if(OnJob[playerid] == 1) {
			if(KG[playerid][0]) {
				StartJob[playerid] = 1;
				ClearAnimations(playerid);
				Rac::SetPlayerFacingAngle(playerid, 180.0);
				GetPlayerPos(playerid, posx, posy, posz);
				PlayerObject[playerid] = CreateObject(1957, posx, posy-0.67, posz+0.01,0.00000000,0.00000000,0.00000000);
				ApplyAnimation(playerid,"INT_SHOP","shop_cashier",4.1,1,0,0,1,11000); // WEAPON_csawlo
				SetPlayerAttachedObject(playerid, 1, 18635, 14, 0.264531, 0.121060, 0.022172, 279.757507, 164.484985, 184.886245); // Даем молоток
				SetPlayerAttachedObject(playerid, 2, 18644, 13, 0.334366, 0.015833, -0.035214, 294.913085, 188.347946, 235.000213); // Даем отвертку
				SetTimerEx("OnPlayerEndJob", 8000+(random(3)*1000), false, "ii", playerid, 1);
			} else {
				Send(playerid, COLOR_GREY, "Возьмите металл раздаточного стола");
			}
		}
	}
	
	else
	if(TaxiCallTime[playerid] > 0 && TaxiAccepted[playerid] != INVALID_PLAYER_ID) {
	    TaxiAccepted[playerid] = INVALID_PLAYER_ID;
		TaxiCallTime[playerid] = 0;
		GameTextForPlayer(playerid, "~w~Reached destination", 5000, 1);
		DestroyDynamicCP(checkpoints[playerid]);
	
	} else if(BusCallTime[playerid] > 0 && BusAccepted[playerid] != INVALID_PLAYER_ID) {
	    BusAccepted[playerid] =INVALID_PLAYER_ID;
		GameTextForPlayer(playerid, "~w~Reached destination", 5000, 1);
		BusCallTime[playerid] = 0;
		DestroyDynamicCP(checkpoints[playerid]);
	
	} else {
		switch(Pl::CheckpointStatus[playerid]) {
			case CHECKPOINT_HOME: {
				PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
				DestroyDynamicCP(checkpoints[playerid]);
				Pl::CheckpointStatus[playerid] = CHECKPOINT_NONE;
				GameTextForPlayer(playerid, "~w~You are~n~~y~Home", 5000, 1);
		    }
		}
	}
	return 1;
}

public OnPlayerEnterDynamicRaceCP(playerid, checkpointid) {
	if(!Pl::isLogged(playerid)) return 0;
	
	new string[144];
	
	switch(GetPlayerState(playerid)) {
		case PLAYER_STATE_DRIVER : {
			new Veh = GetPlayerVehicleID(playerid);
			switch(Pl::Info[playerid][pJob]) {
				case JOB_BUSMAN : {
					if(checkpointb[playerid] == checkpointid && GetPVarInt(playerid, "RouteID") != INVALID_ID) {
						if(IsABusCar(Veh)) {
							new next = GetPVarInt(playerid, "NextCP");
							new route = GetPVarInt(playerid, "RouteID");

							if(++next < BusRouteCount[route]) {
								DestroyDynamicRaceCP(checkpointb[playerid]);
								if(strcmp(BusRoute[route][next-1][stopName], "NULL", false) != 0) {
									SetVehicleVelocity(Veh, 0.0, 0.0, 0.0);
									PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
									format(string, sizeof(string),  "** %s, следующия остановка - %s.", BusRoute[route][next-1][stopName], BusRoute[route][BusRoute[route][next - 1][stopNext]][stopName]);
									ProxDetector(30.0, playerid, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
								}
								if((next + 1) >= BusRouteCount[route]) {
									checkpointb[playerid] = CreateDynamicRaceCP(
										1,
										BusRoute[route][next][stopX],
										BusRoute[route][next][stopY],
										BusRoute[route][next][stopZ],
										0, 0, 0, 4.0, 0, 0, playerid, 99999.0
									);
								} else {
									if(BusRoute[route][next][stopNext] != 0) {
										checkpointb[playerid] = CreateDynamicRaceCP(
											1,
											BusRoute[route][next][stopX],
											BusRoute[route][next][stopY],
											BusRoute[route][next][stopZ],
											0, 0, 0, 4.0, 0, 0, playerid, 99999.0
										);
									} else {
										checkpointb[playerid] = CreateDynamicRaceCP(
											0,
											BusRoute[route][next][stopX],
											BusRoute[route][next][stopY],
											BusRoute[route][next][stopZ],
											BusRoute[route][next + 1][stopX],
											BusRoute[route][next + 1][stopY],
											BusRoute[route][next + 1][stopZ],
											4.0, 0, 0, playerid, 99999.0
										);
									}
								}
								SetPVarInt(playerid, "NextCP", next);
							} else {
								BusDrivers --;
								TransportDuty[playerid] = 0;
								TransportValue[playerid] = 0;
								DestroyDynamicRaceCP(checkpointb[playerid]);
								DestroyDynamic3DTextLabel(AttachText[Veh]);
								SetVehicleVelocity(Veh, 0.0, 0.0, 0.0);
								PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
								format(string, sizeof(string),  "** %s, конечная остановка.", BusRoute[route][next-1][stopName]);
								ProxDetector(30.0, playerid, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
								
								new Float:health;
								GetVehicleHealth(Veh, health);
								new cost = floatround((health*5.0));
								format(string, sizeof(string),  "* Маршрут закончен! Вы заработали $%i", cost);
								Send(playerid, COLOR_YELLOW, string);
								format(string, sizeof(string),  "~g~+$%i", cost);
								GameTextForPlayer(playerid, string, 7000, 1);
								Rac::GivePlayerMoney(playerid, cost);

								SetPVarInt(playerid, "RouteID", INVALID_ID);
								DeletePVar(playerid, "NextCP");
							
							}
						}
					}
				}
			}
		}
	}
	return 1;
}

public OnPlayerEnterDynamicArea(playerid, areaid) {
	if(!Pl::isLogged(playerid)) return 0;
	
	new fracid = Pl::FracID(playerid);
	if(areaid == Area::ASH) {
		AshQueue(playerid, 0);
	}
	
	else if(areaid == Area::jailField) {
	}
	
	else if(IsValidBiz(GangOnBattle[fracid])) {
		if(BizzInfo[GangOnBattle[fracid]][bZahvatArea] == areaid) {
			Iter::Add(GangSolder[fracid], playerid);
			Pl::SetFracColor(playerid);
		}
	}
	
	else {
		for(new i; i < TOTAL_ANTIDM_ZONES; i++) {
			if(AntiDmInfo[i][e_AntiDmZone] == areaid) {
				InAntiDmZone{playerid} = true;
				return 1;
			}
		}
	}
	return 1;
}

public OnPlayerLeaveDynamicArea(playerid, areaid) {
	if(!Pl::isLogged(playerid)) return 0;
	
	new fracid = Pl::FracID(playerid);
	
	if(areaid == Area::ASH) {
		AshQueue(playerid, 1);
	}
	
	else if(areaid == Area::Shamal) {
		Pl::CarInt[playerid] = INVALID_PLAYER_ID;
	}
	
	else if(areaid == Area::jailField) {
		if(Pl::Info[playerid][pJailed] == 1) {
			format(temp, sizeof temp, "* {FF6347}%s[ID: %d] {CDFFFF}подозрение на побег из тюрьмы. {C2A2DA}(оставшийся срок: %d секунд).", GetName(playerid), playerid, Pl::Info[playerid][pJailTime]);
			SendToAdmin(COLOR_CHEATS, temp, 1, 1);
		}	
	}
	
	else if(IsValidBiz(GangOnBattle[fracid])) {
		new biz = GangOnBattle[fracid];
		if(BizzInfo[biz][bZahvatArea] == areaid) {
			Iter::Remove(GangSolder[fracid], playerid);
			if(ZahvatDeath[playerid] == 0) {
				if(!Iter::Count(GangSolder[fracid]) && BizzInfo[biz][bAttack] == fracid) {
					new attack = BizzInfo[biz][bAttack];
					new defend = BizzInfo[biz][bDefend];
					if(fracid == defend && Iter::Count(GangSolder[attack]) > 0) {
						ZahvatScore[attack] ++;
						BizzInfo[biz][bFrac] = attack;
						GiveGangRespect(attack, ZahvatScore[attack]);
						Gz::StopFlashForAll(BizzInfo[biz][bZone]);
						Gz::HideForAll(BizzInfo[biz][bZone]);
						Gz::ShowForAll(BizzInfo[biz][bZone], GetFracColor(BizzInfo[biz][bFrac]));
						format(temp, sizeof(temp), "~r~%s~g~~n~RESPECT~r~+%d", GetGangName(attack), ZahvatScore[attack]);
						GameTextForGangs(temp, 6000, 1);
						format(temp, sizeof temp, "[GANG NEWS] %s[%d] захватили территорию бизнеса %s, %s[%d] повержены!",
						GetGangName(attack), ZahvatScore[attack], BizzInfo[biz][bDescription], GetGangName(defend), ZahvatScore[defend]);
						sendToTeam(GetFracColor(attack), temp, Gangs);
					}
					
					else {
						ZahvatScore[defend] ++;
						GiveGangRespect(defend, ZahvatScore[defend]);
						Gz::StopFlashForAll(BizzInfo[biz][bZone]);
						Gz::HideForAll(BizzInfo[biz][bZone]);
						Gz::ShowForAll(BizzInfo[biz][bZone], GetFracColor(BizzInfo[biz][bFrac]));
						format(temp, sizeof(temp), "~r~%s~g~~n~RESPECT~r~+%d", GetGangName(defend), ZahvatScore[defend]);
						GameTextForGangs(temp, 6000, 1);
						format(temp, sizeof(temp), "[GANG NEWS] %s[%d] удержала территорию своего бизнеса %s, %s[%d] повержены!",
						GetGangName(defend), ZahvatScore[defend], BizzInfo[biz][bDescription], GetGangName(attack), ZahvatScore[attack]);
						sendToTeam(GetFracColor(defend), temp, Gangs);
					}
			
					ZahvatKills{attack} = ZahvatKills{defend} = 0;
					SolderOnAFK{attack} = SolderOnAFK{defend} = 0;
					ZahvatScore[defend] = ZahvatScore[defend] = 0;
					
					Iter::Clear(GangSolder[attack]);
					Iter::Clear(GangSolder[defend]);
					GangOnBattle[attack] = GangOnBattle[defend] = INVALID_BIZ_ID;
					BizzInfo[biz][bAttack] = BizzInfo[biz][bDefend] = 0;
					BizzInfo[biz][bOnBattle] = 0;
					DisableZahvatMapIcon(attack, defend);
					Td::HideForAll(BizzInfo[biz][bZahvatTD]);
					Td::Destroy(BizzInfo[biz][bZahvatTD]);
					DestroyDynamicArea(BizzInfo[biz][bZahvatArea]);
					KillTimer(BizzInfo[biz][bZahvatTimer]);
					UpdateBizz(biz);
					UpdateGangInfo();
				}
			} else {
				ZahvatDeath[playerid] = 0;
			}
		}
	}
	
	else {
		for(new i; i < TOTAL_ANTIDM_ZONES; i++) {
			if(AntiDmInfo[i][e_AntiDmZone] == areaid) {
				if(AntiDmInfo[i][e_AntiDmZoneId] == 11 && OnJob[playerid] == 1) {
					if(IsPlayerAttachedObjectSlotUsed(playerid,1)) RemovePlayerAttachedObject(playerid,1);
					if(IsPlayerAttachedObjectSlotUsed(playerid,2)) RemovePlayerAttachedObject(playerid,2);
					if(PlayerObject[playerid] != INVALID_OBJECT_ID) DestroyObject(PlayerObject[playerid]);
					KG[playerid][0] = 0;
					KG[playerid][1] = 0;
					OnJob[playerid] = 0;
					StartJob[playerid] = 0;
					SetPlayerSkin(playerid, Pl::Info[playerid][pChar]);
					Send(playerid, -1, "Вы покинули завод, вы ничего не заработали.");
				}
				InAntiDmZone{playerid} = false;
				return 1;
			}
		}
	}	
	return 1;
}

stock AshQueue(playerid, reason) {
	switch(reason) {
		case 0 : {
			if(!Iter::Contains(AshQueue, playerid)) {
				if(!TakingLesson{playerid}) {
					Iter::Add(AshQueue, playerid);
					GetPlayerName(playerid, plname, 24);
					scf(string_ah, temp, "%i.%s\n", Iter::Count(AshQueue), plname);
					UpdateDynamic3DTextLabelText(ah_text, 0x42aaffFF, string_ah);
					Send(playerid, COLOR_WHITE,"* Вы заняли место в очереди.");
				}
			}
		}
		
		case 1 : {
			if(Iter::Contains(AshQueue, playerid)) {
				new pddp;
				Iter::Remove(AshQueue, playerid);
				format(string_ah,sizeof(string_ah),">> Очередь допущенных к практической части экзамена: <<\n");
				foreach(new i : AshQueue) {
					pddp++;
					GetPlayerName(i, plname, 24);
					scf(string_ah, temp, "%i.%s\n", pddp, plname);
				}
				UpdateDynamic3DTextLabelText(ah_text, 0x42aaffFF, string_ah);
				Send(playerid, COLOR_WHITE, "* Вы покинули очередь.");
			}
		}
	}
	return 1;
}

public: OnPlayerGatePickUp(playerid, gateid, pickupid) {
	foreach(new i : GateModePickup) {
		if(GateData[i][GateID] == gateid) {
			switch(GateData[i][GateAttach]) {
				case GATE_ATTACH_FRAC : {
					new frcaid = Pl::FracID(playerid);
					if(GateData[i][GateAllowed][frcaid] == 1) {
						if(GateOpen(gateid)) {
							PlayerPlaySound(playerid, 1058, 0, 0, 0);
							SetTimerEx("GateClose", 1000 * 7, false, "i", gateid);
						}
					} else {
						Send(playerid, COLOR_GREY, "* Для вас проезд закрыт!"); 
					}
				}
				
				case GATE_ATTACH_HOUSE : {
					if(Pl::Info[playerid][pHouseKey] == GateData[i][GateAllowed][0]) {
						if(GateOpen(gateid)) {
							PlayerPlaySound(playerid, 1058, 0, 0, 0);
							SetTimerEx("GateClose", 1000 * 7, false, "i", gateid);
						}
					} else {
						Send(playerid, COLOR_GREY, "* Для вас проезд закрыт!"); 
					}
				}
				
				case GATE_ATTACH_JOB : {
					if(Pl::Info[playerid][pJob] == GateData[i][GateAllowed][0]) {
						if(GateOpen(gateid)) {
							PlayerPlaySound(playerid, 1058, 0, 0, 0);
							SetTimerEx("GateClose", 1000 * 7, false, "i", gateid);
						}
					} else {
						Send(playerid, COLOR_GREY, "* Для вас проезд закрыт!"); 
					}
				}
				
				default : {
					if(GateOpen(gateid)) {
						PlayerPlaySound(playerid, 1058, 0, 0, 0);
						SetTimerEx("GateClose", 1000 * 7, false, "i", gateid);
					}
				}
			}
			return 1;
		}
	}
	return 1;
}

public OnPlayerPickUpDynamicPickup(playerid, pickupid) {
	if(PickupInfo[playerid][pOld] == pickupid) {
		return 1;
	} else if(PickupInfo[playerid][pDelay]) {
		PickupInfo[playerid][pOld] = pickupid;
		return GetPlayerPos(playerid, PickupInfo[playerid][pOldPos][0], PickupInfo[playerid][pOldPos][1], PickupInfo[playerid][pOldPos][2]);
	} else {
		PickupInfo[playerid][pOld] = pickupid;
		GetPlayerPos(playerid, PickupInfo[playerid][pOldPos][0], PickupInfo[playerid][pOldPos][1], PickupInfo[playerid][pOldPos][2]);
	}
	
	if(GetPlayerDistanceFromPickup(playerid, pickupid) > 18.0) {
		return Rac::Kick(playerid, "SendPic");
	}

	switch(GetPlayerState(playerid)) {
		case PLAYER_STATE_ONFOOT : {
			if(pickupid == helpp[0] || pickupid == helpp[1] || pickupid == helpp[2]) {
				ShowDialog(playerid, D_REF, DIALOG_STYLE_LIST, "{33CCFF}Справка.", "dialog/ref/main.txt", "SELECT", "CANCEL");
			}
			
			else if(pickupid == healash || pickupid == healcnn || pickupid == healfbi) {
				Rac::SetPlayerHealth(playerid, 100.0);
			}
			
			else if(pickupid == Parashut) {
				if(!Rac::CheckPlayerWeapon(playerid, 46)) {
					Rac::GivePlayerWeapon(playerid, 46, 1);
				}		
			}
	
			else if(pickupid == saveTuning) {
				if(!IsValidHouse(Pl::Info[playerid][pHouseKey])) return Send(playerid, COLOR_GREY, "* У Вас нет дома!");
				if(HouseInfo[Pl::Info[playerid][pHouseKey]][hvModel] == 0) return Send(playerid, COLOR_GREY, "* У Вас нет домашней машины!");
				SPD(playerid, D_TUNING, DIALOG_STYLE_LIST, ""#__SERVER_PREFIX""#__SERVER_NAME_LC": Tuning", "Зарегистрировать тюнинг\nУдалить тюнинг", "SELECT", "CANCEL");
			}

			else if(pickupid == givepasport) {
				if(!Pl::Info[playerid][pPasport][0]) {
					SPD(playerid, D_GIVE_PASS, 1, "{ffcf00}Паспортный стол", "Укажите ваш возраст", "Ввод", "Отмена");
				} else {
					Send(playerid, COLOR_GREY, "* У Вас уже есть паспорт!");
				}
			}
	
			else if(pickupid == ammozakona[0]) {
				if(!IsACop(playerid)) return Send(playerid,COLOR_GREY,"* Вы не законник!");
				if(Pl::Info[playerid][pLic][3] <= 0) return Send(playerid,COLOR_WHITE,"Продавец: Я не могу продать вам оружие без лицензии!");
				ShowMenuForPlayer(Ammu2Menu,playerid);
				Rac::TogglePlayerControllable(playerid, 0);
			}
	
			else if(pickupid == ammozakona[1]) {
				if(Pl::FracID(playerid) != 2) return Send(playerid,COLOR_GREY,"* Для вас нет комплекта одежды!");
				if(Pl::Info[playerid][pRank] < 3) return Send(playerid,COLOR_GREY,"* Только с 3-го ранга!");
				SPD(playerid, D_MASK+1, DIALOG_STYLE_LIST, "Скины скрытности","Японец\nКоронос\nБаллас\nГражданский\nВернуть свой","ВЫБОР","ОТМЕНА");
			}
	
			else if(pickupid == ammozakona[2]) {
				if(Pl::FracID(playerid) != 3) return Send(playerid,COLOR_GREY,"* Для вас нет комплекта одежды!");
				Container::At(Pl::FracID(playerid), Container::First, SelectCharPlace[playerid], ChosenSkin[playerid]);
				SetPlayerSkin(playerid, ChosenSkin[playerid]);
				ShowMenuForPlayer(ClothesMenu, playerid);
				Rac::TogglePlayerControllable(playerid, 0);
			}
	
			else if(pickupid == ammozakona[3]) {
				if(!IsACop(playerid)) return Send(playerid,COLOR_GREY,"* Вы не законник!");
				SPD(playerid, D_ARMOUR, DIALOG_STYLE_MSGBOX, "Одеть бронежилет?", "Вам приедеться заплатить $500", "ОДЕТЬ","ОТМЕНА");
			}
	
			else if(buy[0] <= pickupid <= buy[1]) {
				Rac::TogglePlayerControllable(playerid, false);
				ShowMenuForPlayer(BuyMenu, playerid);
			}
	
			else if(pickupid == proba) {
				ShowCantina(playerid);
			}
	
			else if(pickupid == fire_ext) {
				if(Pl::FracID(playerid) == TEAM_GOV) {
					if(Rac::GetPlayerAmmo(playerid, 42) == 0) {
						Rac::GivePlayerWeapon(playerid, 42, 500);
					}
				}
			}
	
			else if(pickupid == mak[0] || pickupid == mak[1]) {
				Rac::TogglePlayerControllable(playerid,0);
				ShowMenuForPlayer(BurgerMenu, playerid);
			}
	
			else if(pickupid == boj) {
				SPD(playerid, 2222, DIALOG_STYLE_LIST,"Выберите стиль боя. Стоимость 100.000",
				"БОКС\nКУНГ-ФУ\nСАМБО\nУЛИЧНЫЙ","Выбрать","Отмена");
			}
	
			else if(pickupid == Piza) {
				Rac::TogglePlayerControllable(playerid,0);
				ShowMenuForPlayer(PizaMenu, playerid);
			}
	
			else if(pickupid == weapon1 || pickupid == weapon2 || pickupid == weapon3 || pickupid == weapon4) {
				if(Pl::Info[playerid][pLic][3] <= 0) return Send(playerid,COLOR_WHITE,"Продавец: Я не могу продать вам оружие без лицензии!");
				ShowMenuForPlayer(Ammu1Menu,playerid);
				Rac::TogglePlayerControllable(playerid, 0);
			}
	
			else if(pickupid == testpdd) {
				if(Pl::Info[playerid][pLic][0]) return Send(playerid,COLOR_GREY,"* У Вас уже есть права!");
				if(Pl::Info[playerid][pTest] == 999) return Send(playerid,COLOR_GREY,"* Вы уже сдали теорию!");
				SetPVarInt(playerid, "SelectedItem", 1);
				return ShowDialog(playerid, D_PDDTEST, 1, ""#__SERVER_PREFIX""#__SERVER_NAME_LC": TEST PDD", "dialog/pddtest/pdd_test_1.txt", "Ответ", "Отмена");
			}
	
			else if(pickupid == prolaps[0] || pickupid == prolaps[1]) {
				if(GetPlayerInterior(playerid) == 3) {
					Rac::SetPlayerPos(playerid, 215.3485, -133.1142, 1003.5078);
					Rac::SetPlayerFacingAngle(playerid, 92.2598);
					SetPlayerCameraPos(playerid, 210.4674, -131.8238, 1004.2631);
					SetPlayerCameraLookAt(playerid, 214.3328, -132.8457, 1004.1403);
					Rac::SetPlayerVirtualWorld(playerid, ((99 * 7) + playerid));
				} else {
					Rac::SetPlayerPos(playerid, 224.6642, -11.5788, 1002.2109);
					Rac::SetPlayerFacingAngle(playerid, 359.9657);
					SetPlayerCameraPos(playerid, 222.6168, -6.3763, 1002.4910);
					SetPlayerCameraLookAt(playerid, 224.0792, -10.0924, 1002.7197);
					Rac::SetPlayerVirtualWorld(playerid, ((99 * 7) + playerid));
				}
				Container::At(Pl::FracID(playerid), Container::First, SelectCharPlace[playerid], ChosenSkin[playerid]);
				SetPlayerSkin(playerid, ChosenSkin[playerid]);
				ShowMenuForPlayer(ClothesMenu, playerid);
				Rac::TogglePlayerControllable(playerid, 0);
			}
	
			else if(pickupid == Bank[0]) {
				ShowDialog(playerid, D_BANK, DIALOG_STYLE_LIST, ""#__SERVER_PREFIX""#__SERVER_NAME_LC": BANK", "dialog/bankmenu.txt", "SELECT","CENCEL");
			}
	
			else if(pickupid == Bank[1]) {
				ShowFracBank(playerid);
			}
	
			else if(FactoryPickup[0] <= pickupid <= FactoryPickup[1]) {
				if(OnJob[playerid] == 1 && !KG[playerid][0]) {
					if(Gm::Info[Gm::FactoryMetal] > 1 && Gm::Info[Gm::FactoryFuel] > 5) {
						KG[playerid][0] = 1;
						Gm::Info[Gm::FactoryMetal] -= 1;
						Gm::Info[Gm::FactoryFuel] -= 5;
						GameTextForPlayer(playerid, "~b~ +1kg", 2000, 1);
					} else {
						GameTextForPlayer(playerid, "~r~no metall or benzin", 2000, 1);
					}
				}
			}
			
			else if(pickupid == FactoryPickup[2]) {
				if(OnJob[playerid] == 1) {
					SPD(playerid, D_FACTORY_JOB+1, 0, "{ffcf00}Производственный цех"," Вы действительно желаете закончить рабочий день?" ,"Да", "Нет");
				} else {
					SPD(playerid, D_FACTORY_JOB, 0, "{ffcf00}Производственный цех"," Вы действительно желаете начать рабочий день?" ,"Да", "Нет");
				}
			}
			
			else if(ATMp[0] <= pickupid <= ATMp[1]) {
				ShowDialog(playerid, D_ATM, DIALOG_STYLE_LIST, ""#__SERVER_PREFIX""#__SERVER_NAME_C" ATM.", "dialog/atmmenu.txt", "SELECT","CENCEL");
			}
			
			else if(pickupid == HGaragePickup[0]) {
				/*new Float:x, Float:y;
				new local = Pl::Info[playerid][pLocal] - OFFSET_HOUSE;
				GetXYInFrontOfPoint(x, y, HouseInfo[local][hgIntPos][3], 1.5);
				Rac::SetPlayerPos(playerid, HouseInfo[local][hgIntPos][0] + x, HouseInfo[local][hgIntPos][1] + y, HouseInfo[local][hgIntPos][2]);
				SetPlayerFacingAngle(playerid, HouseInfo[local][hgIntPos][3]);
				Rac::SetPlayerInterior(playerid, HouseInfo[local][hInt]);
				Rac::SetPlayerVirtualWorld(playerid, HouseInfo[local][hVirtual]);
				SetCameraBehindPlayer(playerid);*/
				
				EnterHouse(playerid, Pl::Info[playerid][pLocal] - OFFSET_HOUSE);
			}
			
			else if(pickupid == HGaragePickup[1]) {
				/*new Float:x, Float:y;
				new local = Pl::Info[playerid][pLocal] - OFFSET_HOUSE;
				if(HouseInfo[local][hgStreetPos][3] <= 0.0) return Send(playerid, COLOR_GREY, "* Используйте команду /editgarstreet для установки выезда из гаража");
				GetXYInFrontOfPoint(x, y, HouseInfo[local][hgStreetPos][3], 1.5);
				Rac::SetPlayerPos(playerid, HouseInfo[local][hgStreetPos][0] + x, HouseInfo[local][hgStreetPos][1] + y, HouseInfo[local][hgStreetPos][2]);
				SetPlayerFacingAngle(playerid, HouseInfo[local][hgStreetPos][3]);
				Rac::SetPlayerInterior(playerid, 0);
				Rac::SetPlayerVirtualWorld(playerid, 0);
				SetCameraBehindPlayer(playerid);
				Pl::Info[playerid][pLocal] = 0;*/
			}
			
			else if(pickupid == EstateAgency) {
				ShowDialog(playerid, D_NONE, DIALOG_STYLE_MSGBOX, "Estate Agency", "dialog/estate-agency-help.txt", "ENTER", "");
			}
			
			else {
				if(!PickupHndlr::Portal(playerid, pickupid)) {
					if(!PickupHndlr::Job(playerid, pickupid)) {
						if(!PickupHndlr::Bizz(playerid, pickupid)) {
							if(!PickupHndlr::Houses(playerid, pickupid)) {}
						}
					}
				}
			}
		}
		
		case PLAYER_STATE_DRIVER : {
			if(GarageParkPickup[0] <= pickupid <= GarageParkPickup[3]) {
				new veh = GetPlayerVehicleID(playerid);
				new slot = GetIdxExtraVehicleFromVehicleID(playerid, veh);
				if(slot == -1) return Send(playerid, COLOR_GREY, "* Этот транспорт нельзя сдать в гараж!");
				Veh::Destroy(ExtraVehicles[playerid][slot][evID2]);
				ExtraVehicles[playerid][slot][evPark] = PARK_GARAGE;
				AddExtraVehicleToGarage(playerid, slot);
				UpdateExtraVehicle(playerid, slot);
				Send(playerid, COLOR_GREY, "* Транспорт был сдан в гараж!");
			}
			
			else if(pickupid == barn[0]) {
				if(Pl::FracID(playerid) == TEAM_FARMERS) {
					new vehid = GetPlayerVehicleID(playerid);
					if(GetVehicleModel(vehid) == 532) {
						SPD(playerid, D_BARN, 0, "Амбар", "Разгрузить мак?", "OK", "CANCEL");
					} else {
						SPD(playerid, D_BARN+2, 1, "Амбар", "Взять мак:", "OK", "CANCEL");
					}
				}
			}
			
			else if(pickupid == barn[1]) {
				if(Pl::FracID(playerid) == TEAM_FARMERS) {
					SPD(playerid, D_BARN+1, 0, "Притон", "Продать мак?", "OK", "CANCEL");
				}
			}
			
			else if(pickupd[playerid][0] == pickupid) {
				if(acceptgruz{playerid}) {
					new veh = GetPlayerVehicleID(playerid);
					if(IsATruckCar(veh) && Rac::GetPlayerState(playerid) == 2) {
						new trailer = GetVehicleTrailer(veh);
						if(trailer) {
							acceptgruz{playerid} = 0;
							DestroyDynamicPickup(pickupd[playerid][0]);
							DestroyDynamicMapIcon(pickupd[playerid][1]);
							
							new rnd = (1000 + (random(7)*1000));
							Rac::GivePlayerMoney(playerid, rnd);
							SetVehicleToRespawn(trailer);
							
							format(temp, sizeof(temp),"* Груз доставлен. Заработано %d$", rnd);
							Send(playerid,COLOR_YELLOW, temp);
							format(temp, sizeof(temp),"~g~+$%i", rnd);
							GameTextForPlayer(playerid, temp, 5000, 1);
						} else {
							DestroyDynamicPickup(pickupd[playerid][0]);
							DestroyDynamicMapIcon(pickupd[playerid][1]);
							Send(playerid,COLOR_YELLOW, "* Вы приехали без груза!");
						}
					}
				} else {
					acceptgruz{playerid} = 0;
					DestroyDynamicPickup(pickupd[playerid][0]);
					DestroyDynamicMapIcon(pickupd[playerid][1]);
				}
			}
			
			else {
				if(!PickupHndlr::Gas(playerid, pickupid)) {
					if(!PickupHndlr::Portal(playerid, pickupid)) {}
				}
			}
		}
	}
	
	return 1;
}


stock PickupHndlr::Gas(playerid, pickupid) {
	foreach(new i : Refills) {
		if(pickupid == RefillInfo[i][brPickup]) {
			new veh = GetPlayerVehicleID(playerid);
			switch(GetVehicleType(GetVehicleModel(veh))) {
				case VEHICLE_TYPE_BIKE, VEHICLE_TYPE_AUTO : {
					SetPVarInt(playerid, "SelectGas", i);
					SetVehicleVelocity(veh, 0, 0, 0);
					ShowRefillDialog(playerid, GetIndexFromBizID(RefillInfo[i][brBizID]));
				}
				default : Send(playerid,COLOR_GREY,"* Заправка непредназначена для вашего транспорта!");
			}
			return 1;
		}
	}
	return 0;
}

stock PickupHndlr::Portal(playerid, pickupid) {
	foreach(new i : Portal) {
		if(Ptl::Info[i][Ptl::Pickup][0] == pickupid) {
			if(EditMode{playerid}) {
				SetPVarInt(playerid, "selectTeleport", i);
				format(dialog, sizeof dialog, "Telepot №%i | | Пикап №1", Ptl::Info[i][Ptl::Id]);
				SPD(playerid,TP_EDIT,2,dialog,"Перый пикап\nВторой пикап\nОткрыть/Закрыть\nУдалить","Выбор","Выход");
				return 1;
			}
			
			if(Ptl::Info[i][Ptl::Portal2][0] != 0.0) {
				if(!Ptl::Info[i][Ptl::Allowed][Pl::FracID(playerid)]) {
					switch(CallLocalFunction("onPlayerPortal", "iii", playerid, Ptl::Info[i][Ptl::Id], 1)) {
						case -1 : {
							return 1;
						}
						case 0 : {
							return GameTextForPlayer(playerid, "~r~Closed", 1000, 1);
						}
					}
				}
				
				new Float:x,Float:y;
				if(Ptl::Info[i][Ptl::Type][1] != 14) {
					GetXYInFrontOfPoint(x, y, Ptl::Info[i][Ptl::Portal2][3], 1.5);
					Rac::SetPlayerPos(playerid,Ptl::Info[i][Ptl::Portal2][0]+x,Ptl::Info[i][Ptl::Portal2][1]+y,Ptl::Info[i][Ptl::Portal2][2]);
					Rac::SetPlayerFacingAngle(playerid, Ptl::Info[i][Ptl::Portal2][3]);
				} else {
					new veh = GetPlayerVehicleID(playerid);
					GetXYInFrontOfPoint(x, y, Ptl::Info[i][Ptl::Portal2][3], vehicleSize(veh)+2.0);
					Rac::SetVehiclePos(veh, Ptl::Info[i][Ptl::Portal2][0]+x,Ptl::Info[i][Ptl::Portal2][1]+y,Ptl::Info[i][Ptl::Portal2][2]);
					SetVehicleZAngle(veh, Ptl::Info[i][Ptl::Portal2][3]);
					LinkVehicleToInterior(veh, Ptl::Info[i][Ptl::Inter][1]);
					SetVehicleVirtualWorld(veh, Ptl::Info[i][Ptl::World][1]);
				}
				Rac::SetPlayerInterior(playerid, Ptl::Info[i][Ptl::Inter][1]);
				Rac::SetPlayerVirtualWorld(playerid, Ptl::Info[i][Ptl::World][1]);
				SetCameraBehindPlayer(playerid);
				
				return 1;
			}
		}
		
		else if(Ptl::Info[i][Ptl::Pickup][1] == pickupid) {
			if(EditMode{playerid}) {
				SetPVarInt(playerid, "selectTeleport", i);
				format(dialog, sizeof dialog, "Telepot №%i | Пикап №2 ", Ptl::Info[i][Ptl::Id]);
				SPD(playerid,TP_EDIT,2,dialog,"Перый пикап\nВторой пикап\nОткрыть/Закрыть\nУдалить","Выбор","Выход");
				return 1;
			}
			
			if(!Ptl::Info[i][Ptl::Allowed][Pl::FracID(playerid)]) {
				switch(CallLocalFunction("onPlayerPortal", "iii", playerid, Ptl::Info[i][Ptl::Id], 2)) {
					case -1 : {
						return 1;
					}
					case 0 : {
						return GameTextForPlayer(playerid, "~r~Closed", 1000, 1);
					}
				}
			}
				
			new Float:x,Float:y;
			if(Ptl::Info[i][Ptl::Type][0] != 14) {
				GetXYInFrontOfPoint(x, y, Ptl::Info[i][Ptl::Portal1][3], 1.5);
				Rac::SetPlayerPos(playerid,Ptl::Info[i][Ptl::Portal1][0]+x,Ptl::Info[i][Ptl::Portal1][1]+y,Ptl::Info[i][Ptl::Portal1][2]);
				Rac::SetPlayerFacingAngle(playerid, Ptl::Info[i][Ptl::Portal1][3]);
			} else {
				new veh = GetPlayerVehicleID(playerid);
				GetXYInFrontOfPoint(x, y, Ptl::Info[i][Ptl::Portal1][3], vehicleSize(veh)+2.0);
				Rac::SetVehiclePos(veh, Ptl::Info[i][Ptl::Portal1][0]+x,Ptl::Info[i][Ptl::Portal1][1]+y,Ptl::Info[i][Ptl::Portal1][2]);
				SetVehicleZAngle(veh, Ptl::Info[i][Ptl::Portal1][3]);
				LinkVehicleToInterior(veh, Ptl::Info[i][Ptl::Inter][0]);
				SetVehicleVirtualWorld(veh, Ptl::Info[i][Ptl::World][0]);
			}
			Rac::SetPlayerInterior(playerid, Ptl::Info[i][Ptl::Inter][0]);
			Rac::SetPlayerVirtualWorld(playerid, Ptl::Info[i][Ptl::World][0]);
			SetCameraBehindPlayer(playerid);
			
			return 1;
		}
	}
	
	return 0;
}

stock PickupHndlr::Job(playerid, pickupid) {
	new i = interpolationSearch2D(JobsInfo, pickupid, jP);
	if(i != -1) {
		if(Pl::Info[playerid][pPasport][0] != 0) {
			if(Pl::Info[playerid][pJob] != JOB_NONE) {
				Send(playerid, COLOR_GREY, "* У Вас уже есть работа! /quitjob - уволится (если выполнен контракт)");
			} else {
				GettingJob[playerid] = JobsInfo[i][jID];
				format(src, sizeof(src), "{ffffff}Вы хотите устроится на работу.\n— Должность: {ff0000}%s\n{ffffff}— Срок контракта: {ff0000}5 часов\n\n\
				{ffffff}Вы не уволитесь пока не выполните контракт!\nВы согласны?", JobsInfo[i][jName]);
				SPD(playerid, D_JOB, 0, "Трудоустройство", src, "Да", "Нет");
			}
		} else {
			Send(playerid, COLOR_GREY, "* У Вас нет паспорта! Получить его можно в мэрии.");
		}
		return 1;
	}
	return 0;
}


stock PickupHndlr::Bizz(playerid, pickupid) {
	foreach(new i : Biznes) {
		if(BizzInfo[i][bPickupEnter] == pickupid) {
			if(BizzInfo[i][bOwned]) {
				format(dialog, sizeof dialog,
				"Название: %s\n\
				Плата за вход: $%i\n\n\
				Владелец: %s\n\
				Команьон: %s\n\
				Крыша: %s\n\
				Level: %i\n\
				ID бизнеса: %i",
				BizzInfo[i][bDescription], BizzInfo[i][bEnterCost], BizzInfo[i][bOwner], BizzInfo[i][bExtortion],
				GetGangName(BizzInfo[i][bFrac]), BizzInfo[i][bLevel], BizzInfo[i][bID]);
				SPD(playerid, D_EN_BIZ, 0, ""#__SERVER_PREFIX""#__SERVER_NAME_LC": Business Info", dialog, "ENTER", "CANCEL");
			} else {
				format(dialog, sizeof dialog,
				"Название: %s\n\n\
				БИЗНЕС ПРОДАЕТСЯ\n\
				Цена: $%i\n\
				Level: %i\n\
				ID бизнеса: %i\n\
				Введите /buybiz для покупки!",
				BizzInfo[i][bDescription], BizzInfo[i][bPrice], BizzInfo[i][bLevel], BizzInfo[i][bID]);
				SPD(playerid, D_EN_BIZ, 0, ""#__SERVER_PREFIX""#__SERVER_NAME_LC": Business Info", dialog, "OK", "CANCEL");
			}
			SetPVarInt(playerid, "PlayerBizz", i);
			return 1;
		}
		
		else if(BizzInfo[i][bPickupExit] == pickupid) {
			SetPVarInt(playerid, "PlayerBizz", i);
			SPD(playerid, D_EX_BIZ, 0, "EXIT", "Вы хотите выйти?", "OK", "CANCEL");
			return 1;
		}
	}
	return 0;
}

stock PickupHndlr::Houses(playerid, pickupid) {
	foreach(new i : Houses) {
		if(HouseInfo[i][hPickup] == pickupid) {
			switch(HouseInfo[i][hOwned]) {
				case 0 : {
					format(dialog, sizeof dialog,
					"ДОМ ПРОДАЕТСЯ!\n\
					Описание: %s\n\
					Цена: $%i\n\
					Level: %i\n\
					ID дома: %i\n\
					Введите /buyhouse, чтобы купить дом.",
					HouseInfo[i][hDescription], HouseInfo[i][hPrice], HouseInfo[i][hLevel], i);
				}
				
				case 1 : {
					switch(HouseInfo[i][hRent][0]) {
						case 0 : {
							format(dialog, sizeof dialog,
							"Владелец: %s\n\
							Level: %i\n\
							ID дома: %i",
							HouseInfo[i][hOwner],  HouseInfo[i][hLevel], i);
						}
						case 1 : {
							format(dialog, sizeof dialog,
							"Владелец: %s\n\
							Стоимость аренды: $%i\n\
							Level: %i\n\
							ID дома: %i\n\
							Введите /rentroom, чтобы посилиться тут.",
							HouseInfo[i][hOwner], HouseInfo[i][hRent][1], HouseInfo[i][hLevel], i);
						}
					}
				}
			}
			SetPVarInt(playerid, "PlayerHouse", i);
			SPD(playerid, D_EN_HOUSE, 0, ""#__SERVER_PREFIX""#__SERVER_NAME_LC": Информация о доме.", dialog, "ENTER", "CANCEL");
			return 1;
		}
		
		else if(HouseInfo[i][hgPickupInt] == pickupid) {
			new Float:x, Float:y;
			GetXYInFrontOfPoint(x, y, HGaragePickupPos[0][3], 2.0);
			Rac::SetPlayerPos(playerid, HGaragePickupPos[0][0] + x, HGaragePickupPos[0][1] + y, HGaragePickupPos[0][2]);
			SetPlayerFacingAngle(playerid, HGaragePickupPos[0][3]);
			Rac::SetPlayerInterior(playerid, 3);
			Rac::SetPlayerVirtualWorld(playerid, HouseInfo[i][hVirtual]);
			SetCameraBehindPlayer(playerid);
			return 1;
		}
		
		else if(HouseInfo[i][hgPickupStreet] == pickupid) {
			/*if(Pl::Info[playerid][pHouseKey] != HouseInfo[i][hID]) return Send(playerid, COLOR_GREY, "* У Вас нет ключей!");
			new Float:x, Float:y;
			Pl::Info[playerid][pLocal] = OFFSET_HOUSE + i;
			GetXYInFrontOfPoint(x, y, HGaragePickupPos[1][3], 2.0);
			Rac::SetPlayerPos(playerid, HGaragePickupPos[1][0] + x, HGaragePickupPos[1][1] + y, HGaragePickupPos[1][2]);
			SetPlayerFacingAngle(playerid, HGaragePickupPos[1][3]);
			Rac::SetPlayerInterior(playerid, 3);
			Rac::SetPlayerVirtualWorld(playerid, HouseInfo[i][hVirtual]);
			SetCameraBehindPlayer(playerid);*/
			return 1;
		}
	}
	return 0;
}

public: onPlayerPortal(playerid, portalid, pickupid) {
	switch(portalid) {
		case 11 : {
			if(Pl::FracID(playerid) == TEAM_LICENZERS) {
				return 1;
			}
		}
		case 12 : {
			switch(pickupid) {
				case 1 : {
					if(!TakingLesson{playerid}) {
						Send(playerid, COLOR_WHITE, "* Дождитесь начала экзамена!");
						return -1;
					} else {
						return 1;
					}
				}
				case 2 : {
					return 1;
				}
			}
		}
	}
	return 0;
}

public OnPlayerSelectedMenuRow(playerid, row) {
	new Menu:current = GetPlayerMenu(playerid);

	if(current == GarageMenu) {
		switch(row) {
			case 0: {
				new slot = GetPVarInt(playerid, "SelectedCar"); slot ++;
				if(slot >= TotalVehicleInGarage[playerid]) slot = 0;
				SetPVarInt(playerid, "SelectedCar", slot);
				Veh::Destroy(TempVehicle[playerid]);
				TempVehicle[playerid] = Veh::Create(
					ExtraVehicles[playerid][VehicleInGarage[playerid][slot]][evModel],
					616.0352,-124.1155,997.7648,90.1765,
					ExtraVehicles[playerid][VehicleInGarage[playerid][slot]][evColor1],
					ExtraVehicles[playerid][VehicleInGarage[playerid][slot]][evColor2],
					600
				);
				LinkVehicleToInterior(TempVehicle[playerid], 3);
				SetVehicleVirtualWorld(TempVehicle[playerid], playerid + Pl::Info[playerid][pLocal]);
				ShowMenuForPlayer(GarageMenu, playerid);
			}
			
			case 1 : {
				Veh::Destroy(TempVehicle[playerid]);
				new bidx = Pl::Info[playerid][pLocal] - OFFSET_BIZZ;
				new slot = VehicleInGarage[playerid][GetPVarInt(playerid, "SelectedCar")];
				SetPVarInt(playerid, "SelectedCar", -1);
				
				switch(BizzInfo[bidx][bID]) {
					case Bizz_GarageLS : {
						static const Float:exitPos[][4] = {
							{2005.4939,-1275.3661,23.5474,180.8079},
							{1999.4409,-1274.8125,23.5474,179.3494}
						};
						new rnd = random(sizeof exitPos);
						Rac::SetPlayerPos(playerid, exitPos[rnd][0], exitPos[rnd][1], exitPos[rnd][2] + 2.0);
						ExtraVehicles[playerid][slot][evID2] = Veh::Create(
							ExtraVehicles[playerid][slot][evModel],
							exitPos[rnd][0], exitPos[rnd][1], exitPos[rnd][2], exitPos[rnd][3],
							ExtraVehicles[playerid][slot][evColor1],
							ExtraVehicles[playerid][slot][evColor2],
							INFINITY
						);
						AutoInfo[ExtraVehicles[playerid][slot][evID2]][aOwner] = playerid;
					}
					
					case Bizz_GarageLV : {
						static const Float:exitPos[][4] = {
							{2099.0129,2479.8958,10.5474,179.2626},
							{2090.7698,2480.0090,10.5481,179.6587}
						};
						new rnd = random(sizeof exitPos);
						Rac::SetPlayerPos(playerid, exitPos[rnd][0], exitPos[rnd][1], exitPos[rnd][2] + 2.0);
						ExtraVehicles[playerid][slot][evID2] = Veh::Create(
							ExtraVehicles[playerid][slot][evModel],
							exitPos[rnd][0], exitPos[rnd][1], exitPos[rnd][2], exitPos[rnd][3],
							ExtraVehicles[playerid][slot][evColor1],
							ExtraVehicles[playerid][slot][evColor2],
							INFINITY
						);
						AutoInfo[ExtraVehicles[playerid][slot][evID2]][aOwner] = playerid;
					}
					
					case Bizz_GarageSF : {
						static const Float:exitPos[][4] = {
							{-2429.4846,515.1774,29.6367,214.6334},
							{-2425.7083,518.3276,29.7009,222.1388}
						};
						new rnd = random(sizeof exitPos);
						Rac::SetPlayerPos(playerid, exitPos[rnd][0], exitPos[rnd][1], exitPos[rnd][2] + 2.0);
						ExtraVehicles[playerid][slot][evID2] = Veh::Create(
							ExtraVehicles[playerid][slot][evModel],
							exitPos[rnd][0], exitPos[rnd][1], exitPos[rnd][2], exitPos[rnd][3],
							ExtraVehicles[playerid][slot][evColor1],
							ExtraVehicles[playerid][slot][evColor2],
							INFINITY
						);
						AutoInfo[ExtraVehicles[playerid][slot][evID2]][aOwner] = playerid;
					}
					
					case Bizz_GarageRublovka : {
						static const Float:exitPos[][4] = {
							{-2457.4387,2295.7983,4.7087,89.4643},
							{-2457.5139,2289.9634,4.7085,91.8186}
						};
						new rnd = random(sizeof exitPos);
						Rac::SetPlayerPos(playerid, exitPos[rnd][0], exitPos[rnd][1], exitPos[rnd][2] + 2.0);
						ExtraVehicles[playerid][slot][evID2] = Veh::Create(
							ExtraVehicles[playerid][slot][evModel],
							exitPos[rnd][0], exitPos[rnd][1], exitPos[rnd][2], exitPos[rnd][3],
							ExtraVehicles[playerid][slot][evColor1],
							ExtraVehicles[playerid][slot][evColor2],
							INFINITY
						);
						AutoInfo[ExtraVehicles[playerid][slot][evID2]][aOwner] = playerid;
					}
				}
				SetVehicleNumber(ExtraVehicles[playerid][slot][evID2]);
				ToggleVehicleDoor(ExtraVehicles[playerid][slot][evID2], false);
	
				Rac::SetPlayerInterior(playerid, 0);
				Rac::SetPlayerVirtualWorld(playerid, 0);
				Rac::PutPlayerInVehicle(playerid, ExtraVehicles[playerid][slot][evID2], 0);
				Rac::TogglePlayerControllable(playerid, true);
				RemoveExtraVehicleFromGarage(playerid, slot);
			}
	
			case 2 : {
				Veh::Destroy(TempVehicle[playerid]);
				SetPVarInt(playerid, "SelectedCar", -1);
				Pt::Hide(playerid, Td::AutoSolon);
				Rac::TogglePlayerControllable(playerid, true);
				ExitBiz(playerid, Pl::Info[playerid][pLocal] - OFFSET_BIZZ);
			}
		}
	}
	
	else if(current == AutoSolonMenu) {
		switch(row) {
			case 0: {
				new idx = GetPVarInt(playerid, "SelectedCar"); idx ++;
				new vclass = GetPVarInt(playerid, "VehicleClass");
				if(idx >= ASModelCount[vclass]) idx = 0;
				SetPVarInt(playerid, "SelectedCar", idx);
				Veh::Destroy(TempVehicle[playerid]);
				TempVehicle[playerid] = Veh::Create(AutoSolon[vclass][idx][0], StandPos[vclass][vPos][0], StandPos[vclass][vPos][1], StandPos[vclass][vPos][2], StandPos[vclass][vPos][3], -1, -1, 600);
				Rac::SetPlayerPos(playerid, StandPos[vclass][pPos][0], StandPos[vclass][pPos][1], StandPos[vclass][pPos][2]);
				SetPlayerCameraPos(playerid, StandPos[vclass][pCPos][0], StandPos[vclass][pCPos][1], StandPos[vclass][pCPos][2]);
				SetPlayerCameraLookAt(playerid, StandPos[vclass][pCLookAt][0], StandPos[vclass][pCLookAt][1], StandPos[vclass][pCLookAt][2]);
				SetVehicleVirtualWorld(TempVehicle[playerid], playerid + Pl::Info[playerid][pLocal]);
				
				format(temp, sizeof temp, "~g~ID:~w~ %i~n~~g~MODEL: ~w~%s ~n~~g~PRICE: ~w~$%i ~n~~g~MAX SPEED: ~w~%i KM/H ~n~~g~CLASS: ~w~%c ~n~~g~in availability: ~w~yes",
				AutoSolon[vclass][idx][0], VehicleNames[AutoSolon[vclass][idx][0] - 400], AutoSolon[vclass][idx][1],
				floatround(MaxVehicleSpeed[AutoSolon[vclass][idx][0] - 400]) - 35, AClassChar[vclass]);
				Pt::SetString(playerid, Td::AutoSolon, temp);
				ShowMenuForPlayer(AutoSolonMenu, playerid);
			}
			case 1: {
				new idx = GetPVarInt(playerid, "SelectedCar"); idx --;
				new vclass = GetPVarInt(playerid, "VehicleClass");
				if(idx < 0) idx = ASModelCount[vclass] - 1;
				SetPVarInt(playerid, "SelectedCar", idx);
				Veh::Destroy(TempVehicle[playerid]);
				TempVehicle[playerid] = Veh::Create(AutoSolon[vclass][idx][0], StandPos[vclass][vPos][0], StandPos[vclass][vPos][1], StandPos[vclass][vPos][2], StandPos[vclass][vPos][3], -1, -1, 600);
				Rac::SetPlayerPos(playerid, StandPos[vclass][pPos][0], StandPos[vclass][pPos][1], StandPos[vclass][pPos][2]);
				SetPlayerCameraPos(playerid, StandPos[vclass][pCPos][0], StandPos[vclass][pCPos][1], StandPos[vclass][pCPos][2]);
				SetPlayerCameraLookAt(playerid, StandPos[vclass][pCLookAt][0], StandPos[vclass][pCLookAt][1], StandPos[vclass][pCLookAt][2]);
				SetVehicleVirtualWorld(TempVehicle[playerid], playerid + Pl::Info[playerid][pLocal]);
				
				format(temp, sizeof temp, "~g~ID:~w~ %i~n~~g~MODEL: ~w~%s ~n~~g~PRICE: ~w~$%i ~n~~g~MAX SPEED: ~w~%i KM/H ~n~~g~CLASS: ~w~%c ~n~~g~in availability: ~w~yes",
				AutoSolon[vclass][idx][0], VehicleNames[AutoSolon[vclass][idx][0] - 400], AutoSolon[vclass][idx][1],
				floatround(MaxVehicleSpeed[AutoSolon[vclass][idx][0] - 400]) - 35, AClassChar[vclass]);
				Pt::SetString(playerid, Td::AutoSolon, temp);
				ShowMenuForPlayer(AutoSolonMenu, playerid);
			}
			case 2 : {
				new idx = GetPVarInt(playerid, "SelectedCar");
				new vclass = GetPVarInt(playerid, "VehicleClass");
				if(Rac::GetPlayerMoney(playerid) >= AutoSolon[vclass][idx][1]) {
					SetPVarInt(playerid, "SelectedCar", -1);
					DeletePVar(playerid, "VehicleClass");
					Veh::Destroy(TempVehicle[playerid]);
					Pt::Hide(playerid, Td::AutoSolon);
					
					new biz = Pl::Info[playerid][pLocal] - OFFSET_BIZZ;
					AddExtraVehicle(playerid, AutoSolon[vclass][idx][0], 0, 0, 0, 0, random(125), random(125), PARK_GARAGE, 0);
					GiveBizzProfit(biz, PERCENT(AutoSolon[vclass][idx][1], 20));
					BizzInfo[biz][bProds] --;
					Rac::GivePlayerMoney(playerid, -AutoSolon[vclass][idx][1]);
					Rac::TogglePlayerControllable(playerid, true);
					ExitBiz(playerid, biz);
					
					format(temp, sizeof temp, "~r~-$%i", AutoSolon[vclass][idx][1]);
					GameTextForPlayer(playerid, temp, 1000, 1);
					format(temp, sizeof temp, "* Вы купили личный транспорт %s, стоимостью: $%i", VehicleNames[AutoSolon[vclass][idx][0] - 400], AutoSolon[vclass][idx][1]);
					Send(playerid, COLOR_LIGHTBLUE, temp);
					Send(playerid, COLOR_LIGHTBLUE, "* Транспорт был доставлен в ближайший гараж!");
				} else {
					ShowMenuForPlayer(AutoSolonMenu, playerid);
					Send(playerid, COLOR_GREY, "* У Вас не хватает средств!");
				}
			}
			
			case 3 : {
				SetPVarInt(playerid, "SelectedCar", -1);
				DeletePVar(playerid, "VehicleClass");
				Veh::Destroy(TempVehicle[playerid]);
				Pt::Hide(playerid, Td::AutoSolon);
				Rac::TogglePlayerControllable(playerid, true);
				ExitBiz(playerid, Pl::Info[playerid][pLocal] - OFFSET_BIZZ);
			}
		}
	}
	
	else if(current == IntMenu) {
		switch(row) {
			case 0: {
				new idx = GetPVarInt(playerid, "SelectedItem"); idx ++;
				if(idx >= sizeof(HouseInt)) idx = 0;
				SetPVarInt(playerid, "SelectedItem", idx);
				Rac::SetPlayerPos(playerid, HouseInt[idx][InteriorPos][0], HouseInt[idx][InteriorPos][1], HouseInt[idx][InteriorPos][2]);
				SetPlayerFacingAngle(playerid, HouseInt[idx][InteriorPos][3]);
				Rac::SetPlayerInterior(playerid, HouseInt[idx][Interior]);
				Rac::SetPlayerVirtualWorld(playerid, Pl::Info[playerid][pLocal]);
				SetCameraBehindPlayer(playerid);
				format(temp, sizeof temp, "~n~~n~~n~~n~~n~~n~~n~~n~~g~price: ~w~$%i", HouseInt[idx][InteriorPrice]);
				GameTextForPlayer(playerid, temp, 5000, 6);
				ShowMenuForPlayer(IntMenu, playerid);
			}
			
			case 1: {
				new idx = GetPVarInt(playerid, "SelectedItem"); idx --;
				if(idx < 0) idx = sizeof(HouseInt)-1;
				SetPVarInt(playerid, "SelectedItem", idx);
				Rac::SetPlayerPos(playerid, HouseInt[idx][InteriorPos][0], HouseInt[idx][InteriorPos][1], HouseInt[idx][InteriorPos][2]);
				SetPlayerFacingAngle(playerid, HouseInt[idx][InteriorPos][3]);
				Rac::SetPlayerInterior(playerid, HouseInt[idx][Interior]);
				Rac::SetPlayerVirtualWorld(playerid, Pl::Info[playerid][pLocal]);
				SetCameraBehindPlayer(playerid);
				format(temp, sizeof(temp), "~n~~n~~n~~n~~n~~n~~n~~n~~g~price: ~w~$%i", HouseInt[idx][InteriorPrice]);
				GameTextForPlayer(playerid, temp, 5000, 6);
				ShowMenuForPlayer(IntMenu, playerid);
			}
			
			case 2: {
				new idx = GetPVarInt(playerid, "SelectedItem");
				format(dialog, sizeof dialog, "Цена интерьера:\t$%i\nВы точно хотите купить этот интерьер?", HouseInt[idx][InteriorPrice]);
				SPD(playerid, D_HMENU+11, 0, "[House Menu] > Интерьер", dialog,  "ДА", "НЕТ");
			}
			
			case 3 : {
				SetPVarInt(playerid, "SelectedItem", -1);
				Rac::SpawnPlayer(playerid);
			}
		}
	}
	
	else if(current == SAInteriorsMenu) {
		switch(row) {
			case 0 : {
				new i = GetPVarInt(playerid, "SelectedItem"); i ++;
				if(i >= sizeof(SAInteriors)) i = 0;
				
				Rac::SetPlayerPos(playerid, SAInteriors[i][iX], SAInteriors[i][iY], SAInteriors[i][iZ]);
				SetPlayerFacingAngle(playerid, SAInteriors[i][iA]);
				Rac::SetPlayerInterior(playerid, SAInteriors[i][iI]);
				Rac::SetPlayerVirtualWorld(playerid, 100+playerid);
				SetPVarInt(playerid, "SelectedItem",i);
				format(temp, sizeof temp, "~n~~n~~n~~n~~n~~n~~n~~n~~g~%s(id:%i)", SAInteriors[i][int_Name], i);
				GameTextForPlayer(playerid, temp, 5000, 6);
				ShowMenuForPlayer(SAInteriorsMenu, playerid);
			}
			
			case 1 : {
				new i = GetPVarInt(playerid, "SelectedItem"); i --;
				if(i < 0) i = sizeof(SAInteriors)-1;
				
				Rac::SetPlayerPos(playerid, SAInteriors[i][iX], SAInteriors[i][iY], SAInteriors[i][iZ]);
				SetPlayerFacingAngle(playerid, SAInteriors[i][iA]);
				Rac::SetPlayerInterior(playerid, SAInteriors[i][iI]);
				Rac::SetPlayerVirtualWorld(playerid, 100+playerid);
				format(temp, sizeof temp, "~n~~n~~n~~n~~n~~n~~n~~n~~g~%s(id:%i)", SAInteriors[i][int_Name], i);
				GameTextForPlayer(playerid, temp, 5000, 6);
				SetPVarInt(playerid, "SelectedItem",i);
				ShowMenuForPlayer(SAInteriorsMenu, playerid);
			}
			
			case 2 : {
				Pl::SetSpawnInfo(playerid);
				Rac::SpawnPlayer(playerid);
			}
		}
	}
	
//===================== Пролапс ================================
	else if(current == ClothesMenu) {
		switch(row) {
			case 0 : {
				Container::At(Pl::FracID(playerid), Container::Next, SelectCharPlace[playerid], ChosenSkin[playerid]);
				SetPlayerSkin(playerid, ChosenSkin[playerid]);
				ShowMenuForPlayer(ClothesMenu, playerid);
			}
			
			case 1 : {
				Container::At(Pl::FracID(playerid), Container::Previous, SelectCharPlace[playerid], ChosenSkin[playerid]);		
				SetPlayerSkin(playerid, ChosenSkin[playerid]);
				ShowMenuForPlayer(ClothesMenu, playerid);
			}
			
			case 2 : {
				if(Pl::Info[playerid][pLocal] != 0) {
					Rac::SetPlayerVirtualWorld(playerid, BizzInfo[Pl::Info[playerid][pLocal] - OFFSET_BIZZ][bVirtual]);
				}
				Pl::Info[playerid][pChar] = ChosenSkin[playerid];
				Pl::SetSpawnInfo(playerid);
				SetPlayerSkin(playerid, ChosenSkin[playerid]);
				ChosenSkin[playerid] = 0;
				SelectCharPlace[playerid] = 0;
				Rac::TogglePlayerControllable(playerid, 1);
				SetCameraBehindPlayer(playerid);
		    }
			
			case 3 : {
				if(Pl::Info[playerid][pLocal] != 0) {
					Rac::SetPlayerVirtualWorld(playerid, BizzInfo[Pl::Info[playerid][pLocal] - OFFSET_BIZZ][bVirtual]);
				}
				SetCameraBehindPlayer(playerid);
				SetPlayerSkin(playerid, Pl::Info[playerid][pChar]);
				Rac::TogglePlayerControllable(playerid, 1);
			}
		}
	}

	else if(current == SkinMenu) {
		switch(row) {
			case 0 : {
				Container::At(99+Pl::Info[playerid][pSex], Container::Next, SelectCharPlace[playerid], ChosenSkin[playerid]);
				SetPlayerSkin(playerid, ChosenSkin[playerid]);
				ShowMenuForPlayer(SkinMenu, playerid);
			}

			case 1 : {
				Container::At(99+Pl::Info[playerid][pSex], Container::Previous, SelectCharPlace[playerid], ChosenSkin[playerid]);
				SetPlayerSkin(playerid, ChosenSkin[playerid]);
				ShowMenuForPlayer(SkinMenu, playerid);
			}
			
			case 2 : {
				ChosenSkin[playerid] = 0;
				SelectCharPlace[playerid] = 0;
				MedicBill{playerid} = false;
				PlayerLogged{playerid} = true;
				Pl::Info[playerid][pReg] = 1;
				Pl::Info[playerid][pLevel] = START_LEVEL;
				Pl::Info[playerid][pChar] = GetPlayerSkin(playerid);
				
				GivePlayerBankMoney(playerid, 10000);
				Rac::GivePlayerMoney(playerid, START_MONEY);
				Rac::TogglePlayerControllable(playerid, 1);
				Pl::Update(playerid);
				
				format(temp, sizeof temp, "* %s (ID: %i) прокрался(ась) на ..::"#__SERVER_PREFIX""#__SERVER_NAME_LC"::.. [RUS]", GetName(playerid), playerid);
				sendToLog(COLOR_GREY, temp);
				
				Pl::SetSpawnInfo(playerid);
				Rac::SpawnPlayer(playerid);

				Send(playerid, COLOR_LIGHTGREEN, "Добро пожаловать на ..::"#__SERVER_PREFIX""#__SERVER_NAME_LC"::.. [RUS]");
				ShowDialog(playerid, D_NONE, DIALOG_STYLE_MSGBOX, "WELCOME", "dialog/welcome.txt", "OK", "");
			}
		}
	}
	
	else if(current == PizaMenu) {
		new Float:health;
		GetPlayerHealth(playerid, health);
		if(Rac::GetPlayerMoney(playerid) >= PizzaInfo[row][bPrice]) {
			if(health < 100.0) {
				new biz = Pl::Info[playerid][pLocal] - OFFSET_BIZZ;
				GiveBizzProfit(biz, PizzaInfo[row][bPrice]);
				BizzInfo[biz][bProds] --;
				Rac::GivePlayerHealth(playerid, PizzaInfo[row][bHP], 100.0);
				Rac::GivePlayerMoney(playerid, -PizzaInfo[row][bPrice]);
				
				GetPlayerName(playerid, plname, 24);
				format(temp, sizeof temp, "* %s купил(а) %s.", plname, PizzaInfo[row][bDescription]);
				ProxDetector(10.0, playerid, temp, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
				format(temp, sizeof temp, "~g~+%.1f HP", PizzaInfo[row][bHP]);
				GameTextForPlayer(playerid, temp, 5000, 1);
				format(temp, sizeof temp, "* %.1f", health);
				Send(playerid, COLOR_PURPLE, temp);
				
				Rac::TogglePlayerControllable(playerid, false);
				ShowMenuForPlayer(Menu:PizaMenu, playerid);
			} else {
				Send(playerid, COLOR_PURPLE, "* Вы сыты!");
				Rac::TogglePlayerControllable(playerid, true);
			}
		} else {
			Send(playerid, COLOR_PURPLE, "* У Вас нет столько денег!");
			Rac::TogglePlayerControllable(playerid, true);
		}
	}
	
	else if(current == BurgerMenu) {
		new Float:health;
		GetPlayerHealth(playerid, health);
		if(Rac::GetPlayerMoney(playerid) >= BurgerInfo[row][bPrice]) {
			if(health < 100.0) {
				new biz = Pl::Info[playerid][pLocal] - OFFSET_BIZZ;
				GiveBizzProfit(biz, BurgerInfo[row][bPrice]);
				BizzInfo[biz][bProds] --;
				Rac::GivePlayerHealth(playerid, BurgerInfo[row][bHP], 100.0);
				GetPlayerName(playerid, plname, 24);
				format(temp, sizeof temp, "* %s купил(а) %s.", plname, BurgerInfo[row][bDescription]);
				Rac::GivePlayerMoney(playerid, -BurgerInfo[row][bPrice]);
				ProxDetector(10.0, playerid, temp, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
				format(temp, sizeof temp, "~g~+%.1f HP", BurgerInfo[row][bHP]);
				GameTextForPlayer(playerid, temp, 5000, 1);
				format(temp, sizeof temp, "* %.1f", health);
				Send(playerid, COLOR_PURPLE, temp);
				Rac::TogglePlayerControllable(playerid,0);
				ShowMenuForPlayer(BurgerMenu, playerid);
			} else {
				Send(playerid, COLOR_PURPLE, "* Вы сыты!");
				Rac::TogglePlayerControllable(playerid,1);
			}
		} else {
			Send(playerid, COLOR_PURPLE, "* У Вас нет столько денег!");
			Rac::TogglePlayerControllable(playerid,1);
		}
	}
	
	else if(current == BarMenu) {
		new Float:health;
		GetPlayerHealth(playerid, health);
		if(Rac::GetPlayerMoney(playerid) >= DrinkInfo[row][dPrice]) {
			if(strcmp(DrinkInfo[row][dName], "Cigarette", true) == 0) {
				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_SMOKE_CIGGY);
				Rac::TogglePlayerControllable(playerid,1);
			
			} else if(health < 160.0) {
				Rac::GivePlayerHealth(playerid, DrinkInfo[row][dHP], 160.0);
				Rac::GivePlayerMoney(playerid, -DrinkInfo[row][dPrice]);

				if(GetPlayerDrunkLevel(playerid) < 20000 && DrinkInfo[row][dDrunk]) {
					SetPlayerDrunkLevel(playerid,GetPlayerDrunkLevel(playerid)+1000);
					Pl::Drunk[playerid] += DrinkInfo[row][dDrunk];
				}
				
				switch(row) {
					case 0..3   : SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_SPRUNK);
					case 4..7   : SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_BEER);
					case 8..10  : SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_WINE);
					default		: SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_SPRUNK);
				}
				
				GetPlayerName(playerid, plname, 24);
				format(temp, sizeof temp, "* %s выпил(а) %s.", plname, DrinkInfo[row][dName]);
				ProxDetector(10.0, playerid, temp, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
				
				format(temp, sizeof temp, "~g~+%.1f HP", DrinkInfo[row][dHP]);
				GameTextForPlayer(playerid, temp, 5000, 1);
				
				format(temp, sizeof temp, "* %.1f", health);
				Send(playerid, COLOR_PURPLE, temp);
				
				Rac::TogglePlayerControllable(playerid,0);
				ShowMenuForPlayer(BarMenu, playerid);
			} else {
				Send(playerid, COLOR_PURPLE, "* Бармен отказывается вам наливать!");
				Rac::TogglePlayerControllable(playerid,1);
			}
		} else {
			Send(playerid, COLOR_PURPLE, "* У Вас нет столько денег!");
			Rac::TogglePlayerControllable(playerid,1);
		}
	}
	
	else if(current == HitmanMenu) {
		if(Rac::GetPlayerMoney(playerid) >= HitmanAmmo[row][gPrice]) {
			if(Pl::Info[playerid][pRank] >= HitmanAmmo[row][gRank]) {
				Rac::GivePlayerMoney(playerid, -HitmanAmmo[row][gPrice]);
				Rac::GivePlayerWeapon(playerid, HitmanAmmo[row][gID], HitmanAmmo[row][gAmmo]);
				format(src, sizeof(src), "~r~-$%i", HitmanAmmo[row][gPrice]);
				GameTextForPlayer(playerid, src, 3000, 1);
				Rac::TogglePlayerControllable(playerid, 0);
				ShowMenuForPlayer(HitmanMenu, playerid);
			} else {
				Send(playerid, COLOR_GREY, "* Вам не подходит это оружие!");
				Rac::TogglePlayerControllable(playerid, 1);
			}
		} else {
			Send(playerid, COLOR_GREY, "* У Вас не хватает денег!");
			Rac::TogglePlayerControllable(playerid, 1);
		}
	}
	
	else if(current == Ammu1Menu) {
		new _bidx = Pl::Info[playerid][pLocal] - OFFSET_BIZZ;
		if(Rac::GetPlayerMoney(playerid) >= Ammu1Info[row][gPrice]) {
			Rac::GivePlayerMoney(playerid, -Ammu1Info[row][gPrice]);
			GiveBizzProfit(_bidx, Ammu1Info[row][gPrice]);
			BizzInfo[_bidx][bProds]--;
			Rac::GivePlayerWeapon(playerid, Ammu1Info[row][gID], Ammu1Info[row][gAmmo]);
			GetPlayerName(playerid, plname, 24);
			format(temp, sizeof temp, "* %s купил(а) %s.", plname, Ammu1Info[row][gName]);
			ProxDetector(10.0, playerid, temp, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
			format(temp, sizeof temp, "~r~-$%i", Ammu1Info[row][gPrice]);
			GameTextForPlayer(playerid, temp, 3000, 1);
			Rac::TogglePlayerControllable(playerid,0);
			ShowMenuForPlayer(Ammu1Menu, playerid);
		} else {
			Send(playerid, COLOR_GREY, "* У Вас не хватает денег!");
			Rac::TogglePlayerControllable(playerid, 1);
		}
	}
	
	else if(current == Ammu2Menu) {
		new _bidx = Pl::Info[playerid][pLocal] - OFFSET_BIZZ;
		if(Rac::GetPlayerMoney(playerid) >= Ammu2Info[row][gPrice]) {
			Rac::GivePlayerMoney(playerid, -Ammu2Info[row][gPrice]);
			if(0 <= _bidx < sizeof(BizzInfo)) {
				GiveBizzProfit(_bidx, Ammu2Info[row][gPrice]);
				BizzInfo[_bidx][bProds]--;
			}
			Rac::GivePlayerWeapon(playerid, Ammu2Info[row][gID], Ammu2Info[row][gAmmo]);
			GetPlayerName(playerid, plname, 24);
			format(temp, sizeof temp, "* %s купил(а) %s.", plname, Ammu2Info[row][gName]);
			ProxDetector(10.0, playerid, temp, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
			format(temp, sizeof temp, "~r~-$%i", Ammu2Info[row][gPrice]);
			GameTextForPlayer(playerid, temp, 3000, 1);
			Rac::TogglePlayerControllable(playerid,0);
			ShowMenuForPlayer(Ammu2Menu, playerid);
		} else {
			Send(playerid, COLOR_GREY, "* У Вас не хватает денег!");
			Rac::TogglePlayerControllable(playerid, 1);
		}
	}
	
	else if(current == BuyMenu) {
		new biz = Pl::Info[playerid][pLocal] - OFFSET_BIZZ;
		switch(row) {
			case 0 : {
				if(Rac::GetPlayerMoney(playerid) >= TelephonePrice) {
					new randphone = rndNum(100000,899999);
					Pl::Info[playerid][pNumber] = randphone;
					format(temp, sizeof(temp), "~r~-$%d", TelephonePrice);
					GameTextForPlayer(playerid, temp, 5000, 1);
					Rac::GivePlayerMoney(playerid, -TelephonePrice);
					GiveBizzProfit(biz, TelephonePrice);
					BizzInfo[biz][bProds]--;
					PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
					format(temp, sizeof(temp), "Вы купили телефон, номер: %d", randphone);
					Send(playerid, COLOR_GRAD4, temp);
					Send(playerid, COLOR_GRAD5, "* Вы можете посмотреть свой номер, прописав /stats");
				}
			}
			
			case 1 : {
				new bidx = GetIndexFromBizID(Bizz_Lottery);
			    if(Rac::GetPlayerMoney(playerid) >= ScrathCardPrice) {
					Rac::GivePlayerMoney(playerid, -ScrathCardPrice);
					GiveBizzProfit(biz, PERCENT(ScrathCardPrice,10));
					GiveBizzProfit(bidx, ScrathCardPrice - PERCENT(ScrathCardPrice,10));
					format(temp, sizeof(temp), "~r~-$%d", ScrathCardPrice);
					GameTextForPlayer(playerid, temp, 5000, 1);
					PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
					new prize;
					new randcard1 = random(10);
					new randcard2 = random(10);
					new randcard3 = random(10);
					
					temp[0] = '\0';
					if(randcard1 >= 5) {
						strcat(temp, "~b~] ");
						randcard1 = 1;
					} else if(randcard1 <= 4 && randcard1 >= 2) {
						strcat(temp, "~g~] ");
						randcard1 = 2;
					} else if(randcard1 < 2) {
						strcat(temp, "~y~] ");
						randcard1 = 3;
					}
					
					if(randcard2 >= 5) {
						strcat(temp, "~b~] ");
						randcard2 = 1;
					} else if(randcard2 <= 4 && randcard2 >= 2) {
						strcat(temp, "~g~] ");
						randcard2 = 2;
					} else if(randcard2 < 2) {
						strcat(temp, "~y~] ");
						randcard2 = 3;
					}
					
					if(randcard3 >= 5) {
						strcat(temp, "~b~] ");
						randcard3 = 1;
					} else if(randcard3 <= 4 && randcard3 >= 2) {
						strcat(temp, "~g~] ");
						randcard3 = 2;
					} else if(randcard3 < 2) {
						strcat(temp, "~y~] ");
						randcard3 = 3;
					}
					
					if(randcard1 == randcard2 && randcard1 == randcard3) {
						if(randcard1 > 5) prize = 2500;
						if(randcard1 <= 4 && randcard1 >= 2) prize = 1500;
						if(randcard1 < 2) prize = 500;
						Rac::GivePlayerMoney(playerid, prize);
						BizzInfo[bidx][bSafe] -= prize;
						format(temp, sizeof(temp), "%s~n~~n~~w~~g~$%i", temp, prize);
					} else {
						strcat(temp, "~n~~n~~w~~r~$0");
					}
					GameTextForPlayer(playerid, temp, 3000, 3);
				}
			}
			
			case 2 : {
			    if(Rac::GetPlayerMoney(playerid) >= PhoneBookPrice) {
					Rac::GivePlayerMoney(playerid, -PhoneBookPrice);
					GiveBizzProfit(biz, PhoneBookPrice);
					BizzInfo[biz][bProds]--;
					format(temp, sizeof(temp), "~r~-$%d", PhoneBookPrice);
					GameTextForPlayer(playerid, temp, 5000, 1);
					PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
	                Pl::Info[playerid][pPhoneBook] = 1;
					format(temp, sizeof(temp), "Вы купили телефонную книгу. Теперь можете узнать номер телефона любого игрока!");
					Send(playerid, COLOR_GRAD4, temp);
					Send(playerid, COLOR_WHITE, "Используйте: /number [id/name].");
				}
			}
			
			case 3 : {
			    if(Rac::GetPlayerMoney(playerid) >= DicePrice) {
					gDice{playerid} = true;
					Rac::GivePlayerMoney(playerid, -DicePrice);
					GiveBizzProfit(biz, DicePrice);
					BizzInfo[biz][bProds]--;
					format(temp, sizeof(temp), "~r~-$%d", DicePrice);
					GameTextForPlayer(playerid, temp, 5000, 1);
					PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
					format(temp, sizeof(temp), "Вы купили кубики.");
					Send(playerid, COLOR_GRAD4, temp);
					Send(playerid, COLOR_WHITE, "Используйте: /dice");
				}
			}
			
			case 4 : {
			    if(Rac::GetPlayerMoney(playerid) >= CarKeyPrice) {
					if(gLastCar[playerid] != INVALID_VEHICLE_ID) {
						Rac::GivePlayerMoney(playerid, -CarKeyPrice);
						GiveBizzProfit(biz, CarKeyPrice);
						BizzInfo[biz][bProds]--;
						format(temp, sizeof(temp), "~r~-$%d", CarKeyPrice);
						GameTextForPlayer(playerid, temp, 5000, 1);
						PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
						HireCar[playerid] = gLastCar[playerid];
						format(temp, sizeof(temp), "Вы купили ключи для тачки.");
						Send(playerid, COLOR_GRAD4, temp);
					}
					else Send(playerid, COLOR_WHITE, "У Вас нет транспортного средства!");
				}
			}
			
			case 5 : {
			    if(Rac::GetPlayerMoney(playerid) >= CandomPrice) {
					Condom[playerid] ++;
					GiveBizzProfit(biz, CandomPrice);
					BizzInfo[biz][bProds]--;
					Rac::GivePlayerMoney(playerid, -CandomPrice);
					format(temp, sizeof(temp), "~r~-$%d", CandomPrice);
					GameTextForPlayer(playerid, temp, 5000, 1);
					PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
					format(temp, sizeof(temp), "Вы купили гандон!");
					Send(playerid, COLOR_GRAD4, temp);
				}
			}
			
			case 6 : {
			    if(Rac::GetPlayerMoney(playerid) >= CDPlayerPrice) {
					Pl::Info[playerid][pCDPlayer] = 1;
					Rac::GivePlayerMoney(playerid, -CDPlayerPrice);
					GiveBizzProfit(biz, CDPlayerPrice);
					BizzInfo[biz][bProds]--;
					PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
					format(temp, sizeof(temp), "~r~-$%d", CDPlayerPrice);
					GameTextForPlayer(playerid, temp, 5000, 1);
					format(temp, sizeof(temp), "* %s купил(а) CD-Player.", GetName(playerid));
					ProxDetector(10.0, playerid, temp, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
					Send(playerid, COLOR_WHITE, "Используйте: /music");
				}
			}
		}
		ShowMenuForPlayer(BuyMenu, playerid);
		Rac::TogglePlayerControllable(playerid, 0);
	}
	return 1;
}

public OnPlayerExitedMenu(playerid) {
	new Menu:current = GetPlayerMenu(playerid);
	if(current == IntMenu) {
		ShowMenuForPlayer(IntMenu, playerid);
	}
	
	else if(current == SkinMenu) {
		ShowMenuForPlayer(SkinMenu, playerid);
	}
	
	else if(current == ClothesMenu) {
		ShowMenuForPlayer(ClothesMenu, playerid);
	}
	
	else if(current == AutoSolonMenu) {
		ShowMenuForPlayer(AutoSolonMenu, playerid);
	}
	
	else if(current == GarageMenu) {
		ShowMenuForPlayer(GarageMenu, playerid);
	}
	
	else {
		Rac::TogglePlayerControllable(playerid, 1);
	}
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger) {
	if(gCarLock{vehicleid} && !ispassenger) return Rac::Kick(playerid, "NOP SetVehicleParams");
	
	if(GetVehicleModel(vehicleid) == 519 && ispassenger) {
		Pl::CarInt[playerid] = vehicleid;
		Rac::SetPlayerPos(playerid, 1.8050,23.2547,1199.5938);
		Rac::SetPlayerVirtualWorld(playerid, vehicleid);
		Rac::SetPlayerFacingAngle(playerid, 0);
		Rac::SetPlayerInterior(playerid, 1);
		SetCameraBehindPlayer(playerid);
	}
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid) {
//	Rac::TogglePlayerControllable(playerid, false);
//	SetTimerEx(""#Rac::"TogglePlayerControllable", 2000, false, "ii", playerid, 1);
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	Streamer::UpdateEx(playerid, x, y, z, GetPlayerVirtualWorld(playerid), newinteriorid);
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate) {
	if((newstate == 2 && oldstate == 2) || (newstate == 3 && oldstate == 2) || (newstate == 2 && oldstate == 3)) {
		return Rac::Kick(playerid, "AutoDrive");
	}
	
	if(Pl::isLogged(playerid)) {
		new fracid = Pl::FracID(playerid), vehid = GetPlayerVehicleID(playerid), oldvehid = gLastCar[playerid];
		
		switch(newstate) {
			case PLAYER_STATE_ONFOOT : {
				Pt::Hide(playerid, Pt::Fuel[playerid]);
				Pt::Hide(playerid, Pt::Spec[playerid]);
				Pt::Hide(playerid, Pt::Status[playerid]);
				Pt::SetString(playerid, Pt::Name[playerid], "_");

				if(oldvehid != INVALID_VEHICLE_ID) {
					if(TransportDuty[playerid] > 0) {
						if(TransportDuty[playerid] == 1) TaxiDrivers -= 1;
						else if(TransportDuty[playerid] == 2) BusDrivers -= 1;
						MG2[playerid] = 0;
						TransportDuty[playerid] = 0;
						TransportValue[playerid] = 0;
						TransportMoney[playerid] = 0;
						DestroyDynamicRaceCP(checkpointb[playerid]);
						DestroyDynamic3DTextLabel(AttachText[oldvehid]);
						Rac::GivePlayerMoney(playerid, TransportMoney[playerid]);
						Send(playerid, COLOR_LIGHTBLUE, "* Вы теперь не на дежурстве!");
					}

					Iter::Remove(vehiclePassengers[oldvehid], playerid);
					
					GetVehicleParamsEx(oldvehid, engine, light, alarm, doors, bonnet, boot, objective);
					if(objective > 0) {
						new count;
						foreach(new i: vehiclePassengers[oldvehid]) {
							if(Bl::Info[i][Bl::Finder] != INVALID_PLAYER_ID) {
								count ++;
							}
						}
						if(!count) {
							SetVehicleParamsEx(oldvehid, engine, light, alarm, doors, bonnet, boot, false);
						}
					}
				}
				
				new driver = TransportDriver[playerid];
				if(TransportCost[playerid] > 0 && driver != INVALID_PLAYER_ID) {
					if(IsPlayerConnected(driver)) {
						TransportMoney[driver] += TransportCost[playerid];
						TransportTime[driver] = 0;
						TransportCost[driver] = 0;
						format(src, sizeof(src), "~w~The ride cost~n~~r~$%d",TransportCost[playerid]);
						GameTextForPlayer(playerid, src, 5000, 1);
						format(src, sizeof(src), "~w~Passenger left the car~n~~g~Earned $%d",TransportCost[playerid]);
						GameTextForPlayer(driver, src, 5000, 1);
						Rac::GivePlayerMoney(playerid, -TransportCost[playerid]);
						TransportCost[playerid] = 0;
						TransportTime[playerid] = 0;
						TransportDriver[playerid] = INVALID_PLAYER_ID;
					}
				}
				
				if(Bl::Info[playerid][Bl::Finder] != INVALID_PLAYER_ID) {
					GetPlayerPos(playerid, posx, posy, posz);
					Bl::Info[Bl::Info[playerid][Bl::Finder]][Bl::Marker] = CreateDynamicCP(posx, posy, posz, 1.6, -1, -1, Bl::Info[playerid][Bl::Finder], 200.0);
					foreach(new i: inStreamPlayers[playerid]) {
						if(Bl::Info[i][Bl::Observe] == playerid){
							Bl::Info[i][Bl::Marker] = CreateDynamicCP(posx, posy, posz, 1.6, -1, -1, i, 200.0);
						}
					}
				}
			}

			case PLAYER_STATE_DRIVER : {
				new seatid = GetPlayerVehicleSeat(playerid);
				new model = GetVehicleModel(vehid);
				if(seatid != 128) {
					if(!seatid) {
						if(!(400 <= model <= 611) || MaxPassengers[model - 400 >>> 3] >>> ((model - 400 & 7) << 2) & 0xF == 15) {
							return Rac::Kick(playerid, "Crasher");
						}
					} else {
						return Rac::Kick(playerid, "Crasher");
					}
				}
				
				new vehtype = GetVehicleType(model);
				switch(vehtype) {
					case VEHICLE_TYPE_BOAT : {
						if(Pl::Info[playerid][pLic][2] < 1) {
							Send(playerid, COLOR_GREY, "* У Вас нет лицензии на водный транспорт!");
							return Rac::RemovePlayerFromVehicle(playerid);
						}
					}
					
					case VEHICLE_TYPE_AIRPLANE, VEHICLE_TYPE_HELICOPTER : {
						if(Pl::Info[playerid][pLic][1] < 1) {
							if(!TakingLesson{playerid}) {
								Send(playerid, COLOR_GREY, "* У Вас нет лицензии на воздушный транспорт!");
								return Rac::RemovePlayerFromVehicle(playerid);
							}
						}
					}
					
					case VEHICLE_TYPE_AUTO : {
						if(Pl::Info[playerid][pLic][0] < 1) {
							if(!TakingLesson{playerid}) {
								Send(playerid, COLOR_GREY, "* У Вас нет лицензии на легковой транспорт!");
								return Rac::RemovePlayerFromVehicle(playerid);
							}
						}
					}
				}

				new fc_frac, fc_rank;
				if(Fc::GetInfo(vehid, "fr", fc_frac, fc_rank)) {
					if(fc_frac == 11) {
						if(TakingLesson{playerid}) {
						} else {
							if(fc_frac == fracid) {
								if(fc_rank > Pl::Info[playerid][pRank]) {
									format(src, sizeof(src), "* Этот транспорт доступен с ранга %s[%i]", RankInfo[fc_frac][fc_rank], fc_rank);
									Send(playerid, COLOR_GREY, src);
									return Rac::RemovePlayerFromVehicle(playerid);
								}
							} else {
								format(src, sizeof(src), "* Транспорт зареверзирован (%s)", FracInfo[fc_frac][fName]);
								Send(playerid,COLOR_GREY, src);
								return Rac::RemovePlayerFromVehicle(playerid);
							}
						}
					} else if(fc_frac == fracid) {
						if(fc_rank > Pl::Info[playerid][pRank]) {
							format(src, sizeof(src), "* Этот транспорт доступен с ранга %s[%i]", RankInfo[fc_frac][fc_rank], fc_rank);
							Send(playerid, COLOR_GREY, src);
							return Rac::RemovePlayerFromVehicle(playerid);
						}
					} else {
						format(src, sizeof(src), "* Транспорт зареверзирован (%s)", FracInfo[fc_frac][fName]);
						Send(playerid,COLOR_GREY, src);
						return Rac::RemovePlayerFromVehicle(playerid);
					}
				}
				
				new vehjob;
				if(GetVehDescription(vehid, "j", vehjob)) {
					if(vehjob) {
						if(Pl::Info[playerid][pJob] != vehjob && !EditMode{playerid}) {
							static const jnames[][] = {
								"-", "-", "-", "-", "-", "-",
								"Механики", "-", "-",
								"Автобусники",
								"Дальнобойщики"
							};
							format(src, sizeof(src), "* Транспорт зареверзирован (%s)", jnames[vehjob]);
							Send(playerid, COLOR_GREY, src);
							return Rac::RemovePlayerFromVehicle(playerid);
						} else {
							switch(vehjob) {
								case JOB_MECHANIC : {
									Send(playerid, COLOR_YELLOW, "Используйте /at чтобы взять на буксир автомобиль, и /dt чтобы отцепить его.");
								}
							}
						}
					}
				}

				if(IsACompTruck(vehid)) {
					if(HireCar[playerid] == vehid) {
						Send(playerid, COLOR_GREEN, "* Вы можете доставлять продукты в бизнесы");
						Send(playerid, COLOR_GREEN, "* Команды доставки /buyprods /sellprods");
					} else {
						format(src, sizeof(src),"Стоимость: $%i\nВы хотите арендовать грузовик?", HireCost(vehid));
						SPD(playerid, D_RENTCAR, 0, "Доставка продуктов", src, "ДА", "НЕТ");
						Rac::TogglePlayerControllable(playerid, 0);
					}
				}
				
				if(AutoInfo[vehid][aFuel] < 16.0) {
					PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
					format(src, sizeof(src), "~w~Benzin: ~r~%.1fL", AutoInfo[vehid][aFuel]);
					if(AutoInfo[vehid][aFuel] < 1.0) GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~w~HET ЂEH€…HA", 5000, 5);
				} else {
					format(src, sizeof(src), "~w~Benzin: ~b~%.1fL", AutoInfo[vehid][aFuel]);
				}
				Pt::SetString(playerid, Pt::Fuel[playerid], src);
				
				if(Rac::GetVehicleHealth(vehid) < 450.0) {
					PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
					GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~w~C‡OMAHO", 7000, 5);
				}

				if(!isEngined{vehid}) {
					switch(vehtype) {
						case VEHICLE_TYPE_VELLO : {
							GetVehicleParamsEx(vehid,engine,light,alarm,doors,bonnet,boot,objective);
							SetVehicleParamsEx(vehid, 1, 0, 0, 0, 0, 0, objective);
						}
						case VEHICLE_TYPE_AIRPLANE, VEHICLE_TYPE_BOAT, VEHICLE_TYPE_HELICOPTER : { 
							GetVehicleParamsEx(vehid,engine,light,alarm,doors,bonnet,boot,objective);
							SetVehicleParamsEx(vehid,true,light,alarm,doors,bonnet,boot,objective);
						}
						case VEHICLE_TYPE_AUTO, VEHICLE_TYPE_BIKE : {
							Send(playerid, COLOR_FADE1, "* Нажмите ALT, чтобы завести двигатель!");
						}
					}
				}
				
				switch(fc_frac) {
					case TEAM_RIFA : {
						if(model == 482) {
							format(src, sizeof(src), "* Материалы: %i/%i", AutoInfo[vehid][aMats], AutoInfo[vehid][aMaxMats]);
							Send(playerid, COLOR_GREEN, src);
							Send(playerid, COLOR_GREEN, "* Команды доставки /buymats /sellmats");
						}
					}
					
					case TEAM_FARMERS : {
						switch(vehtype) {
							case VEHICLE_TYPE_BIKE, VEHICLE_TYPE_AUTO : {
								format(src, sizeof(src), "* Мак: %i/%i", AutoInfo[vehid][aDrugs], AutoInfo[vehid][aMaxDrugs]);
								Send(playerid, COLOR_GREEN, src);
							}
						}
					}
				}
				
				switch(vehtype) {
					case VEHICLE_TYPE_BIKE, VEHICLE_TYPE_AUTO : {
						Pt::Show(playerid, Pt::Fuel[playerid]);
						Pt::Show(playerid, Pt::Status[playerid]);
						for(new i; i < 3; Pt::Show(playerid, Pt::Speed[playerid][i]), i++) {}
					}
					
					case VEHICLE_TYPE_BOAT : {
						Pt::Show(playerid, Pt::Status[playerid]);
						for(new i; i < 3; Pt::Show(playerid, Pt::Speed[playerid][i]), i++) {}
					}
					
					case VEHICLE_TYPE_AIRPLANE, VEHICLE_TYPE_HELICOPTER : {
						for(new i; i < 3; Pt::Show(playerid, Pt::Speed[playerid][i]), i++) {}
					}
				}
				Pt::Show(playerid, Pt::Name[playerid]);
				Iter::Add(vehiclePassengers[vehid], playerid);
				gLastCar[playerid] = vehid;
				
				if(Bl::Info[playerid][Bl::Finder] != INVALID_PLAYER_ID) {
					DestroyDynamicCP(Bl::Info[Bl::Info[playerid][Bl::Finder]][Bl::Marker]);
					foreach(new i: inStreamPlayers[playerid]) {
						if(Bl::Info[i][Bl::Observe] == playerid){
							DestroyDynamicCP(Bl::Info[i][Bl::Marker]);
						}
					}
					GetVehicleParamsEx(vehid, engine, light, alarm, doors, bonnet, boot, objective);
					if(objective < 1) {
						SetVehicleParamsEx(vehid, engine, light, alarm, doors, bonnet, boot, true);
					}
				}
			}

			case PLAYER_STATE_PASSENGER : {
				foreach(new driver : vehiclePassengers[vehid]) {
					if(TransportDuty[driver] && Rac::GetPlayerState(driver) == 2) {
						if(TransportValue[driver] > Rac::GetPlayerMoney(playerid)) {
							format(temp, sizeof temp, "Вы нуждаетесь $%i для того чтобы сесть.", TransportValue[driver]);
							Send(playerid, COLOR_LIGHTBLUE, temp);
							Rac::RemovePlayerFromVehicle(playerid);
						} else {
							switch(TransportDuty[driver]) {
								case 1 : {
									TransportTime[driver] = 1;
									TransportTime[playerid] = 1;
									TransportCost[playerid] = TransportValue[driver];
									TransportCost[driver] = TransportValue[driver];
									TransportDriver[playerid] = driver;
									
									format(temp, sizeof temp, " Вы заплатили $%i Таксисту.", TransportValue[driver]);
									Send(playerid, COLOR_LIGHTBLUE, temp);
									format(temp, sizeof temp, " Пассажир %s вошел в ваше Такси.", GetName(playerid));
									Send(driver, COLOR_LIGHTBLUE, temp);
								}
								
								case 2 : {
									format(temp, sizeof temp, " Вы заплатили $%d водителю автобуса.", TransportValue[driver]);
									Send(playerid, COLOR_LIGHTBLUE, temp);
									format(temp, sizeof temp, " Пассажир %s вошел в ваш автобус.", GetName(playerid));
									Send(driver, COLOR_LIGHTBLUE, temp);
								}
							}
							Rac::GivePlayerMoney(playerid, -TransportValue[driver]);
							TransportMoney[driver] += TransportValue[driver];
						}
					}
				}
				
				Iter::Add(vehiclePassengers[vehid], playerid);
				gLastCar[playerid] = vehid;
				
				if(Bl::Info[playerid][Bl::Finder] != INVALID_PLAYER_ID) {
					DestroyDynamicCP(Bl::Info[Bl::Info[playerid][Bl::Finder]][Bl::Marker]);
					foreach(new i: inStreamPlayers[playerid]) {
						if(Bl::Info[i][Bl::Observe] == playerid){
							DestroyDynamicCP(Bl::Info[i][Bl::Marker]);
						}
					}
					GetVehicleParamsEx(vehid, engine, light, alarm, doors, bonnet, boot, objective);
					if(objective < 1) {
						SetVehicleParamsEx(vehid, engine, light, alarm, doors, bonnet, boot, true);
					}
				}
			}
		}
		
		if(oldstate == PLAYER_STATE_DRIVER && newstate != PLAYER_STATE_DRIVER) {
			for(new i; i < 3; Pt::Hide(playerid, Pt::Speed[playerid][i]), i++) {}
		}
	}

	return 1;
}

stock HireCost(carid) {
	if(1 <= carid <= MAX_VEHICLES) {
		new model = GetVehicleModel(carid);
		
		switch(model) {
			case 414 : return 1000;
			case 440 : return 900;
			case 456 : return 1500;
			case 499 : return 1100;
		}
		return ModelCost(model);
	}
	return 5000;
}

stock ModelCost(model) {
	for(new i; i < 4; i++) {
		for(new j; j < ASModelCount[i]; j++) {
			if(model == AutoSolon[i][j][1]) {
				return AutoSolon[i][j][1];
			}
		}
	}
	return 50000;
}

stock ToggleVehicleDoor(carid, bool:toggle) {
	if(1 <= carid <= MAX_VEHICLES) {
		gCarLock{carid} = !toggle;
		GetVehicleParamsEx(carid, engine, light, alarm, doors , bonnet, boot, objective);
		SetVehicleParamsEx(carid, engine, light, alarm, gCarLock{carid}, bonnet, boot, objective);
		foreach(new i: Player) SetVehicleParamsForPlayer(carid, i, 0, gCarLock{carid});
	}
	return 1;
}

public OnPlayerRequestClass(playerid, classid) {
	if(Pl::isLogged(playerid)) {
		Pl::SetSpawnInfo(playerid);
		Rac::SpawnPlayer(playerid);
	} else {
		new pos = random(sizeof EnterPos);
		Pl::Info[playerid][pCamPos] = pos;
		SetSpawnInfo(playerid, 1, 1, EnterPos[pos][p_pos][0], EnterPos[pos][p_pos][1], EnterPos[pos][p_pos][2], EnterPos[pos][p_pos][3],0,0,0,0,0,0);
		PlayerPlaySound(playerid, EnterPos[pos][musicid], 0.0, 0.0, 0.0);
		Rac::SpawnPlayer(playerid);
	}

	return 1;
}

public OnPlayerRequestSpawn(playerid) return 0;

stock SetPlayerCriminal(playerid, declare, reason[], wlevel = 1) {
	if(Pl::isLogged(playerid)) {
		new turned[24], turner[24];
		GetPlayerName(playerid, turned, sizeof(turned));
		if(Pl::isLogged(declare)) {
			GetPlayerName(declare, turner, sizeof(turner));
		} else {
			strmid(turner, "*Неизвестно", 0, 38, sizeof turner);
		}
		WantedTime[playerid] = 180;
		Pl::SetWantedLevel(playerid, Pl::Info[playerid][pWantedL] + wlevel);
		strmid(Pl::Crime[playerid][pVictim], turner, 0, strlen(turner), 255);
		strmid(Pl::Crime[playerid][pAccusing], reason, 0, strlen(reason), 255);
		strmid(Pl::Crime[playerid][pAccused], turner, 0, strlen(turner), 255);
		format(src, sizeof(src), "* Вы совершили преступление! ( %s ); Обвинитель: %s",reason,turner);
		Send(playerid, COLOR_LIGHTRED, src);
		if(Pl::Info[playerid][pWantedL] > 0) {
			format(src, sizeof(src), "* Ваш уровень розыска: %i", Pl::Info[playerid][pWantedL]);
			Send(playerid, COLOR_YELLOW, src);
			if(IsPlayerConnected(ReturnUser(turner))) {
				format(src, sizeof(src), "%s(рация):ПРЕСТУПЛЕНИЕ! %s. Обвиняемый: %s", turner, reason, turned);
				sendToFrac(1, COLOR_RADIO, src);
			}
		}
		Pl::Info[playerid][pCrimes] += 1;
	}
	return 1;
}

stock SetPlayerFree(playerid, declare, reason[]) {
	if(Pl::isLogged(playerid)) {
		ClearCrime(playerid);
		format(src, sizeof(src), "*SMS: %s, поскольку Вы %s, Вы больше не преступник. Отправитель: "#__SERVER_PREFIX""#__SERVER_NAME_LC"(555)", GetName(declare), reason);
		Send(playerid, COLOR_YELLOW, src);
		format(src, sizeof(src), "ШТАБ - КВАРТИРА: Офицер %s посадил на нары", GetName(playerid));
		sendToFrac(1, COLOR_DBLUE, src);
	}
}

stock Update(i) {
	SetPlayerScore(i, Pl::Info[i][pLevel]);
	
	if(Wait{i} > 0) Wait{i}--;
	if(JobWaitTime[i] > 0) JobWaitTime[i]--;
	if(Pl::Info[i][pReport] > 0) Pl::Info[i][pReport]--;
	
	if(++Pl::Info[i][pUpdate] >= (60*4)) {
		Pl::Info[i][pUpdate] = 0;

		if(Pl::Drunk[i] > 0) {
			Pl::Drunk[i] = 0;
			Pl::DrunkTime[i] = 0;
			SetPlayerDrunkLevel(i, 0);
			GameTextForPlayer(i, "~p~Drunk effect~n~~w~Gone", 4500, 1);
		}

		if(Pl::Info[i][pPayDay] < 9) Pl::Info[i][pPayDay]++;

		switch(STDPlayer[i]) {
			case 1 : {
				Rac::GivePlayerHealth(i, -5.0);
				Send(i, COLOR_LIGHTBLUE, "* Потеряно 4 здоровья.");
			}

			case 2 : {
				Rac::GivePlayerHealth(i, -12.0);
				Send(i, COLOR_LIGHTBLUE, "* Потеряно 8 здоровья.");
			}

			case 3 : {
				Rac::GivePlayerHealth(i, -20.0);
				Send(i, COLOR_LIGHTBLUE, "* Потеряно 12 здоровья.");
			}
		}

		if(Rac::GetPlayerMoney(i) < 0) {
			if(!MoneyMessage{i}) {
				MoneyMessage{i} = true;
				format(temp, sizeof(temp), "* У Вас задолжность штату, вы должны отдать сумму: $%d или сядете в тюрьму!", Rac::GetPlayerMoney(i));
				Send(i, COLOR_LIGHTRED, temp);
			}
		} else if(Pl::Info[i][pBank] < 0) {
			if(!MoneyMessage{i}) {
				MoneyMessage{i} = true;
				format(temp, sizeof(temp), "* У Вас задолжность банку, вы должны отдать сумму: $%d или сядете в тюрьму!", Pl::Info[i][pBank]);
				Send(i, COLOR_LIGHTRED, temp);
			}
		} else {
			MoneyMessage{i} = true;
		}
		
		Pl::Update(i);
		Td::ShowForPlayer(i, Copyright);
		Td::ShowForPlayer(i, Logo[0]);
		Td::ShowForPlayer(i, Time);
	}
	
	if(Fixr{i} > 0) {
		if(--Fixr{i} == 0) {
			Fixr{i} = 0;
			PlayerPlaySound(i, 1069, 0.0, 0.0, 0.0);
		}
	}
	
	if(AnimClear[i] > 0) {
		if(--AnimClear[i] == 0) {
			ApplyAnimation(i,"PED","facgum",4.1,0,1,1,1,1);
		}
	}
	
	if(useknock[i] > 0) {
		if(--useknock[i] == 29) {
			ApplyAnimation(i,"CARRY","crry_prtial",4.0,0,0,0,0,0);
		}
	}
	
	if(Pl::NetStats[i] != INVALID_PLAYER_ID) {
		if(Pl::isLogged(Pl::NetStats[i])) {
			GetPlayerNetworkStats(i, dialog, sizeof dialog);
			SPD(i, D_NETSTAT, 0, "Player stat", dialog, "OK", "");
		
		} else if(Pl::NetStats[i] == 999)	{
			GetNetworkStats(dialog, sizeof dialog);
			SPD(i, D_NETSTAT, 0, "Server stat", dialog, "OK", "");
		
		} else if(Pl::NetStats[i] == 1000) {
			Db::stat(dialog, connDb);
			SPD(i, D_NETSTAT, 0, "Mysql stat", dialog, "OK", "");
		
		} else {
			Pl::NetStats[i] = INVALID_PLAYER_ID;
		}
	}

	if(++Pl::Info[i][pHunger] >= 60) {
		Pl::Info[i][pHunger] = 0;
		if(Rac::GetPlayerHealth(i) > 5.0) {
			Rac::GivePlayerHealth(i, -1.0);
		}
	}

	if(NameChange{i} > 0) {
		if(--NameChange{i} == 0) {
			ChangeName(i);
		}
	}

	if(GetPlayerState(i) == PLAYER_STATE_PASSENGER) {
		SetPlayerArmedWeapon(i, 0);
	}

	if(Fell[i] > 0) {
		if(--Fell[i] <= 0) {
			Rac::TogglePlayerControllable(i, 1);
			ApplyAnimation(i,"PED","getup",4.1,0,1,1,1,1);
		}
	}

	if(DrugIntoxic[i] > 0) {
		switch(--DrugIntoxic[i]) {
			case 0 			: SetPlayerWeather(i, 1);
			case 1..60		: SetPlayerWeather(i, 184);
			case 61..120	: SetPlayerWeather(i, 149);
			case 121..180	: SetPlayerWeather(i, 555);
			case 181..240	: SetPlayerWeather(i, 190);
			default			: SetPlayerWeather(i, 190);
		}
	}

	if(WantedTime[i] > 0 && Pl::Info[i][pWantedL] > 0) {
		if(--WantedTime[i] == 0) {
			Pl::SetWantedLevel(i, Pl::Info[i][pWantedL]-1);
			if(Pl::Info[i][pWantedL] > 0) WantedTime[i] = 180;
			format(temp, sizeof(temp),"* Понижение уровня розыска, осталось звезд: %i!", Pl::Info[i][pWantedL]);
			Send(i, COLOR_LIGHTBLUE, temp);
		}
	}

	if(CellTime[i] > 0) {
		if(++CellTime[i] == cchargetime && Pl::isLogged(Mobile[i])) {
			CellTime[i] = 1;
			if(Mobile[Mobile[i]] == i) {
				if(Rac::GetPlayerMoney(i) >= callcost) {
					Rac::GivePlayerMoney(i, -callcost);
					format(temp, sizeof(temp), "~r~-$%i", callcost);
					GameTextForPlayer(i, temp, 1000, 1);
				} else {
					CellTime[i] = 0;
					Mobile[i] = INVALID_PLAYER_ID;
					if(Mobile[Mobile[i]] == i) {
						CellTime[Mobile[i]] = 0;
						Mobile[Mobile[i]] = INVALID_PLAYER_ID;
						Send(Mobile[i], COLOR_GRAD2, "Абонент положил трубку.");
						SetPlayerSpecialAction(Mobile[i],SPECIAL_ACTION_STOPUSECELLPHONE);
					}
					Send(i, COLOR_YELLOW, "* У Вас кончались деньги!");
					SetPlayerSpecialAction(i,SPECIAL_ACTION_STOPUSECELLPHONE);
				}
			}
		}
		if(Mobile[Mobile[i]] == INVALID_PLAYER_ID && CellTime[i] == 5) {
			GetPlayerName(Mobile[i], plname, 24);
			format(temp, sizeof(temp), "* %s's звонит телефон", plname);
			ProxDetector(30.0, Mobile[i], temp, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}
	}
	if(TransportTime[i] > 0) {
		if(TransportTime[i] >= 40) {
			TransportTime[i] = 1;
			if(TransportDriver[i] != INVALID_PLAYER_ID) {
				if(Pl::isLogged(TransportDriver[i])) {
					if(Rac::GetPlayerMoney(i) >= TransportCost[i]) {
						TransportCost[i] += TransportValue[TransportDriver[i]];
						TransportCost[TransportDriver[i]] = TransportCost[i];
					}
				}
			}
		}
		TransportTime[i]++;
		if(Rac::GetPlayerMoney(i) >= TransportCost[i]) {
			format(temp, sizeof(temp), "~n~~n~~n~~n~~n~~n~~n~~g~cost: ~w~$%i/%i", TransportCost[i], TransportTime[i]);
			GameTextForPlayer(i, temp, 1000, 5);
			GameTextForPlayer(TransportDriver[i], temp, 1000, 5);
		} else {
			format(temp, sizeof(temp), "~n~~n~~n~~n~~n~~n~~r~Out Of Money!~n~~g~cost: ~w~$%i/%i", TransportCost[i], TransportTime[i]);
			GameTextForPlayer(i, temp, 1000, 5);
			GameTextForPlayer(TransportDriver[i], temp, 1000, 5);
		}
	}

	if(Pl::Info[i][pMutedTime] != 0) {
		if(--Pl::Info[i][pMutedTime] <= 0 && Pl::Info[i][pMuted] > 0) {
			Pl::Info[i][pMuted] = 0;
			Pl::Info[i][pMutedTime] = 0;
			format(temp, sizeof(temp),""#__SERVER_PREFIX""#__SERVER_NAME_LC": %s выплюнул(а) тряпку изо рта!", GetName(i));
			SendToAll(COLOR_GREY, temp);
		}
	}

	if(UsedFind[i] != 0) UsedFind[i] --;

	if(PlayerTazeTime[i] >= 1) {
		if(++PlayerTazeTime[i] == 15) {
			PlayerTazeTime[i] = 0;
		} else {
			GetPlayerFacingAngle(i, angle);
			Rac::SetPlayerFacingAngle(i, angle + 90);
		}
	}

	if(Pl::Drunk[i] >= 5) {
		if(++Pl::DrunkTime[i] == 8) {
			Pl::DrunkTime[i] = 0;
			if(!IsPlayerInAnyVehicle(i)) ApplyAnimation(i,"PED", "WALK_DRUNK",4.0,0,1,0,0,0);
		}
	}

	if(Pl::Stoned[i] >= 2) {
		if(++Pl::Stoned[i] == 10) Pl::Stoned[i] = 0;
	}

	if(Pl::Info[i][pCarTime] > 0) {
		if(Pl::Info[i][pCarTime] <= 0) Pl::Info[i][pCarTime] = 0;
		else Pl::Info[i][pCarTime] -= 1;
	}

	if(FindTime[i] > 0) {
		format(temp, sizeof(temp), "%i", FindTime[i]);
		GameTextForPlayer(i, temp, 1500, 6);
		if(--FindTime[i] == 0) {
			DisablePlayerCheckpointEx(i, FIND_ICON);
			PlayerPlaySound(i, 1056, 0.0, 0.0, 0.0);
			GameTextForPlayer(i, "~r~RedMarker gone", 2500, 1);
		}
	}

	if(TaxiCallTime[i] > 0 || BusCallTime[i] > 0) {
		if(TaxiAccepted[i] != INVALID_PLAYER_ID) {
			if(IsPlayerConnected(TaxiAccepted[i])) {
				GetPlayerPos(TaxiAccepted[i], posx, posy, posz);
				DestroyDynamicCP(checkpoints[i]);
				checkpoints[i] = CreateDynamicCP(posx, posy, posz, 5.0, -1, -1, i, 99999.9);
			}
		}
		else if(BusAccepted[i] != INVALID_PLAYER_ID) {
			if(IsPlayerConnected(BusAccepted[i])) {
				GetPlayerPos(BusAccepted[i], posx, posy, posz);
				DestroyDynamicCP(checkpoints[i]);
				checkpoints[i] = CreateDynamicCP(posx, posy, posz, 5.0,-1,-1,i,99999.9);
			}
		}
	}

	if(MedicCallTime[i][1] > 0) {
		if(MedicCallTime[i][1] == 300) {
			MedicCallTime[i][0] = INVALID_PLAYER_ID;
			MedicCallTime[i][1] = 0;
			DestroyDynamicMapIcon(pickupd[i][1]);
			PlayerPlaySound(i, 1056, 0.0, 0.0, 0.0);
			GameTextForPlayer(i, "~r~RedMarker gone", 2500, 1);
		} else {
			if(IsPlayerConnected(MedicCallTime[i][0])) {
				format(temp, sizeof temp, "%d", 300 - MedicCallTime[i][1]);
				GameTextForPlayer(i, temp, 1500, 6);
				MedicCallTime[i][1] ++;
			} else {
				MedicCallTime[i][1] = 300;
				format(temp, sizeof temp, "* Клиент %s, вышел из игры.", GetName(MedicCallTime[i][0]));
				Send(i, COLOR_AZTECAS, temp);
			}
		}
	}
	
	if(MechanicCallTime[i][1] > 0) {
		if(MechanicCallTime[i][1] == 300) {
			MechanicCallTime[i][0] = INVALID_PLAYER_ID;
			MechanicCallTime[i][1] = 0;
			DestroyDynamicMapIcon(pickupd[i][1]);
			PlayerPlaySound(i, 1056, 0.0, 0.0, 0.0);
			GameTextForPlayer(i, "~r~RedMarker gone", 2500, 1);
		} else {
			if(IsPlayerConnected(MechanicCallTime[i][0])) {
				format(temp, sizeof(temp), "%d", 300 - MechanicCallTime[i][1]);
				GameTextForPlayer(i, temp, 1500, 6);
				MechanicCallTime[i][1] ++;
			} else {
				MechanicCallTime[i][1] = 300;
				format(temp, sizeof temp, "* Клиент %s, вышел из игры.", GetName(MechanicCallTime[i][0]));
				Send(i, COLOR_AZTECAS, temp);
			}
		}
	}

	if(Pl::CuffedTime[i] > 0) {
		if(--Pl::CuffedTime[i] == 0) {
			Pl::CuffedTime[i] = 0;
			RemovePlayerAttachedObject(i, 0);
			SetPlayerSpecialAction(i, SPECIAL_ACTION_NONE);
		}
	}
	return 1;
}

public: Fillup(playerid, amount, price, sec) {
	if(sec > 0) {
		format(temp, sizeof temp, "~g~%i~n~~b~Please wait...", sec);
		GameTextForPlayer(playerid, temp, 600, 5);
		SetTimerEx("Fillup", 300, false, "iiii", playerid, amount, price, --sec);
	} else {
		new gas = GetPVarInt(playerid, "SelectGas");
		if(gas != INVALID_ID) {
			new bidx = GetIndexFromBizID(RefillInfo[gas][brBizID]);
			if(BizzInfo[bidx][bProds] <= 0) {
				GameTextForPlayer(playerid, "~r~Out of stock", 5000, 1);
			} else {
				BizzInfo[bidx][bProds] -= floatround(amount / 10);
				GiveBizzProfit(bidx, price);
				new veh = GetPlayerVehicleID(playerid);
				AutoInfo[veh][aFuel] += float(amount);
				updateBenzinTD(playerid, veh);
				format(temp, sizeof temp,"* Машина заправлена, с вас: $%i.", price);
				Send(playerid, COLOR_LIGHTBLUE, temp);
				Rac::GivePlayerMoney(playerid, -price);
			}
			SetPVarInt(playerid, "SelectGas", INVALID_ID);
		}
		Rac::TogglePlayerControllable(playerid, true);
	}
}

stock SetPlayerWeapons(playerid) {
	if(Pl::isLogged(playerid)) {
		Rac::ResetPlayerWeapons(playerid);
	    if(!Pl::Info[playerid][pJailed]) {
			switch(Pl::FracID(playerid)) {
				case 1..3 : {
					Rac::GivePlayerWeapon(playerid, 3, 1);
				}

				case 5 : {
					Rac::GivePlayerWeapon(playerid, 2, 1);
					Rac::GivePlayerWeapon(playerid, 22, 30);
				}
				case 6 : {
					Rac::GivePlayerWeapon(playerid, 8, 1);
					Rac::GivePlayerWeapon(playerid, 22, 30);
				}
				
				case 9 : {
					Rac::GivePlayerWeapon(playerid, 43, 25);
				}
				
				case 10 : {
					Rac::GivePlayerWeapon(playerid, 3, 1);
					Rac::GivePlayerWeapon(playerid, 41, 1000);
				}
				
				case 11 : {
					Rac::GivePlayerWeapon(playerid, 3, 1);
					Rac::GivePlayerWeapon(playerid, 41, 1000);
				}
				
				case 12..19 : {
					Rac::GivePlayerWeapon(playerid, 5, 1);
					Rac::GivePlayerWeapon(playerid, 22, 30);
				}
				
				case 20 : {
					Rac::GivePlayerWeapon(playerid, 6, 1);
					Rac::GivePlayerWeapon(playerid, 22, 30);
				}
			}
		}
	}
	return 1;
}

stock PrintBizInfo(playerid, bizid) {
	new i = GetIndexFromBizID(bizid);
	if(i != -1) {
		format(dialog, sizeof dialog, "%s\n\n{ffffff}----------------------------------------------------------\n", BizzInfo[i][bDescription]);
		scf(dialog, src, "{ffa500}Владелец: {ffffff}%s\n",BizzInfo[i][bOwner]);
		scf(dialog, src, "{ffa500}Компоньон: {AA3333}%s\n",BizzInfo[i][bExtortion]);
		scf(dialog, src, "{ffa500}Крыша: {%h}%s\n", rgb<GetFracColor(BizzInfo[i][bFrac])>, GetGangName(BizzInfo[i][bFrac]));
		scf(dialog, src, "{ffffff}----------------------------------------------------------\n");
		scf(dialog, src, "{ffa500}Статус: %s\n", BizzInfo[i][bLocked]?("{AA3333}[закрыт]"):("{33AA33}[открыт]"));
		scf(dialog, src, "{ffa500}Стоимость входа: {33AA33}$%i\n",BizzInfo[i][bEnterCost]);
		scf(dialog, src, "{ffa500}На счету бизнеса: {33AA33}$%i\n", BizzInfo[i][bSafe]);
		scf(dialog, src, "{ffffff}----------------------------------------------------------\n");
		scf(dialog, src, "{ffa500}Стоимость продуктов: {33AA33}$%i\n",BizzInfo[i][bPriceProd]);
		scf(dialog, src, "{ffa500}Продуктов в бизнесе: {ffffff}%i/%i",BizzInfo[i][bProds],BizzInfo[i][bMaxProds]);
		SPD(playerid, D_NONE, 0, "Информация о бизнесе", dialog, "ENTER", "");
	}
	return 1;
}

stock PrintHouseInfo(playerid, i, mode = 0) {
    if(IsValidHouse(i)) {
		format(dialog, sizeof dialog, "%s\n\n{ffffff}----------------------------------------------------------\n", HouseInfo[i][hDescription]);
		scf(dialog, src, "{ffa500}Владелец:{0080ff} %s\n", HouseInfo[i][hOwner]);
		scf(dialog, src, "{ffa500}Цена дома:{33AA33} $%d\n", HouseInfo[i][hPrice]);
		scf(dialog, src, "{ffa500}Статус: {33AA33}%s\n", HouseInfo[i][hLock]?("{AA3333}[закрыт]"):("{33AA33}[открыт]"));
		scf(dialog, src, "{ffa500}Аренда: {33AA33}%s\n", HouseInfo[i][hRent][0]?("{33AA33}[открыта]"):("{AA3333}[закрыта]"));
		scf(dialog, src, "{ffa500}Цена аренды: {33AA33}$%d\n", HouseInfo[i][hRent][1]);
		scf(dialog, src, "{ffffff}----------------------------------------------------------\n");
		scf(dialog, src, "{ffa500}Денег в сейфе: {33AA33}$%d\n", HouseInfo[i][hSafe][0]);
		scf(dialog, src, "{ffa500}Нарко в сейфе: {33AA33}%d грамм\n", HouseInfo[i][hSafe][1]);
		scf(dialog, src, "{ffa500}Матов в сейфе: {33AA33}%d матов\n", HouseInfo[i][hSafe][2]);
		scf(dialog, src, "{ffffff}----------------------------------------------------------\n");
		scf(dialog, src, "{ffa500}Аптечек: {33AA33}%i штук\n", HouseInfo[i][hSafe][3]);
		scf(dialog, src, "{ffa500}Бронежилетов: {33AA33}%i штук\n", HouseInfo[i][hSafe][4]);
		scf(dialog, src, "{ffa500}Телевизор: %s\n", HouseInfo[i][hTv]?("{33AA33}[есть]"):("{AA3333}[нету]"));
		scf(dialog, src, "{ffa500}Домашнее авто: {33AA33}%s\n", (400<=HouseInfo[i][hvModel]<=611)?(VehicleNames[HouseInfo[i][hvModel]-400]):("unknown"));
		scf(dialog, src, "{ffffff}----------------------------------------------------------\n");
		if(mode && Pl::isAdmin(playerid, MODER2LVL)) {
			scf(dialog, src, "{ffa500}Без хозяина уже: {33AA33}%i/20", getday(gettime(), HouseInfo[i][hDate]));
		}
		SPD(playerid, D_NONE, 0, "Информация о доме", dialog, "ENTER", "");
	}
	return 1;
}


public: ShowStats(playerid, statid, mode) {
	#define FIELD_COL d16800
	#define TITLE_COL 34b036
	if(!Pl::isLogged(statid)) return 0;
	GetPlayerVersion(statid, temp, sizeof temp);	
	format(dialog,sizeof dialog,"{ffffff}----------------------------------------------------------\n");
	scf(dialog, src, "{"#FIELD_COL"}Уровень: {ffffff}%d\n", 			Pl::Info[statid][pLevel]);
	scf(dialog, src, "{"#FIELD_COL"}Респекты: {ffffff}%d/%d\n", 		Pl::Info[statid][pExp], EXP(statid));
	scf(dialog, src, "{"#FIELD_COL"}Цена уровня: {ffffff}$%d\n",		costlvl(statid));
	scf(dialog, src, "{"#FIELD_COL"}Пол: {ffffff}%s\n",					GetPlayerSex(statid));
	scf(dialog, src, "{"#FIELD_COL"}Возраст: {ffffff}%s\n",				GetPlayerAge(statid));
	scf(dialog, src, "{"#FIELD_COL"}Местонахождение: {ffffff}%s\n",		GetPlayerOrigin(statid));
	scf(dialog, src, "{"#FIELD_COL"}Предупреждения: {ffffff}%d / 3\n",	Pl::Info[statid][pWarns]);
	scf(dialog, src, "{"#FIELD_COL"}VIP аккаунт: {ffffff}%s\n",			Pl::Info[statid][pVip]?("Есть"):("Нету"));
	scf(dialog, src, "{"#FIELD_COL"}Часов в игре: {ffffff}%d\n",		Pl::Info[statid][pTime]);
	scf(dialog, src, "{ffffff}----------------------------------------------------------\n");
	scf(dialog, src, "{"#FIELD_COL"}Работа: {ffffff}%s\n", 				JobsInfo[Pl::Info[statid][pJob]][jName]);
	scf(dialog, src, "{"#FIELD_COL"}Организация: {ffffff}%s\n", 		FracInfo[Pl::FracID(statid)][fName]);
	scf(dialog, src, "{"#FIELD_COL"}Ранг: {ffffff}%s\n",				RankInfo[Pl::FracID(statid)][Pl::Info[statid][pRank]]);
	scf(dialog, src, "{ffffff}----------------------------------------------------------\n");
	scf(dialog, src, "{"#FIELD_COL"}Деньги(наличные): {ffffff}$%d\n", 	Rac::GetPlayerMoney(statid));
	scf(dialog, src, "{"#FIELD_COL"}Деньги(в банке): {ffffff}$%d\n",	Pl::Info[statid][pBank]);
	scf(dialog, src, "{"#FIELD_COL"}Номер телефона: {ffffff}%d\n",		Pl::Info[statid][pNumber]);
	scf(dialog, src, "{ffffff}----------------------------------------------------------\n");
	scf(dialog, src, "{"#FIELD_COL"}Лотторейный №: {ffffff}%d\n",		Pl::Info[statid][pLottoNr]);
	scf(dialog, src, "{"#FIELD_COL"}Кол-во преступлений: {ffffff}%d\n",	Pl::Info[statid][pCrimes]);
	scf(dialog, src, "{"#FIELD_COL"}Кол-во арестов: {ffffff}%d\n",		Pl::Info[statid][pArrested]);
	scf(dialog, src, "{"#FIELD_COL"}Смертей с розыском: {ffffff}%d\n",	Pl::Info[statid][pWantedD]);
	scf(dialog, src, "{"#FIELD_COL"}Уровень розыска: {ffffff}%d\n", 	Pl::Info[statid][pWantedL]);
	scf(dialog, src, "{"#FIELD_COL"}Убийств: {ffffff}%d\n",				Pl::Info[statid][pKills]);
	scf(dialog, src, "{"#FIELD_COL"}Смертей: {ffffff}%d\n",				Pl::Info[statid][pDeaths]);
	scf(dialog, src, "{"#FIELD_COL"}Выговоров: {ffffff}%d\n", 			Pl::Info[statid][pRebuke]);
	scf(dialog, src, "{ffffff}----------------------------------------------------------\n");
	scf(dialog, src, "{"#FIELD_COL"}Наркотики: {ffffff}%d\n", 			Pl::Info[statid][pDrugs]);
	scf(dialog, src, "{"#FIELD_COL"}Материалы: {ffffff}%d\n", 			Pl::Info[statid][pMats]);

	if(Pl::isAdmin(playerid, 1) && mode) {
		scf(dialog, src, "{ffffff}----------------------------------------------------------\n");
		scf(dialog, src, "{"#FIELD_COL"}UserID: {ffffff}%i\n", 		Pl::Info[statid][pID]);
		scf(dialog, src, "{"#FIELD_COL"}Client: {ffffff}%s\n", 		temp);
		scf(dialog, src, "{"#FIELD_COL"}Дом: {ffffff}%i\n",  		Pl::Info[statid][pHouseKey]);
		scf(dialog, src, "{"#FIELD_COL"}Бизнес: {ffffff}%i\n", 		Pl::Info[statid][pBizKey]);
		scf(dialog, src, "{"#FIELD_COL"}Лицензии: {ffffff}D:%i, F:%i, B:%i, G:%i\n", Pl::Info[statid][pLic][0], Pl::Info[statid][pLic][1], Pl::Info[statid][pLic][2], Pl::Info[statid][pLic][3]);
		scf(dialog, src, "{"#FIELD_COL"}Локация: {ffffff}%i\n", 	Pl::Info[statid][pLocal]);
		scf(dialog, src, "{"#FIELD_COL"}Вирт. Мир: {ffffff}%i\n",	GetPlayerVirtualWorld(statid));
		scf(dialog, src, "{"#FIELD_COL"}Интерьер: {ffffff}%i\n", 	GetPlayerInterior(statid));
	}
	
	format(temp, sizeof temp,"{"#TITLE_COL"}Статистика аккуанта: {ffffff}%s", GetName(statid));
	return SPD(playerid, D_NONE, 0, temp, dialog, "ENTER","");
}

stock ShowPass(playerid, showforid, dialogid) {
	if(!Pl::isLogged(showforid)) return 0;
	new fio[2][12], _date[2][14], fracid = Pl::FracID(playerid);
	to_timestamp(_date[0], Pl::Info[playerid][pPasport][1], "%Y-%m-%d");
	to_timestamp(_date[1], Pl::Info[playerid][pPasport][2], "%Y-%m-%d");
	GetPlayerName(playerid, plname, 24), sscanf(plname, "p<_>s[12]S(-)[12]", fio[0], fio[1]);

	format(dialog, sizeof dialog,"{ffffff}----------------------------------------------------------\n");
	scf(dialog, src, "{"#FIELD_COL"}Имя: {ffffff}%s\n", fio[0]);
	scf(dialog, src, "{"#FIELD_COL"}Фамилия: {ffffff}%s\n", fio[1]);
	scf(dialog, src, "{"#FIELD_COL"}Возраст: {ffffff}%s\n", GetPlayerAge(playerid));
	scf(dialog, src, "{"#FIELD_COL"}Пол: {ffffff}%s\n", GetPlayerSex(playerid));
	scf(dialog, src, "{ffffff}----------------------------------------------------------\n");
	scf(dialog, src, "{"#FIELD_COL"}Организация: {%h}%s\n", rgb<GetFracColor(fracid)>, FracInfo[fracid][fName]);
	scf(dialog, src, "{"#FIELD_COL"}Должность: {ffffff}%s\n", RankInfo[fracid][Pl::Info[playerid][pRank]]);
	scf(dialog, src, "{"#FIELD_COL"}Преступлений: {ffffff}%i\n", Pl::Info[playerid][pCrimes]);
	scf(dialog, src, "{"#FIELD_COL"}Проживание в штате: {ffffff}%i(в годах)\n", Pl::Info[playerid][pLevel]);
	scf(dialog, src, "{"#FIELD_COL"}Работа: {ffffff}%s\n", JobsInfo[Pl::Info[playerid][pJob]][jName]);
	scf(dialog, src, "{ffffff}----------------------------------------------------------\n");
	scf(dialog, src, "{"#FIELD_COL"}Действует от: {ffffff}%s\n", _date[0]);
	scf(dialog, src, "{"#FIELD_COL"}Действует до: {ffffff}%s\n", _date[1]);
	
	if(playerid != showforid) {
		format(temp, sizeof(temp),"{"#TITLE_COL"}Паспорт гражданина: {ffffff}%s", plname);
		SPD(showforid, dialogid, 0, temp, dialog, "ENTER","");
	} else {
		SPD(showforid, dialogid, 0, "Ваш паспорт", dialog, "ENTER","");
	}
	return 1;
}

stock IsLegalFrac(fracid) {
	switch(fracid) {
		case 1..4	: return 1;
		case 7		: return 1;
		case 9..11	: return 1;
	}
	return 0;
}

stock GetFracType(fracid) {
	if(!IsValidFrac(fracid)) return FRAC_TYPE_UNKNOWN;
	if((linearSearch(Gangs, fracid) != -1)) return FRAC_TYPE_GANG;
	if((linearSearch(Mafias, fracid) != -1)) return FRAC_TYPE_MAFIA;
	if((linearSearch(Teams, fracid) != -1)) return FRAC_TYPE_TEAM;
	
	return FRAC_TYPE_OTHER; 
}

stock Pl::SetFracColor(playerid) {
	return SetPlayerColor(playerid, GetFracColor(Pl::FracID(playerid)));
}

stock LoadSpawns() {
	new time = GetTickCount();
	new Cache:result = Db::query(connDb, "SELECT * FROM `"#__TableSpawns__"` ORDER BY `id` ASC");
	new rows = cache_get_row_count();
	if(rows) {
		for(new i; i < rows; i++) {
			new id;
			cache_get_int(i, 0, id);
			cache_get_int(i, 1, SpawnInfo[id][spInt]);
			cache_get_int(i, 2, SpawnInfo[id][spVirt]);
			cache_get_float(i, 3, SpawnInfo[id][spX]);
			cache_get_float(i, 4, SpawnInfo[id][spY]);
			cache_get_float(i, 5, SpawnInfo[id][spZ]);
			cache_get_float(i, 6, SpawnInfo[id][spA]);
		}
		debug("LoadSpawns() - Ok! Spawns: %i. Run time: %i (ms)", rows, GetTickCount()-time);
	}
	cache_delete(result);
	return 1;
}

stock LoadGMInfo() {
	new time = GetTickCount();
	new Cache:result = Db::query(connDb, "SELECT * FROM `"#__TableStuffs__"` WHERE 1", true);
	if(cache_get_row_count()) {
		cache_get_int(0, 0, Gm::Info[Gm::TaxValue]);
		cache_get_int(0, 1, Gm::Info[Gm::PritonDrugs]);
		cache_get_int(0, 2, Gm::Info[Gm::AmbarDrugs]);
		cache_get_int(0, 3, Gm::Info[Gm::FactoryMetal]);
		cache_get_int(0, 4, Gm::Info[Gm::FactoryFuel]);
		cache_get_int(0, 5, Gm::Info[Gm::FactoryProds]);
		cache_get_int(0, 6, Gm::Info[Gm::EnableReg]);
		debug("LoadGMInfo() - Ok! Run time: %i (ms)", GetTickCount()-time);
	}
	cache_delete(result);
	return 1;
}

stock SaveStuff() {
	format(query, sizeof query, "UPDATE `"#__TableStuffs__"` SET ");
	scf(query, temp, "`TaxValue`='%i',", Gm::Info[Gm::TaxValue]);
	scf(query, temp, "`PDrugs`='%i',", Gm::Info[Gm::PritonDrugs]);
	scf(query, temp, "`ADrugs`='%i',", Gm::Info[Gm::AmbarDrugs]);
	scf(query, temp, "`fmetal`='%i',", Gm::Info[Gm::FactoryMetal]);
	scf(query, temp, "`ffuel`='%i',", Gm::Info[Gm::FactoryFuel]);
	scf(query, temp, "`fprods`='%i',", Gm::Info[Gm::FactoryProds]);
	scf(query, temp, "`regged`='%i'", Gm::Info[Gm::EnableReg]);
	Db::tquery(connDb, query, "", "");
	return 1;
}

stock LoadHouses() {
	new time = GetTickCount();
    format(query, sizeof query, "SELECT * FROM `"#__TableHouses__"` ORDER BY `id` ASC", true);
	new Cache:result = Db::query(connDb, query, true);
	new rows = cache_get_row_count();
	if(rows) {
		for(new iter; iter < rows; iter++) {
			new i;
			cache_get_int(iter, 0, i);
			HouseInfo[i][hID] = i;
			HouseInfo[i][hVirtual] = i;
			HouseInfo[i][hgGarage] = false;
			cache_get_int(iter, 1, HouseInfo[i][hOwned]);
			cache_get_int(iter, 2, HouseInfo[i][hLock]);
			cache_get_row(iter, 3, HouseInfo[i][hOwner], connDb, 24);
			cache_get_row(iter, 4, HouseInfo[i][hDescription], connDb, 24);
			cache_get_int(iter, 5, HouseInfo[i][hPrice]);
			cache_get_int(iter, 6, HouseInfo[i][hLevel]);
			cache_get_int(iter, 7, HouseInfo[i][hInt]);
			cache_get_int(iter, 8, HouseInfo[i][hDate]);
			cache_get_int(iter, 9, HouseInfo[i][hTv]);
			cache_get_str(iter, 10, "p<,>a<i>[2]", HouseInfo[i][hRent]);
			cache_get_str(iter, 11, "p<,>a<i>[5]", HouseInfo[i][hSafe]);
			cache_get_str(iter, 12, "p<,>a<i>[6]", HouseInfo[i][hGuns]);
			cache_get_str(iter, 13, "p<,>a<i>[6]", HouseInfo[i][hAmmos]);
			cache_get_str(iter, 14, "p<,>a<f>[4]", HouseInfo[i][hEnter]);
			cache_get_str(iter, 15, "p<,>a<f>[4]", HouseInfo[i][hExit]);
			cache_get_int(iter, 16, HouseInfo[i][hvModel]);
			
			if(400 <= HouseInfo[i][hvModel] <= 611) {
				cache_get_str(iter, 17, "p<,>a<i>[2]", HouseInfo[i][hvColor]);
				cache_get_int(iter, 18, HouseInfo[i][hvPark]);
				cache_get_str(iter, 21, "p<,>a<f>[4]", HouseInfo[i][hvSpawn]);
				HouseInfo[i][hAuto] = Veh::Create(
					HouseInfo[i][hvModel],
					HouseInfo[i][hvSpawn][0],
					HouseInfo[i][hvSpawn][1],
					HouseInfo[i][hvSpawn][2],
					HouseInfo[i][hvSpawn][3],
					HouseInfo[i][hvColor][0],
					HouseInfo[i][hvColor][1],
					3600*2
				);
				AutoInfo[HouseInfo[i][hAuto]][aOwner] = INVALID_PLAYER_ID * i;
				SetVehicleNumber(HouseInfo[i][hAuto]);
				ToggleVehicleDoor(HouseInfo[i][hAuto], false);
				cache_get_float(iter, 19, AutoInfo[HouseInfo[i][hAuto]][aMileage]);
				cache_get_str(iter, 20, "p<,>a<i>[13]i", AutoInfo[HouseInfo[i][hAuto]][aTuning], AutoInfo[HouseInfo[i][hAuto]][aPaintJob]);
				AddTuning(HouseInfo[i][hAuto]);
				switch(HouseInfo[i][hvPark]) {
					case 1 : {
						LinkVehicleToInterior(HouseInfo[i][hAuto], 3);
						SetVehicleVirtualWorld(HouseInfo[i][hAuto], HouseInfo[i][hVirtual]);
					}
				}
			}
			
			switch(HouseInfo[i][hOwned]) {
				case 0 : {
					HouseInfo[i][hPickup] = AddPickup(1273, 23, HouseInfo[i][hEnter][0], HouseInfo[i][hEnter][1], HouseInfo[i][hEnter][2], 0);
					HouseInfo[i][hMapIcon] = CreateDynamicMapIcon( HouseInfo[i][hEnter][0], HouseInfo[i][hEnter][1], HouseInfo[i][hEnter][2], 31, 0, 0, -1, -1, 250.0);
				}
				case 1 : {
					HouseInfo[i][hPickup] = AddPickup(1318, 23, HouseInfo[i][hEnter][0], HouseInfo[i][hEnter][1], HouseInfo[i][hEnter][2], 0);
					HouseInfo[i][hMapIcon] = CreateDynamicMapIcon(HouseInfo[i][hEnter][0], HouseInfo[i][hEnter][1], HouseInfo[i][hEnter][2], 32,0, 0, -1, -1, 250.0);
				}
			}
			Iter::Add(Houses, i);
		}
		debug("LoadHouses() - Ok! Houses: %i. Run time: %i (ms)", Iter::Count(Houses), GetTickCount()-time);
	}
	cache_delete(result);
	return 1;
}

stock LoadHGarages() {
	HGaragePickup[0] = AddPickup(1318, 23, HGaragePickupPos[0][0], HGaragePickupPos[0][1], HGaragePickupPos[0][2], 0);
	HGaragePickup[1] = AddPickup(1318, 23, HGaragePickupPos[1][0], HGaragePickupPos[1][1], HGaragePickupPos[1][2], 0);
	
	new time = GetTickCount();
	format(query, sizeof query, "SELECT * FROM `"#__TableHouseGarages__"` ORDER BY `house` ASC");
	new Cache:result = Db::query(connDb, query, true);
	new rows = cache_get_row_count();
	if(rows) {
		for(new i, house; i < rows; i++) {
			cache_get_int(i, 0, house);
			cache_get_str(i, 1, "p<,>a<f>[4]", HouseInfo[house][hgIntPos]);
			cache_get_str(i, 2, "p<,>a<f>[4]", HouseInfo[house][hgStreetPos]);
			
			HouseInfo[house][hgGarage] = true;
			HouseInfo[house][hgPickupInt] = CreateDynamicPickup(1318, 23, HouseInfo[house][hgIntPos][0], HouseInfo[house][hgIntPos][1], HouseInfo[house][hgIntPos][2], HouseInfo[house][hVirtual], -1, -1, 30.0);
			HouseInfo[house][hgPickupStreet] = CreateDynamicPickup(1318, 23, HouseInfo[house][hgStreetPos][0], HouseInfo[house][hgStreetPos][1], HouseInfo[house][hgStreetPos][2], 0, -1, -1, 8.0);
			
			Streamer_AppendArrayData(STREAMER_TYPE_PICKUP, HGaragePickup[0], E_STREAMER_WORLD_ID, HouseInfo[house][hVirtual]);
			Streamer_AppendArrayData(STREAMER_TYPE_PICKUP, HGaragePickup[1], E_STREAMER_WORLD_ID, HouseInfo[house][hVirtual]);
		}
		debug("LoadHGarage() - Ok! Garages: %i. Run time: %i (ms)", rows, GetTickCount()-time);
	}
	cache_delete(result);
	return 1;
}

stock LoadBizz() {
	new time = GetTickCount();
	format(query, sizeof query, "SELECT * FROM `"#__TableBusines__"` ORDER BY `id` ASC");
	new Cache:result = Db::query(connDb, query, true);
	new rows = cache_get_row_count();
	if(rows) {
		for(new i; i < rows; i++) {
			cache_get_int(i, 0, BizzInfo[i][bID]);
			cache_get_int(i, 1, BizzInfo[i][bOwned]);
			cache_get_int(i, 2, BizzInfo[i][bLocked]);
			cache_get_row(i, 3, BizzInfo[i][bOwner], connDb, 24);
			cache_get_row(i, 4, BizzInfo[i][bExtortion], connDb, 24);
			cache_get_row(i, 5, BizzInfo[i][bDescription], connDb, 24);
			cache_get_int(i, 6, BizzInfo[i][bLevel]);
			cache_get_int(i, 7, BizzInfo[i][bPrice]);
			cache_get_int(i, 8, BizzInfo[i][bSafe]);
			cache_get_int(i, 9, BizzInfo[i][bEnterCost]);
			cache_get_int(i, 10, BizzInfo[i][bFrac]);
			cache_get_int(i, 11, BizzInfo[i][bProds]);
			cache_get_int(i, 12, BizzInfo[i][bMaxProds]);
			cache_get_int(i, 13, BizzInfo[i][bPriceProd]);
			cache_get_int(i, 14, BizzInfo[i][bInterior]);
			cache_get_str(i, 15, "p<,>a<i>[2]", BizzInfo[i][bIcon]);
			cache_get_str(i, 16, "p<,>a<f>[4]", BizzInfo[i][bEnter]);
			cache_get_str(i, 17, "p<,>a<f>[4]", BizzInfo[i][bExit]);

			BizzInfo[i][bVirtual] = BizzInfo[i][bID];
			
			switch(BizzInfo[i][bOwned]) {
				case 0 : {
					BizzInfo[i][bPickupEnter] = AddPickup(1272, 23, BizzInfo[i][bEnter][0], BizzInfo[i][bEnter][1], BizzInfo[i][bEnter][2], 0);
				}
				default : {
					BizzInfo[i][bPickupEnter] = AddPickup(1239, 23, BizzInfo[i][bEnter][0], BizzInfo[i][bEnter][1], BizzInfo[i][bEnter][2], 0);
				}
			}
			if(BizzInfo[i][bIcon][BizzInfo[i][bOwned]] != 0) {
				BizzInfo[i][bMapIcon] = CreateDynamicMapIcon(BizzInfo[i][bEnter][0], BizzInfo[i][bEnter][1], BizzInfo[i][bEnter][2], BizzInfo[i][bIcon][BizzInfo[i][bOwned]], 0, 0, -1, -1, 250.0);
			}
			if(BizzInfo[i][bInterior] != -1) {
				BizzInfo[i][bPickupExit] = AddPickup(1318, 23, BizzInfo[i][bExit][0], BizzInfo[i][bExit][1], BizzInfo[i][bExit][2], BizzInfo[i][bVirtual]);
			}
			GetSquarePos(BizzInfo[i][bEnter][0], BizzInfo[i][bEnter][1], MAX_ZONE_SIZE, BizzInfo[i][bzMinX], BizzInfo[i][bzMinY], BizzInfo[i][bzMaxX], BizzInfo[i][bzMaxY]);
			BizzInfo[i][bZone] = Gz::Create(BizzInfo[i][bzMinX], BizzInfo[i][bzMinY], BizzInfo[i][bzMaxX], BizzInfo[i][bzMaxY]);
			GangBiznes{BizzInfo[i][bFrac]} ++;
			Iter::Add(Biznes, i);
		}
		debug("LoadBizz() - Ok! Biznes: %i. Run time: %i (ms)", Iter_Count(Biznes), GetTickCount()-time);
	}
	cache_delete(result);
	return 1;
}

stock LoadGas() {
	new time = GetTickCount();
	format(query, sizeof query, "SELECT * FROM `"#__TableRefills__"` ORDER BY `id` ASC");
	new Cache:result = Db::query(connDb, query, true);
	new rows = cache_get_row_count();
	if(rows) {
		for(new i; i < rows; i++) {
			cache_get_int(i, 0, RefillInfo[i][brID]);
			cache_get_int(i, 1, RefillInfo[i][brBizID]);
			cache_get_str(i, 2, "p<,>a<f>[3]", RefillInfo[i][brPos]);
			RefillInfo[i][brPickup] = AddPickup(1650, 14, RefillInfo[i][brPos][0], RefillInfo[i][brPos][1], RefillInfo[i][brPos][2], 0);
			Iter::Add(Refills, i);
		}
		debug("LoadGas() - Ok! Gas: %i. Run time: %i (ms)", Iter::Count(Refills), GetTickCount()-time);
	}
	cache_delete(result);
	return 1;
}

stock LoadGangInfo() {
	new time = GetTickCount();
	format(query, sizeof query, "SELECT * FROM `"#__TableGangInfo__"` ORDER BY `gRespect` DESC");
	new Cache:result = Db::query(connDb, query, true);
	new rows = cache_get_row_count();
	if(rows) {
		for(new i; i < rows; i++) {
			cache_get_int(i, 0, GangInfo[i][fID]);
			cache_get_int(i, 1, GangInfo[i][gRespect]);
			cache_get_float(i, 2, GangInfo[i][gPosX]);
			cache_get_float(i, 3, GangInfo[i][gPosY]);
			cache_get_float(i, 4, GangInfo[i][gPosZ]);
		}
		debug("LoadGangInfo() - Ok! Run time: %i (ms)", GetTickCount()-time);
	}
	cache_delete(result);
	return 1;
}

stock SaveGI() {
	for(new i; i < sizeof GangInfo; ++i) {
		format(query, sizeof query, "UPDATE `"#__TableGangInfo__"` SET ");
		scf(query, src, "`gRespect`='%i',", GangInfo[i][gRespect]);
		scf(query, src, "`gPosX`='%f',", GangInfo[i][gPosX]);
		scf(query, src, "`gPosY`='%f',", GangInfo[i][gPosY]);
		scf(query, src, "`gPosZ`='%f' ", GangInfo[i][gPosZ]);
		scf(query, src, "WHERE `fracID`='%i'", GangInfo[i][fID]);
		Db::tquery(connDb, query, "", "");
	}
	return;
}

stock LoadFracInfo() {
	new time = GetTickCount();
	format(query, sizeof query, "SELECT * FROM `"#__TableFracInfo__"` ORDER BY `fID` ASC");
	new Cache:result = Db::query(connDb, query, true);
	new rows = cache_get_row_count();
	if(rows) {
		strmid(FracInfo[0][fName], "Civilian", 0, strlen("Civilian"), 255);
		for(new i; i < rows; i++) {
			new fracid;
			cache_get_int(i, 0, fracid);
			cache_get_int(i, 1, FracInfo[fracid][fBank]);
			cache_get_str(i, 2, "p<,>a<i>[3]", FracInfo[fracid][fRConf]);
			cache_get_str(i, 3, "p<,>a<i>[2]", FracInfo[fracid][fBConf]);
			cache_get_row(i, 4, FracInfo[fracid][fName], connDb, 36);
			cache_get_row(i, 5, FracInfo[fracid][fTag], connDb, 16);
			cache_get_str(i, 6, "p<,>a<i>[2]a<f>[4]", FracInfo[fracid][fSpawn][fSpawnInt], FracInfo[fracid][fSpawn][fSpawnPos]);
			cache_get_str(i, 7, "h", FracInfo[fracid][fColor]);
			Iter::Add(Frac, fracid);
		}
		debug("LoadFracInfo() - Ok! Fracs: %i. Run time: %i (ms)", Iter::Count(Frac), GetTickCount()-time);
	}
	cache_delete(result);
	return 1;
}

stock UpdateFracInfo(fracid) {
	if(IsValidFrac(fracid)) {
		format(query, sizeof query, "UPDATE `"#__TableFracInfo__"` SET ");
		scf(query, temp, "`fBank`='%i',", FracInfo[fracid][fBank]);
		scf(query, temp, "`fRConf`='%i,%i,%i',", FracInfo[fracid][fRConf][zRANK], FracInfo[fracid][fRConf][bRANK], FracInfo[fracid][fRConf][gRANK]);
		scf(query, temp, "`fBConf`='%i,%i',", FracInfo[fracid][fBConf][bKILLS], FracInfo[fracid][fBConf][bPRICE]);
		scf(query, temp, "`fColor`='0x%s'", hexToString(FracInfo[fracid][fColor]));
		scf(query, temp, " WHERE `fID`='%i'", fracid);
		Db::tquery(connDb, query, "", "");
		return 1;
	}
	return 0;
}

stock LoadFracVehicles( ) {
	new time = GetTickCount();
	format(query, sizeof query, "SELECT * FROM `"#__TableFracVehicles__"` ORDER BY `ID` ASC");
	new Cache:result = Db::query(connDb, query, true);
	new rows = cache_get_row_count();
	if(rows) {
		for(new i; i < rows; i++) {
			cache_get_int(i, 0, Fc::Info[i][Fc::Id][0]);
			cache_get_int(i, 1, Fc::Info[i][Fc::Model]);
			cache_get_int(i, 2, Fc::Info[i][Fc::FracId]);
			cache_get_int(i, 3, Fc::Info[i][Fc::RankId]);
			cache_get_str(i, 4, "p<,>a<i>[2]", Fc::Info[i][Fc::Color]);
			cache_get_row(i, 5, Fc::Info[i][Fc::Number], connDb, 10);
			cache_get_str(i, 6, "p<,>a<f>[4]", Fc::Info[i][Fc::RespPos]);
			cache_get_float(i, 7, AutoInfo[0][aMileage]);
			
			Fc::Info[i][Fc::Id][1] = Veh::Create(
				Fc::Info[i][Fc::Model],
				Fc::Info[i][Fc::RespPos][0],
				Fc::Info[i][Fc::RespPos][1],
				Fc::Info[i][Fc::RespPos][2],
				Fc::Info[i][Fc::RespPos][3],
				Fc::Info[i][Fc::Color][0],
				Fc::Info[i][Fc::Color][1],
				600
			);
			
			if(!strlen(Fc::Info[i][Fc::Number])) strmid(Fc::Info[i][Fc::Number], Fc::DEF_NUMBER, 0, strlen(Fc::DEF_NUMBER), 255);
			SetVehicleNumberPlate(Fc::Info[i][Fc::Id][1], Fc::Info[i][Fc::Number]);
			AutoInfo[Fc::Info[i][Fc::Id][1]][aMileage] = AutoInfo[0][aMileage];
			Iter::Add(TeamVehicles[Fc::Info[i][Fc::FracId]], Fc::Info[i][Fc::Id][1]);
		}
		Fc::TOTAL = rows;
		debug("LoadFracVehicles() - Ok! Vehicles: %i; Run time: %i (ms)", Fc::TOTAL, GetTickCount()-time);
	}
	cache_delete(result);
	return 1;
}

public: UpdateProp() {
	foreach(new i : Biznes) UpdateBizz(i);
	foreach(new i : Houses) UpdateHouse(i);
	foreach(new i : Frac) UpdateFracInfo(i);
	for(new i; i < TOTAL_VEHICLES; ++i) UpdateToSQL(i, 0);
	for(new i; i < Fc::TOTAL; ++i) Fc::Update(i);

	SaveStuff();
	
	SaveGI();

	return 1;
}

stock Float:GetDistanceBetweenPlayers(p1,p2) {
	new Float:xyz[3];
	GetPlayerPos(p2, xyz[0], xyz[1], xyz[2]);
	return GetPlayerDistanceFromPoint(p1, xyz[0], xyz[1], xyz[2]);
}

stock GetClosestPlayer(playerid, Float:radi=200.0) {
	new Float: dist, p1 = INVALID_PLAYER_ID;
	foreach(new i : inStreamPlayers[playerid]) {
		dist = GetDistanceBetweenPlayers(i, playerid);
		if(dist <= radi && dist != -1.00) {
			radi = dist;
			p1 = i;
		}
	}

	return p1;
}

stock DateProp(playerid, ...) {
	static const STATIC_ARGS = 1;
	new argCount = numargs();
	if((argCount - STATIC_ARGS) > 0) { 
		for(new i = STATIC_ARGS; i < argCount; i++) {
			switch(getarg(i)) {
				case 0 : {
					new houseid = Pl::Info[playerid][pHouseKey];
					if(IsPlayerHouseOwner(playerid, houseid)) {
						HouseInfo[houseid][hDate] = gettime();
					}
				}
				
				case 1 : {
					if(Pl::Info[playerid][pPasport][0] != 0) {
						new currtime = gettime();
						if(currtime >= Pl::Info[playerid][pPasport][2]) {
							Pl::Info[playerid][pPasport][0] = 0;
							Pl::Info[playerid][pPasport][1] = 0;
							Pl::Info[playerid][pPasport][2] = 0;
							Send(playerid, COLOR_YELLOW, "* Ваш паспорт больше не действителен, новый можно получить в Мэрии.");
						}
					}
				}
			}
		}
	}
	return 1;
}

public: ClearBanList(currtime) {
	new banIp[16];
	new rows = cache_get_row_count();
	if(rows) {
		for(new i; i < rows; i++) {
			cache_get_row(i, 0, banIp);
			format(query, sizeof query, "unbanip %.16s", banIp);
			SendRconCommand(query);
		}
		format(query, sizeof query, "DELETE FROM `"#__TableBanned__"` WHERE `unbandate` <= '%i'", currtime);
		Db::tquery(connDb, query, "", "");
	}
	return 1;
}


public: Checkprop() {
	SendLog(LOG_HOUSE, "[Debug] Checkprop starting...");
	new count;
	foreach(new i : Houses) {
		if(HouseInfo[i][hOwned] && getday(gettime(), HouseInfo[i][hDate]) >= 15) {
			format(query, sizeof query, "[Debug] Home sold! HouseID: %i; Owner: %s; Price: %i", HouseInfo[i][hID], HouseInfo[i][hOwner], HouseInfo[i][hPrice]);
			SendLog(LOG_HOUSE, query);
			ClearHouse(i);
			count++;
		}
	}
	format(query, sizeof query, "[Debug] Total sales of houses: %i", count);
	SendLog(LOG_HOUSE, query);
	return 1;
}

public: onPayDay() {
	SendLog(LOG_PAYDAY_STATS, "[Debug] PayDay starting...");

	new
		tax,
		hkey,
		rent,
		bidx,
		ebill,
		interest,
		totaltax,
		tmpintrate = 1,
		totalebill,
		totalchecks
	;

	bidx = GetIndexFromBizID(Bizz_PowerHouse);
	foreach(new i : Player) {
		if(Pl::isLogged(i)) {
			if(Pl::Info[i][pLevel] > 0) {
				hkey = Pl::Info[i][pHouseKey];
				GetPlayerName(i, plname, 24);
				if(IsValidHouse(hkey)) {
					rent = HouseInfo[hkey][hRent][1];
					if(IsPlayerHouseOwner(i, hkey)) {
						rent = 0;
					} else {
						if(rent > Rac::GetPlayerMoney(i)) {
							Pl::Info[i][pHouseKey] = INVALID_HOUSE_ID;
							Send(i, COLOR_WHITE, "* Вы были выселены.");
							rent = 0;
						}
					}
					
					if(rent) {
						HouseInfo[hkey][hSafe][0] += rent;
						Rac::GivePlayerMoney(i, -rent);
					}

					ebill = (HouseInfo[hkey][hPrice] / BizzInfo[bidx][bEnterCost]);
					if(Pl::Info[i][pBank] > 0 || Rac::GetPlayerMoney(i) > 0) {
						totalebill += ebill;
						if(Pl::Info[i][pBank] >= ebill) GivePlayerBankMoney(i, -ebill);
						else Rac::GivePlayerMoney(i, -ebill);
					} else ebill = 0;
				}
				
				if(Pl::Info[i][pVip] > 0) tmpintrate = 3;
				
				interest = (Pl::Info[i][pBank]/1000)*(tmpintrate);
				
				if(Pl::Info[i][pPayDay] >= 9) {
					Pl::Info[i][pPayCheck] += GetPayCheck(Pl::Info[i][pLevel]);
					tax = floatround(PERCENT(Pl::Info[i][pPayCheck], Gm::Info[Gm::TaxValue]));
					Pl::Info[i][pExp]++;
					Pl::Info[i][pTime]++;
					Send(i, 0x34c92400, "|________________ЗАРПЛАТА______________|");
					sendf(i, src, COLOR_GREY, "* Чек: $%i Налог: -$%i", Pl::Info[i][pPayCheck], tax);
					sendf(i, src, COLOR_GREY, "* Баланс: $%i", Pl::Info[i][pBank]-interest);
					sendf(i, src, COLOR_GREY, "* Вклад в банке под: 0.%i процентов",tmpintrate);
					if(hkey != INVALID_HOUSE_ID) sendf(i, src, COLOR_GREY, "* Счет за электричество: -$%i", ebill);
					sendf(i, src, COLOR_GREY, "* Полученные средства по банковскому вкладу: $%i", interest);
					sendf(i, src, COLOR_GREY, "* Плата за аренду: -$%i", rent);
					Send(i, COLOR_GREY, "|--------------------------------------|");
					if(tax > 0) {
						totaltax += tax;
						Pl::Info[i][pPayCheck] -= tax;
					}
					totalchecks += Pl::Info[i][pPayCheck];
					GivePlayerBankMoney(i, interest);
					GivePlayerBankMoney(i, -Gm::Info[Gm::TaxValue]);
					GivePlayerBankMoney(i, Pl::Info[i][pPayCheck]);
					sendf(i, src, COLOR_GREY, "* Текущий баланс: $%i", Pl::Info[i][pBank]);
					GameTextForPlayer(i, "~y~Bank~n~~w~Paycheck", 5000, 1);
					PlayerPlayMusic(i);
					DEBUG[TOTAL_PLAYER_PAID] ++;
					
					Pl::Info[i][pPayDay] = 0;
					Pl::Info[i][pPayCheck] = 0;
					
					if(Pl::Info[i][pContractTime] != 0) {
						Pl::Info[i][pContractTime]--;
					}
					if(Pl::Info[i][pVip] > 0) {
						Pl::Info[i][pPayDayHad] += 1;
						if(Pl::Info[i][pPayDayHad] >= 5) {
							Pl::Info[i][pExp]++;
							Pl::Info[i][pPayDayHad] = 0;
						}
					}
					
					DateProp(i, 1);
					Pl::Update(i);
				} else {
					Send(i, COLOR_LIGHTRED, "*"#__SERVER_PREFIX""#__SERVER_NAME_LC": Вы играли слишком мало, поэтому сервер не выдал вам зарплату за прошлый час.");
				}
				if(MoneyMessage{i} && !(Rac::GetPlayerMoney(i) > 0 || Pl::Info[i][pBank] > 0)) {
					MoneyMessage{i} = false;
					Jailed(i, 300, 3);
					GameTextForPlayer(i, "~r~Busted!", 2000, 1);
					format(src, sizeof(src), "* Вы заключены в тюрьму на 10 минут! Причина: Задолжность");
					Send(i, COLOR_LIGHTBLUE, src);
				}
			}
		}
	}

	GiveFracMoney(7, totaltax);
	GiveBizzProfit(bidx, totalebill);
	
	format(src, sizeof(src), "PAYDAY STATS: Получивших зарплату: %i, Собрано налога: $%i, Ушло на зарплату: $%i, Счета за электричество: $%i", DEBUG[TOTAL_PLAYER_PAID], totaltax, totalchecks, totalebill);
	SendToAdmin(COLOR_YELLOW, src, 1, 4);
	format(src, sizeof(src), "PAYDAY STATS: Сохранений аккаунтов: %i, houses:%i/biznes:%i, MySQL-ошибок: %i, Сейчас играют: %i",
	DEBUG[TOTAL_SAVE_ACCOUNT], DEBUG[TOTAL_SAVE_HOUSES], DEBUG[TOTAL_SAVE_BIZNES], DEBUG[TOTAL_QUERY_ERRORS], Iter::Count(Player));
	SendToAdmin(COLOR_YELLOW, src, 1, 4);

	for(new i; i < sizeof(DEBUG); i++) DEBUG[i] = 0; // Clear debug
	
	return 1;
}

public: onPlayerRegister(playerid) {
	if(!IsPlayerConnected(playerid)) return 1;
	Pl::Info[playerid][pID] = cache_insert_id();
	if(Pl::Info[playerid][pID] == 1) Pl::Info[playerid][pAdmin] = 5;
	ShowLoginForm(playerid, 1);
	return 1;
}

public: onPlayerLogin(playerid) {
	if(!IsPlayerConnected(playerid)) return 1;
	
	if(cache_get_row_count() == 1) {
		cache_get_row(0, 1, plname);
		cache_get_int(0, 3, Pl::Info[playerid][pLevel]);
		cache_get_int(0, 4, Pl::Info[playerid][pAdmin]);
		cache_get_int(0, 5, Pl::Info[playerid][pHelper]);
		cache_get_int(0, 6, Pl::Info[playerid][pVip]);
		cache_get_int(0, 7, Pl::Info[playerid][pReg]);
		cache_get_int(0, 8, Pl::Info[playerid][pSex]);
		cache_get_int(0, 9, Pl::Info[playerid][pAge]);
		cache_get_int(0, 10, Pl::Info[playerid][pOrigin]);
		cache_get_int(0, 11, Pl::Info[playerid][pMuted]);
		cache_get_int(0, 12, Pl::Info[playerid][pExp]);
		Rac::SetPlayerMoney(playerid, cache_get_row_int(0, 13));
		cache_get_int(0, 14, Pl::Info[playerid][pBank]);
		cache_get_int(0, 15, Pl::Info[playerid][pCrimes]);
		cache_get_int(0, 16, Pl::Info[playerid][pKills]);
		cache_get_int(0, 17, Pl::Info[playerid][pTime]);
		cache_get_int(0, 18, Pl::Info[playerid][pDeaths]);
		cache_get_int(0, 19, Pl::Info[playerid][pArrested]);
		cache_get_int(0, 20, Pl::Info[playerid][pWantedL]);
		cache_get_int(0, 21, Pl::Info[playerid][pWantedD]);
		cache_get_int(0, 22, Pl::Info[playerid][pPhoneBook]);
		cache_get_int(0, 23, Pl::Info[playerid][pLottoNr]);
		cache_get_int(0, 24, Pl::Info[playerid][pJob]);
		cache_get_int(0, 25, Pl::Info[playerid][pPayCheck]);
		cache_get_int(0, 26, Pl::Info[playerid][pJailed]);
		cache_get_int(0, 27, Pl::Info[playerid][pJailTime]);
		cache_get_int(0, 28, Pl::Info[playerid][pMats]);
		cache_get_int(0, 29, Pl::Info[playerid][pDrugs]);
		cache_get_int(0, 30, Pl::Info[playerid][pLeader]);
		cache_get_int(0, 31, Pl::Info[playerid][pMember]);
		cache_get_int(0, 32, Pl::Info[playerid][pRank]);
		cache_get_int(0, 33, Pl::Info[playerid][pChar]);
		cache_get_int(0, 34, Pl::Info[playerid][pContractTime]);
		cache_get_str(0, 35, "p<,>a<i>[8]", Pl::Info[playerid][pSkill]);
		cache_get_int(0, 36, Pl::Info[playerid][pLocal]);
		cache_get_int(0, 37, Pl::Info[playerid][pNumber]);
		cache_get_int(0, 38, Pl::Info[playerid][pHouseKey]);
		cache_get_int(0, 39, Pl::Info[playerid][pBizKey]);
		cache_get_str(0, 40, "p<,>a<i>[4]", Pl::Info[playerid][pLic]);
		cache_get_int(0, 41, Pl::Info[playerid][pCarTime]);
		cache_get_int(0, 42, Pl::Info[playerid][pPayDay]);
		cache_get_int(0, 43, Pl::Info[playerid][pPayDayHad]);
		cache_get_int(0, 44, Pl::Info[playerid][pCDPlayer]);
		cache_get_int(0, 45, Pl::Info[playerid][pMutedTime]);
		cache_get_int(0, 46, Pl::Info[playerid][pWarns]);
		cache_get_int(0, 47, Pl::Info[playerid][pFuel]);
		cache_get_int(0, 48, Pl::Info[playerid][pFightstyle]);
		cache_get_int(0, 49, Pl::Info[playerid][pBanned]);
		cache_get_int(0, 50, Pl::Info[playerid][pTest]);
		cache_get_int(0, 51, Pl::Info[playerid][pRebuke]);
		cache_get_str(0, 52, "p<,>a<i>[3]", Pl::Info[playerid][pPasport]);
		cache_get_int(0, 53, Pl::Info[playerid][pLastVisit]);
	} else {
		WrongLogin[playerid]--;
		Send(playerid, COLOR_LIGHTRED, "*"#__SERVER_PREFIX""#__SERVER_NAME_LC": Неверный пароль! В случае 3-х кратного неверного ввода КИК!");
		ShowLoginForm(playerid, 1);
		return 1;
	}
	
	if(Pl::Info[playerid][pBanned] == 1) {
		Send(playerid, COLOR_YELLOW, "{ffffff}Введите {e85209}/(q)uit {ffffff}чтобы выйти из игры");
		SPD(playerid, D_NONE, 0, "• ACCOUNT BLOCKED •", "Этот аккуант был отключен администратором!\nВведите /q чтобы выйти из игры", "Ок", "");
		Kick(playerid);
		return 1;
	}
	
	Td::ShowForPlayer(playerid, Copyright);
	Td::ShowForPlayer(playerid, Logo[0]);
	Td::ShowForPlayer(playerid, Time);
	Add_To_Iterator(playerid);
	ShowBizZones(playerid);
	
	if(Pl::Info[playerid][pReg] == 0) {
		Rac::SetPlayerInterior(playerid, 3);
		Rac::SetPlayerPos(playerid, 215.3485, -133.1142, 1003.5078);
		Rac::SetPlayerFacingAngle(playerid, 92.2598);
		SetPlayerCameraPos(playerid, 210.4674, -131.8238, 1004.2631);
		SetPlayerCameraLookAt(playerid, 214.3328, -132.8457, 1004.1403);
		Rac::TogglePlayerControllable(playerid, false);
		SPD(playerid, D_REGG + 2, 0, "Sex", "Выберете пол вашего персонажа.", "ЖЕН", "МУЖ");
	} else {
		sendf(playerid, temp, COLOR_WHITE, "*"#__SERVER_PREFIX""#__SERVER_NAME_LC": Мы рады видеть тебя на сервере, %s!", plname);
		
		if(Pl::Info[playerid][pWantedL] > 0) {
			WantedTime[playerid] = 180;
			Pl::SetWantedLevel(playerid, Pl::Info[playerid][pWantedL]);
			sendf(playerid, temp, COLOR_YELLOW, "* Восстановление уровня розыска! Текущий уровень: %i зв.", Pl::Info[playerid][pWantedL]);
		}
		
		
		Pl::SetFracColor(playerid);
		DateProp(playerid, 0, 1);
		
		format(temp, sizeof temp, "~w~Welcome ~n~~g~   %s", plname);
		GameTextForPlayer(playerid, temp, 6000, 1);
		Pl::SetSpawnInfo(playerid);
		Rac::SpawnPlayer(playerid);
		
		if(!Pl::Info[playerid][pAdmin]) {
			format(temp, sizeof temp, "* %s (ID: %i) прокрался(ась) на ..::"#__SERVER_PREFIX""#__SERVER_NAME_LC"::.. [RUS]", plname, playerid);
			sendToLog(COLOR_GREY, src);
		}
		PlayerLogged{playerid} = true;
		
		format(query, sizeof query, "SELECT * FROM `"#__TableExtraVehicles__"` WHERE `owner` = '%i' ORDER BY `id` ASC", Pl::Info[playerid][pID]);
		Db::tquery(connDb, query, "LoadExtraVehicles", "i", playerid);
		
		format(query, sizeof query, "SELECT `f_id`,`mink` FROM `"#__TableBlacklist__"` WHERE `accused`='%i'", Pl::Info[playerid][pID]);
		Db::tquery(connDb, query, ""#Bl::"Check", "i", playerid);
	}
	return 1;
}

public: Pl::Update(playerid) {
	if(Pl::isLogged(playerid)) {
		new bidx = GetIndexFromBizID(Pl::Info[playerid][pBizKey]);
		new hidx = Pl::Info[playerid][pHouseKey];
		if(IsValidBiz(bidx)) UpdateBizz(bidx);
		if(IsValidHouse(hidx)) UpdateHouse(hidx);

		Pl::Info[playerid][pLastVisit] = gettime();
		format(query, sizeof query, "UPDATE `"#__TableUsers__"` SET ");
		scf(query, src, "`Level`='%i',", Pl::Info[playerid][pLevel]);
		scf(query, src, "`Admin`='%i',", Pl::Info[playerid][pAdmin]);
		scf(query, src, "`Helper`='%i',", Pl::Info[playerid][pHelper]);
		scf(query, src, "`Vip`='%i',", Pl::Info[playerid][pVip]);
		scf(query, src, "`Reg`='%i',", Pl::Info[playerid][pReg]);
		scf(query, src, "`Sex`='%i',", Pl::Info[playerid][pSex]);
		scf(query, src, "`Age`='%i',", Pl::Info[playerid][pAge]);
		scf(query, src, "`Origin`='%i',", Pl::Info[playerid][pOrigin]);
		scf(query, src, "`Muted`='%i',", Pl::Info[playerid][pMuted]);
		scf(query, src, "`Exp`='%i',", Pl::Info[playerid][pExp]);
		scf(query, src, "`Money`='%i',", Rac::GetPlayerMoney(playerid));
		scf(query, src, "`Bank`='%i',", Pl::Info[playerid][pBank]);
		scf(query, src, "`Crimes`='%i',", Pl::Info[playerid][pCrimes]);
		scf(query, src, "`Kill`='%i',", Pl::Info[playerid][pKills]);
		scf(query, src, "`Time`='%i',", Pl::Info[playerid][pTime]);
		scf(query, src, "`Deaths`='%i',", Pl::Info[playerid][pDeaths]);
		scf(query, src, "`Arrested`='%i',", Pl::Info[playerid][pArrested]);
		scf(query, src, "`WLevel`='%i',", Pl::Info[playerid][pWantedL]);
		scf(query, src, "`WDeaths`='%i',", Pl::Info[playerid][pWantedD]);
		scf(query, src, "`PhoneBook`='%i',", Pl::Info[playerid][pPhoneBook]);
		scf(query, src, "`LottoNr`='%i',", Pl::Info[playerid][pLottoNr]);
		scf(query, src, "`Job`='%i',", Pl::Info[playerid][pJob]);
		scf(query, src, "`PayCheck`='%i',", Pl::Info[playerid][pPayCheck]);
		scf(query, src, "`Jailed`='%i',", Pl::Info[playerid][pJailed]);
		scf(query, src, "`JailTime`='%i',", Pl::Info[playerid][pJailTime]);
		scf(query, src, "`Mats`='%i',", Pl::Info[playerid][pMats]);
		scf(query, src, "`Drugs`='%i',", Pl::Info[playerid][pDrugs]);
		scf(query, src, "`Leader`='%i',", Pl::Info[playerid][pLeader]);
		scf(query, src, "`Member`='%i',", Pl::Info[playerid][pMember]);
		scf(query, src, "`Rank`='%i',", Pl::Info[playerid][pRank]);
		scf(query, src, "`Char`='%i',", Pl::Info[playerid][pChar]);
		scf(query, src, "`Contract`='%i',", Pl::Info[playerid][pContractTime]);
		scf(query, src, "`skill`='%i,", Pl::Info[playerid][pSkill][0]);
		for(new i=1; i < 7; i++) scf(query, src, "%i,", Pl::Info[playerid][pSkill][i]);
		scf(query, src, "%i',", Pl::Info[playerid][pSkill][7]);
		scf(query, src, "`Local`='%i',", Pl::Info[playerid][pLocal]);
		scf(query, src, "`Number`='%i',", Pl::Info[playerid][pNumber]);
		scf(query, src, "`House`='%i',", Pl::Info[playerid][pHouseKey]);
		scf(query, src, "`Busines`='%i',", Pl::Info[playerid][pBizKey]);
		scf(query, src, "`licenses`='%i,%i,%i,%i',", Pl::Info[playerid][pLic][0], Pl::Info[playerid][pLic][1], Pl::Info[playerid][pLic][2], Pl::Info[playerid][pLic][3]);
		scf(query, src, "`CarTime`='%i',", Pl::Info[playerid][pCarTime]);
		scf(query, src, "`PayDay`='%i',", Pl::Info[playerid][pPayDay]);
		scf(query, src, "`PayDayHad`='%i',", Pl::Info[playerid][pPayDayHad]);
		scf(query, src, "`CDPlayer`='%i',", Pl::Info[playerid][pCDPlayer]);
		scf(query, src, "`MutedTime`='%i',", Pl::Info[playerid][pMutedTime]);
		scf(query, src, "`Warns`='%i',", Pl::Info[playerid][pWarns]);
		scf(query, src, "`Fuel`='%i',", Pl::Info[playerid][pFuel]);
		scf(query, src, "`Fightstyle`='%i',", Pl::Info[playerid][pFightstyle]);
		scf(query, src, "`Banned`='%i',", Pl::Info[playerid][pBanned]);
		scf(query, src, "`Test`='%i',", Pl::Info[playerid][pTest]);
		scf(query, src, "`Rebuke`='%i',", Pl::Info[playerid][pRebuke]);
		scf(query, src, "`Passport`='%i,%i,%i',", Pl::Info[playerid][pPasport][0], Pl::Info[playerid][pPasport][1], Pl::Info[playerid][pPasport][2]);
		scf(query, src, "`Online`='%i' ", Pl::Info[playerid][pLastVisit]);
		scf(query, src, "WHERE `ID`='%i'", Pl::Info[playerid][pID]);
		Db::tquery(connDb, query, "", "");
		DEBUG[TOTAL_SAVE_ACCOUNT] ++;
	}
	return 1;
}

stock UpdateHouse(i) {
	new safeDiscription[28];
	Db::escape_string(HouseInfo[i][hDescription], safeDiscription);
	format(query, sizeof query, "UPDATE `"#__TableHouses__"` SET ");
	scf(query, src, "`owned`='%i',", HouseInfo[i][hOwned]);
	scf(query, src, "`locked`='%i',", HouseInfo[i][hLock]);
	scf(query, src, "`owner`='%s',", HouseInfo[i][hOwner]);
	scf(query, src, "`description`='%s',", safeDiscription);
	scf(query, src, "`price`='%i',", HouseInfo[i][hPrice]);
	scf(query, src, "`level`='%i',", HouseInfo[i][hLevel]);
	scf(query, src, "`interior`='%i',", HouseInfo[i][hInt]);
	scf(query, src, "`date`='%i',", HouseInfo[i][hDate]);
	scf(query, src, "`tv`='%i',", HouseInfo[i][hTv]);
	scf(query, src, "`rent`='%i',", HouseInfo[i][hRent][0], HouseInfo[i][hRent][1]);
	scf(query, src, "`safe`='%i,%i,%i,%i,%i',", HouseInfo[i][hSafe][0], HouseInfo[i][hSafe][1], HouseInfo[i][hSafe][2], HouseInfo[i][hSafe][3], HouseInfo[i][hSafe][4]);
	scf(query, src, "`safe_weap`='%i,%i,%i,%i,%i,%i',", HouseInfo[i][hGuns][0], HouseInfo[i][hGuns][1], HouseInfo[i][hGuns][2], HouseInfo[i][hGuns][3], HouseInfo[i][hGuns][4], HouseInfo[i][hGuns][5]);
	scf(query, src, "`safe_ammo`='%i,%i,%i,%i,%i,%i',", HouseInfo[i][hAmmos][0], HouseInfo[i][hAmmos][1], HouseInfo[i][hAmmos][2], HouseInfo[i][hAmmos][3], HouseInfo[i][hAmmos][4], HouseInfo[i][hAmmos][5]);
	scf(query, src, "`enter`='%.3f,%.3f,%.3f,%.3f',", HouseInfo[i][hEnter][0], HouseInfo[i][hEnter][1], HouseInfo[i][hEnter][2], HouseInfo[i][hEnter][3]);
	scf(query, src, "`exit`='%.3f,%.3f,%.3f,%.3f',", HouseInfo[i][hExit][0], HouseInfo[i][hExit][1], HouseInfo[i][hExit][2], HouseInfo[i][hExit][3]);
	scf(query, src, "`vehicle`='%i',", HouseInfo[i][hvModel]);
	scf(query, src, "`vehicle_color`='%i,%i',", HouseInfo[i][hvColor][0], HouseInfo[i][hvColor][1]);
	scf(query, src, "`vehicle_park`='%i',", HouseInfo[i][hvPark]);
	if(IsValidVehicle(HouseInfo[i][hAuto])) {
		scf(query, src, "`vehicle_mileage`='%f',", AutoInfo[HouseInfo[i][hAuto]][aMileage]);
	}
	scf(query, src, "`vehicle_spawn`='%.3f,%.3f,%.3f,%.3f' ", HouseInfo[i][hvSpawn][0], HouseInfo[i][hvSpawn][1], HouseInfo[i][hvSpawn][2], HouseInfo[i][hvSpawn][3]);
	scf(query, src, "WHERE `id`='%i'", HouseInfo[i][hID]);
	Db::tquery(connDb, query, "", "");
	DEBUG[TOTAL_SAVE_HOUSES]++;
	return 1;
}

stock UpdateHouseGarage(idx) {
	format(query, sizeof query, "UPDATE `"#__TableHouseGarages__"` SET ");
	scf(query, src, "`intpos`='%.3f,%.3f,%.3f,%.3f',", HouseInfo[idx][hgIntPos][0], HouseInfo[idx][hgIntPos][1], HouseInfo[idx][hgIntPos][2], HouseInfo[idx][hgIntPos][3]);
	scf(query, src, "`streetpos`='%.3f,%.3f,%.3f,%.3f' ", HouseInfo[idx][hgStreetPos][0], HouseInfo[idx][hgStreetPos][1], HouseInfo[idx][hgStreetPos][2], HouseInfo[idx][hgStreetPos][3]);
	scf(query, src, "WHERE `house`='%i'", HouseInfo[idx][hID]);
	Db::tquery(connDb, query, "", "");
	return 1;
}

stock DeleteHouseGarage(idx) {
	if(HouseInfo[idx][hgGarage]) {
		HouseInfo[idx][hgGarage] = false;
		DestroyDynamicPickup(HouseInfo[idx][hgPickupInt]);
		DestroyDynamicPickup(HouseInfo[idx][hgPickupStreet]);
		format(query, sizeof query, "DELETE FROM `"#__TableHouseGarages__"` WHERE `house` = '%i'", HouseInfo[idx][hID]);
		Db::tquery(connDb, query, "", "");
	}
	return 1;
}

stock Fc::Update(idx) {
	format(query, sizeof query, "UPDATE `"#__TableFracVehicles__"` SET ");
	scf(query, src, "`model`='%i',", Fc::Info[idx][Fc::Model]);
	scf(query, src, "`frac`='%i',", Fc::Info[idx][Fc::FracId]);
	scf(query, src, "`rank`='%i',", Fc::Info[idx][Fc::RankId]);
	scf(query, src, "`colors`='%i,%i',", Fc::Info[idx][Fc::Color][0], Fc::Info[idx][Fc::Color][1]);
	scf(query, src, "`number`='%s',", Fc::Info[idx][Fc::Number]);
	scf(query, src, "`resp_pos`='%.3f,%.3f,%.3f,%.3f',", Fc::Info[idx][Fc::RespPos][0], Fc::Info[idx][Fc::RespPos][1], Fc::Info[idx][Fc::RespPos][2], Fc::Info[idx][Fc::RespPos][3]);
	scf(query, src, "`miles`='%f' ", AutoInfo[Fc::Info[idx][Fc::Id][1]][aMileage]);
	scf(query, src, "WHERE `ID`='%i'", Fc::Info[idx][Fc::Id][0]);
	Db::tquery(connDb, query, "", "");
	return 1;
}

stock UpdateBizz(i) {
	new safeDescription[24];
	Db::escape_string(BizzInfo[i][bDescription], safeDescription, connDb);
	format(query, sizeof query, "UPDATE `"#__TableBusines__"` SET ");
	scf(query, src, "`owned`='%i',", BizzInfo[i][bOwned]);
	scf(query, src, "`locked`='%i',", BizzInfo[i][bLocked]);
	scf(query, src, "`owner`='%s',", BizzInfo[i][bOwner]);
	scf(query, src, "`extortion`='%s',", BizzInfo[i][bExtortion]);
	scf(query, src, "`description`='%s',", safeDescription);
	scf(query, src, "`level`='%i',", BizzInfo[i][bLevel]);
	scf(query, src, "`price`='%i',", BizzInfo[i][bPrice]);
	scf(query, src, "`safe`='%i',", BizzInfo[i][bSafe]);
	scf(query, src, "`enter_cost`='%i',", BizzInfo[i][bEnterCost]);
	scf(query, src, "`keeper`='%i',", BizzInfo[i][bFrac]);
	scf(query, src, "`prods`='%i',", BizzInfo[i][bProds]);
	scf(query, src, "`max_prods`='%i',", BizzInfo[i][bMaxProds]);
	scf(query, src, "`price_prods`='%i',", BizzInfo[i][bPriceProd]);
	scf(query, src, "`interior`='%i',", BizzInfo[i][bInterior]);
	scf(query, src, "`icon`='%i,%i',", BizzInfo[i][bIcon][0], BizzInfo[i][bIcon][1]);
	scf(query, src, "`enter`='%.3f,%.3f,%.3f,%.3f',", BizzInfo[i][bEnter][0], BizzInfo[i][bEnter][1], BizzInfo[i][bEnter][2], BizzInfo[i][bEnter][3]);
	scf(query, src, "`exit`='%.3f,%.3f,%.3f,%.3f' ", BizzInfo[i][bExit][0], BizzInfo[i][bExit][1], BizzInfo[i][bExit][2], BizzInfo[i][bExit][3]);
	scf(query, src, "WHERE `id` = '%i'", BizzInfo[i][bID]);
	Db::tquery(connDb, query, "", "");
	DEBUG[TOTAL_SAVE_BIZNES]++;
	return 1;
}

stock UpdateBizzPickups(b) {
	if(BizzInfo[b][bOwned]) {
		DestroyDynamicMapIcon(BizzInfo[b][bMapIcon]);
		DestroyDynamicPickup(BizzInfo[b][bPickupEnter]);
		if(BizzInfo[b][bIcon][BizzInfo[b][bOwned]] != 0) {
			BizzInfo[b][bMapIcon] = CreateDynamicMapIcon(BizzInfo[b][bEnter][0],BizzInfo[b][bEnter][1],BizzInfo[b][bEnter][2], BizzInfo[b][bIcon][BizzInfo[b][bOwned]], 0, -1, -1, -1, 250.0);
		}
		BizzInfo[b][bPickupEnter] = AddPickup(1239, 23, BizzInfo[b][bEnter][0], BizzInfo[b][bEnter][1], BizzInfo[b][bEnter][2],-1);
	} else {
		DestroyDynamicMapIcon(BizzInfo[b][bMapIcon]);
		DestroyDynamicPickup(BizzInfo[b][bPickupEnter]);
		if(BizzInfo[b][bIcon][BizzInfo[b][bOwned]] != 0) {
			BizzInfo[b][bMapIcon] = CreateDynamicMapIcon(BizzInfo[b][bEnter][0],BizzInfo[b][bEnter][1], BizzInfo[b][bEnter][2], BizzInfo[b][bIcon][BizzInfo[b][bOwned]], 0, -1, -1, -1, 250.0);
		}
		BizzInfo[b][bPickupEnter] = AddPickup(1272, 23, BizzInfo[b][bEnter][0], BizzInfo[b][bEnter][1], BizzInfo[b][bEnter][2],-1);
	}
	return 1;
}

stock UpdateHousePickups(i) {
	DestroyDynamicPickup(HouseInfo[i][hPickup]);
	DestroyDynamicMapIcon(HouseInfo[i][hMapIcon]);
	switch(HouseInfo[i][hOwned]) {
		case 0 : {
			HouseInfo[i][hPickup] = AddPickup(1273, 23, HouseInfo[i][hEnter][0], HouseInfo[i][hEnter][1], HouseInfo[i][hEnter][2], 0);
			HouseInfo[i][hMapIcon] = CreateDynamicMapIcon( HouseInfo[i][hEnter][0], HouseInfo[i][hEnter][1], HouseInfo[i][hEnter][2], 31, 0, 0, -1, -1, 250.0);
		}
		case 1 : {
			HouseInfo[i][hPickup] = AddPickup(1318, 23, HouseInfo[i][hEnter][0], HouseInfo[i][hEnter][1], HouseInfo[i][hEnter][2], 0);
			HouseInfo[i][hMapIcon] = CreateDynamicMapIcon(HouseInfo[i][hEnter][0], HouseInfo[i][hEnter][1], HouseInfo[i][hEnter][2], 32,0, 0, -1, -1, 250.0);
		}
	}
	return 1;
}

stock SaveToSQL(idx, type = 1) {
	if(type == 2) {
		format(query, sizeof query, "INSERT INTO `"#__TableVehicles__"` (`Model`,`pX`,`pY`,`pZ`,`pA`,");
		scf(query, temp, "`col1`,`col2`,`resp`) VALUES ('%i',", VehicleInfo[idx][vModel]);
		scf(query, temp, "'%f','%f','%f','%f',", VehicleInfo[idx][vPosX], VehicleInfo[idx][vPosY], VehicleInfo[idx][vPosZ], VehicleInfo[idx][vPosA]);
		scf(query, temp, "'%i','%i','%i')", VehicleInfo[idx][vColor1], VehicleInfo[idx][vColor2], VehicleInfo[idx][vRespTime]);

		new Cache:result = Db::query(connDb, query, true);
		VehicleInfo[idx][vID] = cache_insert_id();
		cache_delete(result);
	}
	return 1;
}

stock UpdateToSQL(idx, type=0) {
	switch(type) {
		case 0 : {
			format(query, sizeof query, "UPDATE `"#__TableVehicles__"` SET ");
			scf(query, src, "`Model`='%i',", VehicleInfo[idx][vModel]);
			scf(query, src, "`pX`='%f',", VehicleInfo[idx][vPosX]);
			scf(query, src, "`pY`='%f',", VehicleInfo[idx][vPosY]);
			scf(query, src, "`pZ`='%f',", VehicleInfo[idx][vPosZ]);
			scf(query, src, "`pA`='%f',", VehicleInfo[idx][vPosA]);
			scf(query, src, "`aM`='%f',", AutoInfo[VehicleInfo[idx][cID]][aMileage]);
			scf(query, src, "`col1`='%i',", VehicleInfo[idx][vColor1]);
			scf(query, src, "`col2`='%i',", VehicleInfo[idx][vColor2]);
			scf(query, src, "`resp`='%i',", VehicleInfo[idx][vRespTime]);
			scf(query, src, "`job`='%i' ", VehicleInfo[idx][vJob]);
			scf(query, src, "WHERE `ID`='%i'", VehicleInfo[idx][vID]);
			Db::tquery(connDb, query, "", "");
			return 1;
		}
	}
	return 0;
}

stock RemoveInSQL(idx, type=1) {
	switch(type) {
		case 2 : {
			format(query, sizeof query, "DELETE FROM `"#__TableVehicles__"` WHERE `ID` = '%i'", VehicleInfo[idx][vID]);
			Db::tquery(connDb, query, "", "");
			return 1;
		}
	}

	return 0;
}

stock updatePickup( i ) {
	format(query, sizeof query, "UPDATE `"#__TablePickups__"` SET ");
	scf(query,src,"`models`='%i,%i',", Ptl::Info[i][Ptl::Model][0], Ptl::Info[i][Ptl::Model][1]);
	scf(query,src,"`types`='%i,%i',", Ptl::Info[i][Ptl::Type][0], Ptl::Info[i][Ptl::Type][1]);
	scf(query,src,"`interiors`='%i,%i',", Ptl::Info[i][Ptl::Inter][0], Ptl::Info[i][Ptl::Inter][1]);
	scf(query,src,"`worlds`='%i,%i',", Ptl::Info[i][Ptl::World][0], Ptl::Info[i][Ptl::World][1]);
	scf(query,src,"`portal1`='%.4f,%.4f,", Ptl::Info[i][Ptl::Portal1][0], Ptl::Info[i][Ptl::Portal1][1]);
	scf(query,src,"%.4f,%.4f',", Ptl::Info[i][Ptl::Portal1][2], Ptl::Info[i][Ptl::Portal1][3]);
	scf(query,src,"`portal2`='%.4f,%.4f,", Ptl::Info[i][Ptl::Portal2][0], Ptl::Info[i][Ptl::Portal2][1]);
	scf(query,src,"%.4f,%.4f',", Ptl::Info[i][Ptl::Portal2][2], Ptl::Info[i][Ptl::Portal2][3]);
	scf(query,src,"`allowed`='%i' ", arrayToBin(Ptl::Info[i][Ptl::Allowed], MAX_FRAC));
	scf(query,src,"WHERE `id`='%i'", Ptl::Info[i][Ptl::Id]);
	Db::tquery(connDb, query, "", "");
	return 1;
}

stock updateAntiDmZone(zone) {
	format(query, sizeof query, "UPDATE `"#__TableAntidmzones__"` SET ");
	scf(query,src,"`world`='%i',", AntiDmInfo[zone][e_AntiDmWorld]);
	scf(query,src,"`coord`='%.4f,", AntiDmInfo[zone][e_AntiDmCoord][0]);
	scf(query,src,"%.4f,", AntiDmInfo[zone][e_AntiDmCoord][1]);
	scf(query,src,"%.4f,", AntiDmInfo[zone][e_AntiDmCoord][2]);
	scf(query,src,"%.4f'", AntiDmInfo[zone][e_AntiDmCoord][3]);
	scf(query,src," WHERE `id`='%i'", AntiDmInfo[zone][e_AntiDmZoneId]);
	Db::tquery(connDb, query, "", "");
	return 1;
}


public OnPlayerCommandReceived(playerid, cmdtext[]) {
	if(!Pl::isLogged(playerid)) return Send(playerid, COLOR_GREY, "* Вы не авторизованы!");
	return 1;
}


public OnPlayerCommandPerformed(playerid, cmdtext[], success) {
	switch(success) {
		case -1 : Send(playerid, COLOR_GRAD1, "* Такой команды не существует!");
	}
    return 1;
}


#include "../include/gwrp/cmd/AdminCommand.pwn"
#include "../include/gwrp/cmd/UserCommand.pwn"
#include "../include/gwrp/cmd/LeaderCommand.pwn"
#include "../include/gwrp/cmd/HelperCommand.pwn"


public OnPlayerText(playerid, text[]) {
	if(isnull(text) || text[0] == ' ') return 0;
	if(!Pl::isLogged(playerid)) return !Send(playerid, COLOR_GREY, "* Вы не авторизованы!");
	if(Gag{playerid}) return !Send(playerid,COLOR_GREY,"* У Вас кляп во рту!");
	if(IsPMuted(playerid))return !Send(playerid, COLOR_CYAN, "* Админ отнял у вас возможность говорить в главном чате.");

	new replacetext[144], tmp[32], string[144], sendername[24];
	regex_replace_exid(text, ADBlock, REPLACE_TEXT, replacetext, sizeof replacetext);
	
	if(OnAir{playerid}) {
		new veh = GetPlayerVehicleID(playerid);
		if(IsPlayerInRangeOfPoint(playerid,5.0,353.4343,272.8408,1008.6656)) {
			switch(++Pl::Info[playerid][pSkill][6]) {
				case 50 : Send(playerid, COLOR_YELLOW, "* Ваш Навык Репортера Новостей - теперь Уровень 2");
				case 100 : Send(playerid, COLOR_YELLOW, "* Ваш Навык Репортера Новостей - теперь Уровень 3");
				case 200 : Send(playerid, COLOR_YELLOW, "* Ваш Навык Репортера Новостей - теперь Уровень 4, теперь вы можете управлять вертолетом");
				case 400 : Send(playerid, COLOR_YELLOW, "* Ваш Навык Репортера Новостей - теперь Уровень 5, теперь вы можете брать интервью");
			}
			GetPlayerName(playerid, sendername, 24);
			format(string, sizeof(string), "*[Пресса] %s: %s", sendername, replacetext);
			OOCNews(COLOR_LIGHTBLUE, string);
		} else if(veh != 0) {
			if(IsANews(veh)) {
				switch(++Pl::Info[playerid][pSkill][6]) {
					case 50 : Send(playerid, COLOR_YELLOW, "* Ваш Навык Репортера Новостей - теперь Уровень 2");
					case 100 : Send(playerid, COLOR_YELLOW, "* Ваш Навык Репортера Новостей - теперь Уровень 3");
					case 200 : Send(playerid, COLOR_YELLOW, "* Ваш Навык Репортера Новостей - теперь Уровень 4, теперь вы можете управлять вертолетом");
					case 400 : Send(playerid, COLOR_YELLOW, "* Ваш Навык Репортера Новостей - теперь Уровень 5, теперь вы можете брать интервью");
				}
				GetPlayerName(playerid, sendername, 24);
				format(string, sizeof(string), "*[Пресса] %s: %s", sendername, replacetext);
				OOCNews(COLOR_LIGHTBLUE, string);
			}
		}
		return 0;
	}
	
	if(TalkingLive[playerid] != INVALID_PLAYER_ID) {
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(Pl::FracID(playerid) == 9) {
		    format(string, sizeof(string), "*[Пресса] Репортер %s: %s", sendername, replacetext);
			OOCNews(0x5CFEB9AA, string);
		} else {
		    format(string, sizeof(string), "*[Пресса] Интервьюер %s: %s", sendername, replacetext);
			OOCNews(0x5CFEB9AA, string);
		}
		return 0;
	}
	
	if(CallLawyer[playerid] == 111) {
	    sscanf(replacetext, "s[24]", tmp);
	    if((strcmp("yes", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("yes"))) {
			WantLawyer[playerid] = 0;
			CallLawyer[playerid] = 0;
		    GetPlayerName(playerid, sendername, sizeof(sendername));
		    format(string, sizeof(string), "** %s находится в Тюрьме, и нуждается в Адвокате. Пройдите в Отделение полиции.", sendername);
	    	SendJobMessage(2, COLOR_AZTECAS, string);
	    	SendJobMessage(2, COLOR_AZTECAS, "* Когда Вы в Отделении полиции, попросите, чтобы офицер одобрил Вас с /accept lawyer.");
	    	Send(playerid, COLOR_LIGHTRED, "Сообщение послали всем доступным Адвокатам, пожалуйста ждите.");
	    	return 0;
		} else {
			WantLawyer[playerid] = 0;
			CallLawyer[playerid] = 0;
		    Send(playerid, COLOR_LIGHTRED, "Нет Адвоката, доступного для Вас, Тюремное заключение началось.");
		}
		return 0;
	}
	
	if(Mobile[playerid] != INVALID_PLAYER_ID) {
		if(Pl::isLogged(Mobile[playerid])) {
			if(Mobile[Mobile[playerid]] == playerid) {
				GetPlayerName(playerid, sendername, sizeof(sendername));
				format(string, sizeof(string), "%s говорит (телефон): %s", sendername, replacetext);
				ProxDetector(10.0, playerid, string);
				Send(Mobile[playerid], COLOR_FADE1, string);
			}
		}
		return 0;
	}
	
	if(Pl::Info[playerid][pMaskOn]) {
		format(string, sizeof(string), "Неизвесный говорит: %s", replacetext);
		ProxDetector(20.0, playerid, string);
		if(!IsPlayerInAnyVehicle(playerid)) {
			AnimClear[playerid] = 4;
			ApplyAnimation(playerid,"PED","IDLE_chat",4.1,0,1,1,1,1);
		}
	} else {
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), "* %s[%i] сказал: %s", sendername, playerid, replacetext);
		SetPlayerChatBubble(playerid, replacetext, COLOR_GREEN, 50.0, 10000);
		ProxDetector(20.0, playerid, string);
		if(!IsPlayerInAnyVehicle(playerid)) {
			AnimClear[playerid] = 4;
			ApplyAnimation(playerid,"PED","IDLE_chat",4.1,0,1,1,1,1);
		}
	}
	
	return 0;
}

stock FixHour(hour) {
	hour = timeshift+hour;
	if(hour < 0) {
		hour = hour+24;
	} else if(hour > 23) {
		hour = hour-24;
	}
	shifthour = hour;
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {

	new string[256];
	switch(dialogid) {
		
		case D_NONE : {
		
		}
		
		case D_EDIT_MAPS : {
			if(response) {
				if(!strcmp(inputtext, "Добавить", true)) {
					SPD(playerid, D_EDIT_MAPS + 1, DIALOG_STYLE_INPUT, "Добавить", "Введите имя карты\n\
					Пример: maps/karta.map", "ENTER", "CANCEL");
				}
				else if(strcmp(inputtext, "------------", true) != 0) {
					inputtext[strfind(inputtext, ".")] = '\0';
					new id = strval(inputtext);
					SetPVarInt(playerid, "SelectedItem", id);
					SPD(playerid, D_EDIT_MAPS + 2, DIALOG_STYLE_LIST, MapInfo[id][MapFile], "Изменить\nПерезагрузить\nИзменить вирт. мир\nИзменить интерьер\nУдалить", "SELECT", "CANCEL");
				}
			}
		}
		
		case D_EDIT_MAPS + 1 : {
			if(response) {
				if(sscanf(inputtext, "s[36]", inputtext[0])) {
					SPD(playerid, D_EDIT_MAPS + 1, DIALOG_STYLE_INPUT, "Добавить", "Введите путь до карты\n\
					Пример: karta.map", "ENTER", "CANCEL");
				} else if(!fexist(inputtext[0])) {
					Send(playerid, COLOR_GREY, "* Нет такого файла!");
					SPD(playerid, D_EDIT_MAPS + 1, DIALOG_STYLE_INPUT, "Добавить", "Введите путь до карты\n\
					Пример: maps/karta.map", "ENTER", "CANCEL");
				} else {
					new escapetext[36];
					Db::escape_string(inputtext[0], escapetext);
					format(query, sizeof query, "INSERT INTO `maps` (`map_file`) VALUES ('%s')", escapetext);
					new Cache:result = Db::query(connDb, query, true);
					if(cache_affected_rows()) {
						new id = cache_insert_id();
						Iter::Add(Maps, id);
						MapInfo[id][MapID] = map::Load(inputtext[0]);
						strmid(MapInfo[id][MapFile], inputtext[0], 0, strlen(inputtext[0]), 36);
						MapInfo[id][MapWorld] = -1;
						MapInfo[id][MapInt] = -1;
						Send(playerid, COLOR_YELLOW, "* Карта была добавлена!");
					} else {
						Send(playerid, COLOR_LIGHTRED, "* При добавлении произошла ошибка!");
					}
					cache_delete(result);
				}
			}
		}
		
		case D_EDIT_MAPS + 2 : {
			if(response) {
				switch(listitem) {
					case 0 : SPD(playerid, D_EDIT_MAPS + 3, DIALOG_STYLE_INPUT, "Изменить", "Введите новый путь до карты:", "ENTER", "CANCEL");
					case 1 : {
						new id = GetPVarInt(playerid, "SelectedItem");
						SetPVarInt(playerid, "SelectedItem", -1);
						map::Destroy(MapInfo[id][MapID]);
						MapInfo[id][MapID] = map::Load(MapInfo[id][MapFile], MapInfo[id][MapWorld], MapInfo[id][MapInt]);
						Send(playerid, COLOR_GREY, "* Карта была перезагружена!");
					}
					
					case 2 : SPD(playerid, D_EDIT_MAPS + 4, DIALOG_STYLE_INPUT, "Изменить вирт. мир", "Введите ид виртуального мира:", "ENTER", "CANCEL");
					case 3 : SPD(playerid, D_EDIT_MAPS + 5, DIALOG_STYLE_INPUT, "Изменить интерьер", "Введите ид интерьера:", "ENTER", "CANCEL");
					case 4 : SPD(playerid, D_EDIT_MAPS + 6, DIALOG_STYLE_MSGBOX, "Удалить", "Вы точно хотите удалить карту?", "YES", "NO");
				}
			} else {
				SetPVarInt(playerid, "SelectedItem", -1);
			}
		}
		
		case D_EDIT_MAPS + 3 : {
			new id = GetPVarInt(playerid, "SelectedItem");
			if(response) {
				if(sscanf(inputtext, "s[36]", inputtext[0])) {
					SPD(playerid, D_EDIT_MAPS + 3, DIALOG_STYLE_INPUT, "Изменить", "Введите путь до карты\n\
					Пример: karta.map", "ENTER", "CANCEL");
				} else if(!fexist(inputtext[0])) {
					Send(playerid, COLOR_GREY, "* Нет такого файла!");
					SPD(playerid, D_EDIT_MAPS + 3, DIALOG_STYLE_INPUT, "Изменить", "Введите путь до карты\n\
					Пример: maps/karta.map", "ENTER", "CANCEL");
				} else {
					new escapetext[36];
					Db::escape_string(inputtext[0], escapetext);
					format(query, sizeof query, "UPDATE `maps` SET `map_file` = '%s' WHERE `id` = '%i'", escapetext, id);
					Db::tquery(connDb, query);

					map::Destroy(MapInfo[id][MapID]);
					MapInfo[id][MapID] = map::Load(inputtext[0], MapInfo[id][MapWorld], MapInfo[id][MapInt]);
					strmid(MapInfo[id][MapFile], inputtext[0], 0, strlen(inputtext[0]), 36);
					Send(playerid, COLOR_YELLOW, "* Карта была изменина!");
					SetPVarInt(playerid, "SelectedItem", -1);
				}
			} else {
				SPD(playerid, D_EDIT_MAPS + 2, DIALOG_STYLE_LIST, MapInfo[id][MapFile], "Изменить\nПерезагрузить\nИзменить вирт. мир\nИзменить интерьер\nУдалить", "SELECT", "CANCEL");
			}
		}
		
		case D_EDIT_MAPS + 4 : {
			new id = GetPVarInt(playerid, "SelectedItem");
			if(response) {
				if(sscanf(inputtext, "i", inputtext[0])) {
					SPD(playerid, D_EDIT_MAPS + 4, DIALOG_STYLE_INPUT, "Изменить вирт. мир", "Введите ид виртуального мира:", "ENTER", "CANCEL");
				} else {
					format(query, sizeof query, "UPDATE `maps` SET `map_world` = '%i' WHERE `id` = '%i'", inputtext[0], id);
					Db::tquery(connDb, query);
					map::SetWorld(MapInfo[id][MapID], inputtext[0]);
					Send(playerid, COLOR_YELLOW, "* Виртуальный мир карты был изменен!");
					SetPVarInt(playerid, "SelectedItem", -1);
				}
			} else {
				SPD(playerid, D_EDIT_MAPS + 2, DIALOG_STYLE_LIST, MapInfo[id][MapFile], "Изменить\nПерезагрузить\nИзменить вирт. мир\nИзменить интерьер\nУдалить", "SELECT", "CANCEL");
			}
		}
		
		case D_EDIT_MAPS + 5 : {
			new id = GetPVarInt(playerid, "SelectedItem");
			if(response) {
				if(sscanf(inputtext, "i", inputtext[0])) {
					SPD(playerid, D_EDIT_MAPS + 5, DIALOG_STYLE_INPUT, "Изменить интерьер", "Введите ид интерьера:", "ENTER", "CANCEL");
				} else {
					format(query, sizeof query, "UPDATE `maps` SET `map_int` = '%i' WHERE `id` = '%i'", inputtext[0], id);
					Db::tquery(connDb, query);
					map::SetInterior(MapInfo[id][MapID], inputtext[0]);
					Send(playerid, COLOR_YELLOW, "* Интерьер карты карты был изменен!");
					SetPVarInt(playerid, "SelectedItem", -1);
				}
			} else {
				SPD(playerid, D_EDIT_MAPS + 2, DIALOG_STYLE_LIST, MapInfo[id][MapFile], "Изменить\nПерезагрузить\nИзменить вирт. мир\nИзменить интерьер\nУдалить", "SELECT", "CANCEL");
			}
		}
		
		case D_EDIT_MAPS + 6 : {
			new id = GetPVarInt(playerid, "SelectedItem");
			if(response) {
				SetPVarInt(playerid, "SelectedItem", -1);
				new last = Iter::Count(Maps);
				map::Destroy(MapInfo[id][MapID]);
				format(query, sizeof query, "DELETE FROM `maps` WHERE `id` = '%i'", id);
				Db::tquery(connDb, query);
				
				if(last > id) {
					MapInfo[id][MapID] = MapInfo[last][MapID];
					CopyArray(MapInfo[id][MapFile], MapInfo[last][MapFile], 36);
					MapInfo[id][MapWorld] = MapInfo[last][MapWorld];
					MapInfo[id][MapInt] = MapInfo[last][MapInt];
					Iter::Remove(Maps, last);
					format(query, sizeof query, "UPDATE `maps` SET `id` = '%i' WHERE `id` = '%i'", id, last);
					Db::tquery(connDb, query);
				} else {
					Iter::Remove(Maps, id);
				}
				format(query, sizeof query, "ALTER TABLE `maps` AUTO_INCREMENT = %i", last - 1);
				Db::tquery(connDb, query);
				
				Send(playerid, COLOR_YELLOW, "* Карта была удалена!");
			} else {
				SPD(playerid, D_EDIT_MAPS + 2, DIALOG_STYLE_LIST, MapInfo[id][MapFile], "Изменить\nПерезагрузить\nИзменить вирт. мир\nИзменить интерьер\nУдалить", "SELECT", "CANCEL");
			}
		}
		
		case D_EV_MENU : {
			if(response) {
				format(string, sizeof string, "extra[%i]", listitem);
				new item = GetPVarInt(playerid, string);
				SetPVarInt(playerid, "SelectedItem", item);
				format(string, sizeof string, "Транспорт: %s", VehicleNames[ExtraVehicles[playerid][item][evModel] - 400]);
				dialog[0]='\0';
				if(IsValidHouse(Pl::Info[playerid][pHouseKey])) scf(dialog, temp, "Заспавнить\nПрипарковать");
				scf(dialog, temp, "\nИзменить цвет");
				SPD(playerid, D_EV_MENU+1, DIALOG_STYLE_LIST, string, dialog, "SELECT", "CANCEL");
			}
		}
		
		case D_EV_MENU+1 : {
			if(response) {
				new item = GetPVarInt(playerid, "SelectedItem");
				if(strfind(inputtext, "Заспавнить") != -1) {
					if(GetVehiclePassengers(ExtraVehicles[playerid][item][evID2])) return GameTextForPlayer(playerid, "~w~Car is~n~in ~r~use", 5000, 1);
					if(ExtraVehicles[playerid][item][evPark] == PARK_GARAGE) {
						Veh::Destroy(ExtraVehicles[playerid][item][evID2]);
					} else {
						SetVehicleToRespawn(ExtraVehicles[playerid][item][evID2]);
					}
					PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
					Send(playerid, COLOR_LIGHTBLUE, "* Транспорт отбуксирован на место парковки!");
				}
				
				else if(strfind(inputtext, "Припарковать") != -1) {
					new hid = Pl::Info[playerid][pHouseKey];
					new veh = GetPlayerVehicleID(playerid);
					if(!IsValidHouse(hid)) return Send(playerid, COLOR_GREY, "* У Вас нет дома!");
					if(veh != ExtraVehicles[playerid][item][evID2]) return Send(playerid, COLOR_GREY, "* Вы должны сидеть в траспорте!");
					if(IsPlayerInRangeOfPoint(playerid, 50.0, HouseInfo[hid][hEnter][0], HouseInfo[hid][hEnter][1], HouseInfo[hid][hEnter][2])) {
						ExtraVehicles[playerid][item][evPark] = PARK_HOME;
					} else if(IsPlayerInHouseGarage(playerid)) {
						ExtraVehicles[playerid][item][evPark] = PARK_HOME_GARAGE * hid;
					} else {
						return Send(playerid, COLOR_GREY, "* Вы слишком далеко от дома!");
					}
					GetVehiclePos(veh, ExtraVehicles[playerid][item][evSpawnX], ExtraVehicles[playerid][item][evSpawnY], ExtraVehicles[playerid][item][evSpawnZ]);
					GetVehicleZAngle(veh, ExtraVehicles[playerid][item][evSpawnA]);
					Veh::Destroy(veh);
					RemoveExtraVehicleFromGarage(playerid, item);
					ExtraVehicles[playerid][item][evID2] = Veh::Create(
						ExtraVehicles[playerid][item][evModel],
						ExtraVehicles[playerid][item][evSpawnX],
						ExtraVehicles[playerid][item][evSpawnY],
						ExtraVehicles[playerid][item][evSpawnZ],
						ExtraVehicles[playerid][item][evSpawnA],
						ExtraVehicles[playerid][item][evColor1],
						ExtraVehicles[playerid][item][evColor2],
						INFINITY
					);
					AutoInfo[ExtraVehicles[playerid][item][evID2]][aOwner] = playerid;
					if((ExtraVehicles[playerid][item][evPark] / hid) == PARK_HOME_GARAGE) {
						LinkVehicleToInterior(ExtraVehicles[playerid][item][evID2], 3);
						SetVehicleVirtualWorld(ExtraVehicles[playerid][item][evID2], Pl::Info[playerid][pHouseKey]);
					}
					SetVehicleNumber(ExtraVehicles[playerid][item][evID2]);
					Rac::PutPlayerInVehicle(playerid, ExtraVehicles[playerid][item][evID2], 0);
					UpdateExtraVehicle(playerid, item);
					UpdateHouse(hid);
					format(string, sizeof string, "* Транспорт %s был припаркован!", VehicleNames[ExtraVehicles[playerid][item][evModel] - 400]);
					Send(playerid, COLOR_YELLOW, string);
					
				}
				
				else if(strfind(inputtext, "Изменить цвет") != -1) {
					ShowDialog(playerid, D_EV_MENU+2, DIALOG_STYLE_INPUT, "Перекраска", "dialog/colors.txt", "ENTER", "CANCEL");
				}
			} else {
				ShowExtraVehiclesMenu(playerid);
			}
		}
		
		case D_EV_MENU+2 : {
			if(response) {
				if(sscanf(inputtext, "p<,>ii", inputtext[0], inputtext[1])) {
					Send(playerid, COLOR_GREY, "* Не валидная строка, повторите ввод!");
					return ShowDialog(playerid, D_EV_MENU+2, DIALOG_STYLE_INPUT, "Перекраска", "dialog/colors.txt", "ENTER", "CANCEL");
				} else if(inputtext[0] < 0 || inputtext[0] > 127) {
					Send(playerid, COLOR_GREY, "* Не валидная строка, повторите ввод!");
					return ShowDialog(playerid, D_EV_MENU+2, DIALOG_STYLE_INPUT, "Перекраска", "dialog/colors.txt", "ENTER", "CANCEL");
				} else if(inputtext[1] < 0 || inputtext[1] > 127) {
					Send(playerid, COLOR_GREY, "* Не валидная строка, повторите ввод!");
					return ShowDialog(playerid, D_EV_MENU+2, DIALOG_STYLE_INPUT, "Перекраска", "dialog/colors.txt", "ENTER", "CANCEL");
				} else {
					new item = GetPVarInt(playerid, "SelectedItem");
					ExtraVehicles[playerid][item][evColor1] = inputtext[0];
					ExtraVehicles[playerid][item][evColor2] = inputtext[1];
					ChangeVehicleColor(ExtraVehicles[playerid][item][evID2], inputtext[0], inputtext[1]);
					UpdateExtraVehicle(playerid, item);
					
					format(string, sizeof string, "* Цвет транспорта %s был изминен на %i|%i!", VehicleNames[ExtraVehicles[playerid][item][evModel] - 400], inputtext[0], inputtext[1]);
					Send(playerid, COLOR_YELLOW, string);
				}
			} else {
				ShowExtraVehiclesMenu(playerid);
			}
		}
		
		case D_EV_MENU+3 : {
			if(response) {
				format(string, sizeof string, "extra[%i]", listitem);
				new item = GetPVarInt(playerid, string);
				new targetid = GetPVarInt(playerid, "SelectedPlayer");
				SetPVarInt(playerid, "SelectedPlayer", INVALID_PLAYER_ID);
				if(Pl::isLogged(targetid)) {
					if(RemoveExtraVehicle(targetid, item)) {
						Send(playerid, COLOR_YELLOW, "* Доп. траспорт был удален!");
					}
				} else {
					Send(playerid, COLOR_GREY, "* Игрок вышел из игры!");
				}
			}
		}
		
		case D_WAIT : {
			if(!response) return KickEx(playerid, "Для игры на сервере, Вы должны авторизоватся!", COLOR_LIGHTRED);	
			if(Pl::Info[playerid][pWait] > 0) {
				format(dialog, sizeof dialog, "Дождитесь полной загрузки игры и нажмите ENTER!\n\
				Осталось секунд: %i", Pl::Info[playerid][pWait]);
				SPD(playerid, D_WAIT, 0, "Подождите...",dialog, "ENTER", "");
			}
			return 1;
		}
		
		case D_AUTH : {
			if(!WrongLogin[playerid]) return Rac::Kick(playerid, "Попытка взлома аккаунта");
			if(!response) return KickEx(playerid, "Для игры на сервере, Вы должны авторизоватся!", COLOR_LIGHTRED);
			if(!sscanf(inputtext, "s[36]", inputtext[0])) {
				new hash[SHA2_HASH_LEN];
				SHA256_PassHash(inputtext[0], Db::Conf[Db::KeySult], hash, SHA2_HASH_LEN);
				format(query, sizeof query, "SELECT * FROM `"#__TableUsers__"` WHERE `ID` = '%i' AND `Key` = '%s'", Pl::Info[playerid][pID], hash);
				Db::tquery(connDb, query, "onPlayerLogin", "i", playerid);
			} else {
				ShowLoginForm(playerid, 1);
			}
		}

		case D_REGG : {
			if(!response) return KickEx(playerid, "Для игры на сервере, Вы должны согласится с правилами игры!", COLOR_LIGHTRED);
			ShowLoginForm(playerid, 0);
		}
		
		case D_REGG + 1 : {
			if(!response) return KickEx(playerid, "Для игры на сервере, Вы должны зарегистрироваться!", COLOR_LIGHTRED);
			if(!sscanf(inputtext, "s[36]", inputtext[0])) {
				new hash[SHA2_HASH_LEN];
				SHA256_PassHash(inputtext[0], Db::Conf[Db::KeySult], hash, SHA2_HASH_LEN);
				format(query, sizeof query, "INSERT INTO `"#__TableUsers__"` (`Name`,`Key`,`Fightstyle`) VALUES ('%s', '%s', '%i')",
				GetName(playerid), hash, FightStyles[random(sizeof FightStyles)]);
				Db::tquery(connDb, query, "onPlayerRegister", "i", playerid);
			} else {
				ShowLoginForm(playerid, 0);
			}
		}
		
		case D_REGG + 2 : {
			Pl::Info[playerid][pSex] = response ? 2 : 1;
			SPD(playerid, D_REGG + 3, 2, "Location", "Los Santos\nLas Venturas", "SELECT", "CANCEL");
			return 1;
		}
		
		case D_REGG + 3 : {
			if(response) {
				Pl::Info[playerid][pOrigin] = (listitem + 1);
				new skin;
				Container::At(99+Pl::Info[playerid][pSex], Container::First, SelectCharPlace[playerid], skin);
				SetPlayerSkin(playerid, skin);
				ShowMenuForPlayer(SkinMenu, playerid);
			} else {
				SPD(playerid, D_REGG + 3, DIALOG_STYLE_MSGBOX, "Sex", " Выберете пол вашего персонажа.", "ЖЕН", "МУЖ");
			}
			return 1;
		}
		
		case D_FACTORY_JOB : {
			if(response) {
				if(IsPlayerAttachedObjectSlotUsed(playerid,1)) RemovePlayerAttachedObject(playerid,1);
				if(IsPlayerAttachedObjectSlotUsed(playerid,2)) RemovePlayerAttachedObject(playerid,2);
				OnJob[playerid] = 1;
				SetPlayerSkin(playerid, 27);
				SendClientMessage(playerid, COLOR_LIGHTBLUE, "Вы начали работу в Производственном Цеху!");
				SendClientMessage(playerid, COLOR_LIGHTBLUE, "Идите к столу, чтобы начать работу");
				ApplyAnimation(playerid,"INT_SHOP","shop_cashier",4.1,1,0,0,0,1); //    WEAPON_csawlo
				ClearAnimations(playerid);
			}
			return 1;
		}

		case D_FACTORY_JOB+1 : {
			if(response) {
				if(IsPlayerAttachedObjectSlotUsed(playerid,1)) RemovePlayerAttachedObject(playerid,1);
				if(IsPlayerAttachedObjectSlotUsed(playerid,2)) RemovePlayerAttachedObject(playerid,2);
				OnJob[playerid] = 0;
				SetPlayerSkin(playerid, Pl::Info[playerid][pChar]);
				Rac::GivePlayerMoney(playerid, KG[playerid][1] * 50);
				format(string, sizeof(string), "Вы заработали %d$ за изготовление %dкг продуктов", KG[playerid][1] * 50, KG[playerid][1]);
				Send(playerid, COLOR_LIGHTBLUE, string);
				KG[playerid][0] = 0;
				KG[playerid][1] = 0;
			}
			return 1;
		}
		
		case D_COLORS : {
			if(response) {
				switch(listitem) {
					case 0 : Pl::SetFracColor(playerid);
					case 1 : SetPlayerColor(playerid, COLOR_ALPHA);
					case 2 : {}
					case 3 .. sizeof Colors : SetPlayerColor(playerid, Colors[(listitem - 3)][e_color]);
				}
				Send(playerid, COLOR_WHITE, "* Цвет установлен!");
			}
		}
		
		case D_MASK	: {
			if(response) {
				switch(listitem) {
					case 0..2 : {
						static const skinInfo[][] = {
							{280, "Полиции"},
							{286, "ФБР"},
							{287, "Армии"}
						};
						SetPlayerSkin(playerid, skinInfo[listitem][0]);
						HideNameTag(playerid, true);
						
						format(string, sizeof string, "* Вы скрылись в одежде %s", skinInfo[listitem][1]);
						Send(playerid,COLOR_LIGHTBLUE, string);
					}
					
					case 3 : {
						static const _skinInfo[][] = {
							{7, 19, 22},
							{12, 233, 211}
						};
						SetPlayerSkin(playerid, _skinInfo[Pl::Info[playerid][pSex]][random(3)]);
						HideNameTag(playerid, true);
						
						Send(playerid,COLOR_LIGHTBLUE,"Вы скрылись в одежде гражданского!");
					}
					
					case 4 : {
						HideNameTag(playerid, false);
						SetPlayerSkin(playerid, Pl::Info[playerid][pChar]);
						Send(playerid,COLOR_LIGHTBLUE, "Вы вернули себе свою одежду");
					}
				}
			}
		}
		
		case D_MASK+1 : {
			if(response) {
				switch(listitem) {
					case 0: {
						SetPlayerSkin(playerid, 120);
						HideNameTag( playerid, true );
						Send(playerid,COLOR_LIGHTBLUE,"* Вы скрылись в одежде Японца");
					}

					case 1: {
						SetPlayerSkin(playerid, 115);
						HideNameTag( playerid, true );
						Send(playerid,COLOR_LIGHTBLUE,"* Вы скрылись в одежде Коронос");
					}
					
					case 2: {
						SetPlayerSkin(playerid, 104);
						HideNameTag( playerid, true );
						Send(playerid,COLOR_LIGHTBLUE,"* Вы скрылись в одежде Баллас");
					}
					
					case 3: {
						new rnd = random(2);
						switch(Pl::Info[playerid][pSex]) {
							case 1 : {
								switch(rnd) {
									case 0 : SetPlayerSkin(playerid,7);
									case 1 : SetPlayerSkin(playerid,19);
									case 2 : SetPlayerSkin(playerid,22);
								}
							}
							case 2 : {
								switch(rnd) {
									case 0 : SetPlayerSkin(playerid,12);
									case 1 : SetPlayerSkin(playerid,233);
									case 2 : SetPlayerSkin(playerid,211);
								}
							}
						}
						Send(playerid,COLOR_LIGHTBLUE,"* Вы скрылись в одежде гражданского");
					}
					case 4: {
						SetPlayerSkin(playerid, Pl::Info[playerid][pChar]);
						Send(playerid,COLOR_LIGHTBLUE,"* Вы вернули себе свою одежду");
					}
				}
			}
			
			return 1;
		}
		
		case D_BARN :
		{
			if(response)
			{
				new vehid = GetPlayerVehicleID(playerid);
				if(!vehid) return Send(playerid,COLOR_GREY,"* Вы не в машине!");
				if(AutoInfo[vehid][aDrugs] <= 0) return Send(playerid,COLOR_GREY,"* В вашей машине нету наркотиков!");
				if(Gm::Info[Gm::AmbarDrugs] >= 20000) return Send(playerid,COLOR_GREY,"* Амбар переполнен! Максимум 20000 грамм.");
				inputtext[0] = AutoInfo[vehid][aDrugs]*50;
				Gm::Info[Gm::AmbarDrugs] += AutoInfo[vehid][aDrugs]; Rac::GivePlayerMoney(playerid, inputtext[0]);
				format(string, sizeof(string), "* Вы продали %i грамм притону за %i$", AutoInfo[vehid][aDrugs], inputtext[0]);
				Send(playerid,COLOR_LIGHTBLUE,string);
				AutoInfo[vehid][aDrugs] = 0;
			}
			return 1;
		}
		
		case D_BARN+1 :
		{
			if( response )
			{
				new vehid = GetPlayerVehicleID(playerid);
				if( !vehid ) return Send(playerid,COLOR_GREY,"* Вы не в машине!");
				if(AutoInfo[vehid][aDrugs] <= 0) return Send(playerid,COLOR_GREY,"* В вашей машине нету наркотиков!");
				if(Gm::Info[Gm::AmbarDrugs] >= 20000) return Send(playerid,COLOR_GREY,"* Амбар переполнен! Максимум 20000 грамм.");
				inputtext[0] = AutoInfo[vehid][aDrugs]*70;
				Gm::Info[Gm::PritonDrugs] += AutoInfo[vehid][aDrugs]; Rac::GivePlayerMoney(playerid, inputtext[0]);
				format(string, sizeof(string), "* Вы продали %d грамм притону за %d$", AutoInfo[vehid][aDrugs], inputtext[0]);
				Send(playerid,COLOR_LIGHTBLUE,string);
				AutoInfo[vehid][aDrugs] = 0;
			}
			return 1;
		}
		
		case D_BARN+2 :
		{
			if( response )
			{
				new vehid = GetPlayerVehicleID(playerid);
				if( !vehid ) return Send(playerid,COLOR_GREY,"* Вы не в машине!");
				if( sscanf(inputtext, "i", inputtext[0]) )
				{
					SPD(playerid, D_BARN+2, 1, "Амбар", "Кол-во мака которое хотите взять.", "Взять", "Отмена");
				}
				else if(inputtext[0] > 100)
				{
					Send(playerid,COLOR_GREY,"* Больше 100 грамм возить нельзя!");
					SPD(playerid, D_BARN+2, 1, "Амбар", "Кол-во мака которое хотите взять.", "Взять", "Отмена");
				}
				else
				{
					inputtext[1] = inputtext[0]*50;
					if(Rac::GetPlayerMoney(playerid) < inputtext[1]) Send(playerid,COLOR_GREY,"* У Вас не хватает денег!");
					else if(AutoInfo[vehid][aDrugs]+inputtext[0] > AutoInfo[vehid][aMaxDrugs])
					{
						Send(playerid,COLOR_LIGHTRED2,"* За один раз можно везти 100 грамм!");
						SPD(playerid, D_BARN+2, 1, "Амбар", "Кол-во мака которое хотите взять.", "Взять", "Отмена");
					}
					else
					{
						AutoInfo[vehid][aDrugs] += inputtext[0];
						Gm::Info[Gm::AmbarDrugs] -= inputtext[0];
						Rac::GivePlayerMoney(playerid, -inputtext[1]);
						format(string, sizeof(string), "* Вы взяли %d грамм за $%d", inputtext[0], inputtext[1]);
						Send(playerid,COLOR_LIGHTBLUE,string);
					}
				}
			}
			return 1;
		}
		
		case D_HEALME : {
			if(response) {
				new houseid = Pl::Info[playerid][pLocal] - OFFSET_HOUSE;
				if(!IsValidHouse(houseid)) return Send(playerid, COLOR_GREY, "* Invalid house id!");
				if(!IsPlayerInHouse(playerid, 9.0, houseid)) return Send(playerid, COLOR_GREY, "* Вы не в доме!");
				switch(listitem) {
					case 0 : {
						if(!HouseInfo[houseid][hSafe][3]) return Send(playerid, COLOR_GREY, "* В доме нет аптечек!");
						if(Rac::GetPlayerHealth(playerid) >= 100.0) return Send(playerid, COLOR_GREY, "* Вы уже вылечены!");
						HouseInfo[houseid][hSafe][3] --;
						Rac::SetPlayerHealth(playerid, 100.0);
						GameTextForPlayer(playerid, "~w~You~n~~r~healed", 1, 5000);
						format(string, sizeof(string), "* Оталось аптечек: %i штук.", HouseInfo[houseid][hSafe][3]);
						Send(playerid, COLOR_GREEN, string);
						PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
					}
					case 1 : {
						if(!HouseInfo[houseid][hSafe][4]) return Send(playerid, COLOR_GREY, "* В доме нет брони!");
						if(Rac::GetPlayerArmour(playerid) >= 100.0) return Send(playerid, COLOR_GREY, "* Вы уже в бронежелете!");
						HouseInfo[houseid][hSafe][4] --;
						Rac::SetPlayerArmour(playerid, 100.0);
						GameTextForPlayer(playerid, "~w~You are dressed ~r~~n~in body armor", 1, 5000);
						format(string, sizeof(string), "* Оталось брони: %i штук.", HouseInfo[houseid][hSafe][4]);
						Send(playerid, COLOR_GREEN, string);
						PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
					}
				}
			}
			return 1;
		}
		
		case D_GIVE_PASS : {
			if(response) {
				if(sscanf(inputtext, "i", inputtext[0])) {
					Send(playerid, COLOR_GREY, "* Вы ошиблись, попробуйте еще раз!");
					SPD(playerid, D_GIVE_PASS, 1, "{ffcf00}Паспортный стол", "Укажите ваш возраст", "Ввод", "Отмена");
				} else if(inputtext[0] < 10 || inputtext[0] > 90) {
					Send(playerid, COLOR_GREY, "* Вы ошиблись, попробуйте еще раз!");
					SPD(playerid, D_GIVE_PASS, 1, "{ffcf00}Паспортный стол", "Укажите ваш возраст", "Ввод", "Отмена");
				} else {
					Pl::Info[playerid][pAge] = inputtext[0];
					format(dialog, sizeof dialog, "Вы хотите купить паспорт?\n\
					Стоимость: $%i\nСрок действия: 20 дней", (500*Pl::Info[playerid][pLevel]));
					SPD(playerid, D_GIVE_PASS+1, 0, "{ffcf00}Паспортный стол", dialog, "Взять", "Отмена");
				}
			}
			return 1;
		}
		
		case D_GIVE_PASS+1 : {
			if(response) {
				if(Rac::GetPlayerMoney(playerid) >= (500*Pl::Info[playerid][pLevel])) {
					new currtime = gettime();
					Pl::Info[playerid][pPasport][0] = 1;
					Pl::Info[playerid][pPasport][1] = currtime;
					Pl::Info[playerid][pPasport][2] = ((20*86400) + currtime);
					Rac::GivePlayerMoney(playerid, -(500*Pl::Info[playerid][pLevel]));
					format(string, sizeof(string), "* Вы получили паспорт. Чтобы показать его игроку, введите /pasport.");
					Send(playerid, COLOR_LIGHTBLUE, string);
				} else {
					Send(playerid, COLOR_GREY, "* У Вас не хватает денег!");
				}
			}
			return 1;
		}
		
		case D_NETSTAT : {
			if(response) {
				Pl::NetStats[playerid] = INVALID_PLAYER_ID;
			}
			return 1;
		}

		case D_RADIO : {
			if(response) {
				new vehid = GetPlayerVehicleID(playerid);
				if(vehid && GetPlayerState(playerid) == 2) {
					if(!listitem) {
						AutoInfo[vehid][aRadio] = listitem;
						GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~r~FM OFF", 5000, 5);
						StopAudioStreamForPlayer(playerid);
					} else {
						AutoInfo[vehid][aRadio] = listitem;
						PlayAudioStreamForPlayer(playerid, RadioInfo[listitem][rUrl]);
						format(src, sizeof src,"~n~~n~~n~~n~~n~~n~~g~%s", RadioInfo[listitem][rName]);
						GameTextForPlayer(playerid, src, 5000, 5);
					}
				}
			}
			return 1;
		}
		
		case D_RADIO+1: {
			if(response) {
				if(!listitem) {
					GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~r~FM OFF", 5000, 5);
					StopAudioStreamForPlayer(playerid);
				} else {
					PlayAudioStreamForPlayer(playerid, RadioInfo[listitem][rUrl]);
					format(string, sizeof string,"~n~~n~~n~~n~~n~~n~~g~%s", RadioInfo[listitem][rName]);
					GameTextForPlayer(playerid, string, 5000, 5);
				}
			}
		}
		
		case D_GIFT: {
			if(response && Pl::Info[playerid][pLevel] == 1) {
				new bidx = GetIndexFromBizID(7);
				Pl::Info[playerid][pLevel] = 2;
				Pl::Info[playerid][pLic][0] = 1;
				Pl::Info[playerid][pLic][3] = 1;
				Pl::Info[playerid][pLic][1] = 1;
				Pl::Info[playerid][pLic][2] = 1;
				Rac::GivePlayerMoney(playerid, 400000);
				Pl::Info[playerid][pLocal] = OFFSET_BIZZ - bidx;
				SetPlayerScore(playerid, Pl::Info[playerid][pLevel]);
				
				Rac::SetPlayerInterior(playerid, 3);
				Rac::SetPlayerVirtualWorld(playerid, BizzInfo[bidx][bVirtual]);
				Rac::SetPlayerPos(playerid, 207.4872,-129.2266,1003.5078);
				Send(playerid, COLOR_YELLOW, "* Вы приняли подарок. Желаем удачной игры на сервере!");
			}

			return 1;
		}
		case D_GGUN:
		{
			if(response && Pl::isAdmin(playerid, SUPERMODER))
			{
				new setid, weaponid, amount;
				if(!sscanf(inputtext, "uii", setid, weaponid, amount))
				{
					if(!Pl::isLogged(setid)) return Send(playerid, COLOR_GREY, "* Этот игрок не авторизован!");
					if(IsWrongWeponID(weaponid) && !Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GRAD1, "* Не правельный ID оружия!");
					if(amount < 1 || amount > 999 && !Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GRAD1, "* Не ниже 1 и не выше 999 патронов!");
					if( Rac::GetPlayerAmmo(setid, weaponid) >= 999 && !Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GRAD1, "* У этого игрока слишком много оружия!");
					format(string, sizeof(string), "[AdmWarn] * %s применил команду /ggun к игроку %s[%s]", GetName(playerid), GetName(setid), FracInfo[Pl::FracID(setid)][fName]);
					SendToAdmin(COLOR_YELLOW, string, 1, 3); Rac::GivePlayerWeapon(setid, weaponid, amount);
				}
				else
				{
					ShowDialog(playerid, D_GGUN, DIALOG_STYLE_INPUT, "GIVEGUN", "dialog/ggun.txt", "Ввод", "Отмена");
				}
			}
			return 1;
		}
		case D_SETSTAT:
		{
			if(response && Pl::isAdmin(playerid, ADMINISTRATOR))
			{
				new setid, statcode, amount;
				if(!sscanf(inputtext, "uii", setid, statcode, amount))
				{
					if(!IsPlayerConnected(setid)) return Send(playerid, COLOR_GREY, "* Этот игрок не подлючен!");
					if(!Pl::isLogged(setid)) return Send(playerid, COLOR_GREY, "* Этот игрок не авторизован!");

					switch(statcode)
					{
						case 1:
						{
							Pl::Info[setid][pLevel] = amount;
							format(string, sizeof(string), "* Уровень игрока был изменен на %d", amount);
							Send(playerid, COLOR_GREY, string);
						}
						case 2:
						{
							Pl::Info[setid][pExp] = amount;
							format(string, sizeof(string), "* Респекты игрока были изменены на %d", amount);
							Send(playerid, COLOR_GREY, string);
						}
						case 3:
						{
							if((amount<1000||amount>999999) && !Pl::isAdmin(playerid, ADMINISTRATOR)) {
								Send(playerid, COLOR_GREY, "* Слишком длинный или короткий номер.");
							} else {
								format(query, sizeof query, "SELECT * FROM `"#__TableUsers__"` WHERE `Number` = '%i'", amount);
								new Cache:result = Db::query(connDb, query, true);
								if(cache_get_row_count()) {
									format(string, sizeof(string), "* Номер телефона %d уже есть у другого игрока.", amount);
									Send(playerid, COLOR_GREY, string);
								} else {
									Pl::Info[setid][pNumber] = amount;
									format(string, sizeof(string), "* Номер телефона игрока был измунен на %d", amount);
									Send(playerid, COLOR_GREY, string);
								}
								cache_delete(result);
							}
						}
						case 4:
						{
							if(!IsValidHouse(amount) && amount != INVALID_HOUSE_ID) return Send(playerid, COLOR_GREY, "* Дома с таким ID не существует!");
							Pl::Info[setid][pHouseKey] = amount;
							format(string, sizeof(string), "* Дом игрока был изменен на %d", amount);
							Send(playerid, COLOR_GREY, string);
						}
						case 5:
						{
							if(!IsValidBiz(amount) && amount != INVALID_BIZ_ID) return Send(playerid, COLOR_GREY, "* Бизнеса с таким ID не существует!");
							Pl::Info[setid][pBizKey] = amount;
							format(string, sizeof(string), "* Бизнес игрока был изменен на %d", amount);
							Send(playerid, COLOR_GREY, string);
						}
						case 6:
						{
							if(amount < 0 || amount > 2) return Send(playerid, COLOR_GREY, "* Неверное значение.");
							Pl::Info[setid][pVip] = amount;
							format(string, sizeof(string), "* Вип статус игрока был изминен на %d", amount);
							Send(playerid, COLOR_GREY, string);
						}
						case 7:
						{
							if(amount < 0 || amount > 11) return Send(playerid, COLOR_GREY, "* Неверное значение.");
							if((amount == 7 || amount == 4) && !IsAMafia(setid)) return Send(playerid, COLOR_GREY, "* Он не мафиози!");
						
							Iter::Remove(JobPlayers[Pl::Info[setid][pJob]], playerid);
							Iter::Add(JobPlayers[amount], playerid);
							
							Pl::Info[setid][pJob] = amount;
							format(string, sizeof(string), "* Работа игрока была изменена %s", JobsInfo[Pl::Info[setid][pJob]][jName]);
							Send(playerid, COLOR_GREY, string);
						}
						default:
						{
							format(string, sizeof(string), "* Неверное значение.");
							return ShowDialog(playerid, D_SETSTAT, DIALOG_STYLE_INPUT, "SETSTAT", "dialog/setstat.txt", "Ввод", "Отмена");
						}
					}
					format(string, sizeof(string), "[AdmWarn] * %s применил команду /setstat к игроку %s[%s]. Statcode: %i",
					GetName(playerid), GetName(setid), FracInfo[Pl::FracID(setid)][fName], statcode); SendToAdmin(COLOR_YELLOW, string, 1, 3);
				}
				else
				{
					if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
					Send(playerid, COLOR_GREY, "* Вы нечего не ввели!");
					return ShowDialog(playerid, D_SETSTAT, DIALOG_STYLE_INPUT, "SETSTAT", "dialog/setstat.txt", "Ввод", "Отмена");
				}
			}
			return 1;
		}
		
		case D_EDIT: {
			if(response && Pl::isAdmin(playerid, ADMINISTRATOR)) {
				new amount, name[16];
				if(!sscanf(inputtext, "s[24]i", name, amount)) {
					if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == 2) {
						new idx = GetCarID(playerid);
						if(idx == -1) return Send(playerid, COLOR_GREY, "* Эту машину нельзя редактировать!");
						if(!strcmp(name, "Model", true)) {
							if(amount < 400 || amount > 611) return Send(playerid, COLOR_GREY, "* Неверный ID моднли!");
							VehicleInfo[idx][vModel] = amount;
							AutoInfo[0][aMileage] = AutoInfo[VehicleInfo[idx][cID]][aMileage];
							GetVehiclePos(VehicleInfo[idx][cID], posx, posy, posz);
							GetVehicleZAngle(VehicleInfo[idx][cID], angle);
							Veh::Destroy(VehicleInfo[idx][cID]);
							VehicleInfo[idx][cID] = Veh::Create
							(
								VehicleInfo[idx][vModel],
								VehicleInfo[idx][vPosX],
								VehicleInfo[idx][vPosY],
								VehicleInfo[idx][vPosZ],
								VehicleInfo[idx][vPosA],
								VehicleInfo[idx][vColor1],
								VehicleInfo[idx][vColor2],
								VehicleInfo[idx][vRespTime]
							);
							AutoInfo[VehicleInfo[idx][cID]][aMileage] = AutoInfo[0][aMileage];
							SetVehicleNumber(VehicleInfo[idx][cID]);
							UpdateToSQL(idx, 0);
							SetVehiclePos(VehicleInfo[idx][cID], posx, posy, posz);
							SetVehicleZAngle(VehicleInfo[idx][cID], angle);
							Rac::PutPlayerInVehicle(playerid, VehicleInfo[idx][cID], 0);
							
						} else if(strcmp(name, "Color1", true) == 0) {
							if(amount < -1 || amount > 126) return Send(playerid, COLOR_GREY, "* ID цвета не может быть ниже 0 или выше 126!");
							VehicleInfo[idx][vColor1] = amount;
							AutoInfo[0][aMileage] = AutoInfo[VehicleInfo[idx][cID]][aMileage];
							GetVehiclePos(VehicleInfo[idx][cID], posx, posy, posz);
							GetVehicleZAngle(VehicleInfo[idx][cID], angle);
							Veh::Destroy(VehicleInfo[idx][cID]);
							VehicleInfo[idx][cID] = Veh::Create
							(
								VehicleInfo[idx][vModel],
								VehicleInfo[idx][vPosX],
								VehicleInfo[idx][vPosY],
								VehicleInfo[idx][vPosZ],
								VehicleInfo[idx][vPosA],
								VehicleInfo[idx][vColor1],
								VehicleInfo[idx][vColor2],
								VehicleInfo[idx][vRespTime]
							);
							AutoInfo[VehicleInfo[idx][cID]][aMileage] = AutoInfo[0][aMileage];
							SetVehicleNumber(VehicleInfo[idx][cID]);
							UpdateToSQL(idx, 0);
							SetVehiclePos(VehicleInfo[idx][cID], posx, posy, posz);
							SetVehicleZAngle(VehicleInfo[idx][cID], angle);
							Rac::PutPlayerInVehicle(playerid, VehicleInfo[idx][cID], 0);
							
						} else if(!strcmp(name, "Color2", true)) {
							if(amount < -1 || amount > 126) return Send(playerid, COLOR_GREY, "* ID цвета не может быть ниже 0 или выше 126!");
							VehicleInfo[idx][vColor2] = amount;
							AutoInfo[0][aMileage] = AutoInfo[VehicleInfo[idx][cID]][aMileage];
							GetVehiclePos(VehicleInfo[idx][cID], posx, posy, posz);
							GetVehicleZAngle(VehicleInfo[idx][cID], angle);
							Veh::Destroy(VehicleInfo[idx][cID]);
							VehicleInfo[idx][cID] = Veh::Create
							(
								VehicleInfo[idx][vModel],
								VehicleInfo[idx][vPosX],
								VehicleInfo[idx][vPosY],
								VehicleInfo[idx][vPosZ],
								VehicleInfo[idx][vPosA],
								VehicleInfo[idx][vColor1],
								VehicleInfo[idx][vColor2],
								VehicleInfo[idx][vRespTime]
							);
							AutoInfo[VehicleInfo[idx][cID]][aMileage] = AutoInfo[0][aMileage];
							SetVehicleNumber(VehicleInfo[idx][cID]);
							UpdateToSQL(idx, 0);
							SetVehiclePos(VehicleInfo[idx][cID], posx, posy, posz);
							SetVehicleZAngle(VehicleInfo[idx][cID], angle);
							Rac::PutPlayerInVehicle(playerid, VehicleInfo[idx][cID], 0);
						
						} else if(!strcmp(name, "Resptime", true)) {
							if(amount < 300 || amount > 2000) return Send(playerid, COLOR_GREY, "* Время спавна может быть от 300 до 2000 сек.");
							VehicleInfo[idx][vRespTime] = amount;
							AutoInfo[0][aMileage] = AutoInfo[VehicleInfo[idx][cID]][aMileage];
							GetVehiclePos(VehicleInfo[idx][cID], posx, posy, posz);
							GetVehicleZAngle(VehicleInfo[idx][cID], angle);
							Veh::Destroy(VehicleInfo[idx][cID]);
							VehicleInfo[idx][cID] = Veh::Create(
								VehicleInfo[idx][vModel],
								VehicleInfo[idx][vPosX],
								VehicleInfo[idx][vPosY],
								VehicleInfo[idx][vPosZ],
								VehicleInfo[idx][vPosA],
								VehicleInfo[idx][vColor1],
								VehicleInfo[idx][vColor2],
								VehicleInfo[idx][vRespTime]
							);
							AutoInfo[VehicleInfo[idx][cID]][aMileage] = AutoInfo[0][aMileage];
							SetVehicleNumber(VehicleInfo[idx][cID]);
							UpdateToSQL(idx, 0);
							SetVehiclePos(VehicleInfo[idx][cID], posx, posy, posz);
							SetVehicleZAngle(VehicleInfo[idx][cID], angle);
							Rac::PutPlayerInVehicle(playerid, VehicleInfo[idx][cID], 0);
						} else if(!strcmp(name, "Job", true)) {
							Iter::Remove(JobVehicles[VehicleInfo[idx][vJob]], VehicleInfo[idx][cID]);
							Iter::Add(JobVehicles[VehicleInfo[idx][vJob]], VehicleInfo[idx][cID]);
							VehicleInfo[idx][vJob] = amount;
							UpdateToSQL(idx, 0);
						}
						
						format(string, sizeof(string), "[AdmWarn] * %s применил команду /edit. Params: car %s %i", GetName(playerid), name, amount);
						SendToAdmin(COLOR_YELLOW, string, 4, 3);
					} else {
						foreach(new i : Biznes) {
							if(IsPlayerInRangeOfPoint(playerid, 3.0, BizzInfo[i][bEnter][0], BizzInfo[i][bEnter][1], BizzInfo[i][bEnter][2])) {
								format(string, sizeof(string), "Biz: %d", i);
								Send(playerid, COLOR_GRAD2, string);
								if(amount >= 0) {
									if(!strcmp(name,"level",true) ) 			BizzInfo[i][bLevel] = amount;
									else if(!strcmp(name,"price",true))			BizzInfo[i][bPrice] = amount;
									else if(!strcmp(name,"funds",true))			BizzInfo[i][bSafe] = amount;
									else if(!strcmp(name,"prods",true))			BizzInfo[i][bProds] = amount;
									else if(!strcmp(name,"maxprods",true))		BizzInfo[i][bMaxProds] = amount;
									else if(!strcmp(name,"enterprice",true)) 	BizzInfo[i][bEnterCost] = amount;
									else if(!strcmp(name,"priceprods",true)) 	BizzInfo[i][bPriceProd] = amount;
									format(string, sizeof(string), "[AdmWarn] * %s применил команду /edit. Params: %s %i", GetName(playerid), name, amount);
									SendToAdmin(COLOR_YELLOW, string, 3, 3);
									
									return 1;
								}
							}
						}
						foreach(new i : Houses) {
							if (IsPlayerInRangeOfPoint(playerid,3,HouseInfo[i][hEnter][0], HouseInfo[i][hEnter][1], HouseInfo[i][hEnter][2])) {
								format(string, sizeof(string), "House: %d", i);
								Send(playerid, COLOR_GRAD2, string);
								if(amount >= 0) {
									if(!strcmp(name,"level",true)) 		HouseInfo[i][hLevel] = amount;
									else if(!strcmp(name,"price",true))	HouseInfo[i][hPrice] = amount;
									else if(!strcmp(name,"safe",true))	HouseInfo[i][hSafe][0] = amount;
									format(string, sizeof(string), "[AdmWarn] * %s применил команду /edit. Params: %s %i", GetName(playerid), name, amount);
									SendToAdmin(COLOR_YELLOW, string, 3, 3);
									
									return 1;
								}
							}
						}
					}
				}
				else
				{
					if(!Pl::isAdmin(playerid, ADMINISTRATOR)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
					Send(playerid, COLOR_GREY, "* Вы нечего не ввели!");
					ShowDialog(playerid, D_EDIT, DIALOG_STYLE_INPUT, "EDIT", "dialog/edit.txt", "OK", "ОТМЕНА");
				}
			}
			return 1;
		}
		
		case D_ONLINE: {
			if(response) return ShowOnline(playerid,listitem);
			return 1;
		}
		
		case D_ONLINE+1: {
			if(response) {
				ShowDialog(playerid, D_ONLINE,DIALOG_STYLE_LIST, ""#__SERVER_PREFIX""#__SERVER_NAME_LC" Онлайн", "dialog/online.txt", "SELECT", "CANCEL");
			}
			return 1;
		}
		
		case D_OFFLINE : {
			if(response) return ShowOffline(playerid, listitem);
			return 1;
		}
		
		case D_OFFLINE+1: {
			if(response) {
				ShowDialog(playerid, D_OFFLINE, DIALOG_STYLE_LIST,""#__SERVER_PREFIX""#__SERVER_NAME_LC": OFFLINE", "dialog/offline.txt", "SELECT", "CANCEL");
			}
			return 1;
		}
		
		case D_JOB : {
			if(response) {
				switch(GettingJob[playerid]) {
					case 2 : {
						if(Pl::FracID(playerid) != 7) return Send(playerid, COLOR_GREY, "* Вы не работаете в Правительстве!");
						if(6 <= Pl::Info[playerid][pRank] <= 8) {
							Pl::Info[playerid][pJob] = GettingJob[playerid];
							Pl::Info[playerid][pContractTime] = 5;
							GettingJob[playerid] = 0;
							Send(playerid, COLOR_LIGHTBLUE, "* Теперь, когда Вы подтвердили, что Вы хотите Работу, Вы получили 5-часовой Контракт.");
							Send(playerid, COLOR_LIGHTBLUE, "* Поздравления с Вашей новой Работой, напечатайте /help, чтобы видеть Вашу новую команду.");
						} else {
							Send(playerid, COLOR_GREY, "* Вы не юрист!");
						}
					}
					case 4, 7 : {
						if(!IsAMafia(playerid)) return Send(playerid, COLOR_GREY, "* Вы не мафиози!");
						Pl::Info[playerid][pJob] = GettingJob[playerid];
						Pl::Info[playerid][pContractTime] = 5;
						Iter::Add(JobPlayers[GettingJob[playerid]], playerid);
						
						GettingJob[playerid] = 0;
						ShowDialog(playerid, D_NONE, 0, "Трудоустройство", "dialog/job_success.txt", "OK", "");
					}
					default : {
						Pl::Info[playerid][pJob] = GettingJob[playerid];
						Pl::Info[playerid][pContractTime] = 5;
						Iter::Add(JobPlayers[GettingJob[playerid]], playerid);
						
						GettingJob[playerid] = 0;
						Send(playerid, COLOR_LIGHTBLUE, "* Теперь, когда Вы подтвердили, что Вы хотите Работу, Вы получили 5-часовой Контракт.");
						Send(playerid, COLOR_LIGHTBLUE, "* Поздравления с Вашей новой Работой, напечатайте /help, чтобы видеть Вашу новую команду.");
					}
				}
			}
			return 1;
		}
		
		case D_BANLIST : {
			if(response) {
				new playername[24];
				GetPVarString(playerid, "UnbanPlayer", playername, 24);
				DeletePVar(playerid, "UnbanPlayer");
				if(!Pl::isAdmin(playerid, SUPERMODER)) return Send(playerid, COLOR_GREY, "* Недостаточно прав!");
				if(RemoveBanList(GetIDFromName(playername))) {
					format(string, sizeof(string), "[UNBAN] * %s[%i] разбанил игрока %s", GetName(playerid), playerid, playername);
					SendToAdmin(COLOR_LIGHTBLUE, string, 1, 3);
				}
			}
			return 1;
		}
		case D_HMENU: {
			new hid = Pl::Info[playerid][pHouseKey];
			if(!IsPlayerHouseOwner(playerid, hid)) return Send(playerid, COLOR_GREY, "* У Вас нет дома!");
			if(response) {
				switch(listitem) {
					case 0: PrintHouseInfo(playerid, hid);
					
					case 1 : {
						if(!IsPlayerInHouse(playerid, 20.0, hid)) return Send(playerid, COLOR_GREY, "Вы сейчас не в своем доме!");
						return SafeMenu(playerid, hid);
					}
					
					case 2 : SPD(playerid, D_HMENU+4, DIALOG_STYLE_LIST, "[House Menu] > Аренда", "Вкл./Откл. аренду\nЦена аренды", "ENTER", "CANCLE");
						
					case 3 : ShowDialog(playerid, D_HMENU+10, DIALOG_STYLE_LIST, "[House Menu] > Авто", "dialog/hmenu_auto.txt", "SELECT", "CANCEL");
					
					case 4 : {
						if(!IsPlayerInHouse(playerid, 15.0, hid)) return SPD(playerid, D_NONE, 0, "[House Menu] > Интерьер", "Вы должны находится в своем доме, чтобы изменить интерьер!", "OK", "");
						SetPVarInt(playerid, "SelectedItem", 0);
						Rac::SetPlayerPos(playerid, HouseInt[0][InteriorPos][0], HouseInt[0][InteriorPos][1], HouseInt[0][InteriorPos][2]);
						SetPlayerFacingAngle(playerid, HouseInt[0][InteriorPos][3]);
						Rac::SetPlayerVirtualWorld(playerid, Pl::Info[playerid][pLocal] + playerid);
						SetCameraBehindPlayer(playerid);
						ShowMenuForPlayer(IntMenu, playerid);
					}
					
					case 5 : {
						SPD(playerid, D_HMENU+3, DIALOG_STYLE_LIST, "[House Menu] > Улучшения",
						""#_GREY_ARROW"Покупка гаража {33AA33}[$100000]\n"#_GREY_ARROW"Покупка телевизора {33AA33}[$20000]", "SELECT", "CANCEL");
					}
				}
			}
			return 1;
		}
		case D_HMENU+1: {
			if(response) {
				new hid = Pl::Info[playerid][pHouseKey];
				if(!IsValidHouse(hid)) return Send(playerid, COLOR_GREY, "* У Вас нет дома!");
				switch(listitem) {
					case 0: {
						if(Rac::GetPlayerHealth(playerid) >= 100.0) return Send(playerid, COLOR_GREY, "* Вы уже в вылечены!");
						if(!HouseInfo[hid][hSafe][3]) return Send(playerid, COLOR_GREY, "* В доме нет аптечек!");
						HouseInfo[hid][hSafe][3] --;
						Rac::SetPlayerHealth(playerid, 100.0);
						GameTextForPlayer(playerid, "~w~You~n~~r~healed", 5000, 1);
					}
					case 1: {
						new bidx = GetIndexFromBizID(Bizz_HouseService);
						if(!BizzInfo[bidx][bProds]) return GameTextForPlayer(playerid, "~r~Out of stock", 5000, 1);
						if(HouseInfo[hid][hSafe][3] >= 100) return Send(playerid, COLOR_GREY, "* В доме максимальное кол-во аптечек!");
						if(HouseInfo[hid][hSafe][0] < 1000) return Send(playerid, COLOR_GREY, "* На счету дома недостаточно средств!");
						HouseInfo[hid][hSafe][3] ++;
						HouseInfo[hid][hSafe][0] -= 1000;
						GiveBizzProfit(bidx, 1000);
						BizzInfo[bidx][bProds]--;
						PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
						SPD(playerid, D_HMENU+1, DIALOG_STYLE_LIST, "[House Menu] > Сейф > Аптечки", ""#_GREY_ARROW"Использовать\n"#_GREY_ARROW"Купить {33AA33}[$1000]", "SELECT", "CANCEL");
					}
				}
			} else {
				SafeMenu(playerid, Pl::Info[playerid][pHouseKey]);
			}
		}
		
		case D_HMENU+2: {
			if(response) {
				new hid = Pl::Info[playerid][pHouseKey];
				switch(listitem) {
					case 0: {
						if(!IsValidHouse(hid)) return Send(playerid, COLOR_GREY, "* У Вас нет дома!");
						if(Rac::GetPlayerArmour(playerid) >= 100.0) return Send(playerid, COLOR_GREY, "* Вы уже в бронежилете!");
						if(!HouseInfo[hid][hSafe][4]) return Send(playerid, COLOR_GREY, "* В доме нет бронежилета!");
						HouseInfo[hid][hSafe][4] --;
						Rac::SetPlayerArmour(playerid, 100.0);
						GameTextForPlayer(playerid, "~w~You are dressed ~r~~n~in body armor", 1, 5000);
					}
					
					case 1: {
						new bidx = GetIndexFromBizID(Bizz_HouseService);
						if(!IsValidHouse(hid)) return Send(playerid, COLOR_GREY, "* У Вас нет дома!");
						if(!BizzInfo[bidx][bProds]) return GameTextForPlayer(playerid, "~r~Out of stock", 1, 5000);
						if(HouseInfo[hid][hSafe][4] >= 50) return Send(playerid, COLOR_GREY, "* В доме максимальное кол-во брони!");
						if(HouseInfo[hid][hSafe][0] < 3000) return Send(playerid, COLOR_GREY, "* На счету дома недостаточно средств!");
						HouseInfo[hid][hSafe][4] ++;
						HouseInfo[hid][hSafe][0] -= 3000;
						GiveBizzProfit(bidx, 3000);
						BizzInfo[bidx][bProds]--;
						PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
						SPD(playerid, D_HMENU+2, DIALOG_STYLE_LIST, "[House Menu] > Сейф > Бронежелеты", ""#_GREY_ARROW"Использовать\n"#_GREY_ARROW"Купить {33AA33}[$1000]", "SELECT", "CANCEL");
					}
				}
			} else {
				SafeMenu(playerid, Pl::Info[playerid][pHouseKey]);
			}
		}
		case D_HMENU+3: {
			if(response) {
				new hid = Pl::Info[playerid][pHouseKey];
				if(!IsValidHouse(hid)) return Send(playerid, COLOR_GREY, "* У Вас нет дома!");
				switch(listitem) {
					case 0 : {
						if(HouseInfo[hid][hgGarage]) return Send(playerid, COLOR_GREY, "* У Вас есть гараж!");
						if(HouseInfo[hid][hSafe][0] < 100000) return Send(playerid, COLOR_GREY, "* На счету дома недостаточно средств!");
						HouseInfo[hid][hSafe][0] -= 100000;
						GameTextForPlayer(playerid, "~r~-$100000", 1000, 1);
						PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
						format(query, sizeof query, "INSERT INTO `"#__TableHouseGarages__"` (`house`) VALUES ('%i')", HouseInfo[hid][hID]);
						Db::tquery(connDb, query, "", "");
						HouseInfo[hid][hgGarage] = true;
						Streamer_AppendArrayData(STREAMER_TYPE_PICKUP, HGaragePickup[0], E_STREAMER_WORLD_ID, HouseInfo[hid][hVirtual]);
						Streamer_AppendArrayData(STREAMER_TYPE_PICKUP, HGaragePickup[1], E_STREAMER_WORLD_ID, HouseInfo[hid][hVirtual]);
						Send(playerid, COLOR_GREY, "* В ваш дом добавлен гараж! Установите точку входа в доме (/editgarint) и точку выезда у дома (/editgarstreet)!");
					}
					case 1 : {
						new bidx = GetIndexFromBizID(Bizz_HouseService);
						if(HouseInfo[hid][hSafe][0] < 20000) return Send(playerid, COLOR_GREY, "* На счету дома недостаточно средств!");
						HouseInfo[hid][hTv] = 1;
						HouseInfo[hid][hSafe][0] -= 20000;
						GiveBizzProfit(bidx, 20000);
						BizzInfo[bidx][bProds]--;
						PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
						Send(playerid, COLOR_GRAD5, "Вы можете теперь смотреть телек, пишите /tv.");
					}
				}
			} else {
				ShowDialog(playerid, D_HMENU, DIALOG_STYLE_LIST, "[House Menu]", "dialog/hmenu.txt", "SELECT", "CANCEL");
			}
		}
		case D_HMENU+4:
		{
			if(response)
			{
				new hid = Pl::Info[playerid][pHouseKey];
				if(!IsPlayerHouseOwner(playerid, hid)) return Send(playerid, COLOR_GREY, "* У Вас нет дома!");
				switch(listitem)
				{
					case 0:
					{
						switch(HouseInfo[hid][hRent][0])
						{
							case 0:
							{
								HouseInfo[hid][hRent][0] = 1;
								return SPD(playerid, D_NONE, 0,
								"[House Menu] > Аренда",
								"Аренда была включена!", "ОК", "");
							}
							case 1:
							{
								HouseInfo[hid][hRent][0] = 0;
								return SPD(playerid, D_NONE, 0,
								"[House Menu] > Аренда",
								"Аренда была отключена!", "ОК", "");
							}
						}
					}
					case 1:
					{
						return SPD(playerid, D_HMENU+5, DIALOG_STYLE_INPUT,
						"[House Menu] > Аренда",
						"Введите сумму аренды.\n\
						Максемальная сумма: $99999","ENTER", "CANCEL");
					}
				}
			} else {
				ShowDialog(playerid, D_HMENU, DIALOG_STYLE_LIST, "[House Menu]", "dialog/hmenu.txt", "SELECT", "CANCEL");
			}
		}
		case D_HMENU+5:
		{
			if(response)
			{
				new hid = Pl::Info[playerid][pHouseKey];
				if(!IsPlayerHouseOwner(playerid, hid)) return Send(playerid, COLOR_GREY, "* У Вас нет дома!");
				if(sscanf(inputtext, "d", inputtext[0]))
				{
					return SPD(playerid, D_HMENU+5, DIALOG_STYLE_INPUT,
					"[House Menu] > Аренда",
					"Введите сумму аренды.\n\
					Максемальная сумма: $99999","ENTER", "CANCEL");
				}
				if(inputtext[0] < 1 || inputtext[0] > 99999)
				{
					Send(playerid, COLOR_GREY, "* Стоимость аренды может быть от $1 до $9999");
					return SPD(playerid, D_HMENU+5, DIALOG_STYLE_INPUT,
					"[House Menu] > Аренда",
					"Введите сумму аренды.\n\
					Максемальная сумма: $99999", "ENTER", "CANCEL");
				}
				HouseInfo[hid][hRent][1] = inputtext[0];
				format(string, sizeof(string), "Цена аренды была установлена!\nТепрь аренда стоит:\t$%d", inputtext[0]);
				SPD(playerid, D_NONE, 0, "[House Menu] > Аренда", string, "OK", "");
			}
			else
			{
				return SPD(playerid, D_HMENU+4, DIALOG_STYLE_LIST,
				"[House Menu] > Аренда",
				"Вкл./Откл. аренду\n\
				Цена аренды", "SELECT", "CANCEL");
			}
		}
		case D_HMENU+6:
		{
			new hid = Pl::Info[playerid][pHouseKey];
			if(response) {
				if(!IsPlayerHouseOwner(playerid, hid)) return Send(playerid, COLOR_GREY, "* У Вас нет дома!");
				switch(listitem)
				{
					case 0:
					{
						return SPD(playerid, D_HMENU+7, DIALOG_STYLE_INPUT,
						"[House Menu] > Сейф", "Сколько хотите положить?", "ENTER", "CANCEL");
					}
					case 1:
					{
						return  SPD(playerid, D_HMENU+8, DIALOG_STYLE_INPUT,
						"[House Menu] > Сейф", "Сколько хотите взять?", "ENTER", "CANCEL");
					}
				}
			}
			else
			{
				SafeMenu(playerid, hid);
			}
			return 1;
		}
		case D_HMENU+7:
		{

			if(response)
			{
				new hid = Pl::Info[playerid][pHouseKey];
				if(sscanf(inputtext, "d", inputtext[0])) {
					SPD(playerid, D_HMENU+7, DIALOG_STYLE_INPUT,
					"[House Menu] > Сейф", "Сколько хотите положить?", "ENTER", "CANCEL");
				}
				else if((HouseInfo[hid][hSafe][0] + inputtext[0]) > 10000000)
				{
					Send(playerid, COLOR_GREY, "* В сейф столько не влезит!");
					SPD(playerid, D_HMENU+7, DIALOG_STYLE_INPUT,
					"[House Menu] > Сейф", "Сколько хотите положить?", "ENTER", "CANCEL");
				}
				else if(inputtext[0] < 1 || inputtext[0] > Rac::GetPlayerMoney(playerid)) {
					Send(playerid, COLOR_GREY, "* У Вас нет столько денег!");
					SPD(playerid, D_HMENU+7, DIALOG_STYLE_INPUT,
					"[House Menu] > Сейф", "Сколько хотите положить?", "ENTER", "CANCEL");
				} else {
					HouseInfo[hid][hSafe][0] += inputtext[0];
					Rac::GivePlayerMoney(playerid, -inputtext[0]);
					format(string, sizeof(string), "Вы положили в сейф: {33AA33}$%d", inputtext[0]);
					SPD(playerid, D_NONE, 0, "[House Menu] > Сейф", string, "OK", "");
				}
			} else {
				SPD(playerid, D_HMENU+6, DIALOG_STYLE_LIST,
				"[House Menu] > Сейф", "Положить\nВзять", "SELECT", "CANCEL");
			}
			return 1;
		}
		case D_HMENU+8: {
			if(response) {
				new hid = Pl::Info[playerid][pHouseKey];
				if(sscanf(inputtext, "d", inputtext[0])) {
					SPD(playerid, D_HMENU+7, DIALOG_STYLE_INPUT,
					"[House Menu] > Сейф","Сколько хотите взять?", "ENTER", "CANCEL");
				} else if(inputtext[0] < 1 || inputtext[0] > HouseInfo[hid][hSafe][0]) {
					Send(playerid, COLOR_GREY, "* В сейфе не столько денег!");
					SPD(playerid, D_HMENU+7, DIALOG_STYLE_INPUT,
					"[House Menu] > Сейф","Сколько хотите взять?", "ENTER", "CANCEL");
				} else {
					HouseInfo[hid][hSafe][0] -= inputtext[0];
					Rac::GivePlayerMoney(playerid, inputtext[0]);
					format(string, sizeof(string), "Вы взяли из сейфа: {33AA33}$%d", inputtext[0]);
					SPD(playerid, D_NONE, 0, "[House Menu] > Сейф", string, "OK", "");
				}
			} else {
				SPD(playerid, D_HMENU+6, DIALOG_STYLE_LIST, "[House Menu] > Сейф", "Положить\nВзять", "SELECT", "CANCEL");
			}
		}
		
		case D_HMENU+10: {
			if(response) {
				switch(listitem) {
					case 0..3 : {
						format(dialog, sizeof dialog, "Машина\tЦена\n");
						for(new i; i < ASModelCount[listitem]; i++) {
							scf(dialog, string, ""#_GREY_ARROW"%s {33AA33}\t$%i\n", VehicleNames[AutoSolon[listitem][i][0] - 400], AutoSolon[listitem][i][1]);
						}
						SetPVarInt(playerid, "SelectedCar", listitem);
						SPD(playerid, D_HMENU+13, DIALOG_STYLE_TABLIST_HEADERS, "[House Menu] > Машина", dialog, "SELECT", "CANCEL");
					}
					case 4 : {
						new hid = Pl::Info[playerid][pHouseKey];
						if(!(400 <= HouseInfo[hid][hvModel] <= 611)) {
							SPD(playerid, D_NONE, 0, "[House Menu] > Авто", "У Вас нет домашнего авто!", "OK", "");
						} else {
							ShowDialog(playerid, D_HMENU+24, DIALOG_STYLE_INPUT, "[House Menu] > Авто > Покраска", "dialog/colors.txt", "SELECT", "CANCEL");
						}
					}
				}
			} else {
				ShowDialog(playerid, D_HMENU, DIALOG_STYLE_LIST, "[House Menu]", "dialog/hmenu.txt", "SELECT", "CANCEL");
			}
		
		}
		
		case D_HMENU+11: {
			new idx = GetPVarInt(playerid, "SelectedItem");
			if(idx == -1) return Send(playerid, -1, "Error");
			if(response) {
				new hid = Pl::Info[playerid][pHouseKey];
				new bidx = GetIndexFromBizID(Bizz_HouseService);
				if(!IsValidHouse(hid)) return Send(playerid, COLOR_GREY, "* У Вас нет дома!");
				if(!BizzInfo[bidx][bProds]) {
					GameTextForPlayer(playerid, "~r~Out of Stock", 1, 5000);
					ShowMenuForPlayer(IntMenu, playerid);
					return 1;
				}
				if(HouseInfo[hid][hSafe][0] < HouseInt[idx][InteriorPrice]) {
					Send(playerid, COLOR_GREY, "* На счету дома недастаточно средств!");
					ShowMenuForPlayer(IntMenu, playerid);
					return 1;
				}
				SetPVarInt(playerid, "SelectedItem", -1);
				HouseInfo[hid][hInt] = HouseInt[idx][Interior];
				CopyArray(HouseInfo[hid][hExit], HouseInt[idx][InteriorPos], 4);
				HouseInfo[hid][hSafe][0] -= HouseInt[idx][InteriorPrice];
				GiveBizzProfit(bidx, HouseInt[idx][InteriorPrice]);
				BizzInfo[bidx][bProds]--;
				Rac::SpawnPlayer(playerid);
				Send(playerid, COLOR_LIGHTBLUE, "* Интерьер был успешно изменен!");
			} else {
				SetPVarInt(playerid, "SelectedItem", idx);
				Rac::SetPlayerPos(playerid, HouseInt[0][InteriorPos][0], HouseInt[0][InteriorPos][1], HouseInt[0][InteriorPos][2]);
				SetPlayerFacingAngle(playerid, HouseInt[0][InteriorPos][3]);
				Rac::SetPlayerVirtualWorld(playerid, Pl::Info[playerid][pLocal] + playerid);
				SetCameraBehindPlayer(playerid);
				ShowMenuForPlayer(IntMenu, playerid);
			}
		}
				
		case D_HMENU+13: {
			if(response) {
				new hid = Pl::Info[playerid][pHouseKey];
				new bidx = GetIndexFromBizID(Bizz_HouseService);
				if(!IsPlayerHouseOwner(playerid, hid)) return Send(playerid, COLOR_GREY, "* Вы бомж, сначала купите дом.");
				if(!IsPlayerInSquare2D(playerid, 50.0, HouseInfo[hid][hEnter][0], HouseInfo[hid][hEnter][1])) return Send(playerid, COLOR_GREY, "* Вы слишком далеко от дома!");
				if(!BizzInfo[bidx][bProds]) return GameTextForPlayer(playerid, "~r~Out of Stock", 1, 5000);

				new vclass = GetPVarInt(playerid, "SelectedCar");
				if(HouseInfo[hid][hSafe][0] < AutoSolon[vclass][listitem][1]) return Send(playerid, COLOR_GREY, "* В сейфе дома нет столько денег!");
				CarUpgrade(playerid, hid, AutoSolon[vclass][listitem][0]);
				HouseInfo[hid][hSafe][0] -= AutoSolon[vclass][listitem][1];
				GiveBizzProfit(bidx, PERCENT(AutoSolon[vclass][listitem][1], 20));
				BizzInfo[bidx][bProds] --;
				format(string, sizeof(string), "* Новая Модернизация: Ваш автомобиль теперь %s", VehicleNames[AutoSolon[vclass][listitem][0] - 400]);
				Send(playerid, COLOR_LIGHTBLUE, string);
				SetPVarInt(playerid, "SelectedCar", -1);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			} else {
				ShowDialog(playerid, D_HMENU+10, DIALOG_STYLE_LIST, "[House Menu] > Авто", "dialog/hmenu_auto.txt", "SELECT", "CANCEL");
			}
		}
		
		case D_HMENU+24 : {
			if(response) {
				if(sscanf(inputtext, "p<,>ii", inputtext[0], inputtext[1])) {
					Send(playerid, COLOR_GREY, "* Не валидная строка, повторите ввод!");
					return ShowDialog(playerid, D_HMENU+24, DIALOG_STYLE_INPUT, "[House Menu] > Авто > Покраска", "dialog/colors.txt", "SELECT", "CANCEL");
				} else if(inputtext[0] < 0 || inputtext[0] > 127) {
					Send(playerid, COLOR_GREY, "* Не валидная строка, повторите ввод!");
					return ShowDialog(playerid, D_HMENU+24, DIALOG_STYLE_INPUT, "[House Menu] > Авто > Покраска", "dialog/colors.txt", "SELECT", "CANCEL");
				} else if(inputtext[1] < 0 || inputtext[1] > 127) {
					Send(playerid, COLOR_GREY, "* Не валидная строка, повторите ввод!");
					return ShowDialog(playerid, D_HMENU+24, DIALOG_STYLE_INPUT, "[House Menu] > Авто > Покраска", "dialog/colors.txt", "SELECT", "CANCEL");
				}
				new hid = Pl::Info[playerid][pHouseKey];
				new bidx = GetIndexFromBizID(Bizz_HouseService);
				if(!IsPlayerInSquare2D(playerid, 50.0, HouseInfo[hid][hEnter][0], HouseInfo[hid][hEnter][1])) return Send(playerid, COLOR_GREY, "* Вы слишком далеко от дома!");
				if(!BizzInfo[bidx][bProds]) return GameTextForPlayer(playerid, "~r~Out of Stock", 1, 5000);
				if(HouseInfo[hid][hSafe][0] < 10000) return Send(playerid, COLOR_GREY, "* В сейфе дома нет столько денег!");
				ChangeVehicleColor(HouseInfo[hid][hAuto], inputtext[0], inputtext[1]);
				HouseInfo[hid][hvColor][0] = inputtext[0];
				HouseInfo[hid][hvColor][1] = inputtext[1];
				format(string, sizeof(string), "* Новая Модернизация: Ваш автомобиль был перекрашен в цвета %i/%i", inputtext[0], inputtext[1]);
				Send(playerid, COLOR_LIGHTBLUE, string);
				GameTextForPlayer(playerid, "~r~-$10000", 5000, 1);
			} else {
				ShowDialog(playerid, D_HMENU+10, DIALOG_STYLE_LIST, "[House Menu] > Авто", "dialog/hmenu_auto.txt", "SELECT", "CANCEL");
			}
		}
		
		case D_HMENU+14 : {
			if(response) {
				switch(listitem) {
					case 0: SPD(playerid, D_HMENU+6, DIALOG_STYLE_LIST, "[House Menu] > Сейф > Денги", ""#_GREY_ARROW"Положить\n"#_GREY_ARROW"Взять", "SELECT", "CANCEL");
					case 1: SPD(playerid, D_HMENU+15, DIALOG_STYLE_LIST, "[House Menu] > Сейф > Наркотики", ""#_GREY_ARROW"Положить\n"#_GREY_ARROW"Взять", "SELECT", "CANCEL");
					case 2: SPD(playerid, D_HMENU+18, DIALOG_STYLE_LIST, "[House Menu] > Сейф > Матиреалы", ""#_GREY_ARROW"Положить\n"#_GREY_ARROW"Взять", "SELECT", "CANCEL");
					case 3: SafeMenu(playerid, Pl::Info[playerid][pHouseKey], 1);
					case 4: SPD(playerid, D_HMENU+1, DIALOG_STYLE_LIST, "[House Menu] > Сейф > Аптечки", ""#_GREY_ARROW"Использовать\n"#_GREY_ARROW"Купить {33AA33}[$1000]", "SELECT", "CANCEL");
					case 5: {
						if(IsACop(playerid) && Pl::Info[playerid][pRank] >= 3) {
							SPD(playerid, D_HMENU+2, DIALOG_STYLE_LIST, "[House Menu] > Сейф > Бронежилеты", ""#_GREY_ARROW"Использовать\n"#_GREY_ARROW"Купить {33AA33}[$3000]", "SELECT", "CANCEL");
						} else {
							Send(playerid, COLOR_GREY, "* Только законики могут использовать бронижелет!");
							SafeMenu(playerid, Pl::Info[playerid][pHouseKey]);
						}
					}
				}
			} else {
				ShowDialog(playerid, D_HMENU, DIALOG_STYLE_LIST, "[House Menu]", "dialog/hmenu.txt", "SELECT", "CANCEL");
			}
		}
		case D_HMENU+15:
		{
			new hid = Pl::Info[playerid][pHouseKey];
			if(response)
			{
				if(!IsPlayerHouseOwner(playerid, hid)) return Send(playerid, COLOR_GREY, "* У Вас нет дома!");
				switch(listitem)
				{
					case 0:
					{
						return SPD(playerid, D_HMENU+16, DIALOG_STYLE_INPUT,
						"[House Menu] > Сейф > Наркотики",
						"Сколько хотите положить?", "ENTER", "CANCEL");
					}
					case 1:
					{
						return SPD(playerid, D_HMENU+17, DIALOG_STYLE_INPUT,
						"[House Menu] > Сейф > Наркотики",
						"Сколько хотите взять?", "ENTER", "CANCEL");
					}
				}
			}
			else
			{
				SafeMenu(playerid, hid);
			}
		}
		case D_HMENU+16:
		{
			if(response)
			{
				new hid = Pl::Info[playerid][pHouseKey];
				if(sscanf(inputtext, "i", inputtext[0]))
				{
					return SPD(playerid, D_HMENU+16, DIALOG_STYLE_INPUT,
					"[House Menu] > Сейф > Наркотики > Положить",
					"Сколько хотите положить?", "ENTER", "CANCEL");
				}
				if((HouseInfo[hid][hSafe][1] + inputtext[0]) > 1000)
				{
					Send(playerid, COLOR_GREY, "* В сейф столько не влезит!");
					return SPD(playerid, D_HMENU+16, DIALOG_STYLE_INPUT,
					"[House Menu] > Сейф > Наркотики > Положить",
					"Сколько хотите положить?", "ENTER", "CANCEL");
				}
				if(inputtext[0] < 1 || inputtext[0] > Pl::Info[playerid][pDrugs])
				{
					Send(playerid, COLOR_GREY, "* У Вас нет столько наркоты!");
					return SPD(playerid, D_HMENU+16, DIALOG_STYLE_INPUT,
					"[House Menu] > Сейф > Наркотики > Положить",
					"Сколько хотите положить?", "ENTER", "CANCEL");
				}
				HouseInfo[hid][hSafe][1] += inputtext[0];
				Pl::Info[playerid][pDrugs] -= inputtext[0];
				format(string, sizeof(string), "Вы положили в сейф: %i грамм", inputtext[0]);
				return SPD(playerid, D_NONE, 0, "[House Menu] > Сейф > Наркотики > Положить", string, "OK", "");
			}
			else
			{
				SPD(playerid, D_HMENU+15, DIALOG_STYLE_LIST,
				"[House Menu] > Сейф > Наркотики", "Положить\nВзять", "ENTER", "CANCLE");
				return 1;
			}
		}
		case D_HMENU+17:
		{
			if(response)
			{
				new hid = Pl::Info[playerid][pHouseKey];
				if(sscanf(inputtext, "i", inputtext[0]))
				{
					return SPD(playerid, D_HMENU+17, DIALOG_STYLE_INPUT,
					"[House Menu] > Сейф > Наркотики > Взять",
					"Сколько хотите взять?", "ENTER", "CANCEL");
				}
				if(inputtext[0] < 1 || inputtext[0] > HouseInfo[hid][hSafe][1])
				{
					Send(playerid, COLOR_GREY, "* В сейфе нет столько!");
					return SPD(playerid, D_HMENU+17, DIALOG_STYLE_INPUT,
					"[House Menu] > Сейф > Наркотики > Взять",
					"Сколько хотите взять?", "ENTER", "CANCEL");
				}
				HouseInfo[hid][hSafe][1] -= inputtext[0]; Pl::Info[playerid][pDrugs] += inputtext[0];
				format(string, sizeof(string), "Вы взяли из сейфа: %i грамм", inputtext[0]);
				return SPD(playerid, D_NONE, 0, "[House Menu] > Сейф > Наркотики > Взять", string, "OK", "");
			}
			else
			{
				return SPD(playerid, D_HMENU+15, DIALOG_STYLE_LIST,
				"[House Menu] > Сейф > Наркотики", "Положить\nВзять", "ENTER", "CANCLE");
			}
		}
		case D_HMENU+18:
		{
			new hid = Pl::Info[playerid][pHouseKey];
			if(response)
			{
				if(!IsPlayerHouseOwner(playerid, hid)) return Send(playerid, COLOR_GREY, "* У Вас нет дома!");
				switch(listitem)
				{
					case 0:
					{
						return SPD(playerid, D_HMENU+19, DIALOG_STYLE_INPUT,
						"[House Menu] > Сейф > Материалы",
						"Сколько хотите положить?", "ENTER", "CANCEL");
					}
					case 1:
					{
						return SPD(playerid, D_HMENU+20, DIALOG_STYLE_INPUT,
						"[House Menu] > Сейф > Материалы",
						"Сколько хотите взять?", "ENTER", "CANCEL");
					}
				}
			}
			else
			{
				SafeMenu(playerid, hid);
			}
		}
		case D_HMENU+19:
		{
			if(response)
			{
				new hid = Pl::Info[playerid][pHouseKey];
				if(sscanf(inputtext, "i", inputtext[0]))
				{
					return SPD(playerid, D_HMENU+19, DIALOG_STYLE_INPUT,
					"[House Menu] > Сейф > Материалы",
					"Сколько хотите положить?", "ENTER", "CANCEL");
				}
				if((HouseInfo[hid][hSafe][2] + inputtext[0]) > 100000)
				{
					Send(playerid, COLOR_GREY, "* В сейф столько не влезит!");
					return SPD(playerid, D_HMENU+19, DIALOG_STYLE_INPUT,
					"[House Menu] > Сейф > Материалы",
					"Сколько хотите положить?", "ENTER", "CANCEL");
				}
				if(inputtext[0] < 1 || inputtext[0] > Pl::Info[playerid][pMats])
				{
					Send(playerid, COLOR_GREY, "* У Вас нет столько материалов!");
					return SPD(playerid, D_HMENU+19, DIALOG_STYLE_INPUT,
					"[House Menu] > Сейф > Материалы",
					"Сколько хотите положить?", "ENTER", "CANCEL");
				}
				HouseInfo[hid][hSafe][2] += inputtext[0]; Pl::Info[playerid][pMats] -= inputtext[0];
				format(string, sizeof(string), "Вы положили в сейф: %i материалов", inputtext[0]);
				return SPD(playerid, D_NONE, 0, "[House Menu] > Сейф > Материалы > Положить", string, "OK", "");
			}
			else
			{
				return SPD(playerid, D_HMENU+18, DIALOG_STYLE_LIST,
				"[House Menu] > Сейф > Материалы", "Положить\nВзять", "ENTER", "CANCLE");
			}
		}
		case D_HMENU+20:
		{
			if(response)
			{
				new hid = Pl::Info[playerid][pHouseKey];
				if(sscanf(inputtext, "i", inputtext[0]))
				{
					return SPD(playerid, D_HMENU+20, DIALOG_STYLE_INPUT,
					"[House Menu] > Сейф > Материалы",
					"Сколько хотите взять?", "ENTER", "CANCEL");
				}
				if(inputtext[0] < 1 || inputtext[0] > HouseInfo[hid][hSafe][2])
				{
					Send(playerid, COLOR_GREY, "* В сейфе нет столько!");
					return SPD(playerid, D_HMENU+20, DIALOG_STYLE_INPUT,
					"[House Menu] > Сейф > Материалы",
					"Сколько хотите взять?", "ENTER", "CANCEL");
				}
				HouseInfo[hid][hSafe][2] -= inputtext[0];
				Pl::Info[playerid][pMats] += inputtext[0];
				format(string, sizeof(string), "Вы взяли из сейфа: %i материалов", inputtext[0]);
				return SPD(playerid, D_NONE, 0, "[House Menu] > Сейф > Материалы > Взять", string, "OK", "");
			}
			else
			{
				return SPD(playerid, D_HMENU+18, DIALOG_STYLE_LIST,
				"[House Menu] > Сейф > Материалы", "Положить\nВзять", "ENTER", "CANCLE");
			}
		}
		case D_HMENU+21: {
			if(response) {
				SetPVarInt(playerid, "s_index", listitem);
				return SPD(playerid, D_HMENU+22, DIALOG_STYLE_LIST,
				"[House Menu] > Сейф > Оружие","Взять\nПоложить", "SELECT", "CANCEL");
			} else {
				new hid = Pl::Info[playerid][pHouseKey];
				SafeMenu(playerid, hid);
			}
		}
		
		case D_HMENU+22: {
			if(response) {
				new hid = Pl::Info[playerid][pHouseKey];
				new idx = GetPVarInt(playerid, "s_index");
				switch(listitem) {
					case 0: {
						if(HouseInfo[hid][hGuns][idx] == 0) {
							Send(playerid, COLOR_GREY, "* В этом слоте нет оружия!");
							return SafeMenu(playerid, hid, 1);
						}
						Rac::GivePlayerWeapon(playerid, HouseInfo[hid][hGuns][idx], HouseInfo[hid][hAmmos][idx]);
						HouseInfo[hid][hGuns][idx] = 0; HouseInfo[hid][hAmmos][idx] = 0;
						return SPD(playerid, D_HMENU+23, 0, "[House Menu] > Сейф > Оружие", "Вы взяли оружие из сейфа!", "Назад", "Выход");
					}
					case 1:
					{
						if(HouseInfo[hid][hGuns][idx] != 0)
						{
							Send(playerid, COLOR_GREY, "* В этом слоте уже есть оружия!");
							return SafeMenu(playerid, hid, 1);
						}
						if(HouseInfo[hid][hAmmos][idx] >= 1000)
						{
							Send(playerid, COLOR_GREY, "* Мало места!");
							return SafeMenu(playerid, hid, 1);
						}
						HouseInfo[hid][hGuns][idx] = Rac::GetPlayerWeapon(playerid);
						HouseInfo[hid][hAmmos][idx] = Rac::GetPlayerAmmo(playerid, HouseInfo[hid][hGuns][idx]);
						Rac::RemovePlayerWeapon(playerid, HouseInfo[hid][hGuns][idx]);
						return SPD(playerid, D_HMENU+23, 0,
						"[House Menu] > Сейф > Оружие", "Вы положили оружие в сейф!", "Назад", "Выход");
					}
				}
			}
			else
			{
				SafeMenu(playerid, Pl::Info[playerid][pHouseKey], 1);
			}
		}
		case D_HMENU+23 : {
			if(response) return SafeMenu(playerid, Pl::Info[playerid][pHouseKey], 1);
		}

		
		case D_RENTCAR:
		{
			if(response)
			{
				new vehid = GetPlayerVehicleID(playerid);
				if(IsACompTruck(vehid))
				{
					new hirefee = HireCost(vehid);
					if (Rac::GetPlayerMoney(playerid) < hirefee)
					{
						Rac::RemovePlayerFromVehicle(playerid);
						Rac::TogglePlayerControllable(playerid, 1);
						Send(playerid, COLOR_GRAD2, "* У Вас мало денег!");
					}
					else
					{
						foreach(new i : Biznes)
						{
							if(PlayerToKvadrat(playerid, BizzInfo[i][bzMinX], BizzInfo[i][bzMinY], BizzInfo[i][bzMaxX], BizzInfo[i][bzMaxY]))
							{
								if(BizzInfo[i][bID] == Bizz_ProdSkladLS || BizzInfo[i][bID] == Bizz_ProdSkladSF)
								{
									if((BizzInfo[i][bID] == Bizz_ProdSkladLS && Pl::Info[playerid][pBizKey] != Bizz_ProdSkladLS)
									|| (BizzInfo[i][bID] == Bizz_ProdSkladSF && Pl::Info[playerid][pBizKey] != Bizz_ProdSkladSF))
									{
										Rac::GivePlayerMoney(playerid, -hirefee);
										GiveBizzProfit(i, hirefee);
										PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
										format(string, sizeof(string), "~r~-$%i~n~~w~To open or close using ~g~/lock.~w~successful work!", hirefee);
										GameTextForPlayer(playerid, string, 5000, 3);
										Send(playerid, COLOR_GREEN, "* Вы можете доставлять продукты в бизнесы");
										Send(playerid, COLOR_GREEN, "* Команды доставки /buyprods /sellprods");
									}
									else
									{
										GameTextForPlayer(playerid, "~w~No charge for the boss.~n~To open or close using ~g~/lock.~w~successful work!", 5000, 3);
										Send(playerid, COLOR_GREEN, "* Вы можете доставлять продукты в бизнесы");
										Send(playerid, COLOR_GREEN, "* Команды доставки /buyprods /sellprods");
									}
									if(HireCar[playerid] != INVALID_VEHICLE_ID)
									{
										ToggleVehicleDoor(HireCar[playerid], true);
									}
									HireCar[playerid] = vehid;
									Rac::TogglePlayerControllable(playerid, 1);
									break;
								}
							}
						}
					}
				}
				else
				{
					Rac::RemovePlayerFromVehicle(playerid);
					Rac::TogglePlayerControllable(playerid, 1);
				}
			}
			else
			{
				Rac::RemovePlayerFromVehicle(playerid);
				Rac::TogglePlayerControllable(playerid, 1);
			}
			return 1;
		}
		
		case D_TUNING: {
			if(response) {
				switch(listitem) {
					case 0: {
						SPD(playerid, D_TUNING+1, DIALOG_STYLE_MSGBOX, ""#__SERVER_PREFIX""#__SERVER_NAME_LC": Tuning", "* Вы хотите заригистрировать тюнинг.\n\
						Стоимость улуги: $100000", "OK", "CANCEL");
					}
					
					case 1: {
						SPD(playerid, D_TUNING+2, DIALOG_STYLE_MSGBOX, ""#__SERVER_PREFIX""#__SERVER_NAME_LC": Tuning", "* Вы хотите удалить тюнинг.\n\
						Стоимость улуги: $50000", "OK", "CANCEL");
					}
				}
			}
			
			return 1;
		}
		case D_TUNING+1: {
			if(response) {
				if(Rac::GetPlayerMoney(playerid) < 100000) return Send(playerid, COLOR_GREY, "* У Вас не хватает денег!");
				new bidx = GetIndexFromBizID(Bizz_AutoSolonClassC);
				new house = Pl::Info[playerid][pHouseKey];
				UpdateTuning(HouseInfo[house][hAuto], 1, house);
				Rac::GivePlayerMoney(playerid, -100000);
				GiveBizzProfit(bidx, 10000);
				BizzInfo[bidx][bProds]--;
				Send(playerid, COLOR_LIGHTBLUE, "* Тюнинг был зарегистрирован!");
			} else {
				SPD(playerid, D_TUNING, DIALOG_STYLE_LIST, ""#__SERVER_PREFIX""#__SERVER_NAME_LC": Tuning", "Зарегистрировать тюнинг\nУдалить тюнинг", "SELECT", "CANCEL");
			}
		}
		case D_TUNING+2: {
			if(response) {
				if(Rac::GetPlayerMoney(playerid) < 5000) return Send(playerid, COLOR_GREY, "* У Вас не хватает денег!");
				new bidx = GetIndexFromBizID(Bizz_AutoSolonClassC);
				new hidx = Pl::Info[playerid][pHouseKey];
				if(IsValidHouse(hidx)) {
					Rac::GivePlayerMoney(playerid, -5000);
					GiveBizzProfit(bidx, 5000);
					BizzInfo[bidx][bProds]--;
					ResetTuning(HouseInfo[hidx][hAuto], 1, hidx);
					Send(playerid, COLOR_LIGHTBLUE, "* Тюнинг был удален!");
				} else {
					Send(playerid, COLOR_GREY, "* У Вас нет дома!");
				}
			} else {
				SPD(playerid, D_TUNING, DIALOG_STYLE_LIST, ""#__SERVER_PREFIX""#__SERVER_NAME_LC": Tuning", "Зарегистрировать тюнинг\nУдалить тюнинг", "SELECT", "CANCEL");
			}
		}

		case D_GOTO : {
			if(response) {
				switch(listitem) {
					case 0 : {
						SPD(playerid, D_GOTO+1,DIALOG_STYLE_LIST,""#__SERVER_PREFIX""#__SERVER_NAME_LC": Телепорты > Популярные места",
						"— Los Santos\n— San Fierro\n— Las Venturas\n— АвтоШкола\n\
						— Тюрьма\n— Присон\n— Отель ЛС\n— Банк\n— Дальнобой\n\
						— Маяк\n— Небоскреб Лос Сантоса\n— Гора Чиллиад\n— Рублевка", "SELECT", "CANCEL");
					}
					case 1 : {
						dialog[0] = '\0';
						static const family[] = {5, 6, 8, 12, 13, 14, 15, 16, 17, 18};
						for(new i; i < sizeof family; i++) {
							scf(dialog, string, "— %s\n", FracInfo[family[i]][fName]);
						}
						SPD(playerid, D_GOTO+2, DIALOG_STYLE_LIST, ""#__SERVER_PREFIX""#__SERVER_NAME_LC": Телепорты > Респы банд/мафий", dialog, "SELECT", "CANCEL");
					}
					case 2 : {
						dialog[0] = '\0';
						static const team[] = {1, 2, 3, 4, 7, 9, 10, 11};
						for(new i; i < sizeof team; i++) {
							scf(dialog, string, "— %s\n", FracInfo[team[i]][fName]);
						}
						SPD(playerid, D_GOTO+3, DIALOG_STYLE_LIST, ""#__SERVER_PREFIX""#__SERVER_NAME_LC": Телепорты > Респы фракций", dialog, "SELECT", "CANCEL");
					}
				}
			}
			return 1;
		}
		
		case D_GOTO+1 : {
			if(response) {
				static const Float:tp_respInfo[][] = {
					{1529.6,-1691.2,13.3},
					{-1417.0,-295.8,14.1},
					{1699.2,1435.1,10.7},
					{-2029.798,-106.675,1038.171},
					{263.9608,82.2232,1004.6830},
					{223.8246,1889.4766,17.6406},
					{2225.5227,-1119.8511,25.7969},
					{1461.3962,-1027.9645,23.3168},
					{-72.1355,-1144.2100,4.1964},
					{146.9576,-1965.2183,3.7734},
					{1546.7333,-1371.1244,329.4535},
					{-2256.3052,-1745.8374,487.5512},
					{-2503.6970,2434.2261,16.8024}
				};
				
				if(0 <= listitem <= sizeof(tp_respInfo)) {
					if(GetPlayerState(playerid) == 2) {
						new tmpcar = GetPlayerVehicleID(playerid);
						Rac::SetVehiclePos(tmpcar, tp_respInfo[listitem][0], tp_respInfo[listitem][1], tp_respInfo[listitem][2]);
					} else {
						Rac::SetPlayerPos(playerid, tp_respInfo[listitem][0], tp_respInfo[listitem][1], tp_respInfo[listitem][2]);
					}
					switch(listitem) {
						case 3 : {
							Rac::SetPlayerVirtualWorld(playerid, 11);
							Rac::SetPlayerInterior(playerid,3);
						}
						case 4 : {
							Rac::SetPlayerVirtualWorld(playerid, 1);
							Rac::SetPlayerInterior(playerid, 6);
						}
						default : {
							Rac::SetPlayerVirtualWorld(playerid, 0);
							Rac::SetPlayerInterior(playerid, 0);
						}
					}
					Pl::Info[playerid][pLocal] = 0;
					Send(playerid, COLOR_WHITE, "*"#__SERVER_PREFIX""#__SERVER_NAME_LC": Вы были телепортированы!");
				}
			} else {
				SPD(playerid, D_GOTO, DIALOG_STYLE_LIST, ""#__SERVER_PREFIX""#__SERVER_NAME_LC": Телепорты", "— Популярные места\n— Респы банд\n— Респы фракций", "SELECT", "CANCEL");
			}
		}
		
		case D_GOTO+2: {
			if(response) {
				static const Float:gg_respInfo[][4] = {
					{1141.9388,-2035.1228,69.0078,178.7023},
					{1462.1758,2768.4282,10.8203,267.1316},
					{-1038.2272,-1222.7651,129.2188,89.8312},
					{1060.6426,2159.7278,10.8203,92.2892},
					{-2740.4331,-333.2186,7.1792,314.0976},
					{2474.6370,-1679.3092,13.3365,231.6960},
					{1757.7224,-1895.2913,13.5561,266.3302},
					{876.3609,-1102.0140,24.2969,268.9612},
					{-2156.4856,-197.4804,35.3203,179.7661},
					{2773.9526,-1607.6476,10.9219,268.2025},
					{1063.1372,2159.8367,10.8203,87.9544}
				};
				if(0 <= listitem <= sizeof(gg_respInfo)) {
					new tmpcar = GetPlayerVehicleID(playerid);
					if(GetPlayerState(playerid) == 2) {
						Rac::SetVehiclePos(tmpcar, gg_respInfo[listitem][0], gg_respInfo[listitem][1], gg_respInfo[listitem][2]);
						SetVehicleZAngle(tmpcar, gg_respInfo[listitem][3]);
					} else {
						Rac::SetPlayerPos(playerid, gg_respInfo[listitem][0], gg_respInfo[listitem][1], gg_respInfo[listitem][2]);
						SetPlayerFacingAngle(playerid, gg_respInfo[listitem][3]);
					}
					Pl::Info[playerid][pLocal] = 0;
					Rac::SetPlayerVirtualWorld(playerid, 0);
					Rac::SetPlayerInterior(playerid,0);
					Send(playerid, COLOR_WHITE, "*"#__SERVER_PREFIX""#__SERVER_NAME_LC": Вы были телепортированы!");
				}
			} else {
				SPD(playerid, D_GOTO, DIALOG_STYLE_LIST, ""#__SERVER_PREFIX""#__SERVER_NAME_LC": Телепорты", "— Популярные места\n— Респы банд\n— Респы фракций", "SELECT", "CANCEL");
			}
		}
		
		case D_GOTO+3 : {
			if(response) {
				static const Float:gf_respInfo[][] = {
					{1531.4489,-1701.7860,6.2188},
					{-1581.9905,677.6925,-4.9063},
					{223.8246,1889.4766,17.6406},
					{-2681.4397,638.0493,14.453},
					{1469.1552,-1771.1403,18.7958},
					{752.0109,-1356.0024,13.7000},
					{-1719.3878,1028.7029,17.5859},
					{-2044.9961,-119.2935,34.9892}
				};
				if(0 <= listitem <= sizeof(gf_respInfo)) {
					new tmpcar = GetPlayerVehicleID(playerid);
					if(GetPlayerState(playerid) == 2) {
						Rac::SetVehiclePos(tmpcar, gf_respInfo[listitem][0], gf_respInfo[listitem][1], gf_respInfo[listitem][2]);
					} else {
						Rac::SetPlayerPos(playerid, gf_respInfo[listitem][0], gf_respInfo[listitem][1], gf_respInfo[listitem][2]);
					}
					Pl::Info[playerid][pLocal] = 0;
					Rac::SetPlayerVirtualWorld(playerid, 0);
					Rac::SetPlayerInterior(playerid,0);
					Send(playerid, COLOR_WHITE, "*"#__SERVER_PREFIX""#__SERVER_NAME_LC": Вы были телепортированы!");
				}
			} else {
				SPD(playerid, D_GOTO, DIALOG_STYLE_LIST, ""#__SERVER_PREFIX""#__SERVER_NAME_LC": Телепорты", "— Популярные места\n— Респы банд\n— Респы фракций", "SELECT", "CANCEL");
			}
		}
		
		case D_REFILL : {
			if(response) {
				if(!sscanf(inputtext, "i", inputtext[0])) {
					new i = GetPVarInt(playerid, "SelectGas");
					new veh = GetPlayerVehicleID(playerid);
					if(!(1 <= inputtext[0] <= 100)) return Send(playerid, COLOR_GREY, "* Вы не можите заправится больше чем на 100 литров!");
					if((floatround(AutoInfo[veh][aFuel]) + inputtext[0]) > 100) return Send(playerid, COLOR_GREY, "* В бензобак не влезит столько бензина!");
					new FillUP = (inputtext[0] * (BizzInfo[GetIndexFromBizID(RefillInfo[i][brBizID])][bEnterCost]/100));
					if(Rac::GetPlayerMoney(playerid) < FillUP) return Send(playerid, COLOR_GREY, "* У Вас не хватает денег на запрваку!");
					SetTimerEx("Fillup", 250, false, "iiii", playerid, inputtext[0], FillUP, inputtext[0]);
					Rac::TogglePlayerControllable(playerid, 0);
					format(string, sizeof string, "~g~%i~n~~b~Please wait...", inputtext[0]);
					GameTextForPlayer(playerid, string, 600, 5);
				}
			} else {
				SetPVarInt(playerid, "SelectGas", INVALID_ID);
			}
		}
		
		case D_CRANK: {
			if(response) {
				if(!sscanf(inputtext, "p<.>i{s[40]}", inputtext[0])) {
					new frac = GetPVarInt(playerid, "SelectedFrac");
					SetPVarInt(playerid, "SelectedRank", inputtext[0]);
					if(Pl::Info[playerid][pLeader] == frac || Pl::isAdmin(playerid, ADMINISTRATOR)) {
						format( dialog, sizeof dialog, "Текущее: %s\nВведите новое название ранга.\n", RankInfo[frac][inputtext[0]]);
						SPD(playerid, D_CRANK+1, 1, "Название ранга", dialog, "OK", "CANCEL");
					} else {
						Send(playerid, COLOR_GREY, "* Недостаточно прав!");
					}
				}
			}
		}
		
		case D_CRANK+1: {
			if(response) {
				new len = strlen(inputtext);
				new frac = GetPVarInt(playerid, "SelectedFrac"), rank = GetPVarInt(playerid, "SelectedRank");
				if(isnull(inputtext) || inputtext[0] == ' ') {
					Send(playerid, COLOR_GREY, "* Поле ввода пустое!");
					format(dialog, sizeof dialog, "* Неверный ввод!\nТекущее: %s\nВведите новое название ранга.\n", RankInfo[frac][rank] );
					SPD(playerid, D_CRANK+1, 1, "Название ранга", dialog, "OK", "CANCEL");
				} else if(!len || len > 36) {
					Send(playerid, COLOR_GREY, "* Макс. длина ранга состовляет 36 символов!");
					format(dialog, sizeof dialog, "Текущее: %s\nВведите новое название ранга.\n", RankInfo[frac][rank]);
					SPD(playerid, D_CRANK+1, 1, "Название ранга", dialog, "ENTER", "CANCLE");
				} else if(!regex_match_exid(inputtext, ValidText)) {
					Send(playerid, COLOR_GREY, "* В названии ранга есть заприщеные символы!");
					format(dialog, sizeof dialog, "Текущее: %s\nВведите новое название ранга.\n", RankInfo[frac][rank]);
					SPD(playerid, D_CRANK+1, 1, "Название ранга", dialog, "OK", "CANCEL");
				} else {
					format(dialog, sizeof dialog, "Ранг был изменен!\n\n  Старый: %s\n  Новый: %s\n", RankInfo[frac][rank], inputtext);
					SPD(playerid, D_CRANK+2, 0, "Название ранга", dialog, "OK", "CANCEL");
					UpdateRank(frac, rank, inputtext);
				}
			} else {
				ShowRankList(playerid, GetPVarInt(playerid, "SelectedFrac"));
			}
		}
		
		case D_CRANK+2: {
			if(!response) ShowRankList(playerid, GetPVarInt(playerid, "SelectedFrac"));
		}
		
		case D_BMENU: {
			new bidx = GetIndexFromBizID(Pl::Info[playerid][pBizKey]);
			if(!IsPlayerBizOwner(playerid, bidx) && !IsPlayerBizExtortion(playerid, bidx)) return Send(playerid, COLOR_GREY, "* Вам не принадлежит бизнес!");
			if(response) {
				switch(listitem) {
					case 0 : {
						PrintBizInfo(playerid, Pl::Info[playerid][pBizKey]);
					}
					case 1 : {
						SPD(playerid, D_BMENU+1, DIALOG_STYLE_LIST, "[Biz Menu] > Счет бизнеса", ""#_GREY_ARROW"Снять деньги\n"#_GREY_ARROW"Положить деньги", "ENTER", "CANCLE");
					}
					case 2 : {
						format(string, sizeof(string), "* Введите стоимость(от $1 до $9999) услуг бизнеса.\n\nТекущая стоимость: $%i", BizzInfo[bidx][bEnterCost]);
						SPD(playerid, D_BMENU+4, DIALOG_STYLE_INPUT, "[Biz Menu] > Стоимость услуг", string, "ENTER", "CANCLE");
					}
					case 3 : {
						format(string, sizeof(string), "* Введите новое название бизнеса.\n\nТекущие название: %s", BizzInfo[bidx][bDescription]);
						SPD(playerid, D_BMENU+5, DIALOG_STYLE_INPUT, "[Biz Menu] > Название бизнеса", string, "ENTER", "CANCLE");
					}
					case 4 : {
						format(string, sizeof(string), "* Введите сумму(от $1 до $999) по которой будут\n\
						закупатся продукты в бизнес.\n\nТекущая сумма: $%i", BizzInfo[bidx][bPriceProd]);
						SPD(playerid, D_BMENU+6, DIALOG_STYLE_INPUT, "[Biz Menu] > Цена за продукты", string, "ENTER", "CANCLE");
					}
					case 5 : {
						format(string, sizeof(string),"* Введите ID игрока чтобы назначить нового компаньона.\n\
						Чтобы убрать компаньона введите 255.\n\nТекущий компаньон: %s", BizzInfo[bidx][bExtortion]);
						SPD(playerid, D_BMENU+7, 1, "[Biz Menu] > Компаньон", string, "ENTER", "CANCLE");
					}
				}
			}
		}
		
		case D_BMENU+1: {
			if(response) {
				new bidx = GetIndexFromBizID(Pl::Info[playerid][pBizKey]);
				if(!IsPlayerBizOwner(playerid, bidx) && !IsPlayerBizExtortion(playerid, bidx)) return Send(playerid, COLOR_GREY, "* Вам не принадлежит бизнес!");
				switch(listitem) {
					case 0: {
						format(dialog, sizeof dialog, "* Введите сумму(от $1 до $1kk) которую хотите снять!\n\nТекущий баланс: $%i", BizzInfo[bidx][bSafe]);
						SPD(playerid, D_BMENU+2, DIALOG_STYLE_INPUT, "[Biz Menu] > Счет бизнеса", dialog, "ENTER", "CANCLE");
					}
					case 1: {
						format(dialog, sizeof dialog, "* Введите сумму(от $1 до $1kk) которую хотите положить!\n\nТекущий баланс: $%i\nНаличные: $%i", BizzInfo[bidx][bSafe], Rac::GetPlayerMoney(playerid));
						SPD(playerid, D_BMENU+3, DIALOG_STYLE_INPUT, "[Biz Menu] > Счет бизнеса", dialog, "ENTER", "CANCLE");
					}
				}
			} else {
				ShowDialog(playerid, D_BMENU, DIALOG_STYLE_LIST, "[Biz Menu]", "dialog/bmenu.txt", "ENTER", "CANCLE");
			}
		}
		
		case D_BMENU+2: {
			if(response) {
				new bidx = GetIndexFromBizID(Pl::Info[playerid][pBizKey]);
				if(!IsPlayerBizOwner(playerid, bidx) && !IsPlayerBizExtortion(playerid, bidx)) return Send(playerid, COLOR_GREY, "* Вам не принадлежит бизнес!");
				if(sscanf(inputtext, "i", inputtext[0]) == 0) {
					if(inputtext[0] < 1) {
						format(dialog, sizeof dialog, "* Введите сумму(от $1 до $1kk) которую хотите снять!\n\nТекущий баланс: $%i", BizzInfo[bidx][bSafe]);
						SPD(playerid, D_BMENU+2, DIALOG_STYLE_INPUT, "[Biz Menu] > Счет бизнеса", dialog, "ENTER", "CANCLE");
					}
					else if(inputtext[0] > 1000000) {
						format(dialog, sizeof dialog, "* Введите сумму(от $1 до $1kk) которую хотите снять!\n\nТекущий баланс: $%i", BizzInfo[bidx][bSafe]);
						SPD(playerid, D_BMENU+2, DIALOG_STYLE_INPUT, "[Biz Menu] > Счет бизнеса", dialog, "ENTER", "CANCLE");
					}
					else if(BizzInfo[bidx][bSafe] >= inputtext[0]) {
						BizzInfo[bidx][bSafe] -= inputtext[0];
						Rac::GivePlayerMoney(playerid, inputtext[0]);
						format(string, sizeof(string), "Вы сняли: $%i\nОсталось на счету: $%i", inputtext[0], BizzInfo[bidx][bSafe]);
						SPD(playerid, D_NONE, 0, "[Biz Menu] > Счет бизнеса", string, "OK", "");
					}
					else {
						format(dialog, sizeof dialog, "Сейчас на счету:\t$%i\nВведите сумму которую хотите снять.", BizzInfo[bidx][bSafe]);
						SPD(playerid, D_BMENU+2, DIALOG_STYLE_INPUT, "[Biz Menu] > Счет бизнеса", dialog, "ENTER", "CANCLE");
					}
				} else {
					format(dialog, sizeof dialog, "* Введите сумму(от $1 до $1kk) которую хотите снять!\n\nТекущий баланс: $%i", BizzInfo[bidx][bSafe]);
					SPD(playerid, D_BMENU+2, DIALOG_STYLE_INPUT, "[Biz Menu] > Счет бизнеса", dialog, "ENTER", "CANCLE");
				}
			} else {
				SPD(playerid, D_BMENU+1, DIALOG_STYLE_LIST, "[Biz Menu] > Счет бизнеса", ""#_GREY_ARROW"Снять деньги\n"#_GREY_ARROW"Положить деньги", "ENTER", "CANCLE");
			}
		}
		
		case D_BMENU+3: {
			if(response) {
				new bidx = GetIndexFromBizID(Pl::Info[playerid][pBizKey]);
				if(!IsPlayerBizOwner(playerid, bidx) && !IsPlayerBizExtortion(playerid, bidx)) return Send(playerid, COLOR_GREY, "* Вам не принадлежит бизнес!");
				if(sscanf(inputtext, "i", inputtext[0]) == 0) {
					if(inputtext[0] < 1) {
						format(dialog, sizeof dialog, "* Введите сумму(от $1 до $1kk) которую хотите положить!\n\nТекущий баланс: $%i\nНаличные: $%i", BizzInfo[bidx][bSafe], Rac::GetPlayerMoney(playerid));
						SPD(playerid, D_BMENU+3, DIALOG_STYLE_INPUT, "[Biz Menu] > Счет бизнеса", dialog, "ENTER", "CANCLE");
					}
					else if(Rac::GetPlayerMoney(playerid) >= inputtext[0]) {
						BizzInfo[bidx][bSafe] += inputtext[0];
						Rac::GivePlayerMoney(playerid, -inputtext[0]);
						format(string, sizeof(string), "Сумма: $%i\nТекущий баланс: $%i\nНаличные: $%i", inputtext[0], BizzInfo[bidx][bSafe], Rac::GetPlayerMoney(playerid));
						SPD(playerid, D_NONE, 0, "[Biz Menu] > Счет бизнеса", string, "OK", "");
					}
					else {
						format(dialog, sizeof dialog, "* Введите сумму(от $1 до $1kk) которую хотите положить!\n\nТекущий баланс: $%i\nНаличные: $%i", BizzInfo[bidx][bSafe], Rac::GetPlayerMoney(playerid));
						SPD(playerid, D_BMENU+3, DIALOG_STYLE_INPUT, "[Biz Menu] > Счет бизнеса", dialog, "ENTER", "CANCLE");
					}
				} else {
					format(dialog, sizeof dialog, "* Введите сумму(от $1 до $1kk) которую хотите положить!\n\nТекущий баланс: $%i\nНаличные: $%i", BizzInfo[bidx][bSafe], Rac::GetPlayerMoney(playerid));
					SPD(playerid, D_BMENU+3, DIALOG_STYLE_INPUT, "[Biz Menu] > Счет бизнеса", dialog, "ENTER", "CANCLE");
				}
			} else {
				SPD(playerid, D_BMENU+1, DIALOG_STYLE_LIST, "[Biz Menu] > Счет бизнеса", ""#_GREY_ARROW"Снять деньги\n"#_GREY_ARROW"Положить деньги", "ENTER", "CANCLE");
			}
		}
		
		case D_BMENU+4 : {
			if(response) {
				new bidx = GetIndexFromBizID(Pl::Info[playerid][pBizKey]);
				if(!IsPlayerBizOwner(playerid, bidx) && !IsPlayerBizExtortion(playerid, bidx)) return Send(playerid, COLOR_GREY, "* Вам не принадлежит бизнес!");
				if(!sscanf(inputtext, "i", inputtext[0])) {
					if(1 <= inputtext[0] <= 9999) {
						BizzInfo[bidx][bEnterCost] = inputtext[0];
						format(string, sizeof(string), "Текущая стоимость: $%i", BizzInfo[bidx][bEnterCost]);
						SPD(playerid, D_NONE, 0, "[Biz Menu] > Стоимость услуг", string, "OK", "");
					} else {
						format(string, sizeof(string), "* Введите стоимость(от $1 до $9999) услуг бизнеса.\n\nТекущая стоимость: $%i", BizzInfo[bidx][bEnterCost]);
						SPD(playerid, D_BMENU+4, DIALOG_STYLE_INPUT, "[Biz Menu] > Стоимость услуг", string, "ENTER", "CANCLE");
					}
				} else {
					format(string, sizeof(string), "* Введите стоимость(от $1 до $9999) услуг бизнеса.\n\nТекущая стоимость: $%i", BizzInfo[bidx][bEnterCost]);
					SPD(playerid, D_BMENU+4, DIALOG_STYLE_INPUT, "[Biz Menu] > Стоимость услуг", string, "ENTER", "CANCLE");
				}
			} else {
				ShowDialog(playerid, D_BMENU, DIALOG_STYLE_LIST, "[Biz Menu]", "dialog/bmenu.txt", "ENTER", "CANCLE");
			}
		}
		
		case D_BMENU+5 : {
			if(response) {
				new len = strlen(inputtext);
				new bidx = GetIndexFromBizID(Pl::Info[playerid][pBizKey]);
				if(!IsPlayerBizOwner(playerid, bidx) && !IsPlayerBizExtortion(playerid, bidx)) return Send(playerid, COLOR_GREY, "* Вам не принадлежит бизнес!");
				if(!len || len > 24 || inputtext[0] == ' ') {
					format(string, sizeof(string), "* Введите новое название бизнеса.\n\nТекущие название: %s", BizzInfo[bidx][bDescription]);
					SPD(playerid, D_BMENU+5, DIALOG_STYLE_INPUT, "[Biz Menu] > Название бизнеса", string, "ENTER", "CANCLE");
				} else {
					strmid(BizzInfo[bidx][bDescription], inputtext, 0, len, 24);
					format(string, sizeof(string), "* Название изменино!\n\nТекущие название: %s", BizzInfo[bidx][bDescription]);
					SPD(playerid, D_NONE, 0, "[Biz Menu] > Название бизнеса", string, "OK", "");
				}
			} else {
				ShowDialog(playerid, D_BMENU, DIALOG_STYLE_LIST, "[Biz Menu]", "dialog/bmenu.txt", "ENTER", "CANCLE");
			}
		}
		
		case D_BMENU+6: {
			if(response) {
				new bidx = GetIndexFromBizID(Pl::Info[playerid][pBizKey]);
				if(!IsPlayerBizOwner(playerid, bidx) && !IsPlayerBizExtortion(playerid, bidx)) return Send(playerid, COLOR_GREY, "* Вам не принадлежит бизнес!");
				if(sscanf(inputtext, "i", inputtext[0]) == 0) {
					if(1 <= inputtext[0] <= 999) {
						BizzInfo[bidx][bPriceProd] = inputtext[0];
						format(string, sizeof(string), "Новая цена за продукты:\t$%i", BizzInfo[bidx][bPriceProd]);
						SPD(playerid, D_NONE, 0, "[Biz Menu] > Цена за продукты", string, "OK", "");
					}
					else {
						format(string, sizeof(string), "* Введите сумму(от $1 до $999) по которой будут\n\
						закупатся продукты в бизнес.\n\nТекущая сумма: $%i", BizzInfo[bidx][bPriceProd]);
						SPD(playerid, D_BMENU+6, DIALOG_STYLE_INPUT, "[Biz Menu] > Цена за продукты", string, "ENTER", "CANCLE");
					}
				} else {
					format(string, sizeof(string), "* Введите сумму(от $1 до $999) по которой будут\n\
					закупатся продукты в бизнес.\n\nТекущая сумма: $%i", BizzInfo[bidx][bPriceProd]);
					SPD(playerid, D_BMENU+6, DIALOG_STYLE_INPUT, "[Biz Menu] > Цена за продукты", string, "ENTER", "CANCLE");
				}
			} else {
				ShowDialog(playerid, D_BMENU, DIALOG_STYLE_LIST, "[Biz Menu]", "dialog/bmenu.txt", "ENTER", "CANCLE");
			}
		}
		
		case D_BMENU+7 : {
			if(response) {
				new player, len = strlen(inputtext);
				new bidx = GetIndexFromBizID(Pl::Info[playerid][pBizKey]);
				if(!IsPlayerBizOwner(playerid, bidx)) return Send(playerid, COLOR_GREY, "* Вам не принадлежит бизнес!");
				if(sscanf(inputtext, "s[24]", string) == 0) {
					sscanf(string, "u", player);
					if(player == playerid) {
						Send(playerid, COLOR_GREY, "* Вы владелец бизнеса!");
						format(string, sizeof(string),"* Введите ID игрока чтобы назначить нового компаньона.\n\
						Чтобы убрать компаньона введите 255.\n\nТекущий компаньон: %s", BizzInfo[bidx][bExtortion]);
						SPD(playerid, D_BMENU+7, 1, "[Biz Menu] > Компаньон", string, "ENTER", "CANCLE");
					}
					else if(strval(string) == 255) {
						strmid(BizzInfo[bidx][bExtortion], "No-one", 0, strlen("No-one"), 24);
						format(string, sizeof(string),"* Введите ID игрока чтобы назначить нового компаньона.\n\
						Чтобы убрать компаньона введите 255.\n\nТекущий компаньон: %s", BizzInfo[bidx][bExtortion]);
						SPD(playerid, D_BMENU+7, 1, "[Biz Menu] > Компаньон", string, "ENTER", "CANCLE");
					}
					else if(!Pl::isLogged(player)) {
						Send(playerid, COLOR_GREY, "* Этот игрок не авторизован!");
						format(string, sizeof(string),"* Введите ID игрока чтобы назначить нового компаньона.\n\
						Чтобы убрать компаньона введите 255.\n\nТекущий компаньон: %s", BizzInfo[bidx][bExtortion]);
						SPD(playerid, D_BMENU+7, 1, "[Biz Menu] > Компаньон", string, "ENTER", "CANCLE");
					}
					else {
						Pl::Info[player][pBizKey] = BizzInfo[bidx][bID];
						strmid(BizzInfo[bidx][bExtortion], string, 0, len, 24);
						format(string, sizeof(string),"* Введите ID игрока чтобы назначить нового компаньона.\n\
						Чтобы убрать компаньона введите 255.\n\nТекущий компаньон: %s", BizzInfo[bidx][bExtortion]);
						SPD(playerid, D_BMENU+7, 1, "[Biz Menu] > Компаньон", string, "ENTER", "CANCLE");
					}
				} else {
					format(string, sizeof(string),"* Введите ID игрока чтобы назначить нового компаньона.\n\
					Чтобы убрать компаньона введите 255.\n\nТекущий компаньон: %s", BizzInfo[bidx][bExtortion]);
					SPD(playerid, D_BMENU+7, 1, "[Biz Menu] > Компаньон", string, "ENTER", "CANCLE");
				}
			} else {
				ShowDialog(playerid, D_BMENU, DIALOG_STYLE_LIST, "[Biz Menu]", "dialog/bmenu.txt", "ENTER", "CANCLE");
			}
		}
		
		case D_LMENU-1 : {
			if(response) {
				new fracid = Pl::FracID(playerid);
				if(strfind(inputtext, "Ранги", true) != -1) {
					ShowRankList(playerid, fracid);
					
				} else if(strfind(inputtext, "Транспорт", true) != -1) {
					ShowDialog(playerid, D_LMENU, 2, "L-Menu. Транспорт", "dialog/lmenu/main.txt", "SELECT", "CANCEL");
					
				} else if(strfind(inputtext, "Ранг захвата", false) != -1) {
					SPD(playerid, D_LMENU+8, 1, "L-Menu. Ранг захвата", "Введите ранг захвата:", "OK", "CANCEL");
					
				} else if(strfind(inputtext, "Черный список", true) != -1) {
					ShowLMenu(playerid, D_LMENU+9);
					
				} else if(strfind(inputtext, "Ранг новостей", true) != -1) {
					SPD(playerid, D_LMENU+14, 1, "L-Menu. Ранг новостей", "Введите ранг для написания в /gov:", "OK", "CANCEL");
					
				} else if(strfind(inputtext, "Управление автошколой", true) != -1) {
					SPD(playerid, D_LMENU+10, 2, "L-Menu. Управление автошколой", "Закрыть\nОткрыть", "SELECT", "CANCEL");						
				}
			}
		}
		
		case D_LMENU : {
			if(response) {
				switch(listitem) {
					case 0 : SPD(playerid, D_LMENU+1, 0, "L-Menu: Смена цвета", "Какой цвет хотите поминять?", "[-1-]", "[-2-]");

					case 1 : SPD(playerid, D_LMENU+4, 1, "L-Menu: Смена ранга", "Введите ранг с которого будет доступна машина.", "Enter", "Back");
					
					case 2 : SPD(playerid, D_LMENU+5, 1, "L-Menu: Смена номера", "Введите новый номер(макс. 8 символов)", "Enter", "Back");
					
					case 3 : SPD(playerid, D_LMENU+6, 0, "L-Menu: Смена места спавна", "Сменить место спавна этого авто?", "Enter", "Back");
					
					case 4 : {
						if(Fc::IsEditMode(playerid)) {
							new v_frac, carid = GetPlayerVehicleID(playerid);
							if(Fc::GetInfo(carid, "f", v_frac)) Fc::ShowModel(playerid, v_frac, D_LMENU+7);
						} else {
							Fc::ShowModel(playerid, Pl::FracID(playerid), D_LMENU+7);
						}
					}
				}
			} else {
				ShowLMenu(playerid);
			}
			return 1;
		}
		
		case D_LMENU+10 : {
			if(response) {
				foreach(new i : Portal) {
					if(Ptl::Info[i][Ptl::Id] == 11) {
						foreach(new j : Frac) {
							Ptl::Info[i][Ptl::Allowed][j] = listitem;
						}
						updatePickup(i);
						Send(playerid, -1, (listitem)?("* Автошкола открыта!"):("* Автошкола закрыта!"));
						return 1;
					}
				}
			}
			return 1;
		}
		
		case D_LMENU+8 : {
			if(response) {
				new fracid = Pl::FracID(playerid);
				if(sscanf(inputtext, "i", inputtext[0])) {
					SPD(playerid, D_LMENU+8, DIALOG_STYLE_INPUT, "L-Menu. Ранг захвата", "* Поле ввода пустое!\n\nВведите ранг захвата:", "OK", "CANCEL");
				} else if(!(1 <= inputtext[0] <= RankNums[fracid])) {
					SPD(playerid, D_LMENU+8, DIALOG_STYLE_INPUT, "L-Menu. Ранг захвата", "* Неверный ранг!\n\nВведите ранг захвата:", "OK", "CANCEL");
				} else {
					SetZRank(fracid, inputtext[0]);
					ShowLMenu(playerid);
				}
			} else {
				ShowLMenu(playerid);
			}
			
			return 1;
		}
		
		case D_LMENU+9 : {
			if(response) {
				switch(listitem) {
					case 0 : SPD(playerid, D_LMENU+11, DIALOG_STYLE_INPUT, "L-Menu. Черный список", "Введите ранг добавления в ЧС:", "OK", "CANCEL");
					case 1 : SPD(playerid, D_LMENU+12, DIALOG_STYLE_INPUT, "L-Menu. Черный список", "Введите сумму выхода из ЧС:", "OK", "CANCEL");
					case 2 : SPD(playerid, D_LMENU+13, DIALOG_STYLE_INPUT, "L-Menu. Черный список", "Введите кол-во убийств для выхода из ЧС:", "OK", "CANCEL");
				}
			} else {
				ShowLMenu(playerid);
			}
			return 1;
		}
		
		
		case D_LMENU+11 : {
			if(response) {
				new fracid = Pl::FracID(playerid);
				if(sscanf(inputtext, "i", inputtext[0])) {
					SPD(playerid, D_LMENU+11, DIALOG_STYLE_INPUT, "L-Menu. Черный список", "* Поле ввода пустое!\nВведите ранг добавления в ЧС:", "OK", "CANCEL");
				} else if(!(1 <= inputtext[0] <= RankNums[fracid])) {
					SPD(playerid, D_LMENU+11, DIALOG_STYLE_INPUT, "L-Menu. Черный список", "* Неверный ранг!\nВведите ранг добавления в ЧС:", "OK", "CANCEL");
				} else {
					SetBRank(fracid, inputtext[0]);
					ShowLMenu(playerid, D_LMENU+9);
				}
			} else {
				ShowLMenu(playerid, D_LMENU+9);
			}
		}
		
		case D_LMENU+12 : {
			if(response) {
				if(sscanf(inputtext, "i", inputtext[0])) {
					SPD(playerid, D_LMENU+12, DIALOG_STYLE_INPUT, "L-Menu. Черный список", "* Поле ввода пустое!\nВведите сумму выхода из ЧС:", "OK", "CANCEL");
				} else if(!(1 <= inputtext[0] <= 3000000)) {
					SPD(playerid, D_LMENU+12, DIALOG_STYLE_INPUT, "L-Menu. Черный список", "* Сумма должна быть от 1 до $3000000!\nВведите ранг добавления в ЧС:", "OK", "CANCEL");
				} else {
					FracInfo[Pl::FracID(playerid)][fBConf][bPRICE] = inputtext[0];
					ShowLMenu(playerid, D_LMENU+9);
				}
			} else {
				ShowLMenu(playerid, D_LMENU+9);
			}
		}
		
		case D_LMENU+13 : {
			if(response) {
				if(sscanf(inputtext, "i", inputtext[0])) {
					SPD(playerid, D_LMENU+13, DIALOG_STYLE_INPUT, "L-Menu. Черный список", "* Поле ввода пустое!\nВведите кол-во убийств для выхода из ЧС:", "OK", "CANCEL");
				} else if(!(1 <= inputtext[0] <= 25)) {
					SPD(playerid, D_LMENU+13, DIALOG_STYLE_INPUT, "L-Menu. Черный список", "* Кол-во убийств может быть от 1 до 25!\nВведите кол-во убийств для выхода из ЧС:", "OK", "CANCEL");
				} else {
					FracInfo[Pl::FracID(playerid)][fBConf][bKILLS] = inputtext[0];
					ShowLMenu(playerid, D_LMENU+9);
				}
			} else {
				ShowLMenu(playerid, D_LMENU+9);
			}
		}
		
		case D_LMENU+14 : {
			if(response) {
				new fracid = Pl::FracID(playerid);
				if(sscanf(inputtext, "i", inputtext[0])) {
					SPD(playerid, D_LMENU+14, DIALOG_STYLE_INPUT, "L-Menu. Ранг новостей", "* Поле ввода пустое!\nВведите ранг для написания в /gov:", "OK", "CANCEL");
				} else if(!(1 <= inputtext[0] <= RankNums[fracid])) {
					SPD(playerid, D_LMENU+14, DIALOG_STYLE_INPUT, "L-Menu. Ранг новостей", "* Неверный ранг!\nВведите ранг для написания в /gov:", "OK", "CANCEL");
				} else {
					SetGRank(fracid, inputtext[0]);
					ShowLMenu(playerid);
				}
			} else {
				ShowLMenu(playerid);
			}
		}

		case D_LMENU+1 : {
			if(response) {
				ShowDialog(playerid, D_LMENU+2, 1, "L-Menu: Смена цвета", "dialog/lmenu/colors.txt", "OK", "CANCEL");
			} else {
				ShowDialog(playerid, D_LMENU+3, 1, "L-Menu: Смена цвета", "dialog/lmenu/colors.txt", "OK", "CANCEL");
			}
			return 1;
		}
		
		case D_LMENU+2 : {
			if(response && Pl::Info[playerid][pLeader]) {
				if(sscanf(inputtext, "i", inputtext[0])) {
					Send(playerid, COLOR_GREY, "* Вы оставили поле ввода пустым!");
					ShowDialog(playerid, D_LMENU+2, 1, "L-Menu: Смена цвета", "dialog/lmenu/colors.txt", "OK", "CANCEL");
				} else if(inputtext[0] < 0 || inputtext[0] > 256) {
					Send(playerid, COLOR_GREY, "* Вы ввели не правельный ID цвета!");
					ShowDialog(playerid, D_LMENU+2, 1, "L-Menu: Смена цвета", "dialog/lmenu/colors.txt", "OK", "CANCEL");
				} else {
					new idx, v_frac, carid = GetPlayerVehicleID(playerid);
					if(!Pl::isAdmin(playerid, ADMINISTRATOR)) if(!IsInRespawn(Pl::FracID(playerid), carid))
						return Send(playerid, COLOR_GREY, "* Вы слишком далеко от респавна!");
					
					if(Fc::GetInfo( carid, "fi", v_frac, idx)) {
						if(v_frac == Pl::Info[playerid][pLeader] && !Fc::IsEditMode(playerid)) {
							new Float: posa, fracmoney = GetFracMoney(v_frac), cost = (ModelCost(GetVehicleModel(carid)) / 10);
							if(!Fc::IsEditMode(playerid) && cost > fracmoney) {
								format(string, sizeof(string), "* Недостаточно средств! Необходимо: $%i", cost);
								Send(playerid, COLOR_GREY, string);
							} else {
								if(!Fc::IsEditMode(playerid)) GiveFracMoney(v_frac, -cost);
								GetVehiclePos(carid, posx, posy, posz); GetVehicleZAngle(carid, posa);
								AutoInfo[0][aMileage] = AutoInfo[carid][aMileage];
								Fc::Info[idx][Fc::Color][0] = inputtext[0];
								Fc::RecreateVehicle( idx ); Fc::Update( idx );
								AutoInfo[carid][aMileage] = AutoInfo[0][aMileage];
								SetVehiclePos(Fc::Info[idx][Fc::Id][1], posx, posy, posz); SetVehicleZAngle(carid, posa);
								SetVehicleNumberPlate(Fc::Info[idx][Fc::Id][1], Fc::Info[idx][Fc::Number]);
								Rac::PutPlayerInVehicle(playerid, Fc::Info[idx][Fc::Id][1], 0);
								format(string, sizeof(string),"* Цвет машины был изминен на: %d", inputtext[0]);
								Send(playerid, COLOR_WHITE, string);
								format(string, sizeof(string), "~r~-$%i", cost);
								GameTextForPlayer(playerid, string, 5000, 1);
							}
						} else {
							format(string, sizeof(string),"* Вы не лидер %s", FracInfo[Fc::Info[idx][Fc::FracId]][fName]);
							Send(playerid, COLOR_GREY, string);
						}
					}
				}
			}
			
			return 1;
		}
		
		case D_LMENU+3 : {
			if(response) {
				if(sscanf(inputtext, "i", inputtext[0])) {
					Send(playerid, COLOR_GREY, "* Вы оставили поле ввода пустым!");
					ShowDialog(playerid, D_LMENU+3, 1, "L-Menu: Смена цвета", "dialog/lmenu/colors.txt", "OK", "CANCEL");
				} else if(inputtext[0] < 0 || inputtext[0] > 256) {
					Send(playerid, COLOR_GREY, "* Вы ввели не правельный ID цвета!");
					ShowDialog(playerid, D_LMENU+3, 1, "L-Menu: Смена цвета", "dialog/lmenu/colors.txt", "OK", "CANCEL");
				} else {
					new idx, v_frac, carid = GetPlayerVehicleID(playerid);
					if(!Pl::isAdmin(playerid, ADMINISTRATOR)) if(!IsInRespawn(Pl::FracID(playerid), carid))
						return Send(playerid, COLOR_GREY, "* Вы слишком далеко от респавна!");
						
					if(Fc::GetInfo( carid, "fi", v_frac, idx)) {
						if(v_frac == Pl::Info[playerid][pLeader] && !Fc::IsEditMode(playerid)) {
							new Float: posa, fracmoney = GetFracMoney(v_frac), cost = (ModelCost(GetVehicleModel(carid)) / 10);
							if(!Fc::IsEditMode(playerid)) if( cost > fracmoney) {
								format(string, sizeof(string), "* Недостаточно средств! Необходимо: $%i", cost);
								Send(playerid, COLOR_GREY, string);
							} else {
								if(!Fc::IsEditMode(playerid)) GiveFracMoney(v_frac, -cost);
								GetVehiclePos(carid, posx, posy, posz); GetVehicleZAngle(carid, posa);
								AutoInfo[0][aMileage] = AutoInfo[carid][aMileage];
								Fc::Info[idx][Fc::Color][1] = inputtext[0];
								Fc::RecreateVehicle( idx ); Fc::Update( idx );
								SetVehiclePos(Fc::Info[idx][Fc::Id][1], posx, posy, posz); SetVehicleZAngle(carid, posa);
								SetVehicleNumberPlate(Fc::Info[idx][Fc::Id][1], Fc::Info[idx][Fc::Number]);
								AutoInfo[carid][aMileage] = AutoInfo[0][aMileage];
								Rac::PutPlayerInVehicle(playerid, Fc::Info[idx][Fc::Id][1], 0);
								format(string, sizeof(string),"* Цвет машины был изминен на: %d", inputtext[0]);
								Send(playerid, COLOR_WHITE, string);
								format(string, sizeof(string), "~r~-$%i", cost);
								GameTextForPlayer(playerid, string, 5000, 1);
							}
						} else {
							format(string, sizeof(string),"* Вы не лидер %s", FracInfo[Fc::Info[idx][Fc::FracId]][fName]);
							Send(playerid, COLOR_GREY, string);
						}
					}
				}
			}
		}
		
		case D_LMENU+4 : {
			if(response) {
				if(sscanf(inputtext, "i", inputtext[0])) {
					SPD(playerid, D_LMENU+4, DIALOG_STYLE_INPUT, "L-Menu: Смена ранга", "Введите ранг с которого будет доступна машина.", "Enter", "Back");
				} else {
					new idx, v_frac, carid = GetPlayerVehicleID(playerid);
					if( Fc::GetInfo( carid, "fi", v_frac, idx ) ) {
						if(v_frac == Pl::Info[playerid][pLeader] && !Fc::IsEditMode(playerid)) {
							Fc::Info[idx][Fc::RankId] = inputtext[0];
							Fc::Update( idx );
							format(string, sizeof(string),"* Теперь машина доступна с %d-го ранга!", inputtext[0]);
							Send(playerid, COLOR_WHITE, string); 
						} else {
							format(string, sizeof(string),"* Вы не лидер %s", FracInfo[Fc::Info[idx][Fc::FracId]][fName]);
							Send(playerid, COLOR_GREY, string);
						}
					}
				}
			} else {
				ShowDialog(playerid, D_LMENU, 2, "L-Menu:  Что хотите изменить?", "dialog/lmenu/main.txt", "SELECT", "CANCEL");
			}
		}
		
		case D_LMENU+5 : {
			if(response) {
				new number[10];
				if(sscanf(inputtext, "s[10]", number)) return SPD(playerid, D_LMENU+5, 1, "L-Menu: Смена номера", "Введите новый номер(макс. 8 символов)", "Enter", "Back");
				if(strlen(number) < 1 || strlen(number) > 8) return SPD(playerid, D_LMENU+5, 1, "L-Menu: Смена номера", "Введите новый номер(макс. 8 символов)", "Enter", "Back");
				if(!regex_match_exid(number, ValidText)) return SPD(playerid, D_LMENU+5, 1, "L-Menu: Смена номера", "Введите новый номер(макс. 8 символов)", "Enter", "Back");
				
				new idx, v_frac, carid = GetPlayerVehicleID(playerid);
				if(!Pl::isAdmin(playerid, ADMINISTRATOR)) if(!IsInRespawn(Pl::FracID(playerid), carid))
					return Send(playerid, COLOR_GREY, "* Вы слишком далеко от респавна!");
				
				if(Fc::GetInfo( carid, "fi", v_frac, idx)) {
					if(v_frac == Pl::Info[playerid][pLeader] && !Fc::IsEditMode(playerid)) {
						new Float: posa, fracmoney = GetFracMoney(v_frac), cost = (ModelCost(GetVehicleModel(carid)) / 10);
						if(!Fc::IsEditMode(playerid)) if(cost > fracmoney) {
							format(string, sizeof(string), "* Недостаточно средств! Необходимо: $%i", cost);
							Send(playerid, COLOR_GREY, string);
						} else {
							if(!Fc::IsEditMode(playerid)) GiveFracMoney(v_frac, -cost);
							format(Fc::Info[idx][Fc::Number], 10, "%s", number);
							GetVehiclePos(carid, posx, posy, posz); GetVehicleZAngle(carid, posa);
							AutoInfo[0][aMileage] = AutoInfo[carid][aMileage];
							Fc::RecreateVehicle( idx ); Fc::Update( idx );
							SetVehiclePos(Fc::Info[idx][Fc::Id][1], posx, posy, posz); SetVehicleZAngle(Fc::Info[idx][Fc::Id][1], posa);
							SetVehicleNumberPlate(Fc::Info[idx][Fc::Id][1], Fc::Info[idx][Fc::Number]);
							AutoInfo[Fc::Info[idx][Fc::Id][1]][aMileage] = AutoInfo[0][aMileage];
							Rac::PutPlayerInVehicle(playerid, Fc::Info[idx][Fc::Id][1], 0);
							Send(playerid, COLOR_WHITE, "* Номер был изменен!");
							format(string, sizeof(string), "~r~-$%i", cost);
							GameTextForPlayer(playerid, string, 5000, 1);
						}
					} else {
						format(string, sizeof(string),"* Вы не лидер %s", FracInfo[Fc::Info[idx][Fc::FracId]][fName]);
						Send(playerid, COLOR_GREY, string);
					}
				}
			} else {
				ShowDialog(playerid, D_LMENU, 2, "L-Menu:  Что хотите изменить?", "dialog/lmenu/main.txt", "SELECT", "CANCEL");
			}
		}
		
		case D_LMENU+6 : {
			if(response) {
				new idx, v_frac, carid = GetPlayerVehicleID(playerid);
				if(!Pl::isAdmin(playerid, ADMINISTRATOR)) if(!IsInRespawn(Pl::FracID(playerid), carid))
					return Send(playerid, COLOR_GREY, "* Вы слишком далеко от респавна!");
				
				if(Fc::GetInfo(carid, "fi", v_frac, idx)) {
					if(v_frac == Pl::Info[playerid][pLeader] && !Fc::IsEditMode(playerid)) {
						AutoInfo[0][aMileage] = AutoInfo[carid][aMileage];
						GetVehiclePos(carid, Fc::Info[idx][Fc::RespPos][0], Fc::Info[idx][Fc::RespPos][1], Fc::Info[idx][Fc::RespPos][2]);
						GetVehicleZAngle(carid, Fc::Info[idx][Fc::RespPos][3]);	
						Fc::RecreateVehicle( idx ); Fc::Update( idx );
						SetVehicleNumberPlate(Fc::Info[idx][Fc::Id][1], Fc::Info[idx][Fc::Number]);
						AutoInfo[Fc::Info[idx][Fc::Id][1]][aMileage] = AutoInfo[0][aMileage];
						Rac::PutPlayerInVehicle(playerid, Fc::Info[idx][Fc::Id][1], 0);
						Send(playerid, COLOR_WHITE, "* Машина была припаркована!");
					} else {
						format(string, sizeof(string),"* Вы не лидер %s", FracInfo[Fc::Info[idx][Fc::FracId]][fName]);
						Send(playerid, COLOR_GREY, string);
					}
				}
			} else {
				ShowDialog(playerid, D_LMENU, 2, "L-Menu:  Что хотите изменить?", "dialog/lmenu/main.txt", "SELECT", "CANCEL");
			}
		}
		
		case D_LMENU+7 : {
			if(response) {
				new model_id, model_limit;
				sscanf(inputtext, "P<[]>k<name_to_id>i", model_id, model_limit);
				if(!(400 <= model_id <= 611)) return Send(playerid, COLOR_GREY, "* Unknown model id!");
				if(Fc::GetModelCount(Pl::FracID(playerid), model_id) >= model_limit) {
					format(string, sizeof string, "* Достигнут лимит на установку %s!", VehicleNames[model_id-400]);
					return Send(playerid, COLOR_GREY, string);
				}
				new idx, v_frac, carid = GetPlayerVehicleID(playerid);
				if(!Pl::isAdmin(playerid, 5)) if(!IsInRespawn(Pl::FracID(playerid), carid))
					return Send(playerid, COLOR_GREY, "* Вы слишком далеко от респавна!");
				
				if(Fc::GetInfo(carid, "fi", v_frac, idx)) {
					if(v_frac == Pl::Info[playerid][pLeader] && !Fc::IsEditMode(playerid)) {
						new Float: posa, fracmoney = GetFracMoney(v_frac), cost = ModelCost( model_id );
						if(!Fc::IsEditMode(playerid)) if(cost > fracmoney) {
							format(string, sizeof(string), "* Недостаточно средств! Необходимо: $%i", cost);
							Send(playerid, COLOR_GREY, string);
						} else {
							if(!Fc::IsEditMode(playerid)) GiveFracMoney(v_frac, -cost);
							GetVehiclePos(carid, posx, posy, posz); GetVehicleZAngle(carid, posa);
							Fc::Info[idx][Fc::Model] = model_id;
							Fc::RecreateVehicle( idx ); Fc::Update( idx );
							AutoInfo[Fc::Info[idx][Fc::Id][1]][aMileage] = 0.0000;
							SetVehiclePos(Fc::Info[idx][Fc::Id][1], posx, posy, posz); SetVehicleZAngle(carid, posa);
							SetVehicleNumberPlate(Fc::Info[idx][Fc::Id][1], Fc::Info[idx][Fc::Number]);
							Rac::PutPlayerInVehicle(playerid, Fc::Info[idx][Fc::Id][1], 0);
							Send(playerid, COLOR_WHITE, "* Вы изменили марку машины!");
							format(string, sizeof(string), "~r~-$%i", cost);
							GameTextForPlayer(playerid, string, 5000, 1);
						}
					} else {
						format(string, sizeof(string),"* Вы не лидер %s", FracInfo[Fc::Info[idx][Fc::FracId]][fName]);
						Send(playerid, COLOR_GREY, string);
					}
				}
			} else {
				ShowDialog(playerid, D_LMENU, 2, "L-Menu:  Что хотите изменить?", "dialog/lmenu/main.txt", "SELECT", "CANCEL");
			}
		}
		
		case D_ADD_FC : {
			if(response) {
				new frac_id, model_id, model_limit;
				sscanf(inputtext, "P<[]>k<name_to_id>i", model_id, model_limit);
				if(!(400 <= model_id <= 611)) return Send(playerid, COLOR_GREY, "* Unknown model id!");
				frac_id = GetPVarInt( playerid, "SelectFrac");
				new Float: r_pos[4]; GetPlayerPos( playerid, r_pos[0], r_pos[1], r_pos[2]); GetPlayerFacingAngle(playerid, r_pos[3]);
				format(query, sizeof query, "INSERT INTO `"#__TableFracVehicles__"` (`model`,`frac`,`resp_pos`) VALUES \
				('%i','%i','%.3f,%.3f,%.3f,%.3f')", model_id, frac_id, r_pos[0], r_pos[1], r_pos[2], r_pos[3]);
				
				new Cache:result = Db::query(connDb, query, true);
				if(cache_affected_rows()) {
					new id = Fc::TOTAL; Fc::TOTAL++;
					
					Fc::Info[id][Fc::Id][0] 		= cache_insert_id();
					Fc::Info[id][Fc::Model] 		= model_id;
					Fc::Info[id][Fc::FracId]		= frac_id;
					Fc::Info[id][Fc::Color][0] 	= random( 100 );
					Fc::Info[id][Fc::Color][1] 	= random( 100 );
					Fc::Info[id][Fc::RespPos][0]	= r_pos[0];
					Fc::Info[id][Fc::RespPos][1]	= r_pos[1];
					Fc::Info[id][Fc::RespPos][2]	= r_pos[2];
					Fc::Info[id][Fc::RespPos][3]	= r_pos[3];
					
					strmid(Fc::Info[id][Fc::Number], Fc::DEF_NUMBER, 0, strlen(Fc::DEF_NUMBER), 255);
					
					Fc::Info[id][Fc::Id][1] =
					Veh::Create(
						Fc::Info[id][Fc::Model],
						Fc::Info[id][Fc::RespPos][0],
						Fc::Info[id][Fc::RespPos][1],
						Fc::Info[id][Fc::RespPos][2],
						Fc::Info[id][Fc::RespPos][3],
						Fc::Info[id][Fc::Color][0],
						Fc::Info[id][Fc::Color][1],
						1200
					);
					
					SetVehicleNumberPlate(Fc::Info[id][Fc::Id][1], Fc::Info[id][Fc::Number]);
					Rac::PutPlayerInVehicle(playerid, Fc::Info[id][Fc::Id][1], 0); Fc::Update( id );
					Iter::Add(TeamVehicles[frac_id], Fc::Info[id][Fc::Id][1]);
					Send( playerid, COLOR_YELLOW, "* Машина добавлена!");
				}
				cache_delete(result);
			}
		}
		
		case D_SHOW_MODEL : {
			if(response) {
				if(!strcmp(inputtext, "Добавить", true)) {
					ShowDialog( playerid, D_ADD_MODEL, 1, "Добавить", "dialog/lmenu/addmodel.txt", "Ok", "Cancel");
				}
				else if(strcmp(inputtext, "------------", true)) {
					new model_id, model_limit;
					sscanf(inputtext, "P<[]>k<name_to_id>i", model_id, model_limit);
					if(!(400 <= model_id <= 611)) return Send(playerid, COLOR_GREY, "* Unknown model id!");
					
					SetPVarInt( playerid, "SelectModel", model_id);
					SPD(playerid, D_EDIT_MODEL, 2, "Options", "Изменить модель\nИменить лимит\nУдалить", "Ok", "Cancel");
				}
			}
		}
		
		case D_EDIT_MODEL : {
			new frac_id = GetPVarInt(playerid, "SelectFrac");
			if(response) {
				switch(listitem) {
					case 0 : {
						SPD(playerid, D_EDIT_MODEL+1, 1, "Изменить модель", "Введите новый ID или название модели.\nПример: 400 или Landstalker", "ENTER", "CANCEL");
					}
					
					case 1 : {
						SPD(playerid, D_EDIT_MODEL+2, 1, "Изменить лимит", "Введите лимит(от 1 до 10)", "ENTER", "CANCEL");
					}
					
					case 2 : {
						format(query, sizeof query, "DELETE FROM `"#__TableFracModels__"` WHERE `frac_id` = '%i' AND `model_id` = '%i'", frac_id, GetPVarInt(playerid, "SelectModel"));
						Db::tquery(connDb, query);
						Send(playerid, COLOR_WHITE, "* Эта модель была удалена из списка доступных!");
					}
				}
			} else {
				Fc::ShowModel(playerid, frac_id, D_SHOW_MODEL);
			}
		}
		
		case D_EDIT_MODEL+1 : {
			if(response) {
				new newmodel;
				sscanf(inputtext, "P<[]>k<name_to_id>", newmodel);
				if(!(400 <= newmodel <= 611)) {
					SPD(playerid, D_EDIT_MODEL+1, 1, "Изменить модель", "Введите новый ID или название модели.\nПример: 400 или Landstalker", "Ok", "Cancel");
				} else {
					format(query, sizeof query, "UPDATE `"#__TableFracModels__"` SET `model_id` = '%i' WHERE \
					`frac_id` = '%i' AND `model_id` = '%i'", newmodel, GetPVarInt(playerid, "SelectFrac"), GetPVarInt(playerid, "SelectModel"));
					Db::tquery(connDb, query);
					Send(playerid, COLOR_WHITE, " Модель была изменена!");
				}
			}
		}
		
		case D_EDIT_MODEL+2 : {
			if(response) {
				if(sscanf(inputtext, "i", inputtext[0])) {
					SPD(playerid, D_EDIT_MODEL+2, 1, "Изменить лимит", "Введите лимит(от 1 до 10)", "ENTER", "CANCEL");
				} else if(!(1 <= inputtext[0] <= 10)) {
					SPD(playerid, D_EDIT_MODEL+2, 1, "Изменить лимит", "Введите лимит(от 1 до 10)", "ENTER", "CANCEL");
				} else {
					format(query, sizeof query, "UPDATE `"#__TableFracModels__"` SET `model_limit` = '%i' WHERE \
					`frac_id` = '%i' AND `model_id` = '%i'", inputtext[0], GetPVarInt(playerid, "SelectFrac"), GetPVarInt(playerid, "SelectModel"));
					Db::tquery(connDb, query);
					Send(playerid, COLOR_WHITE, " Лимит был изменен!");
				}
			}
		}
		
		case D_ADD_MODEL : {
			if(response) {
				new model_id;
				sscanf(inputtext, "P<[]>k<name_to_id>", model_id);
				if(!(400 <= model_id <= 611)){
					ShowDialog(playerid, D_ADD_MODEL, 1, "Добавить", "dialog/lmenu/addmodel.txt", "Ok", "Cancel");
				} else {
					new frac_id = GetPVarInt(playerid, "SelectFrac");
					if(model_id < 400 || model_id > 611) return Send(playerid, COLOR_GREY, "* Unknown model id!");
					if(Fc::IsThereModel(frac_id, model_id)) return Send(playerid, COLOR_RED, "* Эта модель уже есть в списке!");
					format(query, sizeof query, "INSERT INTO `"#__TableFracModels__"` (`frac_id`, `model_id`) VALUES ('%i','%i')", frac_id, model_id);
					Db::tquery(connDb, query);
					format(string, sizeof(string), " Модель добавлена! Model_id: %i; Model_name: %s", model_id, VehicleNames[model_id-400]);
					Send(playerid, COLOR_WHITE, string);
				}
			}
		}

		case TP_EDIT : {
			if(response) {
				switch(listitem) {
					case 0 : SPD(playerid, TP_EDIT+1, 2, "Первый пикап", "Модель\nТип\nВирт. мир\nПозиция", "SELECT", "CANCEL");
					case 1 : SPD(playerid, TP_EDIT+2, 2, "Второй пикап", "Модель\nТип\nВирт. мир\nПозиция", "SELECT", "CANCEL");
					case 2 : {
						dialog[0] = '\0';
						new portal = GetPVarInt(playerid, "selectTeleport");
						foreach(new i : Frac) {
							if(Ptl::Info[portal][Ptl::Allowed][i]) {
								scf(dialog,string,"[{33AA33} - {ffffff}]{%h}%s\t\t{ffffff}\n", (GetFracColor(i)>>>8), FracInfo[i][fName]);
							} else {
								scf(dialog,string,"[{AA3333} X {ffffff}]{%h}%s\t\t{ffffff}\n", (GetFracColor(i)>>>8), FracInfo[i][fName]);
							}
						}
						SPD(playerid, TP_EDIT+9, 2, "Доступность для фракций", dialog, "SELECT", "CANCEL");
					}
					
					case 3 : {
						new i = GetPVarInt(playerid, "selectTeleport");
						new last = Iter::Last(Portal);
						DestroyDynamicPickup(Ptl::Info[i][Ptl::Pickup][0]);
						DestroyDynamicPickup(Ptl::Info[i][Ptl::Pickup][1]);
						format(query, sizeof query, "DELETE FROM `"#__TablePickups__"` WHERE `id`='%i'", Ptl::Info[i][Ptl::Id]);
						Db::tquery(connDb, query, "", "");
						if(last > i) {
							Iter::Remove(Portal, last);
							CopyArray(Ptl::Info[i][Ptl::Model], Ptl::Info[last][Ptl::Model], 2);
							CopyArray(Ptl::Info[i][Ptl::Type], Ptl::Info[last][Ptl::Type], 2);
							CopyArray(Ptl::Info[i][Ptl::Inter], Ptl::Info[last][Ptl::Inter], 2);
							CopyArray(Ptl::Info[i][Ptl::World], Ptl::Info[last][Ptl::World], 2);
							CopyArray(Ptl::Info[i][Ptl::Pickup], Ptl::Info[last][Ptl::Pickup], 2);
							CopyArray(Ptl::Info[i][Ptl::Portal1], Ptl::Info[last][Ptl::Portal1], 4);
							CopyArray(Ptl::Info[i][Ptl::Portal2], Ptl::Info[last][Ptl::Portal2], 4);
						} else {
							Iter::Remove(Portal, i);
						}
					}
				}
			} else {
				SetPVarInt(playerid, "selectTeleport", INVALID_ID);
			}
		}
		
		case TP_EDIT+1 : {
			if(response) {
				switch(listitem) {
					case 0 : SPD(playerid, TP_EDIT+3, 1, "Модель пикапа", "Введите id объекта.", "ENTER", "CANCEL");
					case 1 : SPD(playerid, TP_EDIT+5, 1, "Тип пикапа", "Введите тип пикапа.", "ENTER", "CANCEL");
					case 2 : SPD(playerid, TP_EDIT+7, 1, "Мир пикапа", "Введите мир пикапа.", "ENTER", "CANCEL");
					case 3 : Send(playerid, -1, "Встанте на то место где должен быть пикап и введите /setpic1");
				}
			} else {
				format(string, sizeof string, "Telepot №%i", Ptl::Info[GetPVarInt(playerid, "selectTeleport")][Ptl::Id]);
				SPD(playerid,TP_EDIT,2,string,"Перый пикап\nВторой пикап\nОткрыть/Закрыть\nУдалить","Выбор","Выход");
			}
		}
		
		case TP_EDIT+2 : {
			if(response) {
				switch(listitem) {
					case 0 : SPD(playerid, TP_EDIT+4, 1, "Модель пикапа", "Введите id объекта.", "ENTER", "CANCEL");
					case 1 : SPD(playerid, TP_EDIT+6, 1, "Тип пикапа", "Введите тип пикапа.", "ENTER", "CANCEL");
					case 2 : SPD(playerid, TP_EDIT+8, 1, "Мир пикапа", "Введите мир пикапа.", "ENTER", "CANCEL");
					case 3 : Send(playerid, -1, "Встанте на то место где должен быть пикап и введите /setpic2");
				}
			} else {
				format(string, sizeof string, "Telepot №%i", Ptl::Info[GetPVarInt(playerid, "selectTeleport")][Ptl::Id]);
				SPD(playerid,TP_EDIT,2,string,"Перый пикап\nВторой пикап\nОткрыть/Закрыть\nУдалить","Выбор","Выход");
			}
		}
		
		case TP_EDIT+3 : {
			if(response) {
				if(sscanf(inputtext, "i", inputtext[0])) {
					SPD(playerid, TP_EDIT+3, 1, "Модель пикапа", "Введите id объекта.", "ENTER", "CANCEL");
				} else {
					new teleport = GetPVarInt(playerid, "selectTeleport");
					Ptl::Info[teleport][Ptl::Model][0] = inputtext[0];
					Streamer::SetIntData(1, Ptl::Info[teleport][Ptl::Pickup][0], E_STREAMER_MODEL_ID, inputtext[0]);
					updatePickup(teleport);
					SetPVarInt(playerid, "selectTeleport", INVALID_ID);
					Streamer::Update(playerid);
				}
			} else {
				SPD(playerid, TP_EDIT+1, 2, "Первый пикап", "Модель\nПозиция", "SELECT", "CANCEL");
			}
		}
		
		case TP_EDIT+4 : {
			if(response) {
				if(sscanf(inputtext, "i", inputtext[0])) {
					SPD(playerid, TP_EDIT+3, 1, "Модель пикапа", "Введите id объекта.", "ENTER", "CANCEL");
				} else {
					new teleport = GetPVarInt(playerid, "selectTeleport");
					Ptl::Info[teleport][Ptl::Model][1] = inputtext[0];
					Streamer::SetIntData(1, Ptl::Info[teleport][Ptl::Pickup][1], E_STREAMER_MODEL_ID, inputtext[0]);
					updatePickup(teleport);
					SetPVarInt(playerid, "selectTeleport", INVALID_ID);
					Streamer::Update(playerid);
				}
			} else {
				SPD(playerid, TP_EDIT+1, 2, "Второй пикап", "Модель\nПозиция", "SELECT", "CANCEL");
			}
		}
		
		case TP_EDIT+5 : {
			if(response) {
				if(sscanf(inputtext, "i", inputtext[0])) {
					SPD(playerid, TP_EDIT+5, 1, "Тип пикапа", "Введите тип пикапа.", "ENTER", "CANCEL");
				} else if(inputtext[0] < 1 || inputtext[0] > 23) {
					SPD(playerid, TP_EDIT+5, 1, "Тип пикапа", "Введите тип пикапа.", "ENTER", "CANCEL");
				} else {
					new teleport = GetPVarInt(playerid, "selectTeleport");
					Ptl::Info[teleport][Ptl::Type][0] = inputtext[0];
					Streamer::SetIntData(1, Ptl::Info[teleport][Ptl::Pickup][0], E_STREAMER_TYPE, inputtext[0]);
					updatePickup(teleport);
					SetPVarInt(playerid, "selectTeleport", INVALID_ID);
					Streamer::Update(playerid);
				}
			} else {
				SPD(playerid, TP_EDIT+1, 2, "Второй пикап", "Модель\nТип\nПозиция", "SELECT", "CANCEL");
			}
		}
		
		case TP_EDIT+6 : {
			if(response) {
				if(sscanf(inputtext, "i", inputtext[0])) {
					SPD(playerid, TP_EDIT+6, 1, "Тип пикапа", "Введите тип пикапа.", "ENTER", "CANCEL");
				} else if(inputtext[0] < 1 || inputtext[0] > 23) {
					SPD(playerid, TP_EDIT+6, 1, "Тип пикапа", "Введите тип пикапа.", "ENTER", "CANCEL");
				} else {
					new teleport = GetPVarInt(playerid, "selectTeleport");
					Ptl::Info[teleport][Ptl::Type][1] = inputtext[0];
					Streamer::SetIntData(1, Ptl::Info[teleport][Ptl::Pickup][1], E_STREAMER_TYPE, inputtext[0]);
					updatePickup(teleport);
					SetPVarInt(playerid, "selectTeleport", INVALID_ID);
					Streamer::Update(playerid);
				}
			} else {
				SPD(playerid, TP_EDIT+2, 2, "Второй пикап", "Модель\nТип\nПозиция", "SELECT", "CANCEL");
			}
		}
		
		case TP_EDIT+7 : {
			if(response) {
				if(sscanf(inputtext, "i", inputtext[0])) {
					SPD(playerid, TP_EDIT+7, 1, "Мир пикапа", "Введите мир пикапа.", "ENTER", "CANCEL");
				} else if(inputtext[0] < 0) {
					SPD(playerid, TP_EDIT+7, 1, "Мир пикапа", "Введите мир пикапа.", "ENTER", "CANCEL");
				} else {
					new teleport = GetPVarInt(playerid, "selectTeleport");
					Ptl::Info[teleport][Ptl::World][0] = inputtext[0];
					DestroyDynamicPickup(Ptl::Info[teleport][Ptl::Pickup][0]);
					Ptl::Info[teleport][Ptl::Pickup][0]=_AddPickup(Ptl::Info[teleport][Ptl::Model][0],Ptl::Info[teleport][Ptl::Type][0],Ptl::Info[teleport][Ptl::Portal1],Ptl::Info[teleport][Ptl::World][0]);
					updatePickup(teleport);
					Rac::SetPlayerVirtualWorld(playerid,inputtext[0]);
					SetPVarInt(playerid, "selectTeleport", INVALID_ID);
				}
			} else {
				SPD(playerid, TP_EDIT+1, 2, "Второй пикап", "Модель\nТип\nВирт. мир\nПозиция", "SELECT", "CANCEL");
			}
		}
		
		case TP_EDIT+8 : {
			if(response) {
				if(sscanf(inputtext, "i", inputtext[0])) {
					SPD(playerid, TP_EDIT+8, 1, "Мир пикапа", "Введите мир пикапа.", "ENTER", "CANCEL");
				} else if(inputtext[0] < 0) {
					SPD(playerid, TP_EDIT+8, 1, "Мир пикапа", "Введите мир пикапа.", "ENTER", "CANCEL");
				} else {
					new teleport = GetPVarInt(playerid, "selectTeleport");
					Ptl::Info[teleport][Ptl::World][1] = inputtext[0];
					DestroyDynamicPickup(Ptl::Info[teleport][Ptl::Pickup][1]);
					Ptl::Info[teleport][Ptl::Pickup][1]=_AddPickup(Ptl::Info[teleport][Ptl::Model][1],Ptl::Info[teleport][Ptl::Type][1],Ptl::Info[teleport][Ptl::Portal2],Ptl::Info[teleport][Ptl::World][1]);
					updatePickup(teleport);
					Rac::SetPlayerVirtualWorld(playerid,inputtext[0]);
					SetPVarInt(playerid, "selectTeleport", INVALID_ID);
				}
			} else { 
				SPD(playerid, TP_EDIT+2, 2, "Второй пикап", "Модель\nТип\nВирт. мир\nПозиция", "SELECT", "CANCEL");
			}
		}
		
		case TP_EDIT+9 : {
			if(response) {
				dialog[0] = '\0';
				new portal = GetPVarInt(playerid, "selectTeleport");
				Ptl::Info[portal][Ptl::Allowed][listitem + 1] = !Ptl::Info[portal][Ptl::Allowed][listitem + 1];
				foreach(new i : Frac) {
					if(Ptl::Info[portal][Ptl::Allowed][i]) {
						scf(dialog,string,"[{33AA33} - {ffffff}]{%h}%s\t\t{ffffff}\n", (GetFracColor(i)>>>8), FracInfo[i][fName]);
					} else {
						scf(dialog,string,"[{AA3333} X {ffffff}]{%h}%s\t\t{ffffff}\n", (GetFracColor(i)>>>8), FracInfo[i][fName]);
					}
				}
				SPD(playerid, TP_EDIT+9, 2, "Доступность для фракций", dialog, "SELECT", "CANCEL");
				updatePickup(portal);
			} else {
				format(string, sizeof string, "Telepot №%i", Ptl::Info[GetPVarInt(playerid, "selectTeleport")][Ptl::Id]);
				SPD(playerid,TP_EDIT,2,string,"Перый пикап\nВторой пикап\nОткрыть/Закрыть\nУдалить","Выбор","Выход");
			}
		}
		
		case D_CHANGE_PASS : {
			if(response) {
				new hash[SHA2_HASH_LEN];
				SHA256_PassHash(inputtext, Db::Conf[Db::KeySult], hash, SHA2_HASH_LEN);
				format(query, sizeof query, "SELECT * FROM `"#__TableUsers__"` WHERE `ID` = '%i' AND `Key` = '%s'", Pl::Info[playerid][pID], hash);
				new Cache:result = Db::query(connDb, query, true);
				if(cache_get_row_count()) {
					SPD(playerid, D_CHANGE_PASS+1,DIALOG_STYLE_PASSWORD,""#__SERVER_PREFIX""#__SERVER_NAME_LC": ATTENTION PLEASE",
					"ВНИМАНИЕ! Вы хотите изменить пароль своего аккаунта!\n\
					Введите новый пароль и нажмите ОК!\n\n\
					Не рекомендуется использовать простые пароли. Чтобы\n\
					пароль был надежным, он должен содержать цифры,\n\
					заглавные и малые буквы латинского алфавита.","ОК","ОТМЕНА");
				} else {
					Rac::Kick(playerid, "Попытка взлома аккаунта");
				}
				cache_delete(result);
			}
		}
		
		case D_CHANGE_PASS+1 : {
			if(response) {
				if(!strlen(inputtext)) Send(playerid,COLOR_LIGHTRED,""#__SERVER_PREFIX""#__SERVER_NAME_LC": Вы не ввели пароль!");
				else {
					new hash[SHA2_HASH_LEN];
					SHA256_PassHash(inputtext, Db::Conf[Db::KeySult], hash, SHA2_HASH_LEN);
					format(query, sizeof query, "UPDATE `"#__TableUsers__"` SET `Key`='%s' WHERE `ID`='%i'", hash, Pl::Info[playerid][pID]);
					Db::tquery(connDb, query, "", "");
					format(string, sizeof(string), ""#__SERVER_PREFIX""#__SERVER_NAME_LC": ВНИМАНИЕ! ПАРОЛЬ ИЗМЕНЕН! Ваш новый пароль: %s", inputtext);
					Send(playerid, COLOR_LIGHTRED, string);
					Send(playerid, COLOR_LIGHTRED,""#__SERVER_PREFIX""#__SERVER_NAME_LC": ОБЯЗАТЕЛЬНО сделайте скриншот с новым паролем, для этого нажмите F8");
				}
			}
		}
		
		case D_PDDTEST : {
			if(response) {
				new i = GetPVarInt(playerid, "SelectedItem");
				if(!sscanf(inputtext, "c", inputtext[0])) {
					new letter = tolower(inputtext[0]);
					if('a' <= letter <= 'd') {
						if(correctAnswer[i] == letter) {
							format(string, sizeof string, "Вопрос №%i. Ответ верный.", i);
							Send(playerid, COLOR_GREEN, string);
						} else {
							Pl::Info[playerid][pTest] ++;
							format(string, sizeof string, "Вопрос №%i. Ответ не верный.", i);
							Send(playerid, COLOR_LIGHTRED, string);
						}
						if(++i >= sizeof correctAnswer) {
							if(Pl::Info[playerid][pTest] >= 3) {
								SendClientMessage(playerid, COLOR_WHITE, "Тест нe пройден. Допущено более 2-х ошибок.");
								Pl::Info[playerid][pTest] = 0; 
							} else {
								Pl::Info[playerid][pTest] = 999;
								SendClientMessage(playerid, COLOR_GREEN, "* Поздравляю вы сдали теорию. Прошу встаньте в очередь к практике");
								AshQueue(playerid, 0);
							}
							SetPVarInt(playerid, "SelectedItem", -1);
							return SetTimerEx(""#Rac::"TogglePlayerControllable", 50, false, "ii", playerid, 1);
						} else {
							SetPVarInt(playerid, "SelectedItem", i);
							format(string, sizeof string, "dialog/pddtest/pdd_test_%i.txt", i);
							return ShowDialog(playerid, D_PDDTEST, 1, ""#__SERVER_PREFIX""#__SERVER_NAME_LC": TEST PDD", string, "Ответ", "Отмена");
						}
					}
				}
				format(string, sizeof string, "dialog/pddtest/pdd_test_%i.txt", i);
				ShowDialog(playerid, D_PDDTEST, 1, ""#__SERVER_PREFIX""#__SERVER_NAME_LC": PDD TEST", string, "Ответить","Отмена");
			} else {
				Pl::Info[playerid][pTest] = 0;
				SetPVarInt(playerid, "SelectedItem", -1);
				Send(playerid, COLOR_GREY, "* Вы не сдали тест");
				return SetTimerEx(""#Rac::"TogglePlayerControllable", 50, false, "ii", playerid, 1);
			}
			return 1;
		}
		
		case D_EN_HOUSE : {
			if(response) {
				new bidx = GetPVarInt(playerid, "PlayerHouse");
				if(Pl::Info[playerid][pHouseKey] == bidx || HouseInfo[bidx][hLock] == 0) {
					EnterHouse(playerid, bidx);
					GameTextForPlayer(playerid, "~w~Welcome Home", 5000, 1);
				} else {
					GameTextForPlayer(playerid, "~r~Locked", 5000, 1);
				}
			}
		}
		
		case D_EX_HOUSE : {
			if(response) {
				ExitHouse(playerid, GetPVarInt(playerid, "PlayerHouse"));
			}
			return 1;
		}
		
		case D_EN_BIZ : {
			if(response) {
				new bizz = GetPVarInt(playerid, "PlayerBizz");
				if(Pl::Info[playerid][pBizKey] == BizzInfo[bizz][bID] || Rac::GetPlayerMoney(playerid) >= BizzInfo[bizz][bEnterCost]) {
					if(BizzInfo[bizz][bLocked] == 1) return GameTextForPlayer(playerid, "~r~Closed", 5000, 1);
					if(BizzInfo[bizz][bProds] <= 0) return GameTextForPlayer(playerid, "~r~Out Of Stock", 5000, 1);
					switch(BizzInfo[bizz][bID]) {						
						case Bizz_AutoSolonClassA, Bizz_AutoSolonClassB, Bizz_AutoSolonClassC, Bizz_AutoSolonClassD: {
							if(TotalExtraVehicles[playerid] >= ExtraVehicleLimit[Pl::Info[playerid][pVip]]) return Send(playerid, COLOR_GREY, "* Вы купили макс. кол-во личного транспорта!");
							new vclass;
							switch(BizzInfo[bizz][bID]) {
								case Bizz_AutoSolonClassA : vclass = 0;
								case Bizz_AutoSolonClassB : vclass = 1;
								case Bizz_AutoSolonClassC : vclass = 2;
								case Bizz_AutoSolonClassD : vclass = 3;
							}
							TempVehicle[playerid] = Veh::Create(AutoSolon[vclass][0][0], StandPos[vclass][vPos][0], StandPos[vclass][vPos][1], StandPos[vclass][vPos][2], StandPos[vclass][vPos][3], -1, -1, 600);
							Rac::SetPlayerPos(playerid, StandPos[vclass][pPos][0], StandPos[vclass][pPos][1], StandPos[vclass][pPos][2]);
							SetPlayerCameraPos(playerid, StandPos[vclass][pCPos][0], StandPos[vclass][pCPos][1], StandPos[vclass][pCPos][2]);
							SetPlayerCameraLookAt(playerid, StandPos[vclass][pCLookAt][0], StandPos[vclass][pCLookAt][1], StandPos[vclass][pCLookAt][2]);
							
							Pl::Info[playerid][pLocal] = OFFSET_BIZZ + bizz;
							Rac::SetPlayerVirtualWorld(playerid, playerid + Pl::Info[playerid][pLocal]);
							SetVehicleVirtualWorld(TempVehicle[playerid], playerid + Pl::Info[playerid][pLocal]);
							Rac::TogglePlayerControllable(playerid, false);
							
							SetPVarInt(playerid, "SelectedCar", 0);
							SetPVarInt(playerid, "VehicleClass", vclass);
							
							format(temp, sizeof temp, "~g~ID:~w~ %i~n~~g~MODEL: ~w~%s ~n~~g~PRICE: ~w~$%i ~n~~g~MAX SPEED: ~w~%i KM/H ~n~~g~CLASS: ~w~%c ~n~~g~in availability: ~w~yes",
							AutoSolon[vclass][0][0], VehicleNames[AutoSolon[vclass][0][0] - 400], AutoSolon[0][0][1],
							floatround(MaxVehicleSpeed[AutoSolon[vclass][0][0] - 400]) - 35, AClassChar[vclass]);
							
							Pt::SetString(playerid, Td::AutoSolon, temp);
							Pt::Show(playerid, Td::AutoSolon);
							ShowMenuForPlayer(AutoSolonMenu, playerid);
							return 1;
						}
					
						case Bizz_GarageLS, Bizz_GarageSF, Bizz_GarageLV, Bizz_GarageRublovka : {
							if(TotalExtraVehicles[playerid] <= 0) return Send(playerid, COLOR_GREY, "* У Вас нет личного транспорта!");
							if(TotalVehicleInGarage[playerid] <= 0) return Send(playerid, COLOR_GREY, "* Вы забрали весь транспорт из гаража!");
							if(IsPlayerTakeExtraVehicle(playerid)) return Send(playerid, COLOR_GREY, "* Вы уже взяли транспорт из гаража!");
							Pl::Info[playerid][pLocal] = OFFSET_BIZZ + bizz;
							
							if(Pl::Info[playerid][pBizKey] != BizzInfo[bizz][bID]) {
								BizzInfo[bizz][bProds] --;
								GiveBizzProfit(bizz, BizzInfo[bizz][bEnterCost]);
								Rac::GivePlayerMoney(playerid, -BizzInfo[bizz][bEnterCost]);
								format(string, sizeof string, "~r~-$%d", BizzInfo[bizz][bEnterCost]);
								GameTextForPlayer(playerid, string, 5000, 3);
							}

							TempVehicle[playerid] = Veh::Create(
								ExtraVehicles[playerid][VehicleInGarage[playerid][0]][evModel],
								616.0352,-124.1155,997.7648,90.1765,
								ExtraVehicles[playerid][VehicleInGarage[playerid][0]][evColor1],
								ExtraVehicles[playerid][VehicleInGarage[playerid][0]][evColor2],
								600
							);
							
							LinkVehicleToInterior(TempVehicle[playerid], 3);
							SetVehicleVirtualWorld(TempVehicle[playerid], playerid + Pl::Info[playerid][pLocal]);

							Rac::SetPlayerPos(playerid, 609.7039,-131.0049,997.9922);
							Rac::SetPlayerInterior(playerid, 3);
							Rac::SetPlayerVirtualWorld(playerid, playerid + Pl::Info[playerid][pLocal]);
							SetPlayerCameraPos(playerid, 609.0421, -130.5442, 999.5136);
							SetPlayerCameraLookAt(playerid, 611.7945, -127.7963, 998.5791);
							TogglePlayerControllable(playerid, false);
							SetPVarInt(playerid, "SelectedCar", 0);							
							ShowMenuForPlayer(GarageMenu, playerid);
							return 1;
						}
						
						case Bizz_PaintBall : {
							format(string, sizeof(string), "~r~-$%i~n~~w~WELCOME PAINT_BALL", BizzInfo[bizz][bEnterCost]);
							return GameTextForPlayer(playerid, string, 5000, 3);
						}
					}
					
					if(Pl::Info[playerid][pBizKey] != BizzInfo[bizz][bID]) {
						BizzInfo[bizz][bProds]--;
						GiveBizzProfit(bizz, BizzInfo[bizz][bEnterCost]);
						Rac::GivePlayerMoney(playerid,-BizzInfo[bizz][bEnterCost]);
						format(string, sizeof(string), "~r~-$%d", BizzInfo[bizz][bEnterCost]);
						GameTextForPlayer(playerid, string, 5000, 3);
					}

					EnterBiz(playerid, bizz);
				}
				else GameTextForPlayer(playerid, "~r~You dont have the cash", 5000, 1);
			}
			return 1;
		}
		
		case D_EX_BIZ : {
			if(response) {
				ExitBiz(playerid, GetPVarInt(playerid, "PlayerBizz"));
			}
		}
		
		case 2222 : {
			if(response) {
				if(Rac::GetPlayerMoney(playerid) < 100000) return Send(playerid, COLOR_GREY, "* У Вас не хватает денег!");
				if(0 <= listitem < sizeof fightStyle) {
					Rac::GivePlayerMoney(playerid, -100000);
					Pl::Info[playerid][pFightstyle] = fightStyle[listitem][0];
					SetPlayerFightingStyle(playerid, fightStyle[listitem][0]);
					format(string, sizeof string, "* Теперь вы деретесь в стиле %s. Время драться!", fightStyle[listitem][1]);
					Send(playerid, COLOR_GREEN, string);
				}
			}
			return 1;
		}
		
		case D_FIGHTSTYLE : {
			if(response) {
				if(0 <= listitem < sizeof fightStyle) {
					Pl::Info[playerid][pFightstyle] = fightStyle[listitem][0];
					SetPlayerFightingStyle(playerid, fightStyle[listitem][0]);
					format(string, sizeof string, "* Теперь вы деретесь в стиле %s. Время драться!", fightStyle[listitem][1]);
					Send(playerid, COLOR_GREEN, string);
				}
			}
		}
		
		case 149 : {
			if(response) {
				if(Rac::GetPlayerHealth(playerid) >= 100.0) return Send(playerid, COLOR_GREY, "* Вы сыты!");
				Rac::GivePlayerHealth(playerid, EatInfo[listitem][bHP], 100.0);
				format(string, sizeof(string), "* %s взял %s.", GetName(playerid), EatInfo[listitem][bDescription]);
				ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				format(string, sizeof(string), "~g~+ %.1f HP", EatInfo[listitem][bHP]);
				GameTextForPlayer(playerid, string, 5000, 1);
				
				if(Rac::GetPlayerHealth(playerid) >= 100.0) {
					Send(playerid, COLOR_GREY, "* Вы сыты!");
				} else {
					ShowCantina(playerid);
				}
			}
		}
		
		case 65 : {
			if(response) {
				Pl::Info[playerid][pSex] = 2;
				Send(playerid, COLOR_LIGHTBLUE, "* Ок, вы девушка");
			} else {
				Pl::Info[playerid][pSex] = 1;
				Send(playerid, COLOR_LIGHTBLUE, "* Ок, вы парень");
			}
		}
		
// СИСТЕМА БАНКА.
		case D_BANK : {
			if(response) {
				switch(listitem) {
					case 0 : {
						format(string, sizeof(string), "Баланс счета %s: $%i", GetName(playerid), Pl::Info[playerid][pBank]);
						SPD(playerid, D_BANK+33, DIALOG_STYLE_MSGBOX, "BALANCE", string, "OK", "CANCEL");
					}
					
					case 1 : {
						SPD(playerid, D_BANK+1, DIALOG_STYLE_INPUT, "WITHDRAW", "Введите сумму: ", "OK","CANCEL");
					}
					
					case 2 : {
						SPD(playerid, D_BANK+2, DIALOG_STYLE_INPUT, "DEPOSIT", "Введите сумму: ", "OK","CANCEL");
					}
					
					case 3 : {
						SPD(playerid, D_BANK+3, DIALOG_STYLE_INPUT, "TRANSFER", "Введите сумму перевода: ", "OK","CANCEL");
					}
				}
			}
		}
		
		case D_BANK+1 : {
			if(response) {
				if(sscanf(inputtext, "i", inputtext[0])) {
					SPD(playerid, D_BANK+1, DIALOG_STYLE_INPUT, "WITHDRAW", "Неверный ввод! Повторите попытку.\nВведите сумму: ", "OK","CANCEL");
				} else {
					if(inputtext[0] > 0 && Pl::Info[playerid][pBank] >= inputtext[0]) {
						Rac::GivePlayerMoney(playerid, inputtext[0]);
						GivePlayerBankMoney(playerid, -inputtext[0]);
						format(string, sizeof(string), "* Вы сняли $%i со своего счета. Остаток: $%i", inputtext[0], Pl::Info[playerid][pBank]);
						SPD(playerid, D_BANK+33, DIALOG_STYLE_MSGBOX, "WITHDRAW", string, "OK", "CANCEL");
					} else {
						SPD(playerid, D_BANK+1, DIALOG_STYLE_INPUT, "WITHDRAW", "Недостаточно средств.\nВведите сумму: ", "OK","CANCEL");
					}
				}
			} else {
				ShowDialog(playerid, D_BANK, DIALOG_STYLE_LIST, ""#__SERVER_PREFIX""#__SERVER_NAME_LC": BANK", "dialog/bankmenu.txt", "SELECT","CENCEL");
			}
		}
		
		case D_BANK+2 : {
			if(response) {
				if(sscanf(inputtext, "i", inputtext[0])) {
					SPD(playerid, D_BANK+2, DIALOG_STYLE_INPUT, "DEPOSIT", "Неверный ввод! Повторите попытку.\nВведите сумму: ", "OK","CANCEL");
				} else {
					if(inputtext[0] > 0 && Rac::GetPlayerMoney(playerid) >= inputtext[0]) {
						Rac::GivePlayerMoney(playerid, -inputtext[0]);
						GivePlayerBankMoney(playerid, inputtext[0]);
						format(string, sizeof(string), "* Вы пополнили счет на $%i. Текущий баланс: $%i", inputtext[0], Pl::Info[playerid][pBank]);
						SPD(playerid, D_BANK+33, DIALOG_STYLE_MSGBOX, "DEPOSIT", string, "OK", "CANCEL");
					} else {
						SPD(playerid, D_BANK+2, DIALOG_STYLE_INPUT, "DEPOSIT", "Недостаточно средств.\nВведите сумму: ", "OK","CANCEL");
					}
				}
			} else {
				ShowDialog(playerid, D_BANK, DIALOG_STYLE_LIST, ""#__SERVER_PREFIX""#__SERVER_NAME_LC": BANK", "dialog/bankmenu.txt", "SELECT","CENCEL");
			}
		}
		
		case D_BANK+3 : {
			if(response) {
				if(sscanf(inputtext, "i", inputtext[0])) {
					SPD(playerid, D_BANK+3, DIALOG_STYLE_INPUT, "TRANSFER", "Неверный ввод! Повторите попытку\nВведите сумму перевода: ", "OK","CANCEL");
				} else {
					if(inputtext[0] > 0 && Pl::Info[playerid][pBank] >= inputtext[0]) {
						SetPVarInt(playerid, "TransferAmount", inputtext[0]);
						format(string, sizeof(string), "* Сумма: $%i.\nВведите ID получателя платежа:", inputtext[0]);
						SPD(playerid, D_BANK+4, DIALOG_STYLE_INPUT, "TRANSFER", string, "OK", "CANCEL");
					} else {
						SPD(playerid, D_BANK+3, DIALOG_STYLE_INPUT, "TRANSFER", "Недостаточно средств.\nВведите сумму перевода: ", "OK","CANCEL");
					}
				}
			} else {
				ShowDialog(playerid, D_BANK, DIALOG_STYLE_LIST, ""#__SERVER_PREFIX""#__SERVER_NAME_LC": BANK", "dialog/bankmenu.txt", "SELECT","CENCEL");
			}
		}
		
		case D_BANK+4 : {
			if(response) {
				new player;
				if(sscanf(inputtext, "u", player)) {
					format(string, sizeof(string), "* Сумма: $%i.\nВведите ID получателя платежа:", GetPVarInt(playerid, "TransferAmount"));
					SPD(playerid, D_BANK+4, DIALOG_STYLE_INPUT, "TRANSFER", string, "OK", "CANCEL");
				} else {
					if(playerid == player) {
						SPD(playerid, D_BANK+33, DIALOG_STYLE_MSGBOX, "TRANSFER", "Вы ввели свой ID!", "OK", "CANCEL");
					} else if(Pl::isLogged(player)) {
						SetPVarInt(playerid, "TransferPlayer", player);
						SetTimerEx("OnPlayerBankTransfer", 1000*10, false, "i", playerid);
						format(string, sizeof(string), "Вы собираетесь совершить перевод на сумму $%i игроку [%i]%s.\n\
						У Вас есть 10 секунд для подтверждения платежа!", GetPVarInt(playerid, "TransferAmount"), player, GetName(player));
						SPD(playerid, D_BANK+5, DIALOG_STYLE_MSGBOX, "TRANSFER", string, "OK", "CANCEL");
					} else {
						format(string, sizeof(string), "Игрок не залогинен!\n\n* Сумма: $%i.\nВведите ID получателя платежа:", GetPVarInt(playerid, "TransferAmount"));
						SPD(playerid, D_BANK+4, DIALOG_STYLE_INPUT, "TRANSFER", string, "OK", "CANCEL");
					}
				}
			} else {
				SPD(playerid, D_BANK+3, DIALOG_STYLE_INPUT, "TRANSFER", "Введите сумму перевода: ", "OK", "CANCEL");
			}
		}
		
		case D_BANK+5 : {
			if(response) {
				new player = GetPVarInt(playerid, "TransferPlayer");
				if(player == INVALID_PLAYER_ID) {
					SPD(playerid, D_BANK+33, DIALOG_STYLE_MSGBOX, "TRANSFER", "Время транзакции истекло!\nПовторите попытку.", "OK", "CANCEL");
				} else {
					new amount = GetPVarInt(playerid, "TransferAmount");
					GivePlayerBankMoney(playerid, -amount);
					GivePlayerBankMoney(player, amount);
					new bidx = OFFSET_BIZZ - bidx;
					if(amount >= 10000 && IsValidBiz(bidx)) GiveBizzProfit(bidx, amount/99);
					format(string, sizeof(string), "* Перевод успешно совершен!\n\
					Сумма: $%i\nПолучатель: [%i]%s\nОтправитель: [%i]%s", amount, player, GetName(player), playerid, GetName(playerid));
					SPD(playerid, D_BANK+33, DIALOG_STYLE_MSGBOX, "DEPOSIT", string, "OK", "CANCEL");
					format(string, sizeof(string), "* %s[%i] перевел на ваш счет $%i", GetName(playerid), playerid, amount);
					Send(player, COLOR_GREY, string);
					format(string, sizeof(string), "[BANK] * %s[%i] transfer $%i to %s[%i] | %.3f kk", GetName(playerid), playerid, amount, GetName(player), player, float(amount/1000000));
					SendToAdmin(COLOR_YELLOW, string, 1, 3);
				}
				SetPVarInt(playerid, "TransferPlayer", INVALID_PLAYER_ID);
				SetPVarInt(playerid, "TransferAmount", 0);
			} else {
				format(string, sizeof(string), "* Сумма: $%i.\nВведите ID получателя платежа:", GetPVarInt(playerid, "TransferAmount"));
				SPD(playerid, D_BANK+4, DIALOG_STYLE_INPUT, "TRANSFER", string, "OK", "CANCEL");
			}
		}
		
		case D_BANK+33 : {
			ShowDialog(playerid, D_BANK, DIALOG_STYLE_LIST, ""#__SERVER_PREFIX""#__SERVER_NAME_LC": BANK", "dialog/bankmenu.txt", "SELECT","CENCEL");
		}
// СИСТЕМА БАНКА. END

// СИСТЕМА БАНКАМАТОВ
		case D_ATM : {
			if(response) {
				switch(listitem) {
					case 0: {
						format(dialog, sizeof dialog, "Напишите сумму, которую хотите снять со счета.\nМаксимум $100000 за одну опирацию.\n\
						С каждой перечисленной суммы взымается налог в 3 процента!", Pl::Info[playerid][pBank]);
						SPD(playerid, D_ATM+1, DIALOG_STYLE_INPUT,""#__SERVER_PREFIX""#__SERVER_NAME_C" ATM. WITHDRAW", dialog, "OK", "CANCEL");
					}
					
					case 1: {
						format(dialog, sizeof dialog, "Напишите сумму, которую хотите положить на счет.\nМаксимум $100000 за одну опирацию.\n\
						С каждой перечисленной суммы взымается налог в 3 процента!", Pl::Info[playerid][pBank]);
						SPD(playerid, D_ATM+2, DIALOG_STYLE_INPUT, ""#__SERVER_PREFIX""#__SERVER_NAME_C" ATM. DEPOSIT", dialog, "OK", "CANCEL");
					}
					
					case 2: {
						format(dialog, sizeof dialog, "Баланс счета %s: $%i", GetName(playerid), Pl::Info[playerid][pBank]);
						SPD(playerid, D_ATM+33, DIALOG_STYLE_MSGBOX, ""#__SERVER_PREFIX""#__SERVER_NAME_C" ATM. BALANCE", dialog, "OK", "CANCEL");
					}
				}
			}
		}
		
		case D_ATM+1 : {
			if(response) {
				new cash = 0;
				if(sscanf(inputtext, "i", cash)) {
					format(dialog, sizeof dialog, "* Неверный ввод! Повторите попытку!\n\
					\nНапишите сумму, которую хотите снять со счета.\nМаксимум $100000 за одну опирацию.\n\
					С каждой перечисленной суммы взымается налог в 3 процента!", Pl::Info[playerid][pBank]);
					SPD(playerid, D_ATM+1, DIALOG_STYLE_INPUT,""#__SERVER_PREFIX""#__SERVER_NAME_C" ATM. WITHDRAW", dialog, "OK", "CANCEL");
				} else if(cash > 100000) {
					format(dialog, sizeof dialog, "Напишите сумму, которую хотите положить на счет.\nМаксимум $100000 за одну опирацию.\n\
					С каждой перечисленной суммы взымается налог в 3 процента!", Pl::Info[playerid][pBank]);
					SPD(playerid, D_ATM+2, DIALOG_STYLE_INPUT, ""#__SERVER_PREFIX""#__SERVER_NAME_C" ATM. DEPOSIT", dialog, "OK", "CANCEL");
				} else if(cash < 100) {
					format(dialog, sizeof dialog, "* Минимальная сумма за одну операцию состовляет 100$\n\
					\nНапишите сумму, которую хотите снять со счета.\nМаксимум $100000 за одну опирацию.\n\
					С каждой перечисленной суммы взымается налог в 3 процента!", Pl::Info[playerid][pBank]);
					SPD(playerid, D_ATM+1, DIALOG_STYLE_INPUT,""#__SERVER_PREFIX""#__SERVER_NAME_C" ATM. WITHDRAW", dialog, "OK", "CANCEL");
				} else if(cash > Pl::Info[playerid][pBank]) {
					Send(playerid, COLOR_GREY, "Нельзя снять больше денег, чем на счету!");
					format(dialog, sizeof dialog, "* Недостаточно средств на счету!\n\
					\nНапишите сумму, которую хотите снять со счета.\nМаксимум $100000 за одну опирацию.\n\
					С каждой перечисленной суммы взымается налог в 3 процента!", Pl::Info[playerid][pBank]);
					SPD(playerid, D_ATM+1, DIALOG_STYLE_INPUT,""#__SERVER_PREFIX""#__SERVER_NAME_C" ATM. WITHDRAW", dialog, "OK", "CANCEL");
				} else {
					new proc = (cash*3)/100;
					new babki = cash - proc;
					GiveBizzProfit(0, proc);
					GivePlayerBankMoney(playerid, -babki);
					Rac::GivePlayerMoney(playerid, babki);
					format(dialog, sizeof dialog, "* Вы сняли $%i со своего счета. Остаток: $%i", babki, Pl::Info[playerid][pBank]);
					SPD(playerid, D_ATM+33, DIALOG_STYLE_MSGBOX, ""#__SERVER_PREFIX""#__SERVER_NAME_C" ATM. WITHDRAW", dialog, "OK", "CANCLE");
				}
			} else {
				ShowDialog(playerid, D_ATM, DIALOG_STYLE_LIST, ""#__SERVER_PREFIX""#__SERVER_NAME_C" ATM.", "dialog/atmmenu.txt", "SELECT","CENCEL");
			}
		}
		
		case D_ATM+2 : {
			if(response) {
				new cash;
				if(sscanf(inputtext, "i", cash)) {
					format(dialog, sizeof dialog, "* Неверный ввод! Повторите попытку!\n\
					\nНапишите сумму, которую хотите положить на счет.\nМаксимум $100000 за одну опирацию.\n\
					С каждой перечисленной суммы взымается налог в 3 процента!", Pl::Info[playerid][pBank]);
					SPD(playerid, D_ATM+2, DIALOG_STYLE_INPUT, ""#__SERVER_PREFIX""#__SERVER_NAME_C" ATM. DEPOSIT", dialog, "OK", "CANCEL");
				} else if(cash > 100000) {
					format(dialog, sizeof dialog, "* Неверный ввод! Повторите попытку!\n\
					\nНапишите сумму, которую хотите положить на счет.\nМаксимум $100000 за одну опирацию.\n\
					С каждой перечисленной суммы взымается налог в 3 процента!", Pl::Info[playerid][pBank]);
					SPD(playerid, D_ATM+2, DIALOG_STYLE_INPUT, ""#__SERVER_PREFIX""#__SERVER_NAME_C" ATM. DEPOSIT", dialog, "OK", "CANCEL");
				} else if(cash < 100) {
					format(dialog, sizeof dialog, "* Минимальная сумма за одну операцию состовляет 100$\n\
					\nНапишите сумму, которую хотите положить на счет.\nМаксимум $100000 за одну опирацию.\n\
					С каждой перечисленной суммы взымается налог в 3 процента!", Pl::Info[playerid][pBank]);
					SPD(playerid, D_ATM+2, DIALOG_STYLE_INPUT, ""#__SERVER_PREFIX""#__SERVER_NAME_C" ATM. DEPOSIT", dialog, "OK", "CANCEL");
				} else {
					cash -= ((cash * 3) / 100);
					if(cash > Rac::GetPlayerMoney(playerid)) {
						format(dialog, sizeof dialog, "* У Вас недостаточно средств!\n\
						\nНапишите сумму, которую хотите положить на счет.\nМаксимум $100000 за одну опирацию.\n\
						С каждой перечисленной суммы взымается налог в 3 процента!", Pl::Info[playerid][pBank]);
						SPD(playerid, D_ATM+2, DIALOG_STYLE_INPUT, ""#__SERVER_PREFIX""#__SERVER_NAME_C" ATM. DEPOSIT", dialog, "OK", "CANCEL");
					} else {
						GivePlayerBankMoney(playerid, cash);
						Rac::GivePlayerMoney(playerid, -cash);
						format(dialog, sizeof dialog, "* Вы пополнили счет на $%i. Текущий баланс: $%i", cash, Pl::Info[playerid][pBank]);
						SPD(playerid, D_ATM+33, DIALOG_STYLE_MSGBOX, ""#__SERVER_PREFIX""#__SERVER_NAME_C" ATM. DEPOSIT", dialog, "OK", "CANCEL");
					}
				}
			} else {
				ShowDialog(playerid, D_ATM, DIALOG_STYLE_LIST, ""#__SERVER_PREFIX""#__SERVER_NAME_C" ATM.", "dialog/atmmenu.txt", "SELECT","CENCEL");
			}
		}
		
		case D_ATM+33 : {
			ShowDialog(playerid, D_ATM, DIALOG_STYLE_LIST, ""#__SERVER_PREFIX""#__SERVER_NAME_C" ATM.", "dialog/atmmenu.txt", "SELECT","CENCEL");
		}
// СИСТЕМА БАНКАМАТОВ. END

// СИСТЕМА ФРАКЦИОННОГО БАНКА
		case D_FBANK: {
			if(response) {
				SetPVarInt(playerid, "SelectedItem", listitem);
				format(string, sizeof(string), "Счет %s", FracInfo[FracID[listitem]][fName]);
				SPD(playerid, D_FBANK+1, DIALOG_STYLE_MSGBOX, ""#__SERVER_PREFIX""#__SERVER_NAME_LC": Bank", string, "БАЛАНС", "ПЕРЕВОД");
			}
		}
		
		case D_FBANK+1: {
			new idx = GetPVarInt(playerid, "SelectedItem");
			if(!response) {
				if(Bl::Info[playerid][Bl::onFrac][FracID[idx]] && FracInfo[FracID[idx]][fBConf][bPRICE]) {
					format(string, sizeof(string), "Выход из черного списка\n%s.\nСумма выхода: $%i", FracInfo[FracID[idx]][fName], FracInfo[FracID[idx]][fBConf][bPRICE]);
					SPD(playerid, D_FBANK+4, DIALOG_STYLE_MSGBOX, ""#__SERVER_PREFIX""#__SERVER_NAME_LC": Bank", string, "OK", "CANCEL");
				} else {
					format(string, sizeof(string), "Перевод средств на счет\n%s.\nВведите сумму (от $1 до $1kk):", FracInfo[FracID[idx]][fName]);
					SPD(playerid, D_FBANK+3, DIALOG_STYLE_INPUT, ""#__SERVER_PREFIX""#__SERVER_NAME_LC": Bank", string, "OK", "CANCEL");
				}
			} else {
				if(Pl::FracID(playerid) == FracID[idx] || EditMode{playerid}) {
					format(string, sizeof(string), "Баланс %s:\n$%i", FracInfo[FracID[idx]][fName], GetFracMoney(FracID[idx]));
					SPD(playerid, D_FBANK+2, DIALOG_STYLE_MSGBOX, ""#__SERVER_PREFIX""#__SERVER_NAME_LC": Bank", string, "OK", "CANCEL");
				} else {
					Send(playerid, COLOR_GREY, "* Проверять баланс счета могут только его владельцы!");
				}
			}
		}

		case D_FBANK+2: {
			ShowFracBank(playerid);
		}
		
		case D_FBANK+3: {
			if(response) {
				new idx = GetPVarInt(playerid, "SelectedItem");
				if(sscanf(inputtext, "i", inputtext[0])) {
					format(string, sizeof(string), "Перевод средств на счет\n%s.\nВведите сумму (от $1 до $1kk):", FracInfo[FracID[idx]][fName]);
					SPD(playerid, D_FBANK+3, DIALOG_STYLE_INPUT, ""#__SERVER_PREFIX""#__SERVER_NAME_LC": Bank", string, "OK", "CANCEL");
				}
				
				else if(!(1 <= inputtext[0] < 1000000)) {
					format(string, sizeof(string), "Перевод средств на счет\n%s.\nВведите сумму (от $1 до $1kk):", FracInfo[FracID[idx]][fName]);
					SPD(playerid, D_FBANK+3, DIALOG_STYLE_INPUT, ""#__SERVER_PREFIX""#__SERVER_NAME_LC": Bank", string, "OK", "CANCEL");
				}
				
				else if(inputtext[0] > Rac::GetPlayerMoney(playerid)) {
					Send(playerid,COLOR_GREY,"* У Вас нет столько денег!");
					format(string, sizeof(string), "Перевод средств на счет\n%s.\nВведите сумму (от $1 до $1kk):", FracInfo[FracID[idx]][fName]);
					SPD(playerid, D_FBANK+3, DIALOG_STYLE_INPUT, ""#__SERVER_PREFIX""#__SERVER_NAME_LC": Bank", string, "OK", "CANCEL");
				}
				
				else {
					GiveFracMoney(FracID[idx], inputtext[0]);
					Rac::GivePlayerMoney(playerid, -inputtext[0]);
					GetPlayerName(playerid, plname, 24);
					
					if(IsAMafiaF(FracID[idx]) || IsAGangF(FracID[idx])) {
						format(string, sizeof(string), "[TRANSFER]: Гуляй братва %s положил на счёт $%i", plname, inputtext[0]);
					} else {
						format(string, sizeof(string), "[TRANSFER]: Только что %s положил на счёт $%i", plname, inputtext[0]);
					}
					sendToFamily(FracID[idx], COLOR_AZTECAS, string);
					format(string, sizeof(string), "* Счет %s успешно пополнен на $%i", FracInfo[FracID[idx]][fName], inputtext[0]);
					Send(playerid, COLOR_LIGHTBLUE, string);
				}
					
			} else {
				ShowFracBank(playerid);
			}
		}
		
		case D_FBANK+4: {
			if(response) {
				new idx = GetPVarInt(playerid, "SelectedItem");
				if(Bl::Info[playerid][Bl::onFrac][FracID[idx]]) {
					new exitprice = FracInfo[FracID[idx]][fBConf][bPRICE];
					if(Rac::GetPlayerMoney(playerid) >= exitprice) {
						GetPlayerName(playerid, plname, 24);
						GiveFracMoney(FracID[idx], exitprice);
						Rac::GivePlayerMoney(playerid, -exitprice);
						Bl::Remove(playerid, FracID[idx]);
						
						format(string, sizeof(string), "[BLACK LIST] Терпила %s, заплатил %i$ за выход из черного списка %s", plname, exitprice, FracInfo[FracID[idx]][fName]);
						sendToFamily(FracID[idx], COLOR_AZTECAS, string);
						format(string, sizeof(string), "[BLACK LIST] Вы вышли из черного списка(%s) за %i$", FracInfo[FracID[idx]][fName], exitprice);
						Send(playerid, COLOR_AZTECAS, string);
					}
				}
			} else {
				ShowFracBank(playerid);
			}
		}
// СИСТЕМА ФРАКЦИОННОГО БАНКА. END

// ПОМОЩЬ ПО ИГРЕ
		case D_REF : {
			if(response) {
				switch(listitem) {
					case 0 : ShowDialog(playerid, D_REF+1, DIALOG_STYLE_MSGBOX, "{33CCFF}Справка: Уровень игрока.", "dialog/ref/level.txt", "ENTER", "");
					case 1 : ShowDialog(playerid, D_REF+1, DIALOG_STYLE_MSGBOX, "{33CCFF}Справка: Чаты.", "dialog/ref/chat.txt", "ENTER", "");
					case 2 : ShowDialog(playerid, D_REF+1, DIALOG_STYLE_MSGBOX, "{33CCFF}Справка: Лицензии.", "dialog/ref/licenzes.txt", "ENTER", "");
					case 3 : ShowDialog(playerid, D_REF+1, DIALOG_STYLE_MSGBOX, "{33CCFF}Справка: Работы.", "dialog/ref/jobs.txt", "ENTER", "");
					case 4 : ShowDialog(playerid, D_REF+1, DIALOG_STYLE_MSGBOX, "{33CCFF}Справка: Транспорт.", "dialog/ref/vehicle.txt", "ENTER", "");
					case 5 : ShowDialog(playerid, D_REF+1, DIALOG_STYLE_MSGBOX, "{33CCFF}Справка: Дом.", "dialog/ref/home.txt", "ENTER", "");
					case 6 : ShowDialog(playerid, D_REF+1, DIALOG_STYLE_MSGBOX, "{33CCFF}Справка: Бизнес.", "dialog/ref/biznes.txt", "ENTER", "");
					case 7 : ShowDialog(playerid, D_REF+1, DIALOG_STYLE_MSGBOX, "{33CCFF}Справка: Банк.", "dialog/ref/bank.txt", "ENTER", "");
				}
			}
		}
		
		case D_REF+1 : {
			ShowDialog(playerid, D_REF, DIALOG_STYLE_LIST, "{33CCFF}Справка.", "dialog/ref/main.txt", "SELECT", "CANCEL");
		}
// ПОМОЩЬ ПО ИГРЕ. END

		case D_HELP : {
			if(response) {
				dialog[0] = '\0';
				new tittle[50], category[50], fracid = Pl::FracID(playerid);
				switch(listitem) {
					case 0 : {
						strmid(category, "Клиентские команды", 0, 50);
						LoadFile("dialog/help/client_cmd.txt", dialog);	
					}
					case 1 : {
						strmid(category, "Аккаунт", 0, 50);
						LoadFile("dialog/help/account.txt", dialog);
					}
					case 2 : {
						strmid(category, "Общее", 0, 50);
						LoadFile("dialog/help/common.txt", dialog);
					}
					
					case 3 : {
						strmid(category, "Фракция", 0, 50);
						if(fracid) {
							if(IsAGang(playerid) || IsAMafia(playerid)) strcat(dialog, "{FFFF00}/bl - {FFFFFF}черный список\n");
							if(IsACop(playerid)) {
								strcat(dialog, "{FFFF00}/arrest - {FFFFFF}арестовать игрока\n");
								strcat(dialog, "{FFFF00}/color - {FFFFFF}одеть кепку\n");
								strcat(dialog, "{FFFF00}/ticket - {FFFFFF}выисать штраф игроку\n");
								strcat(dialog, "{FFFF00}/su - {FFFFFF}дать розыск игроку\n");
								strcat(dialog, "{FFFF00}/clear - {FFFFFF}очистить розыск игроку\n");
								strcat(dialog, "{FFFF00}/wanted - {FFFFFF}список розыскиваемых\n");
								strcat(dialog, "{FFFF00}/cuff - {FFFFFF}надеть игроку наручники\n");
								strcat(dialog, "{FFFF00}/uncuff - {FFFFFF}снять игроку наручники\n");
								strcat(dialog, "{FFFF00}/tazer - {FFFFFF}ударить игрока электрошокером\n");
								strcat(dialog, "{FFFF00}/frisk - {FFFFFF}обыскать игрока\n");
								strcat(dialog, "{FFFF00}/mdc - {FFFFFF}посмотреть причину, по которой игроку был дан розыск\n");
								strcat(dialog, "{FFFF00}/take - {FFFFFF}отобрать что-то у игрока\n");
							}
							
							switch(fracid) {
								case 1 : strcat(dialog, "{FFFF00}/duty - {FFFFFF}заступить на дежурство\n");
								case 4 : {
									strcat(dialog, "{FFFF00}/duty - {FFFFFF}заступить на дежурство\n");
									strcat(dialog, "{FFFF00}/heal - {FFFFFF}вылечить игрока\n");
									strcat(dialog, "{FFFF00}/accept medic - {FFFFFF}принять вызов\n");
								}
								case 8 : strcat(dialog, "{FFFF00}/loadmac - {FFFFFF}провеить, сколько мака в амбаре\n");
								case 9 : {
									strcat(dialog, "{FFFF00}/news - {FFFFFF}послать новости в эфир\n");
									strcat(dialog, "{FFFF00}/live - {FFFFFF}начать интервью\n");
								}
								case 10 : strcat(dialog, "{FFFF00}/fare - {FFFFFF}установить таксу\n");
								case 11 : {
									strcat(dialog, "{FFFF00}/startlesson - {FFFFFF}начать экзамен\n");
									strcat(dialog, "{FFFF00}/stoplesson - {FFFFFF}завершить экзамен\n");
									strcat(dialog, "{FFFF00}/givelicense - {FFFFFF}выдать лицензию игроку\n");
									strcat(dialog, "{FFFF00}/take - {FFFFFF}отобрать что-то у игрока\n");
								}
								case 17 : {
									strcat(dialog, "{FFFF00}/buymats - {FFFFFF}купить материалы в доках ЛС\n");
									strcat(dialog, "{FFFF00}/sellmats - {FFFFFF}продать материалы на базе\n");
									strcat(dialog, "{FFFF00}/loadmats - {FFFFFF}посмотреть, на сколько загружен склад\n");
								}
							}
							if(IsAMafia(playerid)) {
								strcat(dialog, "{FFFF00}/selldrugs - {FFFFFF}продать наркоту\n");
								strcat(dialog, "{FFFF00}/sellgun - {FFFFFF}продать оружие\n");
							}
							if(IsAGang(playerid)) strcat(dialog, "{FFFF00}/zahvat - {FFFFFF}атаковать бизнес\n");
							strcat(dialog, "{FFFF00}/color - {FFFFFF}активировать цвет\n");
						}
						else strcat(dialog, "Вам это меню не доступно!");
					}
					case 4:
					{
						strmid(category, "Работа", 0, 50);
						switch(Pl::Info[playerid][pJob])
						{
							case 1: strcat(dialog, "{FFFF00}/find - {FFFFFF}найти игрока\n");
							case 2: strcat(dialog, "{FFFF00}/free - {FFFFFF}выпустить игрока из тюрьмы\n");
							case 3: strcat(dialog, "{FFFF00}/sex - {FFFFFF}предложить заняться сексом\n");
							case 4: strcat(dialog, "{FFFF00}/selldrugs - {FFFFFF}продать наркотики игроку\n");
							case 5: {
								strcat(dialog, "{FFFF00}/jack - {FFFFFF}взломать замок автомобиля\n");
								strcat(dialog, "{FFFF00}/dropcar - {FFFFFF}экспортировать автомобиль\n");
							}
							case 6: {
								strcat(dialog, "{FFFF00}/at - {FFFFFF}прицепить прицеп\n");
								strcat(dialog, "{FFFF00}/dt - {FFFFFF}отцепить прицеп\n");
								strcat(dialog, "{FFFF00}/duty - {FFFFFF}заступить на дежурство\n");
								strcat(dialog, "{FFFF00}/repair - {FFFFFF}починить автомобиль\n");
								strcat(dialog, "{FFFF00}/refill - {FFFFFF}заправить автомобиль\n");
							}
							case 7: {
								strcat(dialog, "{FFFF00}/mats - {FFFFFF}купить/переработать материалы\n");
								strcat(dialog, "{FFFF00}/sellgun - {FFFFFF}продать оружие игроку\n");
							}
							case 8: strcat(dialog, "{FFFF00}/sellcar - {FFFFFF}продать авто игроку\n");
							case 9: strcat(dialog, "{FFFF00}/fare - {FFFFFF}установить цену проезда\n");
							case 10: strcat(dialog, "{FFFF00}/delivery - {FFFFFF}начать рэйс\n");
							default: strcat(dialog, "У Вас нет работы!");
						}
						if(Pl::Info[playerid][pJob] > 0) strcat(dialog, "{FFFF00}/quitjob - {FFFFFF}уволиться\n");
					}
					case 5:
					{
						strmid(category, "Чаты", 0, 50);
						strcat(dialog, "{FFFF00}/w (/pm) - {FFFFFF}отправить личное сообщение игроку\n");
						strcat(dialog, "{FFFF00}/s - {FFFFFF}крикнуть\n");
						strcat(dialog, "{FFFF00}/b - {FFFFFF}OOC чат\n");
						if(IsAFamily(playerid)) strcat(dialog, "{FFFF00}/f - {FFFFFF}отправить сообщение в фракционный чат\n");
						if(IsATeam(playerid) || fracid == 11)
						{
							strcat(dialog, "{FFFF00}/d - {FFFFFF}отправить сообщение в чат департамента\n");
							strcat(dialog, "{FFFF00}/r - {FFFFFF}сказать по рации\n");
							strcat(dialog, "{FFFF00}/m - {FFFFFF}крикнуть по мегафону\n");
							strcat(dialog, "{FFFF00}/gov - {FFFFFF}отправить сообщение в городские новост\n");
						}
						strcat(dialog, "{FFFF00}/ad - {FFFFFF}подать объявление\n");
						strcat(dialog, "{FFFF00}/me - {FFFFFF}описать свое действие от 3-его лица\n");
						strcat(dialog, "{FFFF00}/do - {FFFFFF}описать действия вокруг себя\n");
						strcat(dialog, "{FFFF00}/try - {FFFFFF}попытаться что-то сделать\n");
						strcat(dialog, "{FFFF00}/togooc - {FFFFFF}вкл/выкл сообщения о входе/выходе игроков\n");
						strcat(dialog, "{FFFF00}/tognews - {FFFFFF}вкл/выкл показ новостей\n");
						strcat(dialog, "{FFFF00}/togfam - {FFFFFF}вкл/выкл семейный чат\n");
						strcat(dialog, "{FFFF00}/togpm - {FFFFFF}вкл/выкл личные сообщения\n");
					}
					
					case 6 : {
						strmid(category, "Телефон", 0, 50);
						LoadFile("dialog/help/phone.txt", dialog);
					}
					
					case 7 : {
						strmid(category, "Аренда авто", 0, 50);
						LoadFile("dialog/help/rent_car.txt", dialog);
					}
					
					case 8 : {
						strmid(category, "Дом", 0, 50);
						LoadFile("dialog/help/home.txt", dialog);
					}
					
					case 9 : {
						strmid(category, "Аренда дома", 0, 50);
						LoadFile("dialog/help/rent_home.txt", dialog);
					}
					
					case 10 : {
						strmid(category, "Бизнес", 0, 50);
						LoadFile("dialog/help/biznes.txt", dialog);
					}
					
					case 11:
					{
						strmid(category, "ЛИДЕРКА", 0, 50);
						if(IsPlayerLeader(playerid) > 0) {
							strcat(dialog, "{FFFF00}/lmenu - {FFFFFF}меню лидера\n");
							strcat(dialog, "{FFFF00}/invite - {FFFFFF}принять игрока в свою фракцию\n");
							strcat(dialog, "{FFFF00}/uninvite - {FFFFFF}выгнать игрока из своей фракции\n");
							strcat(dialog, "{FFFF00}/giverank - {FFFFFF}установить ранг игроку\n");
							strcat(dialog, "{FFFF00}/fracpay - {FFFFFF}выдать зарплату\n");
							strcat(dialog, "{FFFF00}/vigovor - {FFFFFF}дать выговор игроку\n");
							strcat(dialog, "{FFFF00}/unvigovor - {FFFFFF}снять выговор с игрока\n");
							if(fracid == 7) {
								strcat(dialog, "{FFFF00}/settax - {FFFFFF}установить налог\n");
								strcat(dialog, "{FFFF00}/givetax - {FFFFFF}выдать зарплпту законникам\n");
								strcat(dialog, "{FFFF00}/checktax - {FFFFFF}проверить казну\n");
							}
						} else {
							strcat(dialog, "Вы не лидер!");
						}
					}
					case 12:
					{
						strmid(category, "Хелперка", 0, 50);
						if(!IsPHelper(playerid, 1)) strcat(dialog, "Вы не хелпер!");
						strcat(dialog, "{FFFF00}/hc - {FFFFFF}отправить текст в чат хелперов\n");
						strcat(dialog, "{FFFF00}/ans - {FFFFFF}ответить игроку\n");
						strcat(dialog, "{FFFF00}/hduty - {FFFFFF}заступить на дежурство\n");
						if(IsPHelper(playerid, 2)) strcat(dialog, "{FFFF00}/hmute - {FFFFFF}дать мут игроку\n");
						if(IsPHelper(playerid, 3)) strcat(dialog, "{FFFF00}/makehelper(1-3) - {FFFFFF}дать хелперку\n");
					}
					case 13:
					{
						if(!Pl::Info[playerid][pAdmin]) strcat(dialog, "Вы не админ!");
						else
						{
							return ShowDialog(playerid, D_NONE, 0, ""#__SERVER_PREFIX""#__SERVER_NAME_LC": Помощь > Команды админов", "dialog/help/admin.txt", "CANCEL", "");
						}
					}
				}
				format(tittle, sizeof(tittle), ""#__SERVER_PREFIX""#__SERVER_NAME_LC": Помощь > %s", category);
				SPD(playerid, D_HELP+33, 0, tittle, dialog, "BACK", "CANCEL");
			}
		}
		
		case D_HELP+33 : { 
			ShowDialog(playerid, D_HELP, DIALOG_STYLE_LIST,""#__SERVER_PREFIX""#__SERVER_NAME_LC": Помощь", "dialog/help.txt", "SELECT", "CANCEL");
		}
		
		case D_ARMOUR: {
			if(response) {
				if(Rac::GetPlayerArmour(playerid) >= 100.0 && Rac::GetPlayerHealth(playerid) >= 100.0) return Send(playerid, COLOR_GRAD2, "* Вы уже в бронежилете!");
				Rac::SetPlayerHealth(playerid, 100.0);
				Rac::SetPlayerArmour(playerid, 100.0);
				Rac::GivePlayerMoney(playerid, -500);
			}
		}
		
		case D_FARE : {
			if(response) {
				new Veh = GetPlayerVehicleID(playerid);
				if(IsABusCar(Veh)) {
					SetPVarInt(playerid, "NextCP", 0);
					SetPVarInt(playerid, "RouteID", listitem);
					format(string, sizeof(string), "»» %s - %s ««\nТариф: $%i", BusRoute[listitem][0][stopName], BusRoute[listitem][BusRouteCount[listitem]-1][stopName], TransportValue[playerid]);
					AttachText[Veh] = Add3DText(string, COLOR_BUS_PRICE, 0.0, 3.5, 2.8, 20.0, INVALID_PLAYER_ID, Veh, 0, 0, 0, -1);
					format(string, sizeof(string), "Вы начали маршрут %s - %s", BusRoute[listitem][0][stopName], BusRoute[listitem][BusRouteCount[listitem]-1][stopName]);
					Send(playerid, COLOR_TAXI_PRICE, string);
					Send(playerid,COLOR_LIGHTRED, "Следуете к красному маячку на радаре.");
					checkpointb[playerid] = CreateDynamicRaceCP(
						2,
						BusRoute[listitem][0][stopX],
						BusRoute[listitem][0][stopY],
						BusRoute[listitem][0][stopZ],
						0, 0, 0, 4.0, 0, 0, playerid, 99999.0
					);
				}
			} else {
				BusDrivers --;
				TransportDuty[playerid] = 0;
				TransportValue[playerid] = 0;
			}
		}
		
		case D_SKILL : {
			if(response) {
				switch(listitem) {
					case 0: {
						new score = Pl::Info[playerid][pSkill][0];
						new level = GetSkillLevel(playerid, 0);
						if(level < 5) format(string,sizeof(string),"*Ваш уровень опыта по профессии детектив = %i.\n*Для повышения уровня необходимо найти ещё %i игроков!", level, 50 - score);
						else format(string,sizeof(string),"*Ваш уровень опыта по профессии детектив = 5.");
						SPD(playerid, D_SKILL+1, DIALOG_STYLE_MSGBOX, "SKILL", string, "НАЗАД", "Закрыть");
					}
					
					case 1: {
						new score = Pl::Info[playerid][pSkill][2];
						new level = GetSkillLevel(playerid, 2);
						if(level < 5) format(string,sizeof(string),"*Ваш уровень опыта по профессии адвокат = %i.\n*Для повышения уровня необходимо освободить ещё %i игроков!", level, 50 - score);
						else format(string,sizeof(string),"*Ваш уровень опыта по профессии адвокат = 5.");
						SPD(playerid, D_SKILL+1, DIALOG_STYLE_MSGBOX, "SKILL", string, "НАЗАД", "Закрыть");
					}
					
					case 2: {
						new score = Pl::Info[playerid][pSkill][1];
						new level = GetSkillLevel(playerid, 1);
						if(level < 5) format(string,sizeof(string),"*Ваш уровень опыта по профессии шлюха = %i.\n*Для повышения уровня необходимо обслужить ещё %i клиентов!", level, 50 - score);
						else format(string,sizeof(string),"*Ваш уровень опыта по профессии шлюха = 5.");
						SPD(playerid, D_SKILL+1, DIALOG_STYLE_MSGBOX, "SKILL", string, "НАЗАД", "Закрыть");
					}
					
					case 3: {
						new score = Pl::Info[playerid][pSkill][7];
						new level = GetSkillLevel(playerid, 7);
						if(level < 5) format(string,sizeof(string),"*Ваш уровень опыта по профессии наркодилер = %i.\n*Для повышения уровня необходимо совершить ещё %i сделок!", level, 50 - score);
						else format(string,sizeof(string),"*Ваш уровень опыта по профессии наркодилер = 5.");
						SPD(playerid, D_SKILL+1, DIALOG_STYLE_MSGBOX, "SKILL", string, "НАЗАД", "Закрыть");
					}
					
					case 4: {
						new score = Pl::Info[playerid][pSkill][4];
						new level = GetSkillLevel(playerid, 4);
						if(level < 5) format(string,sizeof(string),"*Ваш уровень опыта по профессии автоугонщик = %i.\n*Для повышения уровня необходимо продать ещё %i машин!", level, 50 - score);
						else format(string,sizeof(string),"*Ваш уровень опыта по профессии автоугонщик = 5.");
						SPD(playerid, D_SKILL+1, DIALOG_STYLE_MSGBOX, "SKILL", string, "НАЗАД", "Закрыть");
					}
					
					case 5:	{
						new score = Pl::Info[playerid][pSkill][6];
						new level = GetSkillLevel(playerid, 6);
						if(level < 5) format(string,sizeof(string),"*Ваш уровень опыта по профессии репортер = %i.\n*Для повышения уровня необходимо опубликовать ещё %i новостей в /news!", level, 50 - score);
						else format(string,sizeof(string),"*Ваш уровень опыта по профессии репортер = 5.");
						SPD(playerid, D_SKILL+1, DIALOG_STYLE_MSGBOX, "SKILL", string, "НАЗАД", "Закрыть");
					}
					
					case 6: {
						new score = Pl::Info[playerid][pSkill][3];
						new level = GetSkillLevel(playerid, 3);
						if(level < 5) format(string,sizeof(string),"*Ваш уровень опыта по профессии механик = %i.\n*Для повышения уровня необходимо починить/заправить ещё %i машин!", level, 50 - score);
						else format(string,sizeof(string),"*Ваш уровень опыта по профессии механик = 5.");
						SPD(playerid, D_SKILL+1, DIALOG_STYLE_MSGBOX, "SKILL", string, "НАЗАД", "Закрыть");
					}
					
					case 7: {
						new score = Pl::Info[playerid][pSkill][5];
						new level = GetSkillLevel(playerid, 5);
						if(level < 5) format(string,sizeof(string),"*Ваш уровень опыта по профессии автодилер = %i.\n*Для повышения уровня необходимо оформить ещё %i автомобилей!", level, 50 - score);
						else format(string,sizeof(string),"*Ваш уровень опыта по профессии автодилер = 5.");
						SPD(playerid, D_SKILL+1, DIALOG_STYLE_MSGBOX, "SKILL", string, "НАЗАД", "Закрыть");
					}
				}
			}
		}
		
		case D_SKILL+1 : {
			if(response) {
				ShowDialog(playerid, D_SKILL, DIALOG_STYLE_LIST, ""#__SERVER_PREFIX""#__SERVER_NAME_LC": SKILL", "dialog/skill.txt", "Выбор","Отмена");
			}
		}
		
		case D_SPAWN : {
			if(response) {
				Pl::Info[playerid][pOrigin] = listitem ? 2 : 1; 
				Pl::SetSpawnInfo(playerid);
				format(string, sizeof string, "* Вы будите спавнится в отеле %s.", listitem ? ("Лас Вентураса") : ("Jefferson"));
				Send(playerid, COLOR_LIGHTBLUE, string);
			}
		}

		case D_SERVICE : {
			if(response) {
				switch(listitem) {
					case 0: {
						if(!TaxiDrivers) return Send(playerid, COLOR_GREY, "Нет свободных таксистов!");
						if(TransportDuty[playerid] > 0) return Send(playerid, COLOR_GREY, "Вы уже вызвали такси!");
						format(string, sizeof(string), "[ВЫЗОВ] Клиент %s. Сообщение: %s  (( Введите /accept taxi ))", GetName(playerid), inputtext);
						sendToFamily(TEAM_TAXI, COLOR_AZTECAS, string);
						Send(playerid, COLOR_LIGHTBLUE, "* Вы позвали Таксиста, ждите ответа.");
						TaxiCall = playerid;
					}
					
					case 1: {
						if(!Medics) return Send(playerid, COLOR_GREY, "Нет свободных медиков!");
						if(Iter::Count(MedicCalls)) {
							if(Iter::Contains(MedicCalls, playerid)) {
								Send(playerid, COLOR_GREY, "* Вы уже вызвали медика!");
							}
						} else {
							format(string, sizeof(string), "[ВЫЗОВ] Клиент %s. Сообщение: %s  ((Введите /accept medic))", GetName(playerid), inputtext);
							sendToFamily(TEAM_MEDIC, COLOR_AZTECAS, string);
							Send(playerid, COLOR_LIGHTBLUE, "* Вы позвали Санитара, ждите ответа.");
							Iter::Add(MedicCalls, playerid);
						}
					}
					
					case 2: {
						if(!Mechanics) return Send(playerid, COLOR_GREY, "Нет свободных механиков!");
						if(Iter::Count(MechanicCalls)) {
							if(Iter::Contains(MechanicCalls, playerid)) {
								Send(playerid, COLOR_GREY, "* Вы уже вызвали механика!");
							}
						} else {
							format(string, sizeof(string), "[ВЫЗОВ] Клиент %s. Сообщение: %s  (( Введите /accept mechanic ))", GetName(playerid), inputtext);
							SendJobMessage(JOB_MECHANIC, COLOR_AZTECAS, string);
							Send(playerid, COLOR_LIGHTBLUE, "* Вы позвали Автомобильного Механика, ждите ответа.");
							Iter::Add(MechanicCalls, playerid);
						}
					}
				}
			}
		}
	}
	
	return 1;
}

public: Gm::Thread() {
	static advTimer;
	if(++advTimer >= ADV_TIME) {
		advTimer = 0;
		SendToAll(COLOR_LIGHTGREEN,"На сервере "#__SERVER_PREFIX""#__SERVER_NAME_LC" запрещено: ДБ, ДМ, Флуд, Читы, CLEO скрипты, Капс, Розжиг межрасовой розни");
		SendToAll(COLOR_LIGHTBLUE,"Все интересующие вас вопросы, касающиеся игры вы найдете на нашем форуме: "#__SERVER_SITE"");
		SendToAll(COLOR_DBLUE,"Если вас оскорбили, унизили, убили без причины, либо вы увидели читера или того, кто нарушает правила - то пишите /report [id] жалоба.");
	}

	static syncTimer;
	if(++syncTimer >= 60) {
		syncTimer = 0;
		new h, m, s;
		new currtime = gettime(h, m, s);
		FixHour(h);
		h = shifthour;
		
		format(temp, sizeof temp, "~w~%02i:%02i", h, m);
		Td::SetString(Time, temp);
		foreach(new i : Player) {
			if(Pl::isLogged(i)) {
				Td::ShowForPlayer(i, Time);
			}
		}
		
		if((h > ghour) || (h == 0 && ghour == 23)) {
			ghour = h;
			SetWorldTime(h);
			format(temp, sizeof(temp), "*"#__SERVER_PREFIX""#__SERVER_NAME_LC": сейчас %d:00 часа(ов).", h);
			SendToAll(COLOR_WHITE, temp);
			SetTimer("onPayDay", 555, false);
			
			format(query, sizeof query, "SELECT `ip` FROM `"#__TableBanned__"` WHERE `unbandate` <= '%i'", currtime);
			Db::tquery(connDb, query, "ClearBanList", "i", currtime);
			
			foreach(new i : Frac) {
				FracPay[i] = 0;
			}
		}
		if(h == 4 && m == 0) {
			print(" Объявление: через 1 час будет произведен автоматический рестарт сервера");
			SendToAll(COLOR_LIGHTRED, " Объявление: через 1 час будет произведен автоматический рестарт сервера!");
		}
		if(h == 5 && m == 0) {
			Gm::Info[Gm::isAutoRest] = 1;
			print(" Внимание: автоматический рестарт сервера");
			SendToAll(COLOR_LIGHTRED, "Внимание: автоматический рестарт сервера!");
			SetTimerEx("GameModeInitExitFunc", 2000, false, "i", Gm::Info[Gm::isAutoRest]);
		}
	}
	
	static gainsTime[2];
	if(++gainsTime[0] >= GAINS_TIME) {
		gainsTime[0] = 0;
		new cash, totalgains[MAX_FRAC];
		
		foreach(new i : Biznes) {
			if(BizzInfo[i][bOwned] == 1) {
				cash = floatround(PERCENT(BizzInfo[i][bProfit], 10));
				if(cash > 0) {
					BizzInfo[i][bSafe] -= cash;
					totalgains[BizzInfo[i][bFrac]] += cash;
				}
			}
		}
		
		for(new i; i < sizeof Gangs; i++) {
			GiveFracMoney(Gangs[i], totalgains[Gangs[i]]);
			foreach(new p : TeamPlayers[Gangs[i]]) {
				format(temp, sizeof(temp), "~r~%s~n~Gains ~g~$%i", GetGangName(Gangs[i]), totalgains[Gangs[i]]);
				GameTextForPlayer(p, temp, 5000, 1);
			}
		}
		
		if(++gainsTime[1] == 4) {
			gainsTime[1] = 0;
			foreach(new i : Biznes) {
				BizzInfo[i][bProfit] = 0;
			}
		}
	}

	foreach(new vehicleid : enginedVehicles) {
		new driver = GetVehicleDriver(vehicleid);
		if(driver != INVALID_PLAYER_ID) {
			if(!AFKInfo[driver][afk_State]) {
				new speed = Rac::GetPlayerSpeed(driver);
				if(speed > 0) {
					new Float:rate = (speed / 1.6 / 1609.344);
					AutoInfo[vehicleid][aFuel] -= (speed > 110) ? (rate + speed / 1609.344) : (rate);
					if(AutoInfo[vehicleid][aFuel] < 1.0) {
						AutoInfo[vehicleid][aFuel] = 0.0;
						switch(GetVehicleType(GetVehicleModel(vehicleid))) {
							case VEHICLE_TYPE_BIKE, VEHICLE_TYPE_AUTO : {
								isEngined{vehicleid} = false;
								GetVehicleParamsEx(vehicleid,engine,light,alarm,doors,bonnet,boot,objective);
								SetVehicleParamsEx(vehicleid,false,light,alarm,doors,bonnet,boot,objective);
							}
						}
						new next;
						Iter::SafeRemove(enginedVehicles, vehicleid, next);
						vehicleid = next;
					}
				} else {
					goto mark;
				}
			}
		} else {
			mark:
			AutoInfo[vehicleid][aUpdate] ++;
			if(AutoInfo[vehicleid][aUpdate] >= 25) {
				AutoInfo[vehicleid][aFuel] -= 0.5;
				AutoInfo[vehicleid][aUpdate] = 0;
				if(AutoInfo[vehicleid][aFuel] < 1.0) {
					AutoInfo[vehicleid][aFuel] = 0.0;
					switch(GetVehicleType(GetVehicleModel(vehicleid))) {
						case VEHICLE_TYPE_BIKE, VEHICLE_TYPE_AUTO : {
							isEngined{vehicleid} = false;
							GetVehicleParamsEx(vehicleid,engine,light,alarm,doors,bonnet,boot,objective);
							SetVehicleParamsEx(vehicleid,false,light,alarm,doors,bonnet,boot,objective);
						}
					}
					new next;
					Iter::SafeRemove(enginedVehicles, vehicleid, next);
					vehicleid = next;
				}
			}
		}
	}
	
    foreach(new p : Player) {
		if(Pl::Info[p][pWait] > 0) {
			if(--Pl::Info[p][pWait] == 0) {
				GetPlayerName(p, plname, 24);
				if((Pl::Info[p][pID] = GetIDFromName(plname)) != -1) {
					if(!CheckBan(p)) {
						ShowLoginForm(p, 1);
					} else {
						Kick(p);
					}
				} else {
					if(Gm::Info[Gm::EnableReg]) {
						if(regex_match_exid(plname, ValidRPName)) {
							ShowLoginForm(p, 2);
						} else {
							Send(p, COLOR_LIGHTRED, "Ваш ник не соответствует правилам нашего сервера");
							Send(p, COLOR_LIGHTBLUE, "Измените свой ник по типу: Имя_Фамилия. Например: Ivan_Petrov");
							Kick(p);
						}
					} else {
						ShowDialog(p, D_NONE, 0, ""#__SERVER_PREFIX""#__SERVER_NAME_C" REGISTRATION", "dialog/noregged.txt", "OK", "");
						Kick(p);
					}
				}
			}
		} else {
			if(Pl::isLogged(p)) {
				Update(p);
				UnJailPlayer(p);
				playerAFKUpdate(p);
				vehicleStatusUpdate(p);
				playerSpectateUpdate(p);
				PoppyCollection(p);
				OnPlayerPickupExit(p);
			}
		}
    }
}

stock vehicleStatusUpdate(playerid) {
	static string[255];
	new model, vehicle, speed, Float:health;
	
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) {
		vehicle = GetPlayerVehicleID(playerid);
		model = GetVehicleModel(vehicle);
		switch(GetVehicleType(model)) {
			case VEHICLE_TYPE_UNKNOWN : {
			}
			
			case VEHICLE_TYPE_BIKE, VEHICLE_TYPE_AUTO : {
				if(isEngined{vehicle}) {
					GetVehicleHealth(vehicle, health);
					if(health < 450 || AutoInfo[vehicle][aFuel] < 1.0) {
						ToggleVehicleEngine(vehicle, 0);
						format(string, sizeof string, "* Двигатель заглох");
						ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
						GameTextForPlayer(playerid, (health<450)?("~n~~n~~n~~n~~n~~n~~w~C‡OMAHO"):("~n~~n~~n~~n~~n~~n~~w~HET ЂEH€…HA"), 7000, 5);
					}
				}
				
				speed = Rac::GetPlayerSpeed(playerid, false);
				if(!AFKInfo[playerid][afk_State] && speed > 0) {
					AutoInfo[vehicle][aMileage] += speed / 1.6 / 1609.344;
				}
				format(string, sizeof string, "~w~VEHICLE: ~g~%s [id: %i]      %.1f (miles)", VehicleNames[model-400], model, AutoInfo[vehicle][aMileage]);
				if(model == 482 && isTeamVehicle(TEAM_RIFA, vehicle)) {
					scf(string, temp, "      MATS: ~r~%i/%i", AutoInfo[vehicle][aMats], AutoInfo[vehicle][aMaxMats]);
				} else if(IsACompTruck(vehicle)) {
					scf(string, temp, "      PRODS: ~r~%i/%i", PlayerHaul[vehicle-comptruck[0]][pLoad], PlayerHaul[vehicle-comptruck[0]][pCapasity]);
				} else if(isTeamVehicle(TEAM_FARMERS, vehicle)) {
					scf(string, temp, "      MAK: ~r~%i/%i", AutoInfo[vehicle][aDrugs], AutoInfo[vehicle][aMaxDrugs]);
				}
				updateBenzinTD(playerid, vehicle);
			}
			
			default : {
				format(string, sizeof string,"~w~VEHICLE: ~g~%s [id: %i]", VehicleNames[model-400], model, AutoInfo[vehicle][aMileage]);
			}
		}
		Pt::SetString(playerid, Pt::Name[playerid], string);
		Pt::SetString(playerid, Pt::Status[playerid], (gCarLock{vehicle})?("~r~Lock"):("~w~Lock"));
	}
	return 1;
}

stock PoppyCollection(i) {
	if(Pl::FracID(i) == TEAM_FARMERS) {
		if(IsPlayerInDynamicArea(i, Area::poppyField)) {
			new vehid = GetPlayerVehicleID(i);
			if(vehid && GetVehicleModel(vehid) == 532) {
				if(Rac::GetPlayerSpeed(i) > 0) {
					if(AutoInfo[vehid][aDrugs] != AutoInfo[vehid][aMaxDrugs]) {
						AutoInfo[vehid][aDrugs] ++;
					}
				}
			}
		}
	}
}

stock UnJailPlayer(i) {
	if(Pl::Info[i][pJailed] > 0 && AFKInfo[i][afk_Time][0] < AFK_TEXT_SET) {
		if(Pl::Info[i][pJailTime] != 0) {
			Pl::Info[i][pJailTime]--;
			if(Pl::Info[i][pJailTime] <= 0) {
				Pl::SetFracColor(i);
				ClearCrime(i);
				UnJail(i, Pl::Info[i][pJailed]);
				Send(i, COLOR_GRAD1,"* Вы заплатили свой долг обществу.");
				format(temp, sizeof(temp), "~g~Freedom~n~~w~Try to be a better citizen");
				GameTextForPlayer(i, temp, 5000, 1);
			}
		}
	}

	if(WantLawyer[i] >= 1) {
		CallLawyer[i] = 111;
		switch(WantLawyer[i]++) {
			case 1, 8, 15 : Send(i, COLOR_LIGHTRED, "Вы хотите Адвоката? (пишите yes (если нужен) или no (если не нужен) )");
			case 20 : {
				Send(i, COLOR_LIGHTRED, "Адвоката нету. Тюремное заключение началось.");
				WantLawyer[i] = 0;
				CallLawyer[i] = 0;
			}
		}
	}
}

#if defined __rac_included
public onPlayerKick(playerid, reason[], reasonid) {
	GetPlayerName(playerid, plname, 24);
	format(temp, sizeof temp, "[античит] * %s[%i] был кикнут, причина: %s || AC%s", plname, playerid, reason, reasonid == R_NONE ? ("#0000") : R::Info[reasonid]);
	foreach(new i : AdminPlayers) {
		if(playerid != i) {
			if(Pl::isAdmin(i, 1)) {
				Send(i, COLOR_LIGHTRED, temp);
			}
		}
	}
	SendLog(LOG_ANTICHEAT, temp);
	
	return 1;
}

public onPlayerBan(playerid, reason[], reasonid) {
	GetPlayerName(playerid, plname, 24);
	format(temp, sizeof temp, "[античит] * %s[%i] был забанен, причина: %s || AC%s", plname, playerid, reason, reasonid == R_NONE ? ("#0000") : R::Info[reasonid]);
	foreach(new i : AdminPlayers) {
		if(playerid != i) {
			if(Pl::isAdmin(i, 1)) {
				Send(i, COLOR_LIGHTRED, temp);
			}
		}
	}
	SendLog(LOG_ANTICHEAT, temp);
	
	return 1;
}
#endif


public OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart) {
	GMTest{playerid} = false;
}

public OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid, bodypart) {
	if(InAntiDmZone{playerid}) {
		AnimClear[playerid] = 4;
		ApplyAnimation(playerid, "FAT","IDLE_tired", 4.1, 1, 1, 1, 1, 0);
		if(Rac::IsPlayerControllable(playerid)) {
			SetTimerEx(""#Rac::"TogglePlayerControllable", 7000, false, "ii", playerid, 1);
		}
	} else {
		static olddamage[MAX_PLAYERS];
		new currdamage = GetTickCount();
		if((currdamage - olddamage[playerid]) >= 900) {
			olddamage[playerid] = currdamage;
			
			switch(weaponid) {
				case 33, 34 : {
					if(bodypart == BODY_PART_HEAD) {
						SetPlayerDamage(playerid, damagedid, Float:INFINITY, weaponid);
					}
				}
				default : {
					SetPlayerDamage(playerid, damagedid, amount, weaponid);
				}
			}
		}
	}
}

stock SetPlayerDamage(playerid, damagedid, Float:damage, reason) {
	new Float:health, Float:armour;
	GetPlayerHealth(damagedid, health);
	GetPlayerArmour(damagedid, armour);
	
	if(armour > 0) {
		armour -= damage;
		if(armour < 0) {
			health -= -armour;
			if(health < 1) {
				SyncInfo[damagedid][sKillerID] = playerid;
				SyncInfo[damagedid][sReasonID] = reason;
			}
		}
		Rac::SetPlayerArmour(damagedid, armour);
		Rac::SetPlayerHealth(damagedid, health);
	}
	
	else if(health > 0) {
		health -= damage;
		if(health < 1) {
			SyncInfo[damagedid][sKillerID] = playerid;
			SyncInfo[damagedid][sReasonID] = reason;
		}
		Rac::SetPlayerArmour(damagedid, armour);
		Rac::SetPlayerHealth(damagedid, health);
	}
	return 1;
}

public OnPlayerUpdate(playerid) {
	static string[125];

	AFKInfo[playerid][afk_Time][0] = 0;
	if(AFKInfo[playerid][afk_State] != 0) {
		AFKInfo[playerid][afk_State] = 0;
		Delete3DTextLabel(AFKInfo[playerid][afk_Text]);
		CallLocalFunction("OnPlayerAFK", "iii", playerid, 0, 1);
	}
	
	switch(Rac::GetPlayerState(playerid)) {
		case PLAYER_STATE_DRIVER : {
			new vehicle = GetPlayerVehicleID(playerid);
			new speed = Rac::GetPlayerSpeed(playerid, false);
			if(speed > AutoInfo[vehicle][aLimit]) {
				Rac::SetVehicleSpeed(vehicle, AutoInfo[vehicle][aLimit]);
				speed = AutoInfo[vehicle][aLimit];
			}
			format(string, sizeof string, "%03i km'h", speed);
			Pt::SetString(playerid, Pt::Speed[playerid][2], string);
			UpdateSpeedometer(playerid, speed);
		}
	}

	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid) {
	if(Rac::IsValidState(forplayerid) && Rac::IsValidState(playerid)) {
		new fracid = Pl::FracID(forplayerid);
		if(Bl::Info[playerid][Bl::onFrac][fracid] && Bl::Info[forplayerid][Bl::Observe] == INVALID_PLAYER_ID) {
			if(Bl::Info[playerid][Bl::Finder] == INVALID_PLAYER_ID) {
				Bl::Info[playerid][Bl::Finder] = forplayerid;
				Bl::Info[forplayerid][Bl::Observe] = playerid;
				GetPlayerPos(playerid, posx, posy, posz);
				switch(GetPlayerState(playerid)) {
					case PLAYER_STATE_ONFOOT : {
						Bl::Info[forplayerid][Bl::Marker] = CreateDynamicCP(posx, posy, posz, 1.6, -1, -1, forplayerid, 200.0);
					}
					case PLAYER_STATE_DRIVER, PLAYER_STATE_PASSENGER : {
						new vehid = GetPlayerVehicleID(playerid);
						GetVehicleParamsEx(vehid, engine, light, alarm, doors, bonnet, boot, objective);
						SetVehicleParamsEx(vehid, engine, light, alarm, doors, bonnet, boot, true);
					}
				}
				getname(playerid -> plname, forplayerid -> temp);
				format(src, sizeof(src), "[BLACK LIST] Вы были замечены, %s %s [%s]", RankInfo[fracid][Pl::Info[forplayerid][pRank]], temp, FracInfo[fracid][fName]);
				Send(playerid, COLOR_AZTECAS, src);
				format(src, sizeof(src), "[BLACK LIST] Появился запашок черта, %s %s заметил %s", RankInfo[fracid][Pl::Info[forplayerid][pRank]], temp, plname);
				sendToFamily(fracid, COLOR_AZTECAS, src);
			} else {
				GetPlayerPos(playerid, posx, posy, posz);
				Bl::Info[forplayerid][Bl::Observe] = playerid;
				switch(GetPlayerState(playerid)) {
					case PLAYER_STATE_ONFOOT : {
						Bl::Info[forplayerid][Bl::Marker] = CreateDynamicCP(posx, posy, posz, 1.6, -1, -1, forplayerid, 200.0);
					}
				}
			}
		}
	}
	
	if(GetPlayerState(forplayerid) == PLAYER_STATE_SPECTATING) {
		Iter::Add(inStreamPlayers[playerid], forplayerid);
	}
	
	ShowPlayerNameTagForPlayer(forplayerid, playerid, !Pl::Info[playerid][pMaskOn]);
	Iter::Add(inStreamPlayers[forplayerid], playerid);
}

public OnPlayerStreamOut(playerid, forplayerid) {
	if(Rac::IsValidState(forplayerid) && Bl::ValidState(playerid)) {
		new fracid = Pl::FracID(forplayerid);
		if(Bl::Info[playerid][Bl::onFrac][fracid]) {
			if(!Bl::Info[playerid][Bl::isKilled]) {
				if(Bl::Info[playerid][Bl::Finder] == forplayerid) {
					Bl::Info[playerid][Bl::Finder] = INVALID_PLAYER_ID;
					GetPlayerName(playerid, plname, 24);
					Send(playerid, COLOR_AZTECAS, "[BLACK LIST] Вам удалось скрытся!");
					format(temp, sizeof temp, "[BLACK LIST] След был упущен, %s скрылся", plname);
					sendToFamily(fracid, COLOR_AZTECAS, temp);
				}
			} else {
				Bl::Info[playerid][Bl::isKilled] = false;
			}
		}
	}
	
	if(GetPlayerState(forplayerid) == PLAYER_STATE_SPECTATING) {
		Iter::Remove(inStreamPlayers[playerid], forplayerid);
	}
	
	Iter::Remove(inStreamPlayers[forplayerid], playerid);
}

public: AddsOn() adds = true;
public: onUseBannyHop(playerid) useBannyHop{playerid} = false;

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys) {
	#define wait(%0); if(!Wait{%0}){Wait{%0} = 1;}else{return 1;}

	if((newkeys & KEY_FIRE) || (newkeys & KEY_JUMP) || (newkeys & KEY_SECONDARY_ATTACK) || (newkeys & KEY_SUBMISSION)) {
		if(KG[playerid][0]) {
			KG[playerid][0] = 0;
			Send(playerid, COLOR_BLUE, "* Вы уронили мешок");
			if(IsPlayerAttachedObjectSlotUsed(playerid,1)) {
				RemovePlayerAttachedObject(playerid,1);
			}
		}
	}

	if(!useBannyHop{playerid}) {
		if(PRESSED(KEY_SPRINT|KEY_JUMP)) {
			if(GetPlayerVehicleID(playerid) == 0) {
				useBannyHop{playerid} = true;
				SetTimerEx("onUseBannyHop", 1000, false, "i", playerid);
				ApplyAnimation(playerid, "PED", "GETUP_FRONT", 4.0, 0, 1, 1, 0, 0);
			}
			return 1;
		}
	}
	
	if((newkeys & KEY_JUMP) && !(oldkeys & KEY_JUMP)) {
		if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_CUFFED) {
			return ApplyAnimation(playerid, "GYMNASIUM", "gym_jog_falloff",4.1,0,1,1,0,0);
		}
	}

	if(PRESSED(KEY_CROUCH)) {
		wait(playerid);
		
		switch(GetPlayerState(playerid)) {
			case PLAYER_STATE_DRIVER : {
				new veh = GetPlayerVehicleID(playerid);
				if(IsPlayerInHouseGarage(playerid)) {
					new Float:x, Float:y;
					new local = Pl::Info[playerid][pLocal] - OFFSET_HOUSE;
					Pl::Info[playerid][pLocal] = 0;
					GetXYInFrontOfPoint(x, y, HouseInfo[local][hgStreetPos][3], vehicleSize(veh));
					Rac::SetVehiclePos(veh, HouseInfo[local][hgStreetPos][0] + x, HouseInfo[local][hgStreetPos][1] + y, HouseInfo[local][hgStreetPos][2]);
					SetVehicleZAngle(veh, HouseInfo[local][hgStreetPos][3]);
					LinkVehicleToInterior(veh, 0);
					SetVehicleVirtualWorld(veh, 0);
					Rac::SetPlayerInterior(playerid, 0);
					Rac::SetPlayerVirtualWorld(playerid, 0);
					SetCameraBehindPlayer(playerid);
					
					foreach(new i : vehiclePassengers[veh]) {
						if(GetPlayerState(i) == PLAYER_STATE_PASSENGER) {
							Rac::SetPlayerInterior(i, 0);
							Rac::SetPlayerVirtualWorld(i, 0);
							SetCameraBehindPlayer(i);
						}
					}
				} else {
					foreach(new i : Houses) {
						if(IsPlayerInRangeOfPoint(playerid, 10.0, HouseInfo[i][hgStreetPos][0], HouseInfo[i][hgStreetPos][1], HouseInfo[i][hgStreetPos][2])) {
							if(Pl::Info[playerid][pHouseKey] != HouseInfo[i][hID]) return Send(playerid, COLOR_GREY, "* У Вас нет ключей!");
							Pl::Info[playerid][pLocal] = OFFSET_HOUSE + i;
							Rac::SetVehiclePos(veh, 616.0352, -124.1155, 997.7648);
							SetVehicleZAngle(veh, 90.1765);
							LinkVehicleToInterior(veh, 3);
							SetVehicleVirtualWorld(veh, HouseInfo[i][hVirtual]);
							Rac::SetPlayerInterior(playerid, 3);
							Rac::SetPlayerVirtualWorld(playerid, HouseInfo[i][hVirtual]);
							SetCameraBehindPlayer(playerid);
							
							foreach(new j : vehiclePassengers[veh]) {
								if(GetPlayerState(j) == PLAYER_STATE_PASSENGER) {
									Rac::SetPlayerInterior(j, 3);
									Rac::SetPlayerVirtualWorld(j, HouseInfo[i][hVirtual]);
									SetCameraBehindPlayer(j);
								}
							}
							return 1;
						}
					}
				}
			}
		}
		return 1;
	}
	
	if(PRESSED(KEY_AIM) && GetPlayerWeapon(playerid) == 0) {
		wait(playerid);
		
		switch(Rac::GetPlayerState(playerid)) {
			case PLAYER_STATE_ONFOOT : {
				new c = ClosestVeh(playerid, 5.1);
				if(c != INVALID_VEHICLE_ID) {
					GetCoordVehicleParams(c, 3, vehx, vehy, vehz);
					if(IsPlayerInRangeOfPoint(playerid, 1.5, vehx, vehy, vehz)) {
						VehicleBoot{c} = !VehicleBoot{c};
						GetVehicleParamsEx(c,engine,light,alarm,doors,bonnet,boot,objective);
						SetVehicleParamsEx(c,engine,light,alarm,doors,bonnet,VehicleBoot{c},objective);
					} else {
						GetCoordVehicleParams(c, 2, vehx, vehy, vehz);
						if(IsPlayerInRangeOfPoint(playerid, 1.4, vehx, vehy, vehz)) {
							VehicleBonnet{c} = !VehicleBonnet{c};
							GetVehicleParamsEx(c,engine,light,alarm,doors,bonnet,boot,objective);
							SetVehicleParamsEx(c,engine,light,alarm,doors,VehicleBonnet{c},boot,objective);
						}
					}
					if(Pl::Info[playerid][pJob] == 6) {
						switch(GetVehicleType(GetVehicleModel(c))) {
							case VEHICLE_TYPE_BIKE, VEHICLE_TYPE_AUTO : {
								if(JobWaitTime[playerid] != 0) return Send(playerid, COLOR_GREY, "* Невозможно чинить/заправлять слишком часто, качайте скилл!");
					
								new Float:fuel, found;
								if(!IsAMehCar(c)) {
									foreach(new i : JobVehicles[JOB_MECHANIC]) {
										if(IsVehicleClosestForPlayer(playerid, i, 20.0)) {
											found=1;
											Pl::Info[playerid][pSkill][3] ++;
											switch(Pl::Info[playerid][pSkill][3]) {
												case 50 : Send(playerid, COLOR_YELLOW, "* Ваш Автомобильный Навык Механика - теперь Уровень 2, Вы можете добавить больше Топлива к любым Автомобилям Игроков.");
												case 100 : Send(playerid, COLOR_YELLOW, "* Ваш Автомобильный Навык Механика - теперь Уровень 3, Вы можете добавить больше Топлива к любым Автомобилям Игроков.");
												case 200 : Send(playerid, COLOR_YELLOW, "* Ваш Автомобильный Навык Механика - теперь Уровень 4, Вы можете добавить больше Топлива к любым Автомобилям Игроков.");
												case 400 : Send(playerid, COLOR_YELLOW, "* Ваш Автомобильный Навык Механика - теперь Уровень 5, Вы можете добавить больше Топлива к любым Автомобилям Игроков.");
											}
											break;
										}
									}
								} else {
									found=1;
								}
								if(found) {
									switch(Pl::Info[playerid][pSkill][3]) {
										case 0..50		: fuel = 15.0, JobWaitTime[playerid] = 120;
										case 51..100	: fuel = 25.0, JobWaitTime[playerid] = 80;
										case 101..200	: fuel = 35.0, JobWaitTime[playerid] = 60;
										case 201..300 	: fuel = 45.0, JobWaitTime[playerid] = 40;
										case 301..400 	: fuel = 55.0, JobWaitTime[playerid] = 30;
										case 401..501 	: fuel = 65.0, JobWaitTime[playerid] = 20;
										default 		: fuel = 65.0, JobWaitTime[playerid] = 20;
									}

									found=0;
									foreach(new p: vehiclePassengers[c]) {
										if(GetPlayerState(p) == 2) {
											found++;
											format(temp, sizeof temp, "Механик %s починил и заправил машину %s", GetName(playerid), GetName(p));
											break;
										}
									}
									
									if(AutoInfo[c][aFuel] < 100.0) AutoInfo[c][aFuel] += fuel;
									Rac::RepairVehicle(c);
									if(!found) format(temp, sizeof temp, "Автомеханик %s починил и заправил машину", GetName(playerid));
									ProxDetector(15.0, playerid, temp, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
								} else {
									Send(playerid, COLOR_GREY, "* Рядом с вами нет машины механика!");
								}
							}
						}
					}
				}
			}
		}
		return 1;
	}
	
	if(PRESSED(KEY_FIRE)) {
		wait(playerid);
		
		switch(Rac::GetPlayerState(playerid)) {
			case PLAYER_STATE_ONFOOT : {
				if(Pl::CuffedTime[playerid] > 0) {
					AnimClear[playerid] = 4;
					ApplyAnimation(playerid, "FAT","IDLE_tired", 4.1, 1, 1, 1, 1, 0);
					if(Rac::IsPlayerControllable(playerid)) {
						SetTimerEx(""#Rac::"TogglePlayerControllable", 7000, false, "ii", playerid, 1);
					}
				}
			}
			case PLAYER_STATE_DRIVER : {
				new vehid = GetPlayerVehicleID(playerid);
				switch(GetVehicleType(GetVehicleModel(vehid))) {
					case VEHICLE_TYPE_BIKE, VEHICLE_TYPE_AUTO : {
						if(AutoInfo[vehid][aFuel] < 1.0) {
							Send(playerid,COLOR_WHITE,"* Вызовите механика, нет топлива! (/service)");
							format(src, sizeof(src), "* %s попытался завести двигатель (неудачно)", GetName(playerid));
							ProxDetector(20.0, playerid, src, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
							GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~w~HET ЂEH€…HA", 5000, 5);
						} else if(Rac::GetVehicleHealth(vehid) < 450) {
							Send(playerid,COLOR_WHITE,"* Вызовите механика, машина повреждена! (/service)");
							format(src, sizeof(src), "* %s попытался завести двигатель (неудачно)", GetName(playerid));
							ProxDetector(20.0, playerid, src, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
							GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~w~C‡OMAHO", 7000, 5);
						} else {
							ToggleVehicleEngine(vehid, !isEngined{vehid});
							SetPlayerChatBubble(playerid, isEngined{vehid} ? ("завел двигатель") : ("заглушил двигатель"), COLOR_YELLOW, 30.0, 5000);
							GameTextForPlayer(playerid, isEngined{vehid} ? ("~w~ENGINE ~g~ON") : ("~w~ENGINE ~R~OFF"), 5000, 6);
						}
					}
				}
			}
		}
		return 1;
	}
	
	if(PRESSED(KEY_ACTION)) {
		wait(playerid);
	
		switch(GetPlayerState(playerid)) {
			case PLAYER_STATE_DRIVER : {
				new veh = GetPlayerVehicleID(playerid);
				switch(GetVehicleType(GetVehicleModel(veh))) {
					case VEHICLE_TYPE_BIKE, VEHICLE_TYPE_AUTO : {
						VehicleLight{veh} = !VehicleLight{veh};
						GameTextForPlayer(playerid, VehicleLight{veh} ? ("~w~LIGHT ~g~ON") : ("~w~LIGHT ~R~OFF"), 5000, 6);
						SetPlayerChatBubble(playerid, VehicleLight{veh} ? ("включил фары") : ("выключил фары"), COLOR_YELLOW, 30.0, 5000);
						GetVehicleParamsEx(veh,engine,light,alarm,doors,bonnet,boot,objective);
						SetVehicleParamsEx(veh,engine,VehicleLight{veh},alarm,doors,bonnet,boot,objective);
					}
				}
			}
		}
		return 1;
	}
	
	if(PRESSED(KEY_LOOK_BEHIND)) {
		wait(playerid);
		
		switch(GetPlayerState(playerid)) {
			case PLAYER_STATE_ONFOOT : {
				foreach(new i : GateModeKey) {
					if(IsPlayerInRangeOfGate(playerid, 2.0, GateData[i][GateID])) {
						switch(GateData[i][GateAttach]) {
							case GATE_ATTACH_FRAC : {
								new frcaid = Pl::FracID(playerid);
								if(GateData[i][GateAllowed][frcaid] == 1) {
									if(GateOpen(GateData[i][GateID])) {
										PlayerPlaySound(playerid, 1058, 0, 0, 0);
										SetTimerEx("GateClose", 1000 * 7, false, "i", GateData[i][GateID]);
									}
								}
							}
							
							case GATE_ATTACH_HOUSE : {
								if(Pl::Info[playerid][pHouseKey] == GateData[i][GateAllowed][0]) {
									if(GateOpen(GateData[i][GateID])) {
										PlayerPlaySound(playerid, 1058, 0, 0, 0);
										SetTimerEx("GateClose", 1000 * 7, false, "i", GateData[i][GateID]);
									}
								}
							}
							
							case GATE_ATTACH_JOB : {
								if(Pl::Info[playerid][pJob] == GateData[i][GateAllowed][0]) {
									if(GateOpen(GateData[i][GateID])) {
										PlayerPlaySound(playerid, 1058, 0, 0, 0);
										SetTimerEx("GateClose", 1000 * 7, false, "i", GateData[i][GateID]);
									}
								}
							}
							
							default : {
								if(GateOpen(GateData[i][GateID])) {
									PlayerPlaySound(playerid, 1058, 0, 0, 0);
									SetTimerEx("GateClose", 1000 * 7, false, "i", GateData[i][GateID]);
								}
							}
						}
						return 1;
					}
				}
			}
		}
	}	
	return 1;
}


public OnPlayerClickPlayer(playerid, clickedplayerid, source) {
	if(Pl::isAdmin(playerid, 3)) {
		if(!TogTP{clickedplayerid} && !Pl::isAdmin(playerid, ADMINISTRATOR)) return 1;

		GetPlayerPos(clickedplayerid, posx, posy, posz);
		if(GetPlayerState(playerid) == 2) {
			Rac::SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(clickedplayerid));
			Rac::SetPlayerInterior(playerid, GetPlayerInterior(clickedplayerid));
			Rac::SetVehiclePos(GetPlayerVehicleID(playerid), posx, posy, posz);
		} else {
			Rac::SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(clickedplayerid));
			Rac::SetPlayerInterior(playerid, GetPlayerInterior(clickedplayerid));
			Rac::SetPlayerPos(playerid, posx, posy, posz+1);
		}
	}
	return 1;
}

public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ) {
	if(Pl::isAdmin(playerid, ADMINISTRATOR)) {
		if(GetPlayerState(playerid) == 2) {
			Rac::SetPlayerVirtualWorld(playerid, 0);
			Rac::SetVehiclePos(GetPlayerVehicleID(playerid), fX, fY, fZ);
		} else {
			Rac::SetPlayerInterior(playerid, 0);
			Rac::SetPlayerVirtualWorld(playerid, 0);
			Rac::SetPlayerPos(playerid, fX, fY, fZ);
			Pl::Info[playerid][pLocal] = 0;
		}
	}
	return 1;
}

stock ChangeName(playerid) {
	new oldName[MAX_PLAYER_NAME], newName[MAX_PLAYER_NAME];
	GetPlayerName(playerid, oldName, MAX_PLAYER_NAME);
	GetPVarString(playerid, "NewName", newName, MAX_PLAYER_NAME);
	DeletePVar(playerid, "NewName");
	
	if(SetPlayerName(playerid, newName) == 1) {
		new nlen = strlen(newName);
		new bidx = GetIndexFromBizID(Pl::Info[playerid][pBizKey]);
		new hidx = Pl::Info[playerid][pHouseKey];

		if(IsValidHouse(hidx)) {
			if(strcmp(oldName, HouseInfo[hidx][hOwner], false) == 0) {
				strmid(HouseInfo[hidx][hOwner], newName, 0, nlen, MAX_PLAYER_NAME);
				UpdateHouse(hidx);
			}
		}
		if(IsValidBiz(bidx)) {
			if(strcmp(oldName, BizzInfo[bidx][bOwner], false) == 0) {
				strmid(BizzInfo[bidx][bOwner], newName, 0, nlen, MAX_PLAYER_NAME);
				UpdateBizz(bidx);
			}
			
			else if(strcmp(oldName, BizzInfo[bidx][bExtortion], false) == 0) {
				strmid(BizzInfo[bidx][bExtortion], newName, 0, nlen, MAX_PLAYER_NAME);
				UpdateBizz(bidx);
			}
		}
		
		format(query, sizeof query, "UPDATE `"#__TableUsers__"` SET `Name`='%s' WHERE `ID`='%i'", newName, Pl::Info[playerid][pID]),
			Db::tquery(connDb, query, "", "");
		
		format(temp, sizeof temp, "** %s теперь изветен как %s (userid:%i)", oldName, newName, Pl::Info[playerid][pID]),
			SendLog(LOG_CHANGENAME, temp);
			
		format(temp, sizeof temp,"*"#__SERVER_PREFIX""#__SERVER_NAME_LC": %s теперь изветен как %s", oldName, newName),
			SendToAll(COLOR_LIGHTRED, temp);	
	} else {
		Send(playerid, COLOR_LIGHTRED, "* К сожалению при смене вашего ника произошла ошибка.");
		Send(playerid, COLOR_LIGHTRED, "* Обратитесь к администрации: /report");
	}
}

public OnVehicleStreamIn(vehicleid, forplayerid) {
	Iter::Add(inStreamVehicles[forplayerid], vehicleid);
	SetVehicleParamsForPlayer(vehicleid, forplayerid, 0, gCarLock{vehicleid});
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid) {
	Iter::Remove(inStreamVehicles[forplayerid], vehicleid);
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success) {
	new _ip[16];
	if(!checkvar("bind","127.0.0.1")) {
		if(success) {
			foreach(new playerid : Player) {
				GetPlayerIp(playerid, _ip, 16);
				if(!strcmp(ip, _ip, true)) {
					return 1;
				}
			}
			format(temp, sizeof temp, "banip %s", ip);
			SendRconCommand(temp);
		} else {
			foreach(new playerid : Player) {
				GetPlayerIp(playerid, _ip, 16);
				if(!strcmp(ip, _ip, true)) {
					if(++Rac::Info[playerid][Rac::BadRconLogin] >= 2) {
						Rac::Kick(playerid, "Попытка взлома RCON пароля.");
						return 0;
					} else {
						GetPlayerName(playerid, plname, 24);
						format(temp, sizeof temp, "[AdmWarn] * %s[%i] попытался залогинистся как RCON-админ!", plname, playerid);
						SendToAdmin(COLOR_YELLOW, temp, 3, 3);
						return 0;
					}
				}
			}
			format(temp, sizeof temp, "banip %s", ip);
			SendRconCommand(temp);
		}
	}
	return 1;
}

stock GiveFracMoney(fracid, amount) {
	if(IsValidFrac(fracid)) return FracInfo[fracid][fBank] += amount;
	return 0;
}

stock GetFracMoney(fracid) {
	if(IsValidFrac(fracid)) return FracInfo[fracid][fBank];
	return 0;
}

stock GivePlayerBankMoney(playerid, amount) Pl::Info[playerid][pBank] += amount;

public: ReduceTimer(playerid) ReduceTime[playerid] = 0;

public: TazerTime(playerid) PlayerUseTazed{playerid} = false;


stock IsAtATM(playerid) {
	for(new i; i < sizeof(ATMs); i++) {
		if(IsPlayerInRangeOfPoint(playerid, 2.0, ATMs[i][0], ATMs[i][1], ATMs[i][2])) {
			return 1;
		}
	}
	return 0;
}

stock GetClosestGas(playerid) {
	foreach(new i : Refills) {
		if(IsPlayerInRangeOfPoint(playerid, 8.0, RefillInfo[i][brPos][0], RefillInfo[i][brPos][1], RefillInfo[i][brPos][2])) {
			return i;
		}
	}
	return -1;
}

stock GetName(playerid) {
	static name[24];
	GetPlayerName(playerid, name, 24);
	return name;
}

stock GetPIP(playerid) {
	static pip[16];
	GetPlayerIp(playerid, pip, 16);
	return pip;
}

stock GetUserName(uid) {
	new name[24];
	format(query, sizeof query, "SELECT `Name` FROM `"#__TableUsers__"` WHERE `ID` = '%i'", uid);
	new Cache:result = Db::query(connDb, query, true);
	if(cache_get_row_count() > 0) {
		cache_get_row(0, 0, name);
	} else {
		strmid(name, "-", 0, 1, 24);
	}
	cache_delete(result);
	return name;
}

stock GetGangName(gangid) {
	static gangname[16];
	switch(gangid) {
		case 12, 14..18 : strmid(gangname, FracInfo[gangid][fTag], 0, 16);
		default : strmid(gangname, "посторонний", 0, 16);
	}
	return gangname;
}

native gpci(playerid, serial[], maxlen=sizeof serial);
stock GetPlayerSerial(playerid) {
	static serial[54];
	gpci(playerid, serial);
	return serial;
}

stock playerAFKUpdate(playerid) {
	new paused;
	new Float:x, Float:y, Float:z;
	paused = Rac::IsPlayerInPause(playerid);
	
	GetPlayerPos(playerid, x, y, z);
	if(AFKInfo[playerid][afk_Pos] == x) {
		if(paused) {
			AFKInfo[playerid][afk_Time][0] ++;
			AFKInfo[playerid][afk_Time][1] = 0;
		} else {
			AFKInfo[playerid][afk_Time][1] ++;
		}
	} else {
		if(!paused) {
			AFKInfo[playerid][afk_Time][0] = 0;
			AFKInfo[playerid][afk_Time][1] = 0;
			if(AFKInfo[playerid][afk_State] != 0) {
				AFKInfo[playerid][afk_State] = 0;
				Delete3DTextLabel(AFKInfo[playerid][afk_Text]);
				CallLocalFunction("OnPlayerAFK", "iii", playerid, 0, 1);
			}
		}
	}

	switch(AFKInfo[playerid][afk_State]) {
		case 0 : {
			if(paused && AFKInfo[playerid][afk_Time][0] == AFK_TEXT_SET) {
				AFKInfo[playerid][afk_State] = 1;
				CallLocalFunction("OnPlayerAFK", "ii", playerid, 1, 0);
				format(temp, sizeof temp, "{FF6347}[AFK: {ffffff}%i/%i {FF6347}секунд]", AFKInfo[playerid][afk_Time][0], MAX_AFK_TIME);
				AFKInfo[playerid][afk_Text] = Create3DTextLabel(temp, INVALID_ID, 0.00, 0.00, 10000.00, T_DIST, 0);
				Attach3DTextLabelToPlayer(AFKInfo[playerid][afk_Text], playerid, 0.0, 0.0, 0.3);
			}
			
			else if(!paused && AFKInfo[playerid][afk_Time][1] > MAX_AFK_TIME) {
				format(temp, sizeof temp,""#__SERVER_PREFIX""#__SERVER_NAME_LC": [%d]%s был кикнут сервером, причина: AFK", playerid, GetName(playerid));
				SendToAll(COLOR_GREY, temp);
				Kick(playerid);
			}
		}
		
		case 1 : {
			if(AFKInfo[playerid][afk_Time][0] > MAX_AFK_TIME) {
				if(Pl::isAdmin(playerid, ADMINISTRATOR)) {
					AFKInfo[playerid][afk_Time][0] = AFK_TEXT_SET;
					format(temp, sizeof temp, "{FF6347}[AFK: {ffffff}%i/%i {FF6347}секунд]", AFKInfo[playerid][afk_Time], MAX_AFK_TIME);
					Update3DTextLabelText(AFKInfo[playerid][afk_Text], INVALID_ID, temp);
				}
				
				else {
					format(temp, sizeof temp,""#__SERVER_PREFIX""#__SERVER_NAME_LC": [%d]%s был кикнут сервером. Причина: AFK", playerid, GetName(playerid));
					SendToAll(COLOR_GREY, temp);
					Kick(playerid);
				}
			} else {
				format(temp, sizeof temp, "{FF6347}[AFK: {ffffff}%i/%i {FF6347}секунд]", AFKInfo[playerid][afk_Time][0], MAX_AFK_TIME);
				Update3DTextLabelText(AFKInfo[playerid][afk_Text], INVALID_ID, temp);
			}
		}
	}
	
	AFKInfo[playerid][afk_Pos] = x;
}

stock UpdateGangInfo() {
	for(new p; p < sizeof(GangInfo); p++) {
		format(src, sizeof(src),
			"**GANG INFO**\n\n.::%s::.\nБизнесы: %i\nУважение: %i\nБанк: $%i\nЗахват с %i ранга",
			GetGangName(GangInfo[p][fID]),
			GangBiznes{GangInfo[p][fID]},
			GangInfo[p][gRespect],
			GetFracMoney(GangInfo[p][fID]),
			GetZRank(GangInfo[p][fID])
		);
		UpdateDynamic3DTextLabelText(GangInfo[p][gText], GetFracColor(GangInfo[p][fID]), src);
	}
	Sort::Gnome2D(GangInfo, gInfo, gRespect, Sort::METHOD_DESC);
	SaveGI();
}

stock IsAGang(playerid) {
	return (linearSearch(Gangs, Pl::FracID(playerid)) != -1);
}

stock IsAGangF(fracid) {
	return (linearSearch(Gangs, fracid) != -1);
}

stock IsAMafia(playerid) {
	return (linearSearch(Mafias, Pl::FracID(playerid)) != -1);
}

stock IsAMafiaF(fracid) {
	return (linearSearch(Mafias, fracid) != -1);
}


stock GiveGangRespect(gangid, amount) {
	for(new i; i < sizeof(GangInfo); i++) {
		if(GangInfo[i][fID] == gangid) {
			return GangInfo[i][gRespect] += amount;
		}
	}
	return 0;
}

stock SetGangRespect(gangid, amount) {
	for(new i; i < sizeof(GangInfo); i++) {
		if(GangInfo[i][fID] == gangid) {
			return GangInfo[i][gRespect] = amount;
		}
	}
	return 0;
}

stock GetPlayerOrigin(playerid) {
	new origin[24];
	switch(Pl::Info[playerid][pOrigin]) {
		case 1: strunpack(origin, !"Европа", sizeof origin);
		case 2: strunpack(origin, !"Азиа", sizeof origin);
		case 3: strunpack(origin, !"Америка", sizeof origin);
		default: strunpack(origin,!"Европпа", sizeof origin);
	}
	return origin;
}

stock GetPlayerSex(playerid) {
	new sex[10];
	switch(Pl::Info[playerid][pSex]) {
		case 1: strunpack(sex, !"Мужской", sizeof sex);
		case 2: strunpack(sex, !"Женский", sizeof sex);
		default: strunpack(sex, !"-", sizeof sex);
	}
	return sex;
}

stock GetPlayerAge(playerid) {
	new age[5];
	if(Pl::Info[playerid][pAge]) {
		format(age, sizeof age, "%i", Pl::Info[playerid][pAge]);
	} else {
		age = "-";
	}
	return age;
}

stock GetFracColor(fracid) {
	if(IsValidFrac(fracid)) {
		return FracInfo[fracid][fColor];
	}
	return COLOR_ALPHA;
}

stock GetAdminRank(admlevel) {
	new rank[16];
	switch(admlevel) {
		case 1..3: format(rank, sizeof rank, "Модератор %ilvl", admlevel);
		case 4: strunpack(rank, !"Супермодератор");
		case 5: strunpack(rank, !"Администратор");
		default: strunpack(rank, !"-");
	}
	return rank;
}

stock GetHelperRank(hlvl) {
	new hrank[16];
	switch(hlvl) {
		case 1: strunpack(hrank, !"Хелпер");
		case 2: strunpack(hrank, !"Старший Хелпер");
		case 3: strunpack(hrank, !"Главный Хелпер");
		default: strunpack(hrank, !"Хелпер");
	}
	return hrank;
}

stock Db::Init() {		
	Db::log(Db::Conf[Db::Debug] == 1 ? (LOG_ERROR | LOG_WARNING | LOG_DEBUG) : (LOG_ERROR | LOG_WARNING));
	
	connDb = Db::connect(Db::Conf[Db::Host], Db::Conf[Db::User], Db::Conf[Db::Base], Db::Conf[Db::Pass]);
	
	new errno = Db::errno();
	if(errno == 0) Db::FixCharset();
	
	return errno == 0;
}

stock LoadConf() {
	new iniFile = iniOpen("conf.ini");
	if(iniFile != INI_FILE_NOT_FOUND) {
		iniGet(iniFile, "server.hostname", Gm::Info[Gm::Hostname], 36);
		iniGet(iniFile, "server.password", Gm::Info[Gm::Password], 36);
		iniGet(iniFile, "server.mode", Gm::Info[Gm::Mode], 36);
		iniGet(iniFile, "server.map", Gm::Info[Gm::Map], 36);
		iniGetInt(iniFile, "server.status", Gm::Info[Gm::Status]);
		
		iniGet(iniFile, "mysql.host", Db::Conf[Db::Host], 128);
		iniGet(iniFile, "mysql.user", Db::Conf[Db::User], 64);
		iniGet(iniFile, "mysql.base", Db::Conf[Db::Base], 64);
		iniGet(iniFile, "mysql.pass", Db::Conf[Db::Pass], 64);
		iniGet(iniFile, "mysql.charset", Db::Conf[Db::Charset], 16);
		iniGetInt(iniFile, "mysql.debug", Db::Conf[Db::Debug]);
		iniGet(iniFile, "mysql.key_salt", Db::Conf[Db::KeySult], 32);
		
		iniClose(iniFile);
		
		return 1;
	}
	return 0;
}

stock Db::FixCharset() {
	Db::set_charset(Db::Conf[Db::Charset]);
	format(temp, sizeof temp, "SET NAMES '%s'", Db::Conf[Db::Charset]);
	Db::query(connDb, temp, false);
	Db::query(connDb, "SET SESSION character_set_server='utf8';", false);
	return 1;
}

stock Db::Prepare() {
	if(fexist("update.sql")) {
		new File:fhandle = fopen("update.sql", io_read);
		while(fread(fhandle, temp)) {
			LoadFile(temp, query);
			Db::query(connDb, query, false);
		}
		fclose(fhandle);
	}
	return 1;
}

stock SetZRank(fracid, zrank) {
	if(IsValidFrac(fracid)) {
		FracInfo[fracid][fRConf][zRANK] = zrank;
		UpdateGangInfo();
	}
	return 1;
}

stock GetZRank(fracid) {
	if(IsValidFrac(fracid)) {
		return FracInfo[fracid][fRConf][zRANK];
	}
	return 0;
}


stock SetBRank(fracid, zrank) {
	if(IsValidFrac(fracid)) {
		FracInfo[fracid][fRConf][bRANK] = zrank;
	}
	return 1;
}

stock GetBRank(fracid) {
	if(IsValidFrac(fracid)) {
		return FracInfo[fracid][fRConf][bRANK];
	}
	return 0;
}

stock SetGRank(fracid, zrank) {
	if(IsValidFrac(fracid)) {
		FracInfo[fracid][fRConf][gRANK] = zrank;
	}
	return 1;
}

stock GetGRank(fracid) {
	if(IsValidFrac(fracid)) {
		return FracInfo[fracid][fRConf][gRANK];
	}
	return 0;
}

stock Pl::isLogged(playerid) {
	return IsPlayerConnected(playerid) && PlayerLogged{playerid};
}

stock Pl::isRegged(playerid) {
	if(IsPlayerConnected(playerid)) {
		return Pl::Info[playerid][pID] == -1 ? 0 : 1;
	}
	return 0;
}

stock GameTextForGangs(const dest[], time, type, ...) {
	static const STATIC_ARGS = 3;
	new argCount = numargs();
	if((argCount - STATIC_ARGS) > 0) {
		for(new i = STATIC_ARGS; i < argCount; i++) {
			GameTextForGang(getarg(i), dest, time, type);
		}
	} else {
		for(new i; i < sizeof Gangs; i++) {
			GameTextForGang(Gangs[i], dest, time, type);
		}
	}
	return 1;
}

stock GameTextForGang(gangid, const mess[], time, type) {
	foreach(new p: TeamPlayers[gangid]) {
		GameTextForPlayer(p, mess, time, type);
	}
}

stock Pl::Init(playerid) {
	GMTest{playerid}					= false;
	useBannyHop{playerid}				= false;
	InAntiDmZone{playerid}				= false;
	
	KG[playerid]						= {0,0};
	OnJob[playerid]						= 0;
	StartJob[playerid]					= 0;
	PlayerObject[playerid]				= INVALID_OBJECT_ID;

	CP[playerid]						= 0;
	Fixr{playerid}						= 0;
	Wait{playerid}						= 0;
	ChosenSkin[playerid]				= 0;
	SelectCharPlace[playerid]			= 0;
	GettingJob[playerid]				= 0;
	ApprovedLawyer[playerid]			= 0;
	CallLawyer[playerid]				= 0;
	WantLawyer[playerid]				= 0;
	UsedFind[playerid]					= 0;
	CarOffer[playerid]					= INVALID_PLAYER_ID;
	CarPrice[playerid]					= 0;
	CarID[playerid]						= 0;
	CarCalls[playerid]					= 0;
	Condom[playerid]					= 0;
	acceptgruz{playerid}				= 0;
	TaxiCallTime[playerid]				= 0;
	STDPlayer[playerid]					= 0;
	SexOffer[playerid]					= INVALID_PLAYER_ID;
	SexPrice[playerid]					= 0;
	RepairOffer[playerid]				= INVALID_PLAYER_ID;
	RepairPrice[playerid]				= 0;
	RepairCar[playerid]					= 0;
	TalkingLive[playerid]				= INVALID_PLAYER_ID;
	LiveOffer[playerid]					= INVALID_PLAYER_ID;
	RefillOffer[playerid]				= INVALID_PLAYER_ID;
	RefillPrice[playerid]				= 0;
	DrugOffer[playerid]					= INVALID_PLAYER_ID;
	DrugPrice[playerid]					= 0;
	DrugGram[playerid]					= 0;
	AnimClear[playerid]					= 0;
	JailPrice[playerid]					= 0;
	Mobile[playerid]					= 255;
	Music[playerid]						= 0;
	TransportCost[playerid]				= 0;
	gLastCar[playerid]					= INVALID_VEHICLE_ID;
	BusCallTime[playerid]				= 0;
	PlayerTazeTime[playerid]			= 0;
	useknock[playerid]					= 0;
	TicketOffer[playerid]			 	= INVALID_PLAYER_ID;
	TicketMoney[playerid]				= 0;
	MatsHolding[playerid]				= 0;
	TransportTime[playerid]				= 0;
	TaxiAccepted[playerid]				= INVALID_PLAYER_ID;
	BusAccepted[playerid]				= INVALID_PLAYER_ID;
	Fell[playerid]						= 0;
	HireCar[playerid] 					= INVALID_VEHICLE_ID;
	TransportValue[playerid]			= 0;
	TransportDriver[playerid]			= INVALID_PLAYER_ID;
	TransportDuty[playerid]				= 0;
	DrugIntoxic[playerid]				= 0;
	JobWaitTime[playerid]				= 0;
	Mobile[playerid]					= INVALID_PLAYER_ID;
	NameChange{playerid}				= 0;
	FindTime[playerid]					= 0;
	
	MedicCallTime[playerid]				= {INVALID_PLAYER_ID, 0};
	MechanicCallTime[playerid]			= {INVALID_PLAYER_ID, 0};

	PickupInfo[playerid][pOld]			= -1;
	PickupInfo[playerid][pDelay]		= 0;
	
	AFKInfo[playerid][afk_State]		= 0;
	AFKInfo[playerid][afk_Time]			= {0, 0};
	
	Pl::Drunk[playerid]					= 0;
	Pl::CarInt[playerid]				= INVALID_VEHICLE_ID;
	Pl::Stoned[playerid]				= 0;
	Pl::NetStats[playerid]				= INVALID_PLAYER_ID;
	Pl::DrunkTime[playerid]				= 0;
	Pl::CuffedTime[playerid]			= 0;
	
	Pl::SpecInfo[playerid][pSpecID]		= INVALID_PLAYER_ID;
	
	SyncInfo[playerid][sKillerID]		= INVALID_PLAYER_ID;
	SyncInfo[playerid][sReasonID]		= 255;

	Pl::Info[playerid][pReg]			= 0;
	Pl::Info[playerid][pSex]			= 0;
	Pl::Info[playerid][pAge]			= 0;
	Pl::Info[playerid][pExp]			= 0;
	Pl::Info[playerid][pJob]			= 0;
	Pl::Info[playerid][pBank]			= 0;
	Pl::Info[playerid][pWait]			= 10;
	Pl::Info[playerid][pLevel]			= 0;
	Pl::Info[playerid][pAdmin]			= 0;
	Pl::Info[playerid][pKills]			= 0;
	Pl::Info[playerid][pHelper]			= 0;
	Pl::Info[playerid][pOrigin]			= 1;
	Pl::Info[playerid][pCrimes]			= 0;
	Pl::Info[playerid][pDeaths]			= 0;
	Pl::Info[playerid][pArrested]		= 0;
	Pl::Info[playerid][pWantedL]		= 0;
	Pl::Info[playerid][pWantedD]		= 0;
	Pl::Info[playerid][pPhoneBook]		= 0;
	Pl::Info[playerid][pLottoNr]		= 0;
	Pl::Info[playerid][pPayCheck]		= 0;
	Pl::Info[playerid][pJailed]			= 0;
	Pl::Info[playerid][pJailTime]		= 0;
	Pl::Info[playerid][pMats]			= 0;
	Pl::Info[playerid][pDrugs]			= 0;
	Pl::Info[playerid][pLeader]			= 0;
	Pl::Info[playerid][pMember]			= 0;
	Pl::Info[playerid][pRank]			= 0;
	Pl::Info[playerid][pChar]			= 79;
	Pl::Info[playerid][pContractTime]	= 0;
	Pl::Info[playerid][pSkill]			= {0, 0, 0, 0, 0, 0, 0, 0};
	Pl::Info[playerid][pLocal]			= 0;
	Pl::Info[playerid][pNumber]			= 0;
	Pl::Info[playerid][pHouseKey]		= INVALID_HOUSE_ID;
	Pl::Info[playerid][pBizKey]			= INVALID_BIZ_ID;
	Pl::Info[playerid][pLic]			= {0, 0, 0, 0};
	Pl::Info[playerid][pCarTime]		= 0;
	Pl::Info[playerid][pPayDay]			= 0;
	Pl::Info[playerid][pCDPlayer]		= 0;
	Pl::Info[playerid][pPayDayHad]		= 0;
	Pl::Info[playerid][pMutedTime]		= 0;
	Pl::Info[playerid][pMaskOn]			= false;
	Pl::Info[playerid][pWarns]			= 0;
	Pl::Info[playerid][pFuel]			= 0;
	Pl::Info[playerid][pRebuke]			= 0;
	Pl::Info[playerid][pReport]			= 0;
	Pl::Info[playerid][pFightstyle]		= 0;
	Pl::Info[playerid][pVip]			= 0;
	Pl::Info[playerid][pPasport]		= {0, 0, 0};


	Gag{playerid}						= false;
	gOoc{playerid}						= true;
	gFam{playerid}						= true;
	gNews{playerid}						= true;
	gDice{playerid}						= false;
	OnAir{playerid}						= false;
	TogTP{playerid}						= true;
	OnDuty{playerid}					= false;
	BigEar{playerid}					= false;
	HidePM{playerid}					= false;
	EditMode{playerid}					= false;
	MedicBill{playerid}					= false;
	SwitchKey{playerid}					= false;
	AdminDuty{playerid}					= false;
	WatchingTV{playerid}				= false;
	WrongLogin[playerid]				= 3;
	PlayerTied{playerid}				= false;
	HelperDuty{playerid}				= false;
	SpawnChange{playerid}				= false;
	SuspectKill{playerid}				= false;
	PhoneOnline{playerid}				= true;
	MoneyMessage[playerid]				= false;
	TakingLesson{playerid}				= false;
	PlayerUseTazed{playerid}			= false;
	
	TempVehicle[playerid]				= INVALID_VEHICLE_ID;

	SetPVarInt(playerid, "RouteID", INVALID_ID);
	SetPVarInt(playerid, "SelectedCar", -1);
	SetPVarInt(playerid, "SelectedItem", -1);
	SetPVarInt(playerid, "SelectedPlayer", INVALID_PLAYER_ID);
	SetPVarInt(playerid, "selectTeleport", INVALID_ID);
	SetPVarInt(playerid, "SelectGas", INVALID_ID);
	
	SetPVarInt(playerid, "InvateFrac", 0);
	SetPVarInt(playerid, "AnsweredHelper", INVALID_PLAYER_ID);
	SetPVarInt(playerid, "TransferPlayer", INVALID_PLAYER_ID);
	SetPVarInt(playerid, "TransferAmount", 0);
	
	SetPVarInt(playerid, "HouseSeller", INVALID_PLAYER_ID);
	SetPVarInt(playerid, "HouseBuyer", INVALID_PLAYER_ID);
	SetPVarInt(playerid, "HouseType", 0);
	SetPVarInt(playerid, "HousePrice", 0);
	
	TotalExtraVehicles[playerid] = 0;
	TotalVehicleInGarage[playerid] = 0;
	Iter::Clear(ExtraVehicles[playerid]);

	Rac::SetPlayerMoney(playerid, 0);
	Rac::SetPlayerHealth(playerid, 100.0);
	SetPlayerColor(playerid, COLOR_GRAD2);
	
	for(new i; i < MAX_EXTRA_VEHICLES; i++) VehicleInGarage[playerid][i] = 0;
	for(new i; i < 6; i++) DisablePlayerCheckpointEx(playerid, i);
	
	return 1;
}

stock Pl::RemoveWorldModel(playerid) {
	RemoveBuildingForPlayer(playerid, 2938, 1053.2607,2088.0015,10.8203, 20.0);
	RemoveBuildingForPlayer(playerid, 14797, 617.75, -125.39062, 998.32031, 20.0);
	return 1;
}

stock Bl::Init(playerid) {
	foreach(new i : Frac) {
		Bl::Info[playerid][Bl::onFrac][i] = 0;
		Bl::Info[playerid][Bl::Kills][i] = 0;
	}
	Bl::Info[playerid][Bl::isKilled] = false;
	Bl::Info[playerid][Bl::Observe] = INVALID_PLAYER_ID;
	Bl::Info[playerid][Bl::Finder] = INVALID_PLAYER_ID;
}

stock ClearCrime(playerid) {
	new len = strlen("********");
	strmid(Pl::Crime[playerid][pVictim], "********", 0,  len, 255);
	strmid(Pl::Crime[playerid][pAccusing], "•••••••••", 0, len, 255);
	strmid(Pl::Crime[playerid][pAccused], "•••••••••", 0, len, 255);
}


stock Td::Init() {
	Logo[0] = Td::Create(510.000000, 6.000000, "~w~www.~g~gwrp~w~.net");
	Td::BackgroundColor(Logo[0], 255);
	Td::Font(Logo[0], 3);
	Td::LetterSize(Logo[0], 0.35,1.70);
	Td::Color(Logo[0], 0xCCCCCCCC);
	Td::SetOutline(Logo[0], 1);
	Td::SetProportional(Logo[0], 1);

	Time = Td::Create(556.000000, 23.000000, "~w~00:00");
	Td::BackgroundColor(Time, 255);
	Td::Font(Time, 3);
	Td::LetterSize(Time, 0.480000, 2.399999);
	Td::Color(Time, 0xCCCCCCCC);
	Td::SetOutline(Time, 1);
	Td::SetProportional(Time, 1);
	
	Copyright = Td::Create(588.000000, 438.000000, "~w~powered by "#__GamemodeName__"-"#__GamemodeVersion__"");
	Td::Alignment(Copyright, 2);
	Td::BackgroundColor(Copyright, 255);
	Td::Font(Copyright, 3);
	Td::LetterSize(Copyright, 0.220000, 0.899999);
	Td::Color(Copyright, -858993630);
	Td::SetOutline(Copyright, 0);
	Td::SetProportional(Copyright, 1);
	Td::SetShadow(Copyright, 0);
	
	new h, m, s; gettime(h, m, s);
	format(temp, sizeof temp, "~w~%02i:%02i", h, m);
	Td::SetString(Time, temp);
	
	return 1;
}

stock SetVehicleNumber(vehid, number[] = "none") {
	if(strcmp(number, "none", false)) {
		SetVehicleNumberPlate(vehid, number);
    } else {
		if(vehid > 999) {
			format(temp, sizeof temp, "%c%c%04i%c", ('A'+random(26)), ('A'+random(26)), vehid, ('A'+random(26)));
		} else {
			format(temp, sizeof temp, "%c%c%03i%c", ('A'+random(26)), ('A'+random(26)), vehid, ('A'+random(26)));
		}
		SetVehicleNumberPlate(vehid, temp);
	}
}

stock ShowBizZones(playerid) {
	new fracid = Pl::FracID(playerid);
	foreach(new i : Biznes) {
		Gz::ShowForPlayer(playerid, BizzInfo[i][bZone], GetFracColor(BizzInfo[i][bFrac]));
		if(BizzInfo[i][bOnBattle] == 1) {
			Gz::FlashForPlayer(playerid, BizzInfo[i][bZone], GetFracColor(BizzInfo[i][bAttack]));
			if(fracid == BizzInfo[i][bDefend] || fracid == BizzInfo[i][bAttack]) {
				SetPlayerCheckpointEx(playerid, ZAHVAT_ICON, BizzInfo[i][bEnter][0], BizzInfo[i][bEnter][1], BizzInfo[i][bEnter][2], 19, 0, -1, -1, true);
			}
		}
	}
	return 1;
}

stock HideBizZones(playerid) {
	foreach(new i : Biznes) {
		if(BizzInfo[i][bOnBattle] == 1) {
			Gz::StopFlashForPlayer(playerid, BizzInfo[i][bZone]);
		}
		Gz::HideForPlayer(playerid, BizzInfo[i][bZone]);
	}
	return 1;
}

stock Gz::ShowForGangs(zoneid, color) {
	for(new i; i < sizeof Gangs; i++) {
		foreach(new playerid : TeamPlayers[Gangs[i]]) {
			Gz::ShowForPlayer(playerid, zoneid, color);
		}
	}
	return 1;
}

stock Gz::HideForGangs(zoneid) {
	for(new i; i < sizeof Gangs; i++) {
		foreach(new playerid : TeamPlayers[Gangs[i]]) {
			Gz::HideForPlayer(playerid, zoneid);
		}
	}
	return 1;
}

stock Gz::FlashForGangs(zoneid, color) {
	for(new i; i < sizeof Gangs; i++) {
		foreach(new playerid : TeamPlayers[Gangs[i]]) {
			Gz::FlashForPlayer(playerid, zoneid, color);
		}
	}
	return 1;
}

stock Td::ShowForFrac(Text:textid, ...) {
	static const STATIC_ARGS = 1;
	new argCount = numargs();
	if((argCount - STATIC_ARGS) > 0) {
		for(new fracid, i = STATIC_ARGS; i < argCount; i++) {
			if(1 <= (fracid=getarg(i)) <= 20) {
				foreach(new p : TeamPlayers[fracid]) {
					Td::ShowForPlayer(p, textid);
				}
			}
		}
	}
	return 1;
}

stock Td::HideForFrac(Text:textid, ...) {
	static const STATIC_ARGS = 1;
	new argCount = numargs();
	if((argCount - STATIC_ARGS) > 0) {
		for(new fracid, i = STATIC_ARGS; i < argCount; i++) {
			if(1 <= (fracid=getarg(i)) <= 20) {
				foreach(new p : TeamPlayers[fracid]) {
					Td::HiddForPlayer(p, textid);
				}
			}
		}
	}
	return 1;
}

stock Pt::Init(playerid) {
	Pt::Fuel[playerid] = CreatePlayerTextDraw(playerid, 8.000000, 321.000000, "~w~Benzin: ~b~loading");
	Pt::BackgroundColor(playerid, Pt::Fuel[playerid], 255);
	Pt::Font(playerid, Pt::Fuel[playerid], 3);
	Pt::LetterSize(playerid, Pt::Fuel[playerid], 0.400000, 1.699998);
	Pt::Color(playerid, Pt::Fuel[playerid], 0xCCCCCCCC);
	Pt::SetOutline(playerid, Pt::Fuel[playerid], 1);
	Pt::SetProportional(playerid, Pt::Fuel[playerid], 1);
	
	Pt::Status[playerid] = CreatePlayerTextDraw(playerid, 8.000000, 339.000000, "~w~Lock");
	Pt::BackgroundColor(playerid, Pt::Status[playerid], 255);
	Pt::Font(playerid, Pt::Status[playerid], 3);
	Pt::LetterSize(playerid, Pt::Status[playerid], 0.400000, 1.699998);
	Pt::Color(playerid, Pt::Status[playerid], 0xCCCCCCCC);
	Pt::SetOutline(playerid, Pt::Status[playerid], 1);
	Pt::SetProportional(playerid, Pt::Status[playerid], 1);
	
	Pt::Name[playerid] = CreatePlayerTextDraw(playerid, 8.000000, 430.000000, "_");
	Pt::BackgroundColor(playerid, Pt::Name[playerid], 255);
	Pt::Font(playerid, Pt::Name[playerid], 3);
	Pt::LetterSize(playerid, Pt::Name[playerid], 0.400000, 1.499999);
	Pt::Color(playerid, Pt::Name[playerid], 0xCCCCCCCC);
	Pt::SetOutline(playerid, Pt::Name[playerid], 1);
	Pt::SetProportional(playerid, Pt::Name[playerid], 1);
	
	Pt::Spec[playerid] = CreatePlayerTextDraw(playerid, 320.000000, 350.000000, "_");
	Pt::Alignment(playerid, Pt::Spec[playerid], 2);
	Pt::BackgroundColor(playerid, Pt::Spec[playerid], 255);
	Pt::Font(playerid, Pt::Spec[playerid], 2);
	Pt::LetterSize(playerid, Pt::Spec[playerid], 0.489998, 2.099999);
	Pt::Color(playerid, Pt::Spec[playerid], 0xCCCCCCCC);
	Pt::SetOutline(playerid, Pt::Spec[playerid], 1);
	Pt::SetProportional(playerid, Pt::Spec[playerid], 1);
	
	Pt::Speed[playerid][0] = CreatePlayerTextDraw(playerid, 138.000000, 403.000000, " ");
	Pt::BackgroundColor(playerid, Pt::Speed[playerid][0], 0x00000033);
	Pt::Font(playerid, Pt::Speed[playerid][0], 1);
	Pt::LetterSize(playerid, Pt::Speed[playerid][0], 0.359999, 1.8);
	Pt::Color(playerid, Pt::Speed[playerid][0], -1);
	Pt::SetOutline(playerid, Pt::Speed[playerid][0], 1);
	Pt::SetProportional(playerid, Pt::Speed[playerid][0], 1);
   
	Pt::Speed[playerid][1] = CreatePlayerTextDraw(playerid, 138.000000, 403.000000, "IIIIIIIIIIIIIIIIIIIIIIIIIIIII");
	Pt::BackgroundColor(playerid, Pt::Speed[playerid][1], 0x00000000);
	Pt::Font(playerid, Pt::Speed[playerid][1], 1);
	Pt::LetterSize(playerid, Pt::Speed[playerid][1], 0.359999, 1.8);
	Pt::Color(playerid, Pt::Speed[playerid][1], 0xFFFFFF33);
	Pt::SetOutline(playerid, Pt::Speed[playerid][1], 1);
	Pt::SetProportional(playerid, Pt::Speed[playerid][1], 1);

	Pt::Speed[playerid][2] = CreatePlayerTextDraw(playerid, 145.000000, 388.000000, " ");
	Pt::BackgroundColor(playerid, Pt::Speed[playerid][2], 0x000000FF);
	Pt::Font(playerid, Pt::Speed[playerid][2], 2);
	Pt::LetterSize(playerid, Pt::Speed[playerid][2], 0.309998, 1.600000);
	Pt::Color(playerid, Pt::Speed[playerid][2], -1);
	Pt::SetOutline(playerid, Pt::Speed[playerid][2], 0);
	Pt::SetProportional(playerid, Pt::Speed[playerid][2], 1);
	Pt::SetShadow(playerid, Pt::Speed[playerid][2], 0);
	
	Td::AutoSolon = CreatePlayerTextDraw(playerid, 468.000000, 351.000000, "_");
	Pt::BackgroundColor(playerid, Td::AutoSolon, 255);
	Pt::Font(playerid, Td::AutoSolon, 3);
	Pt::LetterSize(playerid, Td::AutoSolon, 0.450000, 1.300000);
	Pt::Color(playerid, Td::AutoSolon, 0xCCCCCCCC);
	Pt::SetOutline(playerid, Td::AutoSolon, 1);
	Pt::SetProportional(playerid, Td::AutoSolon, 1);
	
	return 1;
}


public OnVehicleMod(playerid, vehicleid, componentid) {
	if(Rac::Info[playerid][Rac::Warns][R::TUNING_HACK] == 0) {
		AutoInfo[vehicleid][aTuning][GetVehicleComponentType(componentid)] = componentid;
		return 1;
	}
	
	return 0;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2) {
	if(color1 == -1 && color2 == -1) {
		foreach(new i : Biznes) {
			if(IsPlayerInSquare2D(playerid, 13.0, BizzInfo[i][bEnter][0], BizzInfo[i][bEnter][1])) {
				if(BizzInfo[i][bOwned]) {
					if(Rac::GetPlayerMoney(playerid) < BizzInfo[i][bEnterCost]) {
						GameTextForPlayer(playerid, "~r~You dont have the cash", 5000, 1);
					} else {
						GiveBizzProfit(i, BizzInfo[i][bEnterCost]);
						Rac::GivePlayerMoney(playerid, -BizzInfo[i][bEnterCost]);
						format(src, sizeof(src), "~r~repair price~w~~n~%i$", BizzInfo[i][bEnterCost]);
						GameTextForPlayer(playerid, src, 5000, 1);
					}
				} else {
					if(Rac::GetPlayerMoney(playerid) < BizzInfo[i][bEnterCost]) {
						GameTextForPlayer(playerid, "~r~You dont have the cash", 5000, 1);
					} else {
						GiveBizzProfit(i, 500);
						Rac::GivePlayerMoney(playerid, -500);
						GameTextForPlayer(playerid, "~r~repair price~w~~n~500$", 5000, 1);
					}
				}
				break ;
			}
		}
	} else {
		AutoInfo[vehicleid][aColor][COLOR_ONE] = color1;
		AutoInfo[vehicleid][aColor][COLOR_TWO] = color2;
	}
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid) {
	AutoInfo[vehicleid][aPaintJob] = paintjobid;
	return 1;
}

stock IsAnyTrailerAttachedToVehicle(vehicleid) {
	return linearSearch(trailerID, GetVehicleModel(GetVehicleTrailer(vehicleid))) != -1;
}

stock UpdateTuning(vehid, type, id) {
	switch(type) {
		case 1: {
			if(!IsValidHouse(id)) return 0;
			format(query, sizeof query, "UPDATE `"#__TableHouses__"` SET `vehicle_tuning`='");
			scf(query, src, "%d,%d,%d,%d,", AutoInfo[vehid][aTuning][0], AutoInfo[vehid][aTuning][1], AutoInfo[vehid][aTuning][2], AutoInfo[vehid][aTuning][3]);
			scf(query, src, "%d,%d,%d,%d,", AutoInfo[vehid][aTuning][4], AutoInfo[vehid][aTuning][5], AutoInfo[vehid][aTuning][6], AutoInfo[vehid][aTuning][7]);
			scf(query, src, "%d,%d,%d,%d,", AutoInfo[vehid][aTuning][8], AutoInfo[vehid][aTuning][9], AutoInfo[vehid][aTuning][10], AutoInfo[vehid][aTuning][11]);
			scf(query, src, "%d,%d,%d' ", AutoInfo[vehid][aTuning][12], AutoInfo[vehid][aTuning][13], AutoInfo[vehid][aPaintJob]);
			scf(query, src, "WHERE `id`='%i'", id);
			Db::tquery(connDb, query, "", "");
		}
		case 2: {
			format(query, sizeof query, "UPDATE `"#__TableVehicles__"` SET `tuning`='");
			scf(query, src, "%d,%d,%d,%d,", AutoInfo[vehid][aTuning][0], AutoInfo[vehid][aTuning][1], AutoInfo[vehid][aTuning][2], AutoInfo[vehid][aTuning][3]);
			scf(query, src, "%d,%d,%d,%d,", AutoInfo[vehid][aTuning][4], AutoInfo[vehid][aTuning][5], AutoInfo[vehid][aTuning][6], AutoInfo[vehid][aTuning][7]);
			scf(query, src, "%d,%d,%d,%d,", AutoInfo[vehid][aTuning][8], AutoInfo[vehid][aTuning][9], AutoInfo[vehid][aTuning][10], AutoInfo[vehid][aTuning][11]);
			scf(query, src, "%d,%d,%d' ", AutoInfo[vehid][aTuning][12], AutoInfo[vehid][aTuning][13], AutoInfo[vehid][aPaintJob]);
			scf(query, src, "WHERE `ID`='%d'", id);
			Db::tquery(connDb, query, "", "");
		}
		default: return 0;
	}
	return 1;
}

stock ResetTuning(vehid, type, id) {
	switch(type) {
		case 1: {
			if(IsValidHouse(id)) {
				RemoveTuning(vehid);
				format(query, sizeof query, "UPDATE `"#__TableHouses__"` SET `vehicle_tuning`='0,0,0,0,0,0,0,0,0,0,0,0,0,0,3' WHERE `id`='%i'", id);
				Db::tquery(connDb, query, "", "");
			}
		}
		
		case 2: {
			RemoveTuning(vehid);
			format(query, sizeof query, "UPDATE `"#__TableVehicles__"` SET `tuning`='0,0,0,0,0,0,0,0,0,0,0,0,0,0,3' WHERE `ID`='%i'", id);
			Db::tquery(connDb, query, "", "");
		}
		default: return 0;
	}
	return 1;
}

stock AddTuning(vehid) {
	for(new i; i < MAX_COMPONENT; i++) {
		if(AutoInfo[vehid][aTuning][i] != 0) {
			AddVehicleComponent(vehid, AutoInfo[vehid][aTuning][i]);
		}
	}
	if(AutoInfo[vehid][aPaintJob] != 3) {
		ChangeVehiclePaintjob(vehid, AutoInfo[vehid][aPaintJob]);
	}
	return 1;
}

stock RemoveTuning(vehid) {
	for(new i; i < MAX_COMPONENT; i++) {
		RemoveVehicleComponent(vehid, AutoInfo[vehid][aTuning][i]);
		AutoInfo[vehid][aTuning][i] = 0;
	}
	AutoInfo[vehid][aPaintJob] = 3;
	ChangeVehiclePaintjob(vehid, AutoInfo[vehid][aPaintJob]);
	return 1;
}

stock ShowRankList(playerid, fracid) {
	dialog[0] = '\0';
	for(new i = RankNums[fracid]; i != 0; i--) {
		scf(dialog, temp, "%i.  %s\n", i, RankInfo[fracid][i]);
	}

	SetPVarInt(playerid, "SelectedFrac", fracid);
	format(temp, sizeof(temp), "Ранги [%s]", FracInfo[fracid][fName]);
	SPD(playerid, D_CRANK, DIALOG_STYLE_LIST, temp, dialog, "SELECT", "CANCLE");
	return 1;
}

stock UpdateRank(fracid, rankid, rank[]) {
	new escname[36];
	Db::escape_string(rank, escname);
	strmid(RankInfo[fracid][rankid], rank, 0, strlen(rank), 255);
	format(query, sizeof query, "UPDATE `"#__TableFracRanks__"` SET `r_name` = '%s' WHERE `f_id` = '%i' AND `r_id` = '%i'", escname, fracid, rankid);
	Db::tquery(connDb, query, "", "");
	return 1;
}

stock SetFracName(fracid, name[]) {
	new escname[36];
	Db::escape_string(name, escname);
	strmid(FracInfo[fracid][fName], name, 0, strlen(name), 255);
	format(query, sizeof query, "UPDATE `"#__TableFracInfo__"` SET `fName` = '%s' WHERE `fID` = '%i'", escname, fracid);
	Db::tquery(connDb, query, "", "");
	return 1;
}

stock SetFracTag(fracid, tag[]) {
	new escname[16];
	Db::escape_string(tag, escname);
	strmid(FracInfo[fracid][fTag], tag, 0, strlen(tag), 255);
	format(query, sizeof query, "UPDATE `"#__TableFracInfo__"` SET `fTag` = '%s' WHERE `fID` = '%i'", escname, fracid);
	Db::tquery(connDb, query, "", "");
	return 1;
}

	// Бан игрока
stock AddBanList(playerid, adminid, mins, reason[], type = 1) {
	new unbandate, currdate = gettime();
	unbandate = currdate + mins * 60;
	
	new safestr[64];
	Db::escape_string(reason, safestr);
	format(query, sizeof query, "INSERT INTO `"#__TableBanned__"` (`user_id`,`admin_id`,`ip`,`date`,`unbandate`,`reason`) VALUES (");
	scf(query, src, "'%i','%i','%s',", Pl::Info[playerid][pID], adminid==-1 ? adminid : Pl::Info[adminid][pID], GetPIP(playerid));
	scf(query, src, "'%i','%i','%s')", currdate, unbandate, safestr);
	Db::tquery(connDb, query, "", "");
	
	switch(type) {
		case 1 : {
			format(query, sizeof query, "*"#__SERVER_PREFIX""#__SERVER_NAME_LC": %s был забанен администратором %s, причина: %s", GetName(playerid), GetName(adminid), reason);
			SendToAll(COLOR_LIGHTRED, query);
		}
		case 2 : {
			format(src, sizeof(src), "* Вы были забанены, причина: %s", reason); 
			Send(playerid, COLOR_LIGHTRED, src);
			format(src, sizeof(src), "[AdmWarn] * %s[%i] был забанен, причина: %s", GetName(playerid), playerid, reason);
			SendToAdmin(COLOR_LIGHTRED, src, 1, 3);
		}
		case 3 : {
			format(src, sizeof(src), "* Вы были забанены, причина: %s", reason);
			Send(playerid, COLOR_LIGHTRED, src);
			format(src, sizeof(src), "[античит] * %s[%i] был забанен, причина: %s", GetName(playerid), playerid, reason);
			SendToAdmin(COLOR_LIGHTRED, src, 1, 1);
		}
		default : {
			format(query, sizeof query, "[SBAN] Админ %s забанил игрока %s[%i], причина: %s", GetName(adminid), GetName(playerid), playerid, reason);
			SendToAdmin(COLOR_LIGHTBLUE, query, 1, 3);
		}
	}
	return BanEx(playerid, reason);
}

	// Удаление игрока из бан-листа
stock RemoveBanList(userid) {
	new banIp[16];
	format(query, sizeof query, "SELECT `ip` FROM `"#__TableBanned__"` WHERE `user_id`='%i'", userid);
	new Cache:result = Db::query(connDb, query, true);
	if(cache_get_row_count()) {
		cache_get_row(0, 0, banIp);
		format(query, sizeof query, "unbanip %.16s", banIp);
		SendRconCommand(query);
			
		format(query, sizeof query, "DELETE FROM `"#__TableBanned__"` WHERE `user_id`='%i'", userid);
		Db::tquery(connDb, query, "", "");
		return 1;
	}
	cache_delete(result);
	return 0;
}

stock isBanned(userid) {
	format(query, sizeof query, "SELECT `user_id` FROM `"#__TableBanned__"` WHERE `user_id` = '%i'", userid);
	new Cache:result = Db::query(connDb, query, true);
	new rows = cache_get_row_count();
	cache_delete(result);
	return rows;
}

public: CheckBan(playerid) {
	if(Pl::Info[playerid][pID] != -1) {
		new unbandate, bandate, bip[16], aname[24], reason[64];
		format(query, sizeof query, "SELECT (SELECT `Name` FROM `"#__TableUsers__"` WHERE `ID`=`user_id`),\
		(SELECT `Name` FROM `"#__TableUsers__"` WHERE `ID`=`admin_id`),\
		`ip`,`date`,`unbandate`,`reason` FROM `"#__TableBanned__"` WHERE `user_id`='%i'", Pl::Info[playerid][pID]);
		
		new Cache:result = Db::query(connDb, query, true);
		if(cache_get_row_count()) {
			cache_get_row(0, 0, plname);
			cache_get_row(0, 1, aname);
			cache_get_row(0, 2, bip);
			cache_get_int(0, 3, bandate);
			cache_get_int(0, 4, unbandate);
			cache_get_row(0, 5, reason);
			cache_delete(result);
			
			if((unbandate-gettime()) > 0) {
				new date_s[2][28];
				to_timestamp(date_s[0], bandate, "%d-%m-%Y, %X");
				to_timestamp(date_s[1], unbandate, "%d-%m-%Y, %X");
				
				format(dialog, sizeof dialog, "* Вы были забанены!\n\n");
				scf(dialog, temp, "Забанил: %s\n", issqlnull(aname) ? ("System") : aname);
				scf(dialog, temp, "Причина: %s\n", reason);
				scf(dialog, temp, "Срок бана: %i дней\n", getday(unbandate, bandate));
				scf(dialog, temp, "Дата бана: %s\n", date_s[0]);
				scf(dialog, temp, "Дата разбана: %s\n", date_s[1]);
				return SPD(playerid, D_NONE, 0, ""#__SERVER_PREFIX""#__SERVER_NAME_C" BAN. Введите /q для выхода.", dialog, "*", "");
			} else {
				RemoveBanList(Pl::Info[playerid][pID]);
			}
		}
		cache_delete(result);
	}
	return 0;
}
 
stock ShowPlayerBanList(adminid, pname[]) {
	new bandate, unbandate, bip[16], aname[24], reason[64], date_s[2][28];
	format(query, sizeof query, "SELECT (SELECT `Name` FROM `"#__TableUsers__"` WHERE `ID`=`user_id`),\
	(SELECT `Name` FROM `"#__TableUsers__"` WHERE `ID`=`admin_id`),\
	`ip`,`date`,`unbandate`,`reason` FROM `"#__TableBanned__"` WHERE `user_id`=(SELECT `ID` FROM `"#__TableUsers__"` WHERE BINARY `Name`='%s')", pname);
	new Cache:result = Db::query(connDb, query, true);
	if(cache_get_row_count()) {
		cache_get_row(0, 1, aname);
		cache_get_row(0, 2, bip);
		cache_get_int(0, 3, bandate);
		cache_get_int(0, 4, unbandate);
		cache_get_row(0, 5, reason);
		
		to_timestamp(date_s[0], bandate, "%d-%m-%Y, %X");
		to_timestamp(date_s[1], unbandate, "%d-%m-%Y, %X");
		
		format(dialog, sizeof dialog, "* Забаненый %s\n\n", pname);
		scf(dialog, temp, "Забанил: %s\n", issqlnull(aname) ? ("System") : aname);
		scf(dialog, temp, "Причина: %s\n", reason);
		scf(dialog, temp, "Срок бана: %i дней\n", getday(unbandate, bandate));
		scf(dialog, temp, "Дата бана: %s\n", date_s[0]);
		scf(dialog, temp, "Дата разбана: %s\n\n", date_s[1]);
		SPD(adminid, D_BANLIST, 0, ""#__SERVER_PREFIX""#__SERVER_NAME_C" BANS.", dialog, "UNBAN", "OK");
		SetPVarString(adminid, "UnbanPlayer", pname);
	} else {
		Send(adminid, COLOR_GREY, "* Этот игрок не забанен!");
	}
	cache_delete(result);
	return 1;
}

stock IsWrongWeponID(weponid)
{
	if(weponid <= 0) return true;
	for(new i; i < sizeof(wrongWeapon); i++) if(wrongWeapon[i] == weponid) return true;
	return false;
}

stock IsValidHouse(houseid) {
	return Iter::Contains(Houses, houseid);
}

stock IsPlayerHouseOwner(playerid, house) {
	if(IsValidHouse(house)) {
		return strcmp(GetName(playerid), HouseInfo[house][hOwner], false) == 0 ? 1 : 0; 
	}
	return 0;
}

stock IsValidBiz(biz) {
	return Iter::Contains(Biznes, biz);
}

stock IsPlayerBizOwner(playerid, biz) {
	if(IsValidBiz(biz)) {
		return strcmp(GetName(playerid), BizzInfo[biz][bOwner], false) == 0 ? 1 : 0; 
	}
	return 0;
}

stock IsPlayerBizExtortion(playerid, biz) {
	if(IsValidBiz(biz)) {
		return strcmp(GetName(playerid), BizzInfo[biz][bExtortion], false) == 0 ? 1 : 0; 
	}
	return 0;
}

stock Jailed(playerid, jailtime, type = -1) {
	TempSkin[playerid] = GetPlayerSkin(playerid);
	SetPlayerSkin(playerid, GetJailedSkin(playerid));
	switch(type) {
		case 1 : {
			WantLawyer[playerid] = 1;
			Pl::Info[playerid][pJailed] = 1;
			Rac::SetPlayerInterior(playerid, 6);
			Rac::SetPlayerVirtualWorld(playerid, 1);
			Rac::SetPlayerPos(playerid,264.6288,77.5742,1001.0391);
		}
		case 2 : {
			Pl::Info[playerid][pJailed] = 2;
			Rac::SetPlayerInterior(playerid, 1);
			Rac::SetPlayerVirtualWorld(playerid, 1);
			Rac::SetPlayerPos(playerid, 1401.3,-15.5,1002.9);
			SetPlayerWorldBounds(playerid, 337.5694,101.5826,1940.9759,1798.7453);
		}
		default : {
			Pl::Info[playerid][pJailed] = 1;
			Rac::SetPlayerInterior(playerid, 6);
			Rac::SetPlayerVirtualWorld(playerid, 1);
			Rac::SetPlayerPos(playerid,264.6288,77.5742,1001.0391);
		}
	}
	Pl::SetWantedLevel(playerid, 0);
	Pl::Info[playerid][pJailTime] = jailtime;
	Pl::SetSpawnInfo(playerid);
	Rac::ResetPlayerWeapons(playerid);

	return;
}

stock Pl::SetWantedLevel(playerid, lvl) {
	lvl = (lvl > 6) ? (6) : (lvl < 0 ? 0 : lvl);
	Pl::Info[playerid][pWantedL] = lvl;
	if(lvl) Iter::Add(WantedPlayers, playerid); else Iter::Remove(WantedPlayers, playerid);
	return SetPlayerWantedLevel(playerid, Pl::Info[playerid][pWantedL]);
}

stock CarUpgrade(playerid, hid, newveh) {
	if(400 <= HouseInfo[hid][hvModel] <= 611) {
		ResetTuning(HouseInfo[hid][hAuto], 1, hid);
		HouseInfo[hid][hvModel] = newveh;
		AutoInfo[HouseInfo[hid][hAuto]][aMileage] = 0.0;
		Veh::Destroy(HouseInfo[hid][hAuto]);

		new veh = HouseInfo[hid][hAuto] = Veh::Create(
			HouseInfo[hid][hvModel],
			HouseInfo[hid][hvSpawn][0],
			HouseInfo[hid][hvSpawn][1],
			HouseInfo[hid][hvSpawn][2],
			HouseInfo[hid][hvSpawn][3],
			HouseInfo[hid][hvColor][0],
			HouseInfo[hid][hvColor][1],
			18000
		);

		AutoInfo[veh][aMileage] = AutoInfo[0][aMileage];
		SetVehicleNumber(veh);
		ToggleVehicleDoor(veh, false);
		AutoInfo[veh][aFuel] += 20.0;
		AutoInfo[veh][aOwner] = INVALID_PLAYER_ID * hid;
		if(HouseInfo[hid][hvPark] == HOME_VEHICLE) {
			SetVehicleVirtualWorld(veh, hid);
			LinkVehicleToInterior(veh, 3);
		}
	} else {
		if(IsValidVehicle(HouseInfo[hid][hAuto])) Veh::Destroy(HouseInfo[hid][hAuto]);
		GetPlayerPosEx(playerid, HouseInfo[hid][hvSpawn][0], HouseInfo[hid][hvSpawn][1], HouseInfo[hid][hvSpawn][2], HouseInfo[hid][hvSpawn][3]);
		HouseInfo[hid][hvModel] = newveh;
		new veh = HouseInfo[hid][hAuto] = Veh::Create(
			HouseInfo[hid][hvModel],
			HouseInfo[hid][hvSpawn][0],
			HouseInfo[hid][hvSpawn][1],
			HouseInfo[hid][hvSpawn][2],
			HouseInfo[hid][hvSpawn][3],
			HouseInfo[hid][hvColor][0],
			HouseInfo[hid][hvColor][1],
			18000
		);
		AutoInfo[veh][aMileage] = 0.0;
		SetVehicleNumber(HouseInfo[hid][hAuto]);
		ToggleVehicleDoor(veh, false);
		AutoInfo[veh][aFuel] += 20.0;
		AutoInfo[veh][aOwner] = INVALID_PLAYER_ID * hid;
		if(IsPlayerInHouseGarage(playerid)) {
			HouseInfo[hid][hvPark] = HOME_VEHICLE;
			SetVehicleVirtualWorld(veh, hid);
			LinkVehicleToInterior(veh, 3);
		}
	}
	return 1;
}

stock Pl::SetSpawnInfo(playerid) {
	new i;	
	if(Pl::Info[playerid][pJailed]) {
		switch(Pl::Info[playerid][pJailed]) {
			case 1: {
				SetSpawnInfo(
					playerid,
					1,
					GetJailedSkin(playerid),
					264.6288,
					77.5742,
					1001.0391,
					0.0, 0, 0, 0, 0, 0, 0
				);
			}
			case 2 : {
				SetSpawnInfo(
					playerid,
					1,
					GetJailedSkin(playerid),
					1413.5350,
					-28.7661,
					1000.9248,
					90.5306,
					0, 0, 0, 0, 0, 0
				);
			}
		}
		
		return ;
	}
	
	i = Pl::Info[playerid][pHouseKey];
	if(IsValidHouse(i) && !SpawnChange{playerid}) {
		SetSpawnInfo(
			playerid,
			1,
			Pl::Info[playerid][pChar],
			HouseInfo[i][hExit][0],
			HouseInfo[i][hExit][1],
			HouseInfo[i][hExit][2],
			HouseInfo[i][hExit][3],
			0, 0, 0, 0, 0, 0
		);
	} else {
		i = Pl::FracID(playerid);
		if(IsValidFrac(i)) {
			SetSpawnInfo(
				playerid,
				1,
				Pl::Info[playerid][pChar],
				FracInfo[i][fSpawn][fSpawnPos][0],
				FracInfo[i][fSpawn][fSpawnPos][1],
				FracInfo[i][fSpawn][fSpawnPos][2],
				FracInfo[i][fSpawn][fSpawnPos][3],
				0, 0, 0, 0, 0, 0
			);
		} else {
			i = Pl::Info[playerid][pOrigin];
			if(1 <= i < sizeof SpawnInfo) {
				SetSpawnInfo(
					playerid,
					1,
					Pl::Info[playerid][pChar],
					SpawnInfo[i][spX],
					SpawnInfo[i][spY],
					SpawnInfo[i][spZ],
					SpawnInfo[i][spA],
					0, 0, 0, 0, 0, 0
				);
			} else {
				SetSpawnInfo(
					playerid,
					1,
					Pl::Info[playerid][pChar],
					SpawnInfo[1][spX],
					SpawnInfo[1][spY],
					SpawnInfo[1][spZ],
					SpawnInfo[1][spA],
					0, 0, 0, 0, 0, 0
				);
			}
		}
	}
}

stock GetIDFromName(playername[]) {
	new id = -1;
	format(query, sizeof query, "SELECT `ID` FROM `"#__TableUsers__"` WHERE BINARY `Name` = '%s'", playername);
	new Cache:result = Db::query(connDb, query, true);
	if(cache_get_row_count()) {
		cache_get_int(0, 0, id);
	}
	cache_delete(result);
	return id;
}

stock OnPlayerPickupExit(playerid) {
	if(PickupInfo[playerid][pDelay] != 0) PickupInfo[playerid][pDelay] --;
	else if(PickupInfo[playerid][pOld] != -1) {
		if(!IsPlayerInRangeOfPoint(playerid, 1.5, PickupInfo[playerid][pOldPos][0], PickupInfo[playerid][pOldPos][1], PickupInfo[playerid][pOldPos][2])) {
			PickupInfo[playerid][pOld] = -1;
		}
	}
	return 1;
}

stock IsPlayerInHouse(playerid, Float:radi = 5.0, houseid) {
	return (IsPlayerInRangeOfPoint(playerid, radi, HouseInfo[houseid][hExit][0], HouseInfo[houseid][hExit][1], HouseInfo[houseid][hExit][2]) && Pl::Info[playerid][pLocal] == (OFFSET_HOUSE + houseid));
}

stock IsPlayerInBiz(playerid, Float:radi = 5.0, bizid) {
	new id = GetIndexFromBizID(bizid);
	if(id != -1) {
		return (IsPlayerInRangeOfPoint(playerid, radi, BizzInfo[id][bExit][0], BizzInfo[id][bExit][1], BizzInfo[id][bExit][2]) && Pl::Info[playerid][pLocal] == (OFFSET_BIZZ + id));
	}
	return 0;
}


public OnQueryError(errorid, error[], callback[], querystr[], connectionHandle) {
	switch(errorid) {
		case CR_SERVER_LOST : {
			Db::reconnect(connectionHandle);
			Db::FixCharset();
			
			if(strfind(querystr, "UPDATE", true) != -1) {
				Db::tquery(connDb, querystr, "", "");
			}
			
			return 1;
		}
	}
	
	format(temp, sizeof temp, "(SQL) Query error! ( eID: %i; callback: %s )", errorid, callback),
		SendToAdmin(COLOR_LIGHTBLUE, temp, 4, 5);
	format(temp, sizeof temp, "(SQL) Error: %s", error),
		SendToAdmin(COLOR_LIGHTBLUE, temp, 4, 5);
		
	SendLog(LOG_MYSQL_ERROR,	querystr);
	DEBUG[TOTAL_QUERY_ERRORS]++;
	return 1;
}

stock AddPickup(model, type, Float:x, Float:y, Float:z, vw = -1, text[] = " ", color = INVALID_ID, Float:offsetX = 0.0, Float:offsetY = 0.0, Float:offsetZ = 0.6) {
	if(text[0] != ' ') {
		offsetX += x;
		offsetY += y;
		offsetZ += z;
		
		Add3DText(text, color, offsetX, offsetY, offsetZ, 40.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, vw);
	}
	return CreateDynamicPickup(model, type, x, y, z, vw);
}

stock _AddPickup(model, type, Float:pos[], vw = -1, text[] = " ", color = INVALID_ID, Float:offset[] = {0.0,0.0,0.6}) {
	if(text[0] != ' ') {
		offset[0] += pos[0];
		offset[1] += pos[1];
		offset[2] += pos[2];
		
		Add3DText(text, color, offset[0], offset[2], offset[3], 40.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, vw);
	}
	
	return CreateDynamicPickup(model, type, pos[0], pos[1], pos[2], vw);
}

stock Veh::Init() {
	comptruck[0] = Veh::Create(456,2747.96093750,-2470.80297852,13.89799976,270.00000000,-1,-1,600); // Component Truck <!-- Yankee -->
	Veh::Create(456,2747.80908203,-2461.05297852,13.89799976,270.00000000,-1,-1,600); // Component Truck <!-- Yankee -->
	Veh::Create(440,2748.37597656,-2440.50805664,13.85599995,270.00000000,-1,-1,600); // Component Truck <!-- Rumpo -->
	Veh::Create(440,2748.32617188,-2446.39843750,13.86100006,270.00000000,-1,-1,600); // Component Truck <!-- Rumpo -->
	Veh::Create(440,-1885.72399902,-193.76400757,18.60899925,270.00000000,-1,-1,600); // Component Truck <!-- Rumpo -->
	Veh::Create(440,-1885.72204590,-188.01600647,18.60899925,270.00000000,-1,-1,600); // Component Truck <!-- Rumpo -->
	Veh::Create(440,-1885.65002441,-182.01899719,18.60899925,270.00000000,-1,-1,600); // Component Truck <!-- Rumpo -->
	comptruck[1] = Veh::Create(456,-1851.85900879,-190.76899719,18.62500000,180.00000000,-1,-1,600); // Component Truck <!-- Yankee -->
	
	Veh::Create(591,0.66930000,-377.47270000,6.08020000,1.84030000,-1,-1,600); //Trailer 3
	Veh::Create(435,-6.37590000,-377.50960000,6.03120000,1.82230000,-1,-1,600); //Trailer 1
	Veh::Create(591,-13.11540000,-377.66600000,6.09380000,358.75850000,-1,-1,600); //Trailer 3
	Veh::Create(435,-19.57920000,-377.77120000,6.07290000,359.77210000,-1,-1,600); //Trailer 1
	Veh::Create(591,-32.75900000,-377.77610000,6.06800000,2.68620000,-1,-1,600); //Trailer 3
	Veh::Create(450,-43.65100098,-1153.68395996,1.73199999,334.00000000,-1,-1,600); //Trailer 2
	Veh::Create(591,-49.62799835,-1150.57702637,1.73199999,334.00000000,-1,-1,600); //Trailer 3
	Veh::Create(435,-55.85300064,-1147.68005371,1.73199999,334.00000000,-1,-1,600); //Trailer 1
	Veh::Create(435,-63.07899857,-1144.43505859,1.73199999,334.00000000,-1,-1,600); //Trailer 1
	Veh::Create(435,-26.51590000,-377.77090000,6.10030000,2.00990000,-1,-1,600); //Trailer 1
	
	PlayerHaul[0][pCapasity] = 150;
	PlayerHaul[1][pCapasity] = 150;
	PlayerHaul[2][pCapasity] = 100;
	PlayerHaul[3][pCapasity] = 100;
	PlayerHaul[4][pCapasity] = 50;
	PlayerHaul[5][pCapasity] = 50;
	PlayerHaul[6][pCapasity] = 50;
	PlayerHaul[7][pCapasity] = 150;
	
	new vehicles;
	for(new i; i++ < MAX_VEHICLES;) {
		if(IsValidVehicle(i)) vehicles ++;
	}
	
	return debug("Veh::Init() - Ok! Vehicles: %i", vehicles);
}

stock Area::Init() {
	Area::ASH = CreateDynamicSphere(-2027.1951, -114.5949, 1035.1719, 30.0, 1);
	Area::Shamal = CreateDynamicSphere(1.8050, 23.2547, 1199.5938, 25.0);
	Area::poppyField = CreateDynamicRectangle(-1199.7,-1065.9,-1002.0,-909.5, 0, 0, 0);
	Area::jailField = CreateDynamicRectangle(264.2168+3.0, 264.2168-34.0, 77.5795+3.0, 77.5795-3.0);
	
	return debug("Area::Init() - Ok! Areas: %i", CountDynamicAreas());
}

stock Obj::Init() {
	map::Load("maps/int_ambulance.map");		// ИНТЕРЬЕР В МАШИНЕ AMBULANCE
	map::Load("maps/cleaners.map");				// УБОРЩИКИ УЛИЦ
	map::Load("maps/resp_cnn.map");				// РЕСПА РЕПАРТЕРОВ
//	map::Load("maps/bar_in_pirce.map");			// БАР НА ПИРСЕ
//	map::Load("maps/alhambra.map",11);			// ALHAMBRA
	map::Load("maps/autovokzal.map");			// АВТОВОКЗАЛ
	map::Load("maps/int_shamal.map");			// ИНТЕРЬЕР ШАМАЛА
	map::Load("maps/lspd.map");					// БАЗА ПОЛИЦИИ
	map::Load("maps/aircraft_carrier.map");		// АВИАНОСЕЦ
	map::Load("maps/church.map",Bizz_Church);	// ЦЕРКОВЬ
	map::Load("maps/bomjatnik.map");			// БОМЖАТНИК
	map::Load("maps/db_pereezd.map");			// БД, ПЕРЕЕЗД
	map::Load("maps/fbi.map");					// ФБР
	map::Load("maps/autoshool.map");			// АВТОШКОЛА
	map::Load("maps/mapping.map");				// МАППИНГ ПО ШТАТУ
	map::Load("maps/sfmc_map.map");				// МЕДЕКИ
	map::Load("maps/sd_object.map");			// SD объекты
	map::Load("maps/vagos_object.map");			// Вагос забор
	map::Load("maps/lcn_object.map");			// La Cosa Nostra
	map::Load("maps/rm_objects.map");			// RM
	map::Load("maps/sfpd_objects.map");			// LSPD & SFPD
	map::Load("maps/fermers_objects.map");		// Колхоз забор
	map::Load("maps/gov_objects.map");			// Мэрия объекты
	map::Load("maps/cor_objects.map");			// Coronos объекты
	map::Load("maps/otel_ls.map");				// Отель ЛС
	map::Load("maps/grove_objects.map");		// Groove объекты
	map::Load("maps/factory.map");				// Завод СФ (маппинг с наруже)
	
	AddObject(19176,2146.1540527344,1603.0279541016,1002.4520263672,0,0,270); 						// Перегародка в инте СНН
	AddObject(3037,238.78999329,185.72000122,1004.22198486,90.00000000,0.00000000,270.00000000);	// Перегародка в инте ФБР
	AddObject(5302,371.95800781,155.18600464,1017.30401611,0.00000000,0.00000000,270.00000000);		// прегародка между мэрией и медиками
	AddObject(3749,1523.46533203,2773.23779297,15.53028965,0.00000000,0.00000000,270.00000000);		// YAKUZA
	
	// Дверь в Борделе
	AddObject(19428,968.58398438,-52.86700058,1001.87500000,0.00000000,0.00000000,0.00000000);
	AddObject(19428,968.57702637,-54.03900146,1001.87500000,0.00000000,0.00000000,0.00000000);
	AddObject(1491,968.49798584,-52.43099976,1000.16699219,0.00000000,0.00000000,268.00000000);

	//Заглушки в инте баллас
	AddObject(2957,2176.69799805,1594.29797363,1000.59600830,0.00000000,0.00000000,0.00000000);
	AddObject(2957,2224.27294922,1598.30505371,1000.59600830,0.00000000,0.00000000,0.00000000);
	
	// ЗАВОД
	AddObject(2957,2522.2880859,-1301.9320068,1048.9090576,0.0000000,0.0000000,270.0000000, 2); //object(chinatgaragedoor) (1)
	AddObject(2957,2577.8959961,-1290.1700439,1044.4589844,0.0000000,0.0000000,89.7500000, 2); //object(chinatgaragedoor) (2)
	AddObject(1499,2574.9331055,-1279.9379883,1043.1250000,0.0000000,0.0000000,0.0000000, 2); //object(gen_doorint05) (1)
	
	// ФИКС ВОРОТ В ИНТЕРЬЕРЕ ГАРАЖ
	AddObject(10182,608.7999900,-123.0000000,998.7000100,0.0000000,0.0000000,0.0000000); //object(michdr) (1)
	AddObject(10182,608.7999900,-129.3000000,998.7000100,0.0000000,0.0000000,0.0000000); //object(michdr) (2)
	
	SetDynamicObjectMaterialText(
		AddObject(19482, 2217.0000, -1155.5000, 1026.4000, 0.0000, 0.0000, 90.0000), 0,
		"F6 - чат\nTAB - список игроков\n\
		G   - сесть в машину пассажиром\n\
		F8  - сделать скриншот\n\
		/вопрос - задать вопрос хелперам\n\
		/help - доступные команды",
		OBJECT_MATERIAL_SIZE_256x128,
		"Arial", 18, 1, -16776961
	);
	
	return debug("Obj::Init() - Ok! Objects: %i", CountDynamicObjects());
}

stock Pup::Init() {
	GarageParkPickup[0] = AddPickup(1239, 14, 2014.6802,-1279.2001,23.8203, 0, "* Загнать в гараж *", 0x268DAEAA);
	GarageParkPickup[1] = AddPickup(1239, 14, 2107.2600,2480.5522,10.8203, 0, "* Загнать в гараж *", 0x268DAEAA);
	GarageParkPickup[2] = AddPickup(1239, 14, -2444.6260,525.1984,29.6734, 0, "* Загнать в гараж *", 0x268DAEAA);
	GarageParkPickup[3] = AddPickup(1239, 14, -2456.4290,2292.9119,4.9844, 0, "* Загнать в гараж *", 0x268DAEAA);
	
	weapon1 = AddPickup(1239, 23,296.6332,-38.2177,1001.5156, -1); //аммо лс
	weapon2 = AddPickup(1239, 23,312.2767,-166.1406,999.6010, -1); //аммо лв
	weapon3 = AddPickup(1239, 23,291.2473,-84.0021,1001.5156, -1); //аммо лв
	weapon4 = AddPickup(1239, 23,287.5871,-106.4027,1001.5156, -1); //аммо копы

	barn[0] = AddPickup(1239, 14, -1060.2505,-1195.5034,129.5133, 0, "* Амбар *", 0x268DAEAA);
	barn[1] = AddPickup(1239, 14, 2162.8804,-1660.0884,15.0859, 0, "* Сдача наркоты *", 0x268DAEAA);
	
	EstateAgency = AddPickup(1239, 23, 1721.8441,-1651.8345,20.0625, Bizz_EstateAgency);
	
	AddPickup(1239, 14, 2799.0696,-2356.5588,13.6368, 0, "* Склад материалов *", 0x268DAEAA);
	AddPickup(1239, 14, -2119.6609,-178.9174,35.3203, 0, "* Продажа материалов *", 0x268DAEAA);
	AddPickup(1239, 14, 1173.2563,-1323.3102,15.3943, 0, "* Госпиталь *", 0x268DAEAA);
	AddPickup(1239, 14, 2029.5945,-1404.6426,17.2512, 0, "* Госпиталь *", 0x268DAEAA);
	AddPickup(1239, 14, 597.1277,-1248.6479,18.2734, 0, "* Пакаеты для материалов *", 0x268DAEAA);
	AddPickup(1239, 14, -2115.7246,-78.0859,35.3203, 0, "* Купить матиреалы *", 0x268DAEAA);
	AddPickup(1239, 14, 323.0781,1118.6022,1083.8828, -1, "* Накотики *", 0x268DAEAA);
	AddPickup(1239, 14, 253.9280,69.6094,1003.6406, -1, "* Оправдать преступника *", 0x268DAEAA); 
	AddPickup(1239, 14, 256.7318,188.2524,1008.1719, -1, "* Оправдать преступника *", 0x268DAEAA);

	//============================================================================
	ammozakona[0] = AddPickup(1239, 23, 313.863555, -133.838562, 999.601562, -1); // Пикап покупки оружия
	ammozakona[1] = AddPickup(1275, 23, 308.373474, -131.458786, 999.608337, 4); // Пикап маскировки
	ammozakona[2] = AddPickup(1275, 23, 308.373474, -131.458786, 999.608337, 555); // Пикап снены одежды Армия
	ammozakona[3] = AddPickup(1242, 23, 308.097839, -140.963485, 999.601562, 4); // Пикап хеала
	Streamer::AppendArrayData(1, ammozakona[3], E_STREAMER_WORLD_ID, 4);
	Streamer::AppendArrayData(1, ammozakona[3], E_STREAMER_WORLD_ID, 15);
	Streamer::AppendArrayData(1, ammozakona[3], E_STREAMER_WORLD_ID, 555);

	//============================================================================
	healash = AddPickup(1240,20,-2027.2445,-118.8632,1035.1719,11);
	healcnn = AddPickup(1240,20,2160.9500,1599.9874,999.9737,9);
	healfbi = AddPickup(1240,20,228.6945,154.2483,1003.0234,2);
	Parashut = AddPickup(1310,19,1544.4170,-1353.1135,329.4746,0);
	//============================================================================
	Bank[0] = AddPickup(1239, 23, 2308.8254,-13.2494,26.7422,-1);
	Bank[1] = AddPickup(1239, 23, 2309.4783,-8.4624,26.7422,-1, "Счета фракций/банд/мафий", 0xFF6347AA, 0, 0, 0.9);
	testpdd = AddPickup(1239, 23, -2022.3630,-116.5412,1035.1719, 11);
	//============================================================================
	boj = AddPickup(1239,23,756.4068,-48.0776,1000.7802,-1);
	Piza = AddPickup(1239,23,375.8968,-119.4092,1001.4995,-1);
	proba = AddPickup(1239,23,450.4001,-83.6821,999.5547,-1);
	buy[0] = AddPickup(1239,23,-27.5047,-89.9378,1003.5469,-1);
	buy[1] = AddPickup(1239,23,-29.1611,-184.6501,1003.5469,-1);
	
	mak[0] = AddPickup(1239,23,375.7963,-67.9685,1001.5151,-1);
	mak[1] = AddPickup(1239,23,369.6309,-6.2745,1001.8589,-1);
	
	fire_ext = AddPickup(366, 1,369.8291,188.5891,1008.3893,7);
	
	prolaps[0] = AddPickup(1275, 23, 207.0993, -129.1810,1003.5078, -1, "* Одежда *", 0x268DAEAA);
	prolaps[1] = AddPickup(1275, 23, 209.6147, -8.2010,1005.2109, -1, "* Одежда *", 0x268DAEAA);
	saveTuning = AddPickup(1239, 23, -1663.8300,1208.2209,7.2546, 0, "* Регистрация тюнинга *", 0x268DAEAA);
	givepasport = AddPickup(1239, 23, 362.0381,173.6299,1008.0, 7, "* Паспортный стол *", 0x268DAEAA);
	
	hitpickup[0] = AddPickup(1275, 23, 948.5044,2104.2209,1011.0234, 8);
	hitpickup[1] = AddPickup(1210, 23, 963.1935,2101.9546,1011.0272, 8);
	
	helpp[0] = AddPickup(1239, 23, 2217.3362,-1146.7614,1025.7969, 1, "*** Помощь по игре ***", 0xFF6347AA);
	helpp[1] = AddPickup(1239, 23, 2271.1892,1647.2826,1084.2344,  1, "*** Помощь по игре ***", 0xFF6347AA);
	helpp[2] = AddPickup(1239, 23, 1474.5907,-1771.5734,18.7958, 0, "*** Помощь по игре ***", 0xFF6347AA);
		
	static const jnames[][] = {
		{"Безработным"},
		{"Детективом"},
		{"Адвокатом"},
		{"Проституткой"},
		{"Наркодилером"},
		{"Автоугонщиком"},
		{"Автомехаником"},
		{"Гандилером"},
		{"Автодилером"},
		{"Автобусником"},
		{"Дальнобойщиком"}
	};
	for(new i=1; i < sizeof(JobsInfo); i++) {
		format(temp, sizeof temp, "*** РАБОТА ***\nЗдесь можно устроится\n%s", jnames[JobsInfo[i][jID]]);
		JobsInfo[i][jP] = AddPickup(1239, 23, JobsInfo[i][jPos][0], JobsInfo[i][jPos][1], JobsInfo[i][jPos][2], JobsInfo[i][jV], temp, 0x268DAEAA);
	}
	
	new Float:hz = 1044.1250 - 0.5;
	FactoryPickup[0] = AddPickup(19135, 2, 2551.1204, -1300.0930, hz, 2);
	AddPickup(19135, 2, 2559.1130, -1300.0895, hz, 2);
	AddPickup(19135, 2, 2543.0723, -1300.0941, hz, 2);
	AddPickup(19135, 2, 2543.1548, -1287.2231, hz, 2);
	AddPickup(19135, 2, 2551.1267, -1287.2209, hz, 2);
	FactoryPickup[1] = AddPickup(19135, 2, 2559.1338, -1287.2196, hz, 2);
	FactoryPickup[2] = AddPickup(1275, 23, 2564.1899, -1281.3265, 1044.1, 2);
	
	for(new i; i < sizeof l_FactoryCP; i++) {
		CreateDynamicCP(l_FactoryCP[i][0], l_FactoryCP[i][1], l_FactoryCP[i][2], 0.3, 2, -1, -1, 0.5);
		CreateDynamicCP(r_FactoryCP[i][0], r_FactoryCP[i][1], r_FactoryCP[i][2], 0.3, 2, -1, -1, 0.5);
	}
	FactorySklad = CreateDynamicCP(2564.7886, -1292.9886, 1044.1250,2.0, -1, -1, -1, 3.0);

	CreateDynamicMapIcon(-2647.4233,695.6075,27.9370, 22, 0, -1, -1, -1, 200.0);

	return debug("Pup::Init() - Ok! Pickups: %i", CountDynamicPickups());
}

stock T3d::Init() {
	format(string_ah,sizeof(string_ah),">> Очередь допущенных к практической части экзамена: <<\n");
	ah_text = Add3DText(string_ah, 0x42aaffFF,-2036.0808,-115.1422,1036, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 11);
	
	Add3DText("Правила Дорожного Движения\n/pdd", 0xFF6347AA, -2026.8050537,-113.6340027,1035.1550293+1, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 11);
    Add3DText("*** Продовольственный Склад ***",0xBFF600FF,2771.2314,-2437.2632,13.6377,40.0);
	Add3DText("*** ВНИМАНИЕ ***\n\
		Для получения водительских прав\n\
		необходимо сдать теорию у доски\n\
		и занять место в очереди к двери.",
		0xFF6347AA, -2024.8572, -118.6570, 1035.1719, 10.0,
		INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 11
	);
	
	Add3DText("*** ВНИМАНИЕ ***\n\
		Перед покупкой/продажей/обеном дома\n\
		необходимо очистить сейф.\n\
		Если вы покупаете дом, удостоверьтесь,\n\
		что вы не снимаете комнату (введите /unrent)",
		0xFF6347AA, 1730.1852, -1636.3838, 20.2171, 15.0,
		INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0
	);

	for(new p; p < sizeof GangInfo; p++) {
		format(src, sizeof(src),
			"*** GANG INFO ***\n\n.::%s::.\nБизнесы: %d\nУважение: %d\n Банк: $%d\nЗахват с %d ранга",
			GetGangName(GangInfo[p][fID]),
			GangBiznes{GangInfo[p][fID]},
			GangInfo[p][gRespect],
			GetFracMoney(GangInfo[p][fID]),
			GetZRank(GangInfo[p][fID])
		);
		GangInfo[p][gText] = Add3DText(src, GetFracColor(GangInfo[p][fID]), GangInfo[p][gPosX], GangInfo[p][gPosY], GangInfo[p][gPosZ], 30.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 0);
	}

	format(temp, sizeof(temp),"{ffffff}Cклад:\n {f4c430}Топливо: %d литров\n{00ff00}Продукты: %d кг\n{f4c430}Металл: %d кг", Gm::Info[Gm::FactoryFuel], Gm::Info[Gm::FactoryProds], Gm::Info[Gm::FactoryMetal]);
	FactoryInfo[0] = Add3DText(temp, -1, -1847.7107,113.5725,16.3751, 25.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0);
	format(temp, sizeof(temp),"{ffffff}Склад:\n {f4c430}Топливо: %d л\nПродукты: %d кг\nМеталл: %d кг", Gm::Info[Gm::FactoryFuel], Gm::Info[Gm::FactoryProds], Gm::Info[Gm::FactoryMetal]);
	FactoryInfo[1] = Add3DText(temp, -1, 2565.5071,-1293.0293, 1045.0704, 40.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 2);
	
	Add3DText("Загрузка Продуктов\n/loadprods", 0xFF6347AA, -1857.7770, 110.9073, 15.7994, 25.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0);
	Add3DText("Разгрузка Металла и Топлива\n/unloadstuff", 0xFF6347AA, -1837.0381, 111.2696, 15.6467, 25.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0);

	return debug("T3d::Init() - Ok! 3DTexts: %i", CountDynamic3DTextLabels());
}

stock Mnu::Init() {
	MainMenu = CreateMenu("~w~Welcome", 1, 250.0, 120.0, 110.0, 0.0);
	AddMenuItem(MainMenu, 0, "> Log in");
	AddMenuItem(MainMenu, 0, "> Register");
	AddMenuItem(MainMenu, 0, "> ~r~Rules");
	AddMenuItem(MainMenu, 0, "> ~g~About");
	
	BuyMenu = CreateMenu("24/7", 1, 10, 127, 150.0, 100.0);
	AddMenuItem(BuyMenu, 0, "Phone ($"#TelephonePrice")");
	AddMenuItem(BuyMenu, 0, "Scrath Card ($"#ScrathCardPrice")");
 	AddMenuItem(BuyMenu, 0, "Phone Book ($"#PhoneBookPrice")");
 	AddMenuItem(BuyMenu, 0, "Dice ($"#DicePrice")");
 	AddMenuItem(BuyMenu, 0, "Car's Key's ($"#CarKeyPrice")");
 	AddMenuItem(BuyMenu, 0, "Condom ($"#CandomPrice")");
 	AddMenuItem(BuyMenu, 0, "CD-Player ($"#CDPlayerPrice")");
	
	
	ClothesMenu = CreateMenu("~g~Clothes", 1, 15.0, 200.0, 150.0, 150.0);
	AddMenuItem(ClothesMenu, 0, "Next");
	AddMenuItem(ClothesMenu, 0, "Previous");
	AddMenuItem(ClothesMenu, 0, "Select");
	AddMenuItem(ClothesMenu, 0, "Exit");
	
	
	SkinMenu = CreateMenu("~b~Skins", 1, 15.0, 150.0, 100.0, 100.0);
	AddMenuItem(SkinMenu, 0, "Next");
	AddMenuItem(SkinMenu, 0, "Previous");
	AddMenuItem(SkinMenu, 0, "Select");
	
	
	IntMenu = CreateMenu("Interiors", 1, 15.0, 150.0, 100.0, 100.0);
	AddMenuItem(IntMenu, 0, "Next");
	AddMenuItem(IntMenu, 0, "Previous");
	AddMenuItem(IntMenu, 0, "Select");
	AddMenuItem(IntMenu, 0, "Exit");
	
	
	SAInteriorsMenu = CreateMenu("Interiors", 1, 15.0, 150.0, 100.0, 100.0);
	AddMenuItem(SAInteriorsMenu, 0, "Next");
	AddMenuItem(SAInteriorsMenu, 0, "Previous");
	AddMenuItem(SAInteriorsMenu, 0, "Exit");
	
	
	AutoSolonMenu = CreateMenu("~w~CarShop", 1, 15.0, 200.0, 150.0, 150.0);
	AddMenuItem(AutoSolonMenu, 0, "Next");
	AddMenuItem(AutoSolonMenu, 0, "Previous");
	AddMenuItem(AutoSolonMenu, 0, "Buy");
	AddMenuItem(AutoSolonMenu, 0, "Exit");
	
	
	GarageMenu = CreateMenu("~w~CarGarage", 1, 15.0, 200.0, 150.0, 150.0);
	AddMenuItem(GarageMenu, 0, "Next");
	AddMenuItem(GarageMenu, 0, "Select");
	AddMenuItem(GarageMenu, 0, "Exit");
	

	BarMenu = CreateMenu("Drinks", 1, 15.000, 150.0, 150.0);
	for(new i; i < sizeof(DrinkInfo); i++) {
		format(temp, sizeof temp, "%s [$%i]", DrinkInfo[i][dName], DrinkInfo[i][dPrice]);
		AddMenuItem(BarMenu, 0, temp);
	}

	Ammu1Menu = CreateMenu("BuyGuns", 1, 15.000, 150.0, 150.0);
	for(new i; i < sizeof(Ammu1Info); i++) {
		format(temp, sizeof temp, "> %s [$%i]", Ammu1Info[i][gName], Ammu1Info[i][gPrice]);
		AddMenuItem(Ammu1Menu, 0, temp);
	}

	Ammu2Menu = CreateMenu("BuyGuns", 1, 15.000, 150.0, 150.0);
	for(new i; i < sizeof(Ammu2Info); i++) {
		format(temp, sizeof temp, "> %s [$%i]", Ammu2Info[i][gName], Ammu2Info[i][gPrice]);
		AddMenuItem(Ammu2Menu, 0, temp);
	}
	
	HitmanMenu = CreateMenu("Ammo", 1, 15.000, 200.0, 150.0, 200.0);
	for(new i; i < sizeof(HitmanAmmo); i++) {
		format(temp, sizeof temp, "> %s", HitmanAmmo[i][gName]);
		AddMenuItem(HitmanMenu, 0, temp);
	}

	BurgerMenu = CreateMenu("Burger", 1, 15.000, 150.0, 150.0);
	for(new i; i < sizeof(BurgerInfo); i++) {
		format(temp, sizeof temp, "> %s [$%i]", BurgerInfo[i][bDescription], BurgerInfo[i][bPrice]);
		AddMenuItem(BurgerMenu, 0, temp);
	}

	PizaMenu = CreateMenu("PiZZa", 1, 15.000, 150.0, 150.0);
	for(new i; i < sizeof(PizzaInfo); i++) {
		format(temp, sizeof temp, "> %s [$%i]",  PizzaInfo[i][bDescription], PizzaInfo[i][bPrice]);
		AddMenuItem(PizaMenu, 0, temp);
	}
	return 1;
}

stock ToggleVehicleEngine(vehid, value) {
	switch(GetVehicleType(GetVehicleModel(vehid))) {
		case VEHICLE_TYPE_BIKE, VEHICLE_TYPE_AUTO : {
			if(!value) {
				isEngined{vehid}=false;
				Iter::Remove(enginedVehicles, vehid);
				GetVehicleParamsEx(vehid,engine,light,alarm,doors,bonnet,boot,objective);
			} else {
				isEngined{vehid}=true;
				Iter::Add(enginedVehicles, vehid);
				GetVehicleParamsEx(vehid,engine,light,alarm,doors,bonnet,boot,objective);
			}
			SetVehicleParamsEx(vehid,isEngined{vehid},light,alarm,doors,bonnet,boot,objective);
		}
	}
	return 1;
}

stock RespawnUnoccupiedVehicles() {
	new vehid, bool:occupied[MAX_VEHICLES char] = {false, ...};
	foreach(new i: Player) {
		if((vehid = GetPlayerVehicleID(i))) {
			occupied{vehid} = true;
		}
	}
	
	for(new i; i < MAX_VEHICLES; i++) {
		if(!occupied{i}) {
			SetVehicleToRespawn(i);
		}
	}
}

stock ShowOnline(playerid, id) {
	new num;
	dialogtext[0]='\0';
	switch(id) {
		case 0: {
			format(dialogtext, sizeof dialogtext, "Фракция\tЛидер\n");
			foreach(new i : LeaderPlayers) {
				GetPlayerName(i, plname, 24);
				scf(dialogtext, src, "{FFFF00}%s\t{FFFFFF}%s [id: %i]\n", FracInfo[Pl::Info[i][pLeader]][fName], plname, i);
			}
			if(!strlen(dialogtext)) strcat(dialogtext, "Нет лидеров онлайн!");
			return SPD(playerid, D_ONLINE+1, DIALOG_STYLE_TABLIST_HEADERS, "GrandWorld Leaders", dialogtext, "OK", "");
		}
		case 1: {
			Send(playerid, COLOR_LIGHTRED, "Лицензиары онлайн:");
			foreach(new i: TeamPlayers[TEAM_LICENZERS]) {
				GetPlayerName(i, plname, 24);
				format(temp, sizeof temp, "* Лицензиар: %s. Позвонить /call %i", plname, Pl::Info[i][pNumber]);
				Send(playerid, COLOR_YELLOW, temp);
			}
		}
		case 2: {
			new fracid = Pl::FracID(playerid);
			if(fracid != 0) {
				Send(playerid, COLOR_LIGHTRED, "Члены Вашей оганизации онлайн:");
				foreach(new i: TeamPlayers[fracid]) {
					num ++;
					GetPlayerName(i, plname, 24);
					if(AFKInfo[i][afk_State] != 0) {
						if(Pl::Info[i][pLeader] == fracid) {
							format(temp, sizeof temp, "* %i. %s [id:%i] - %s (%i) {AA3333}|LEADER| {33AA33}<AFK: %i sec>", num, plname, i, RankInfo[fracid][Pl::Info[i][pRank]], Pl::Info[i][pRank], AFKInfo[i][afk_Time][0]);
						} else {
							format(temp, sizeof temp, "* %i. %s [id:%i] - %s (%i) {33AA33}<AFK: %i sec>", num, plname, i, RankInfo[fracid][Pl::Info[i][pRank]], Pl::Info[i][pRank], AFKInfo[i][afk_Time][0]);
						}
					} else {
						if(Pl::Info[i][pLeader] == fracid) {
							format(temp, sizeof temp, "* %i. %s [id:%i] - %s (%i) {AA3333}|LEADER|", num, plname, i, RankInfo[fracid][Pl::Info[i][pRank]], Pl::Info[i][pRank]);
						} else {
							format(temp, sizeof temp, "* %i. %s [id:%i] - %s (%i)", num, plname, i, RankInfo[fracid][Pl::Info[i][pRank]], Pl::Info[i][pRank]);
						}
					}
					Send(playerid, COLOR_YELLOW, temp);
				}
			} else {
				Send(playerid, COLOR_GREY, "* Вы не состоите в этой организации!");
			}
		}
		
		case 3: {
			Send(playerid, COLOR_LIGHTRED, "Адвокаты онлайн:");
			foreach(new i: JobPlayers[2]) {
				GetPlayerName(i, plname, 24);
				format(temp, sizeof temp, "* Лицензиар: %s. Позвонить /call %i", plname, Pl::Info[i][pNumber]);
				Send(playerid, COLOR_YELLOW, temp);
			}
		}
		
		case 4: {
			Send(playerid, COLOR_GREY, "Админы онлайн:");
			foreach(new i : AdminPlayers) {
				num ++;
				GetPlayerName(i, plname, 24);
				format(temp, sizeof temp, "* %i. Админ: %s [id: %i]", num, plname, i);
				Send(playerid, COLOR_GREY, temp);
			}
		}
		
		case 5: {
			Send(playerid, COLOR_LIGHTRED, "Помощники онлайн:");
			foreach(new i : HelperPlayers) {
				num ++;
				GetPlayerName(i, plname, 24);
				format(temp, sizeof temp, "* %i. %s[id:%i] Hlvl: %i", num, plname, i, Pl::Info[i][pHelper]);
				Send(playerid, COLOR_YELLOW, temp);
			}
		}
		
		case 6: {
			new hid = Pl::Info[playerid][pHouseKey];
			if(!IsValidHouse(hid)) return Send(playerid, COLOR_GREY, "* У Вас нет дома!");
			Send(playerid, COLOR_LIGHTRED, "Квартиранты онлайн:");
			foreach(new i: Player) {
				if(i != playerid && Pl::isLogged(i) && hid == Pl::Info[i][pHouseKey]) {
					GetPlayerName(i, plname, 24);
					format(temp, sizeof temp, "* %s. Позвонить /call %i", plname, i, Pl::Info[i][pNumber]);
					Send(playerid, COLOR_YELLOW, temp);
				}
			}
		}
	}

	return 1;
}

stock LoadVehicles() {
	new time = GetTickCount();
	format(query, sizeof query, "SELECT * FROM `"#__TableVehicles__"` ORDER BY `ID` ASC");
	new Cache:result = Db::query(connDb, query, true);
	new rows = cache_get_row_count();
	if(rows) {
		for(new i, veh; i < rows; i++) {
			cache_get_int(i, 0, VehicleInfo[i][vID]);
			cache_get_int(i, 1, VehicleInfo[i][vModel]);
			cache_get_float(i, 2, VehicleInfo[i][vPosX]);
			cache_get_float(i, 3, VehicleInfo[i][vPosY]);
			cache_get_float(i, 4, VehicleInfo[i][vPosZ]);
			cache_get_float(i, 5, VehicleInfo[i][vPosA]);
			cache_get_int(i, 6, VehicleInfo[i][vColor1]);
			cache_get_int(i, 7, VehicleInfo[i][vColor2]);
			cache_get_int(i, 8, VehicleInfo[i][vRespTime]);
			cache_get_int(i, 9, VehicleInfo[i][vJob]);
			cache_get_float(i, 10, AutoInfo[0][aMileage]);
			
			veh = Veh::Create(
				VehicleInfo[i][vModel],
				VehicleInfo[i][vPosX],
				VehicleInfo[i][vPosY],
				VehicleInfo[i][vPosZ],
				VehicleInfo[i][vPosA],
				VehicleInfo[i][vColor1],
				VehicleInfo[i][vColor2],
				VehicleInfo[i][vRespTime]
			);
			cache_get_str(i, 11, "p<,>a<i>[14]i", AutoInfo[veh][aTuning], AutoInfo[veh][aPaintJob]);
			AddTuning(veh);
			SetVehicleNumber(veh);
			AutoInfo[veh][aMileage] = AutoInfo[0][aMileage];
			Iter::Add(JobVehicles[VehicleInfo[i][vJob]], veh);
			AutoInfo[veh][aFuel] = float(rndNum(20,30));
			VehicleInfo[i][cID] = veh;
			TOTAL_VEHICLES ++;
		}
		debug("LoadVehicles() - Ok! Vehicles: %i. Run time: %i (ms)", TOTAL_VEHICLES, GetTickCount()-time);
	}
	cache_delete(result);
	return 1;
}

stock LoadATM() {
	ATMp[0] = CountDynamicPickups()+1;
	for(new i, Float:x, Float:y; i < sizeof ATMs; i++) {
		x = ATMs[i][0]; y = ATMs[i][1];
		AddObject(2942, ATMs[i][0], ATMs[i][1], ATMs[i][2], 0, 0, ATMs[i][3], 0);
		GetXYInFrontOfPoint(x, y, ATMs[i][3], -0.6);
		AddPickup(1239, 23, x, y, ATMs[i][2], 0);
	}
	ATMp[1] = CountDynamicPickups();
}

public: Veh::Destroy(&i) {
	if(IsValidVehicle(i)) {
		if(isEngined{i}) {
			ToggleVehicleEngine(i, 0);
		}
		AutoInfo[i][aOwner] = INVALID_PLAYER_ID;
		AutoInfo[i][aUpdate] = 25;
		AutoInfo[i][aMats] = 0;
		AutoInfo[i][aDrugs] = 0;
		AutoInfo[i][aMaxMats] = 2000;
		AutoInfo[i][aMaxDrugs] = 100;
		AutoInfo[i][aPaintJob] = 3;
		AutoInfo[i][aColor][COLOR_ONE] = 0;
		AutoInfo[i][aColor][COLOR_TWO] = 0;
		Rac::SetVehicleHealth(i, 1000.0);
		Iter::Clear(vehiclePassengers[i]);
		DestroyVehicle(i);
		i = INVALID_VEHICLE_ID;
	}
	return 1;
}

public: Veh::Create(model, Float:x, Float:y, Float:z, Float:a, color1, color2, resptime) {
	new i = CreateVehicle(model, x, y, z, a, color1, color2, resptime);
	AutoInfo[i][aOwner] = INVALID_PLAYER_ID;
	AutoInfo[i][aUpdate] = 0;
	AutoInfo[i][aMats] = 0;
	AutoInfo[i][aDrugs] = 0;
	AutoInfo[i][aMaxMats] = 2000;
	AutoInfo[i][aMaxDrugs] = 100;
	AutoInfo[i][aPaintJob] = 3;
	AutoInfo[i][aColor][COLOR_ONE] = color1;
	AutoInfo[i][aColor][COLOR_TWO] = color2;
	AutoInfo[i][aFuel] = 99.0;
	AutoInfo[i][aLimit] = 300;
	Rac::SetVehicleHealth(i, 1000.0);
	isEngined{i} = false;
	return i;
}

stock CreateZahvatTD(&Text:txdw) {
	txdw = Td::Create(320.000000, 100.000000, "~r~240");
	Td::Alignment(txdw, 2);
	Td::BackgroundColor(txdw, 255);
	Td::Font(txdw, 3);
	Td::LetterSize(txdw, 0.889998, 3.299998);
	Td::Color(txdw, -1);
	Td::SetOutline(txdw, 1);
	Td::SetProportional(txdw, 0);
	return 1;
}


stock ShowOffline(playerid, id) {
	switch(id) {
		case 0 : format(query, sizeof query, "SELECT `Name`,`Leader`,FROM_UNIXTIME(`Online`,'%%Y-%%m-%%d, %%H:%%i') FROM `"#__TableUsers__"` WHERE `Leader` >= '1' ORDER BY `Leader` ASC");
		case 1 : format(query, sizeof query, "SELECT `Name`,`Helper`,FROM_UNIXTIME(`Online`,'%%Y-%%m-%%d, %%H:%%i') FROM `"#__TableUsers__"` WHERE `Helper` >= '1' ORDER BY `Helper` DESC");
		case 2 : format(query, sizeof query, "SELECT `Name`,`Admin`,FROM_UNIXTIME(`Online`,'%%Y-%%m-%%d, %%H:%%i') FROM `"#__TableUsers__"` WHERE `Admin` >= '1' ORDER BY `Admin` DESC");
	}
	Db::tquery(connDb, query, "_ShowOffline", "ii", playerid, id);
	return 1;
}

public: _ShowOffline(playerid, id) {
	new name[24], lastdate[28];
	dialogtext[0]='\0';
	
	switch(id) {
		case 0 : {
			new num, rows = cache_get_row_count(rows);
			if(rows > 0) {
				new leaderid, leader;
				strcat(dialogtext, "Лидер\tПоследний везит\tФракция\n");
				while(rows--) {
					cache_get_row(rows, 0, name);
					cache_get_int(rows, 1, leader);
					cache_get_row(rows, 2, lastdate);
					
					if(IsValidFrac(leader)) {
						leaderid = ReturnUser(name);
						if(!Pl::isLogged(leaderid)) {
							num ++;
							scf(dialogtext, src, "{ffffff}%s\t{AA3333}%s{ffffff}\t{%h}%s\n", name, lastdate, rgb<GetFracColor(leader)>, FracInfo[leader][fName]);
						}
					}
				}
			}
			
			if(!num) {
				SPD(playerid, D_OFFLINE+1, 0, "Лидеры оффлайн", "• Нет лидеров оффлайн •", "OK", "CANCEL");
			} else {
				format(temp, sizeof temp, "Лидеры оффлайн | Лидеров: %i", num);
				SPD(playerid, D_OFFLINE+1, DIALOG_STYLE_TABLIST_HEADERS, temp, dialogtext, "OK", "CANCEL");
			}
		}
		
		case 1 : {
			new num, rows = cache_get_row_count(rows);
			if(rows) {
				new helperid, helper;
				strcat(dialogtext, "Хелпер\tПоследний везит\tРанг\n");
				while(rows--) {
					cache_get_row(rows, 0, name);
					cache_get_int(rows, 1, helper);
					cache_get_row(rows, 2, lastdate);
					if(1 <= helper <= 3) {
						helperid = ReturnUser(name);
						if(!Pl::isLogged(helperid)) {
							num ++;
							scf(dialogtext, src, "{ffffff}%s\t{AA3333}%s{ffffff}\t{33AA33}%s\n", name, lastdate, GetHelperRank(helper));
						}
					}
				}
			}
			
			if(!num) {
				SPD(playerid, D_OFFLINE+1, 0, "Хелперы оффлайн", "• Нет хелперов оффлайн •", "OK", "CANCEL");
			} else {
				SPD(playerid, D_OFFLINE+1, DIALOG_STYLE_TABLIST_HEADERS, "Хелперы оффлайн", dialogtext, "OK", "CANCEL");
			}
		}
		
		case 2 : {
			new num, rows = cache_get_row_count(rows);
			if(rows) {
				new adminid, admin;
				strcat(dialogtext, "Админ\tПоследний везит\tРанг\n");
				while(rows--) {
					cache_get_row(rows, 0, name);
					cache_get_int(rows, 1, admin);
					cache_get_row(rows, 2, lastdate);
					if(1 <= admin <= 5) {
						adminid = ReturnUser(name);
						if(!Pl::isLogged(adminid)) {
							num ++;
							scf(dialogtext, src, "{FFFFFF}%s\t{AA3333}%s{FFFFFF}\t{33AA33}%s\n", name, lastdate, GetAdminRank(admin));
						}
					}
				}
			}
			
			if(!num) {
				SPD(playerid, D_OFFLINE+1, 0, "Администраторы оффлайн", "• Нет админов оффлайн •", "OK", "CANCEL");
			} else {
				SPD(playerid, D_OFFLINE+1, DIALOG_STYLE_TABLIST_HEADERS, "Администраторы оффлайн", dialogtext, "OK", "CANCEL");
			}
		}
	}
	return 1;
}

stock GetCarID(playerid) {
	for(new i; i < TOTAL_VEHICLES; i++) {
		if(IsPlayerInVehicle(playerid, VehicleInfo[i][cID])) {
			return i;
		}
	}
	return -1;
}

stock SafeMenu(playerid, hid, type = 0) {
	if(IsValidHouse(hid)) {
		switch(type) {
			case 0: {
				new count;
				for(new i; i < MAX_HWEAP; i++) if(HouseInfo[hid][hGuns][i] != 0) count ++;
				format(dialog, sizeof dialog, "Название\tКоличество\tЛимит\n"""#_GREY_ARROW"Деньги\t{33AA33}$%i{ffffff}\t{AA3333}$10000000{ffffff}\n", HouseInfo[hid][hSafe][0]);
				scf(dialog, src, ""#_GREY_ARROW"Наркотики\t{33AA33}%i{ffffff}\t{AA3333}1000{ffffff}\n", HouseInfo[hid][hSafe][1]);
				scf(dialog, src, ""#_GREY_ARROW"Матиреалы\t{33AA33}%i{ffffff}\t{AA3333}100000{ffffff}\n", HouseInfo[hid][hSafe][2]);
				scf(dialog, src, ""#_GREY_ARROW"Оружие\t{33AA33}%i{ffffff}\t{AA3333}6{ffffff}\n", count);
				scf(dialog, src, ""#_GREY_ARROW"Аптечки\t{33AA33}%i{ffffff}\t{AA3333}100{ffffff}\n", HouseInfo[hid][hSafe][3]);
				scf(dialog, src, ""#_GREY_ARROW"Бронежилеты\t{33AA33}%i{ffffff}\t{AA3333}10{ffffff}\n", HouseInfo[hid][hSafe][4]);
				SPD(playerid, D_HMENU+14, DIALOG_STYLE_TABLIST_HEADERS, "[House Menu] > Сейф", dialog, "SELECT", "CANCEL");
			}
			case 1: {
				format(dialog, sizeof dialog, "Оружие\tКоличество\n");
				for(new i; i < MAX_HWEAP; i++) {
					if(HouseInfo[hid][hGuns][i] != 0) {
						GetWeaponName(HouseInfo[hid][hGuns][i], temp, 24);
						scf(dialog, src, "{33AA33}%s{ffffff}\t{AA3333}%i{ffffff}\n", temp, HouseInfo[hid][hAmmos][i]);
					} else {
						strcat(dialog, "{33AA33}Пусто{ffffff}\t{AA3333}0{ffffff}\n");
					}
				}
				SPD(playerid, D_HMENU+21, DIALOG_STYLE_TABLIST_HEADERS, "[House Menu] > Сейф > Оружие", dialog, "SELECT", "CANCEL");
			}
		}
		return 1;
	}
	return 0;
}

stock ClearBiz(biz) {
	if(BizzInfo[biz][bOwned] != 0) {
		new playerid = ReturnUser(BizzInfo[biz][bOwner]);
		new targetid = ReturnUser(BizzInfo[biz][bExtortion]);
		if(!Pl::isLogged(playerid)) {
			format(query, sizeof query, "UPDATE `"#__TableUsers__"` SET `Busines` = %i WHERE `Busines` = %i", INVALID_BIZ_ID, BizzInfo[biz][bID]);
			Db::tquery(connDb, query, "", "");
		} else {
			Pl::Info[playerid][pBizKey] = INVALID_BIZ_ID;
			Send(playerid, COLOR_LIGHTRED, "* Ваш бизнес был продан!");
		}
		
		if(!Pl::isLogged(targetid)) {
			format(query, sizeof query, "UPDATE `"#__TableUsers__"` SET `Busines` = %i WHERE `Busines` = %i", INVALID_BIZ_ID, BizzInfo[biz][bID]);
			Db::tquery(connDb, query, "", "");
		} else {
			Pl::Info[playerid][pBizKey] = INVALID_BIZ_ID;
			Send(targetid, COLOR_LIGHTRED, "* Ваш бизнес был продан!");
		}
	}
	BizzInfo[biz][bLocked] = 1;
	BizzInfo[biz][bOwned] = 0;
	BizzInfo[biz][bSafe] = 0;
	BizzInfo[biz][bProfit] = 0;
	strmid(BizzInfo[biz][bOwner], "The State", 0, strlen("The State"), 255);
	strmid(BizzInfo[biz][bExtortion], "No-one", 0, strlen("No-one"), 255);
	UpdateBizzPickups(biz);
	
	return 1;
}

stock ClearHouse(houseid) {
	if(IsValidVehicle(HouseInfo[houseid][hAuto])) {
		HouseInfo[houseid][hvModel] = 0;
		HouseInfo[houseid][hvColor][0] = -1;
		HouseInfo[houseid][hvColor][1] = -1;
		for(new i; i < 4; i++) HouseInfo[houseid][hvSpawn][i] = 0.0;
		AutoInfo[HouseInfo[houseid][hAuto]][aMileage] = 0.0;
		ResetTuning(HouseInfo[houseid][hAuto], 1, houseid);
		Veh::Destroy(HouseInfo[houseid][hAuto]);
	}
	if(HouseInfo[houseid][hOwned] != 0) {
		new playerid = ReturnUser(HouseInfo[houseid][hOwner]);
		if(Pl::isLogged(playerid)) {
			Pl::Info[playerid][pHouseKey] = INVALID_HOUSE_ID;
			foreach(new i : ExtraVehicles[playerid]) {
				if(ExtraVehicles[playerid][i][evPark] == PARK_HOME) {
					ExtraVehicles[playerid][i][evPark] = PARK_GARAGE;
					AddExtraVehicleToGarage(playerid, i);
					UpdateExtraVehicle(playerid, i);
					Veh::Destroy(ExtraVehicles[playerid][i][evID2]);
				}
				else if((ExtraVehicles[playerid][i][evPark] / houseid) == PARK_HOME_GARAGE) {
					ExtraVehicles[playerid][i][evPark] = PARK_GARAGE;
					AddExtraVehicleToGarage(playerid, i);
					UpdateExtraVehicle(playerid, i);
					Veh::Destroy(ExtraVehicles[playerid][i][evID2]);
				}
			}
			Send(playerid, COLOR_LIGHTRED, "* Ваш дом был продан!");
		} else {
			format(query, sizeof query, "UPDATE `"#__TableExtraVehicles__"` SET `park` = '%i' WHERE `park` = '%i'", PARK_GARAGE, PARK_HOME_GARAGE*houseid);
			Db::tquery(connDb, query, "", "");
			
			format(query, sizeof query, "UPDATE `"#__TableUsers__"` SET `House` = '%i' WHERE BINARY `House` = '%i'", INVALID_HOUSE_ID, houseid);
			Db::tquery(connDb, query, "", "");
		}
	}
	HouseInfo[houseid][hTv] = 0;
	HouseInfo[houseid][hLock] = 1;
	HouseInfo[houseid][hOwned] = 0;
	for(new i; i < 5; i++) HouseInfo[houseid][hSafe][i] = 0;
	HouseInfo[houseid][hvPark] = NONE_VEHICLE;
	for(new i; i < MAX_HWEAP; i++) {
		HouseInfo[houseid][hGuns][i] = 0;
		HouseInfo[houseid][hAmmos][i] = 0;
	}
	DeleteHouseGarage(houseid);
	strmid(HouseInfo[houseid][hOwner], "The State", 0, strlen("The State"), 255);
	UpdateHousePickups(houseid);
	return 1;
}

stock GetClosestBiz(playerid, Float:radi) {
	foreach(new i : Biznes) {
		if(IsPlayerInRangeOfPoint(playerid, radi, BizzInfo[i][bEnter][0], BizzInfo[i][bEnter][1], BizzInfo[i][bEnter][2])) {
			return i;
		}
	}
	return -1;
}

stock ShowDialog(playerid, dialogid, style, title[], filename[], buttom1[], buttom2[]) {
	static textbuff[2048];
	if(LoadFile(filename, textbuff)) {
		return SPD(playerid, dialogid, style, title, textbuff, buttom1, buttom2);
	}
	return SPD(playerid, D_NONE, 0, "ERROR", "* File dialog is not found!", "CLOSE", "");
}

stock Fc::GetModelCount(frac_id, model_id) {
	new count;
	foreach(new i : TeamVehicles[frac_id]) {
		if(GetVehicleModel(i) == model_id) {
			count ++;
		}
	}
	return count;
}

stock Fc::GetInfo(vehicleid, format[]="", ...) {
	for(new i; i < FC_TOTAL; i++) {
		if(Fc::Info[i][Fc::Id][1] == vehicleid) {
			if(!isnull(format)) {
				new _f_pos, _p_pos = 2, _params = numargs();
				while(_p_pos < _params) {
					switch(format[_f_pos++]) {
						case 'i' : setarg(_p_pos, 0, i);
						case 'r' : setarg(_p_pos, 0, Fc::Info[i][Fc::RankId]);
						case 'f' : setarg(_p_pos, 0, Fc::Info[i][Fc::FracId]);
						case 'm' : setarg(_p_pos, 0, Fc::Info[i][Fc::Model]);
						case 'x' : setarg(_p_pos, 0, _:Fc::Info[i][Fc::RespPos][0]);
						case 'y' : setarg(_p_pos, 0, _:Fc::Info[i][Fc::RespPos][1]);
						case 'z' : setarg(_p_pos, 0, _:Fc::Info[i][Fc::RespPos][2]);
						case 'a' : setarg(_p_pos, 0, _:Fc::Info[i][Fc::RespPos][3]);
					}
					_p_pos++;
				}
			}
			return 1;
		}
	}
	return 0;
}

stock Fc::FracID(vehicleid) {
	foreach(new i : Frac) {
		if(Iter::Contains(TeamVehicles[i], vehicleid)) {
			return i;
		}
	}
	return 0;
}

stock isTeamVehicle(fracid, vehicleid) {
	if(IsValidFrac(fracid)) {
		return Iter::Contains(TeamVehicles[fracid], vehicleid);
	}
	return 0;
}

stock isJobVehicle(jobid, vehicleid) {
	return Iter::Contains(JobVehicles[jobid], vehicleid);
}

stock GetVehDescription(vehicleid, format[]="", ...) {
	for(new i; i < TOTAL_VEHICLES; i++) {
		if(VehicleInfo[i][cID] == vehicleid) {
			if(!isnull(format)) {
				new a, b = 2, params = numargs();
				while(b < params) {
					switch(format[a++]) {
						case 'i' : setarg(b, 0, i);
						case 'j' : setarg(b, 0, VehicleInfo[i][vJob]);
						case 'm' : setarg(b, 0, VehicleInfo[i][vModel]);
						case 'x' : setarg(b, 0, _:VehicleInfo[i][vPosX]);
						case 'y' : setarg(b, 0, _:VehicleInfo[i][vPosY]);
						case 'z' : setarg(b, 0, _:VehicleInfo[i][vPosZ]);
						case 'a' : setarg(b, 0, _:VehicleInfo[i][vPosA]);
					}
					b++;
				}
			}
			return 1;
		}
	}
	return 0;
}


stock Fc::IsEditMode(playerid) return (Pl::Info[playerid][pAdmin]>=5&&EditMode{playerid});

stock Fc::IsForbiddenVeh(modelid) {
	return binarySearch(Fc::FORBIDDEN_VEH, modelid) != -1;
}

stock Fc::IsThereModel(fracid, modelid) {
	format(query, sizeof query, "SELECT * FROM `"#__TableFracModels__"` WHERE `frac_id` = '%i' AND `model_id` = '%i'", fracid, modelid);
	new Cache:result = Db::query(connDb, query, true);
	new rows = cache_get_row_count();
	cache_delete(result);
	return rows > 0;
}

stock Fc::ShowModel( playerid, fracid, dialogid) {
	format(query, sizeof query, "SELECT `model_id`,`model_limit` FROM `"#__TableFracModels__"` WHERE `frac_id` = '%i'", fracid);
	new Cache:result = Db::query(connDb, query, true);
	new rows = cache_get_row_count();
	if(rows) {
		new model_id, model_limit;
		dialog[0] = '\0';
		for(new i; i < rows; i++) {
			cache_get_int(i, 0, model_id);
			cache_get_int(i, 1, model_limit);
			scf(dialog, query, "%s [%i]\n", VehicleNames[model_id-400], model_limit);
		}
		if(Pl::Info[playerid][pAdmin] >= ADMINISTRATOR && dialogid != D_ADD_FC && dialogid != D_LMENU+7) strcat( dialog, "------------\nДобавить");
		SPD(playerid, dialogid, DIALOG_STYLE_LIST, "Frac Models", dialog, "SELECT", "CANCEL");
	} else {
		if(Pl::Info[playerid][pAdmin] >= ADMINISTRATOR && dialogid != D_ADD_FC && dialogid != D_LMENU+7) {
			SPD(playerid, dialogid, 2, "Frac Models", "Добавить", "ENTER", "CANCLE");
		} else {
			SPD(playerid, dialogid, 0, "Frac Models", "Нет моделей для выбора!", "ok", "");
		}
	}
	SetPVarInt(playerid, "SelectFrac", fracid);
	cache_delete(result);
	return 1;
}

stock Fc::RecreateVehicle(idx) {
	if(0 <= idx < sizeof Fc::Info) {
		Veh::Destroy(Fc::Info[idx][Fc::Id][1]);
		Fc::Info[idx][Fc::Id][1] = Veh::Create(
			Fc::Info[idx][Fc::Model],
			Fc::Info[idx][Fc::RespPos][0],
			Fc::Info[idx][Fc::RespPos][1],
			Fc::Info[idx][Fc::RespPos][2],
			Fc::Info[idx][Fc::RespPos][3],
			Fc::Info[idx][Fc::Color][0],
			Fc::Info[idx][Fc::Color][1],
			1200
		);
		return 1;
	}
	return 0;
}

stock Fc::Delete(idx) {
	if(0 <= idx < sizeof Fc::Info) {
		format(query, sizeof query, "DELETE FROM `"#__TableFracVehicles__"` WHERE `ID` = '%i'", Fc::Info[idx][Fc::Id][0]);
		Db::tquery(connDb, query, "", "");

		Fc::TOTAL --;
		Veh::Destroy(Fc::Info[idx][Fc::Id][1]);
		
		for(new i; i < 2; i++) {
			Fc::Info[idx][Fc::Id][i] = Fc::Info[Fc::TOTAL][Fc::Id][i];
			Fc::Info[idx][Fc::Color][i] = Fc::Info[Fc::TOTAL][Fc::Color][i];
		}
		
		Fc::Info[idx][Fc::Model] = Fc::Info[Fc::TOTAL][Fc::Model];
		Fc::Info[idx][Fc::FracId] = Fc::Info[Fc::TOTAL][Fc::FracId];
	
		strmid(Fc::Info[idx][Fc::Number], Fc::Info[Fc::TOTAL][Fc::Number], 0, strlen(Fc::Info[Fc::TOTAL][Fc::Number]), 255);
		
		Fc::Info[idx][Fc::RespPos][0] = Fc::Info[Fc::TOTAL][Fc::RespPos][0];
		Fc::Info[idx][Fc::RespPos][1] = Fc::Info[Fc::TOTAL][Fc::RespPos][1];
		Fc::Info[idx][Fc::RespPos][2] = Fc::Info[Fc::TOTAL][Fc::RespPos][2];
		Fc::Info[idx][Fc::RespPos][3] = Fc::Info[Fc::TOTAL][Fc::RespPos][3];
		
		return 1;
	}
	return 0;
}

SSCANF:name_to_id(string[]) {
	new model;
	if('0' <= string[0] <= '9') {
		model = strval(string);
		if(400 <= model <= 611) return model;
	} else {
		for(new i; i < sizeof(VehicleNames); i++) {
			if(strcmp(VehicleNames[i], string, true, strlen(VehicleNames[i])) == 0) {
				model += i + 400;
				break;
			}
		}
	}
	return model;
}

stock UpdateStuffTD(playerid, vehid, type) {
	if(IsPlayerConnected(playerid)) {
		new model = GetVehicleModel(vehid);
		format(src, sizeof src, "~w~VEHICLE: ~g~%s [id: %i]      %.1f (miles)", VehicleNames[model-400], model, AutoInfo[vehid][aMileage]);
		switch(type) {
			case 1 : scf(src, temp, "      MATS: ~r~%i/%i", AutoInfo[vehid][aMats], AutoInfo[vehid][aMaxMats]);
			case 2 : scf(src, temp, "      MAK: ~r~%i/%i", AutoInfo[vehicle][aDrugs], AutoInfo[vehicle][aMaxDrugs]);
			case 3 : scf(src, temp, "      PRODS: ~r~%i/%i", PlayerHaul[vehid-comptruck[0]][pLoad], PlayerHaul[vehid-comptruck[0]][pCapasity]);
		}
		Pt::SetString(playerid, Pt::Name[playerid], src);
	}
	return 1;
}

stock LoadSkins() {
	Container::AddArray(100, {78, 79, 135, 200, 230, 212, 213});
	Container::AddArray(101, {55, 152, 138, 201, 63, 54, 85});
	
	new time = GetTickCount();
	format(query, sizeof query, "SELECT `f_id`,`skin_id` FROM `frac_skins`");
	new Cache:result = Db::query(connDb, query, true);
	new rows = cache_get_row_count();
	if(rows) {
		for(new i; i < rows; i++) {
			cache_get_int(i, 0, query[0]);
			cache_get_int(i, 1, query[1]);
			Container::Add(query[0], query[1]);
		}
		debug("LoadSkins() - Ok! Skins: %i. Run time: %i (ms)", rows, GetTickCount()-time);
	}
	cache_delete(result);
	return 1;
}

stock LoadRanks( ) {
	new time = GetTickCount();
	format( query, sizeof query, "SELECT * FROM `"#__TableFracRanks__"` ORDER BY `r_id`");
	new Cache:result = Db::query(connDb, query, true);
	for(new i; i < MAX_RANK; i++) strmid(RankInfo[0][i], "-", 0, strlen("-"), 255);
	new rows = cache_get_row_count();
	if(rows) {
		for(new i, fracid, rankid; i < rows; i++) {
			cache_get_int(i, 0, fracid);
			cache_get_int(i, 1, rankid);
			cache_get_row(i, 2, RankInfo[fracid][rankid], connDb, 36);
			RankNums[fracid] ++;
		}
		debug("LoadRanks() - Ok! Ranks: %i. Run time: %i (ms)", rows, GetTickCount()-time);
	}
	cache_delete(result);
	return 1;
}

stock LoadPortals(){
	new allowed, time = GetTickCount();
	format(query, sizeof query, "SELECT * FROM `"#__TablePickups__"` ORDER BY `id`");
	new Cache:result = Db::query(connDb, query, true);
	new rows = cache_get_row_count();
	if(rows) {
		for(new i; i < rows; i++) {
			cache_get_str(i, 0, "p<,>a<i>[2]", Ptl::Info[i][Ptl::Id]);
			cache_get_str(i, 1, "p<,>a<i>[2]", Ptl::Info[i][Ptl::Model]);
			cache_get_str(i, 2, "p<,>a<i>[2]", Ptl::Info[i][Ptl::Type]);
			cache_get_str(i, 3, "p<,>a<i>[2]", Ptl::Info[i][Ptl::Inter]);
			cache_get_str(i, 4, "p<,>a<i>[2]", Ptl::Info[i][Ptl::World]);
			cache_get_str(i, 5, "p<,>a<f>[4]", Ptl::Info[i][Ptl::Portal1]);
			cache_get_str(i, 6, "p<,>a<f>[4]", Ptl::Info[i][Ptl::Portal2]);
			cache_get_int(i, 7, allowed);
			
			Ptl::Info[i][Ptl::Pickup][0]=_AddPickup(Ptl::Info[i][Ptl::Model][0],Ptl::Info[i][Ptl::Type][0],Ptl::Info[i][Ptl::Portal1],Ptl::Info[i][Ptl::World][0]);
			Ptl::Info[i][Ptl::Pickup][1]=_AddPickup(Ptl::Info[i][Ptl::Model][1],Ptl::Info[i][Ptl::Type][1],Ptl::Info[i][Ptl::Portal2],Ptl::Info[i][Ptl::World][1]);
			binToArray(allowed, Ptl::Info[i][Ptl::Allowed], MAX_FRAC);
			Iter::Add(Portal, i);
		}
		debug("LoadPortals() - Ok! Portals: %i. Run time: %i (ms)", Iter::Count(Portal), GetTickCount()-time);
	}
	cache_delete(result);
	return 1;
}

stock LoadAntiDmZones() {
	new time = GetTickCount();
	format(query, sizeof query, "SELECT * FROM `"#__TableAntidmzones__"` ORDER BY `id` ASC");
	new Cache:result = Db::query(connDb, query, true);
	new rows = cache_get_row_count();
	if(rows) {
		for(new i; i < rows; i++) {
			cache_get_int(i, 0, AntiDmInfo[i][e_AntiDmZoneId]);
			cache_get_int(i, 1, AntiDmInfo[i][e_AntiDmWorld]);
			cache_get_str(i, 2, "a<f>[4]", AntiDmInfo[i][e_AntiDmCoord]);
			
			AntiDmInfo[i][e_AntiDmZone] = CreateDynamicSphere(
				AntiDmInfo[i][e_AntiDmCoord][0],
				AntiDmInfo[i][e_AntiDmCoord][1],
				AntiDmInfo[i][e_AntiDmCoord][2],
				AntiDmInfo[i][e_AntiDmCoord][3],
				AntiDmInfo[i][e_AntiDmWorld]
			);
		}
		TOTAL_ANTIDM_ZONES = rows;
		debug("LoadAntiDmZones() - Ok! Zones: %i. Run time: %i (ms)", TOTAL_ANTIDM_ZONES, GetTickCount()-time);
	}
	cache_delete(result);
	return 1;
}


stock LoadMaps() {
	new time = GetTickCount();
	new Cache:result = Db::query(connDb, "SELECT * FROM `maps` ORDER BY `id` ASC", true);
	new rows = cache_get_row_count();
	if(rows) {
		new id, mapfile[36], world, int;
		for(new i; i < rows; i++) {
			cache_get_int(i, 0, id);
			cache_get_row(i, 1, mapfile, 36);
			cache_get_int(i, 2, world);
			cache_get_int(i, 3, int);
			strmid(MapInfo[id][MapFile], mapfile, 0, strlen(mapfile), 36);
			MapInfo[id][MapID] = map::Load(MapInfo[id][MapFile], world, int);
			Iter::Add(Maps, id);
		}
		debug("LoadMaps() - Ok! Maps: %i. Run time: %i (ms)", Iter::Count(Maps), GetTickCount()-time);
	}
	cache_delete(result);
	return 1;
}



/// :: ::: ::: BL ::: ::: ::
stock Bl::Add(playerid, accuser, reason[]) {
	new escstring[36];
	new currtime = gettime(), fracid = Pl::FracID(accuser);
	Db::escape_string(reason, escstring);
	Bl::Info[playerid][Bl::onFrac][fracid] = 1;
	Bl::Info[playerid][Bl::Kills][fracid] = 0;
	format(query, sizeof query, "INSERT INTO `"#__TableBlacklist__"` (`f_id`,`accused`,`date`,`accuser`,`reason`,`lastvisit`) VALUES (");
	scf(query, src, "'%i','%i','%i',", fracid, Pl::Info[playerid][pID], currtime);
	scf(query, src, "'%i','%s','%i')", Pl::Info[accuser][pID], escstring, currtime+DAY*15);
	Db::tquery(connDb, query, "", "");
	return 1;
}

stock Bl::Remove(playerid, fracid) {
	new name[24];
	GetPlayerName(playerid, name, 24);
	format(query, sizeof query, "DELETE FROM `"#__TableBlacklist__"` WHERE `f_id`='%i' AND `accused`='%i'", fracid, Pl::Info[playerid][pID]);
	Bl::Info[playerid][Bl::onFrac][fracid] = 0;
	Bl::Info[playerid][Bl::Kills][fracid] = 0;
	Db::tquery(connDb, query, "", "");
	return 1;
}

stock Bl::Update(playerid, fracid) {
	format(query, sizeof query, "UPDATE `"#__TableBlacklist__"` SET `mink`='%i' WHERE `accused`='%i' AND `f_id`='%i'",
	Bl::Info[playerid][Bl::Kills][fracid], Pl::Info[playerid][pID], fracid);
	Db::tquery(connDb, query, "", "");
	return 1;
}

public: Bl::Check(playerid) {
	new rows = cache_get_row_count();
	if(rows) {
		new name[24];
		GetPlayerName(playerid, name, 24);
		format(temp, sizeof temp, "[BLACK LIST] Вы находитесь в черном списке ");
		for(new i, fracid, kills; i < rows; i++) {
			sscanf(query, "p<|>ii", fracid, kills);
			cache_get_int(i, 0, fracid);
			cache_get_int(i, 1, kills);
			Bl::Info[playerid][Bl::onFrac][fracid] = 1;
			Bl::Info[playerid][Bl::Kills][fracid] = kills;
			format(query, sizeof query, "[BLACK LIST] Запахло дичью, в штате был(а) замечен(а) %s", name);
			sendToFamily(fracid, COLOR_AZTECAS, query);
			scf(temp, src, "%s, ", FracInfo[fracid][fName]);
		}

		temp[strlen(temp)-2] = '\0';
		Send(playerid, COLOR_AZTECAS, temp);

		format(query, sizeof query, "UPDATE `"#__TableBlacklist__"` SET `lastvisit` = '%i' WHERE `accused` = '%i'", (gettime()+DAY*15), Pl::Info[playerid][pID]);
		Db::tquery(connDb, query, "", "");
	}
}


stock Bl::Clear( ) {
	format(query, sizeof query, "DELETE FROM `"#__TableBlacklist__"` WHERE `lastvisit` <= '%i'", gettime());
	Db::tquery(connDb, query, "", "");
	return 1;
}

public: Bl::Show(playerid, fracid) {
	Send(playerid, COLOR_WHITE, "______________ Черный Список ______________");
	
	new accuser[24], _date[24], reason[36];
	new rows = cache_get_row_count();
	if(rows) {
		for(new i; i < rows; i++) {
			cache_get_str(i, 0, "u", query[0]);
			cache_get_int(i, 1, query[1]);
			cache_get_row(i, 2, _date);
			cache_get_row(i, 3, accuser);
			cache_get_row(i, 4, reason);
			
			if(Pl::isLogged(query[0])) {
				GetPlayerName(query[0], plname, 24);
				format(temp, sizeof temp, "* %s[ID: %i] | Статус: %i/%i | Дата: %s | Занес: %s | Причина: %s", plname, query[0], query[1], FracInfo[fracid][fBConf][bKILLS], _date, accuser, reason);
				Send(playerid, COLOR_AZTECAS, temp);
			}
		}
	}
	return 1;
}

stock Bl::ValidState(playerid) {
	switch(GetPlayerState(playerid)) {
		case 1..3, 7, 8 : return 1;
	}
	return 0;
}

stock GetGunInfo(wname[], &weaponid, &ammo, &mats) {
	for(new i; i < sizeof(GunInfo); i++) {
		if(!strcmp( wname, GunInfo[i][g_name], true)) {
			weaponid = GunInfo[i][g_id];
			ammo = GunInfo[i][g_ammo];
			mats = GunInfo[i][g_mats];
			return 1;
		}
	}
	
	return 0;
}

stock IsATeamF(fracid) {
	for(new i; i < sizeof(Teams); i++) {
		if(Teams[i] == fracid) {
			return 1;
		}
	}
	return 0;
}

stock IsATeam(playerid, mode = 0) {
	if(!mode) {
		mode = Pl::FracID(playerid);
		for(new i; i < sizeof(Teams); i++) {
			if(Teams[i] == mode) {
				return true;
			}
		}
	} else {
		for(new i; i < sizeof(Teams); i++) {
			if(Teams[i] == mode) {
				return true;
			}
		}
	}

	return false;
}

stock IsAFamily(playerid) {
	switch(Pl::FracID(playerid)) {
		case 5, 6	: return 1;
		case 8..20	: return 1;
	}
	return 0;
}

stock IsALawyer(playerid) {
	return (Pl::Info[playerid][pJob] == 2 && Pl::FracID(playerid) == 7 && Pl::Info[playerid][pRank] == 10);
}

stock GetPayCheck(level) {
	return (level * 1500);
}

stock checkvar(varname[], string[]) {
	new value[36];
	GetServerVarAsString(varname, value, sizeof value);
	return strcmp(value, string, false) == 0;
}

stock BlockPickupForPlayer(playerid, pickupid, delay=2) {
	PickupInfo[playerid][pOld] = pickupid;
	PickupInfo[playerid][pDelay] = delay;
	Streamer::GetFloatData(STREAMER_TYPE_PICKUP, pickupid, E_STREAMER_X, PickupInfo[playerid][pOldPos][0]);
	Streamer::GetFloatData(STREAMER_TYPE_PICKUP, pickupid, E_STREAMER_Y, PickupInfo[playerid][pOldPos][1]);
	Streamer::GetFloatData(STREAMER_TYPE_PICKUP, pickupid, E_STREAMER_Z, PickupInfo[playerid][pOldPos][2]);
	return 1;
}

stock Add_To_Iterator(playerid) {
	Iter::Add(TeamPlayers[Pl::FracID(playerid)], playerid);
	if(Pl::Info[playerid][pAdmin]) Iter::Add(AdminPlayers, playerid);
	if(Pl::Info[playerid][pHelper]) Iter::Add(HelperPlayers, playerid);
	if(Pl::Info[playerid][pLeader]) Iter::Add(LeaderPlayers, playerid);
	if(Pl::Info[playerid][pJob  ]) Iter::Add(JobPlayers[Pl::Info[playerid][pJob]], playerid);
}

stock Del_Of_Iterator(playerid) {
	Iter::Clear(inStreamVehicles[playerid]);
	
	Iter::Remove(AdminPlayers, playerid);
	Iter::Remove(ToglogPlayers, playerid);
	Iter::Remove(WantedPlayers, playerid);
	Iter::Remove(HelperPlayers, playerid);
	Iter::Remove(LeaderPlayers, playerid);

	Iter::Remove(TeamPlayers[Pl::FracID(playerid)], playerid);
	Iter::Remove(JobPlayers[Pl::Info[playerid][pJob]], playerid);

	foreach(new i : inStreamPlayers[playerid]) {
		Iter::Remove(inStreamPlayers[i], playerid);
	}
	Iter::Clear(inStreamPlayers[playerid]);
	
	if(Iter::Contains(MechanicCalls, playerid)) {
		Iter::Remove(MechanicCalls, playerid);
		GetPlayerName(playerid, plname, 24);
		format(temp, sizeof(temp), "* Клиент %s, вышел из игры!", plname);
		SendJobMessage(6, COLOR_AZTECAS, temp);
	}
	if(Iter::Contains(MedicCalls, playerid)) {
		Iter::Remove(MedicCalls, playerid);
		GetPlayerName(playerid, plname, 24);
		format(temp, sizeof(temp), "* Клиент %s, вышел из игры!", plname);
		sendToFamily(4, COLOR_AZTECAS, temp);
	}
}

stock HideNameTag(playerid, bool:hide) {
	if(Pl::isLogged(playerid)) {
		Pl::Info[playerid][pMaskOn] = hide;
		foreach(new i : inStreamPlayers[playerid]) {
			ShowPlayerNameTagForPlayer(i, playerid, !hide);
		}
	}
	return 1;
}

stock ClosestVeh(playerid, Float:radi = 200.0, exc = INVALID_VEHICLE_ID) {
	new Float: dist, vehicleid = INVALID_VEHICLE_ID;
	foreach(new i: inStreamVehicles[playerid]) {
		GetVehiclePos(i, vehx, vehy, vehz);
		dist = GetPlayerDistanceFromPoint(playerid, vehx, vehy, vehz);
		if(dist <= radi && i != exc) {
			radi = dist;
			vehicleid = i;
		}
	}
	return vehicleid;
}

stock GetPlayerBootVehicle(playerid, vehicleid) {
	new Float:x, Float:y, Float:z, Float:a;
	GetVehiclePos(vehicleid, x, y, z);
	GetVehicleZAngle(vehicleid, a);
	GetXYInFrontOfPoint(x, y, a, -6.0);
	foreach(new i: inStreamVehicles[playerid]) {
		if(GetVehicleDistanceFromPoint(i, x, y, z) <= (vehicleSize(i)/2.0)) {
			if(i != vehicleid) {
				return i;
			}
		}
	}
	return INVALID_VEHICLE_ID;
}

stock IsVehicleClosestForPlayer(playerid, vehicleid, Float:radi = 200.0, exc = INVALID_VEHICLE_ID) {
	new Float:x, Float:y, Float:z;
	GetVehiclePos(vehicleid, x, y, z);
	return (radi >= GetPlayerDistanceFromPoint(playerid, x, y, z) && exc == INVALID_VEHICLE_ID);
}

stock GetVehicleDriver(vehicleid) {
	if(1 <= vehicleid <= MAX_VEHICLES) {
		foreach(new p : vehiclePassengers[vehicleid]) {
			if(GetPlayerState(p) == 2) {
				return p;
			}
		}
	}
	return INVALID_PLAYER_ID;
}

stock GetVehiclePassengers(vehicleid) {
	return ((1 <= vehicleid <= MAX_VEHICLES) && Iter::Count(vehiclePassengers[vehicleid]));
}

stock GetVehicleFreeSeat(vehicleid) {
	new seatid;
	for(new i = 1; i < 3; i++) {
		if(Pl::isLogged(GetVehiclePlayerSeat(vehicleid, i))) {
			return seatid;
		}
	}
	return seatid;
}

stock GetVehiclePlayerSeat(vehicleid, seatid) {
	if(vehicleid != INVALID_VEHICLE_ID && vehicleid != 0) {
		foreach(new p : vehiclePassengers[vehicleid]) {
			if(GetPlayerVehicleSeat(p) == seatid) {
				return p;
			}
		}
	}
	return INVALID_PLAYER_ID;
}

stock Pl::setCamPos(playerid, i, vw=INVALID_ID) {
	Rac::SetPlayerInterior(playerid,EnterPos[i][iteriorid]);
	Rac::SetPlayerVirtualWorld(playerid, (vw != INVALID_ID) ? vw : (playerid+EnterPos[i][virtworld]));
	Rac::SetPlayerPos(playerid, EnterPos[i][p_pos][0], EnterPos[i][p_pos][1], EnterPos[i][p_pos][2]);
	Rac::SetPlayerFacingAngle(playerid, EnterPos[i][p_pos][3]);
	SetPlayerCameraPos(playerid, EnterPos[i][c_pos][0],EnterPos[i][c_pos][1], EnterPos[i][c_pos][2]);
	SetPlayerCameraLookAt(playerid, EnterPos[i][c_lookAt][0],EnterPos[i][c_lookAt][1], EnterPos[i][c_lookAt][2]);
	PlayerPlaySound(playerid, EnterPos[i][musicid], 0.0, 0.0, 0.0);
}

stock SlapPlayer(playerid, Float:height) {
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	return Rac::SetPlayerPos(playerid, x, y, z+height);
}

stock SetZahvatMapIcon(bizz, attack, defend) {
	foreach(new playerid : TeamPlayers[attack]) {
		SetPlayerCheckpointEx(playerid, ZAHVAT_ICON, BizzInfo[bizz][bEnter][0], BizzInfo[bizz][bEnter][1], BizzInfo[bizz][bEnter][2], 19, 0, -1, -1, true);
	}
	foreach(new playerid : TeamPlayers[defend]) {
		SetPlayerCheckpointEx(playerid, ZAHVAT_ICON, BizzInfo[bizz][bEnter][0], BizzInfo[bizz][bEnter][1], BizzInfo[bizz][bEnter][2], 19, 0, -1, -1, true);
	}
	return 1;
}

stock DisableZahvatMapIcon(attack, defend) {
	foreach(new playerid : TeamPlayers[attack]) {
		DisablePlayerCheckpointEx(playerid, ZAHVAT_ICON);
	}
	foreach(new playerid : TeamPlayers[defend]) {
		DisablePlayerCheckpointEx(playerid, ZAHVAT_ICON);
	}
	return 1;
}
	
stock SetPlayerCheckpointEx(playerid, slot, Float:x, Float:y, Float:z, icon, color, world, interior, global) {
	if(Rac::isValidPlayer(playerid)) {
		if(0 <= slot <= 5) {
			if(PlayerCheckpoints[playerid][slot] != -1) {
				DestroyDynamicMapIcon(PlayerCheckpoints[playerid][slot]);
			}
			PlayerCheckpoints[playerid][slot] = CreateDynamicMapIcon(x, y, z, icon, color, world, interior, playerid, (global)?(99999.9):(200.0));
			Streamer::SetIntData(4, PlayerCheckpoints[playerid][slot], E_STREAMER_STYLE, (global)?(MAPICON_GLOBAL_CHECKPOINT):(MAPICON_LOCAL_CHECKPOINT));
		}
	}
	return 1;
}

stock SetPlayerCheckpointPos(playerid, slot, Float:x, Float:y, Float:z) {
	if(Rac::isValidPlayer(playerid)) {
		if(0 <= slot <= 5) {
			if(PlayerCheckpoints[playerid][slot] != -1) {
				Streamer::SetFloatData(4, PlayerCheckpoints[playerid][slot], E_STREAMER_X, x);
				Streamer::SetFloatData(4, PlayerCheckpoints[playerid][slot], E_STREAMER_Y, y);
				Streamer::SetFloatData(4, PlayerCheckpoints[playerid][slot], E_STREAMER_Z, z);
				return 1;
			}
		}
	}
	return 0;
}
stock DisablePlayerCheckpointEx(playerid, slot) {
	if(Rac::isValidPlayer(playerid)) {
		if(0 <= slot <= 5) {
			if(PlayerCheckpoints[playerid][slot] != -1) {
				DestroyDynamicMapIcon(PlayerCheckpoints[playerid][slot]);
			}
		}
	}
	return 1;
}

public: onSobeitCheck(playerid) {
	new Float:x, Float:y, Float:z;
	GetPlayerCameraFrontVector(playerid, x, y, z);
	Rac::TogglePlayerControllable(playerid, true);
	format(temp, sizeof temp, "[AdmWarn] * %s[%i] прошел тест на собейт, результат - собейт %s", GetName(playerid), playerid, (y < -0.75) ? ("{AA3333}установлен"):("{33AA33}не установлен"));
	SendToAdmin(COLOR_YELLOW, temp, 1, 3);
}

public: onPTMCheck(playerid, targetid, Float:x, Float:y, Float:z) {
	if(Pl::isLogged(targetid)) {
		Rac::SetPlayerPos(targetid, x, y, z);
		format(temp, sizeof temp, "[AdmWarn] * %s[%i] прошел тест на PTM, результат - %s PTM", GetName(playerid), playerid, (GetPlayerTargetPlayer(playerid)==targetid)?("{AA3333}использует"):("{33AA33}не использует"));
		SendToAdmin(COLOR_YELLOW, temp, 1, 3);
	}
}

public: onGMTest(playerid) {
	format(temp, sizeof temp, "[AdmWarn] * %s[%i] прошел тест на GM, результат - GM %s", GetName(playerid), playerid, (GMTest{playerid})?("{AA3333}обнаружен"):("{33AA33}не обнаружен"));
	SendToAdmin(COLOR_YELLOW, temp, 1, 3);
}

stock IsPlayerInVehiclePlayer(playerid, targetid) {
	new vehicleid = GetPlayerVehicleID(playerid);
	if(vehicleid != 0) {
		if(IsPlayerInVehicle(targetid, vehicleid)) {
			return 1;
		}
	}
	return 0;
}

stock PreloadAnimlib(playerid) {
	static const animlib[][] = {
		"BOMBER"		,
		"RAPPING"		,
		"SHOP"			,
		"BEACH"			,
		"SMOKING"		,
		"FOOD"			,
		"ON_LOOKERS"	,
		"DEALER"		,
		"CRACK"			,
		"CARRY"			,
		"COP_AMBIENT"	,
		"PARK"			,
		"INT_HOUSE"		,
		"FOOD"			,
		"CRIB"			,
		"ROB_BANK"		,
		"JST_BUISNESS"	,
		"PED"			,
		"OTB"			,
		"FAT"			,
		"FIGHT_E"
	};
	for(new i; i < sizeof animlib; i++) {
		ApplyAnimation(playerid, animlib[i], "null", 0.0, 0, 0, 0, 0, 0);
	}
}


stock IsFactoryCP(playerid, lr) {
	switch(lr) {
		case 1 : {
			for(new i; i < sizeof l_FactoryCP; i++) {
				if(IsPlayerInRangeOfPoint(playerid, 0.5, l_FactoryCP[i][0], l_FactoryCP[i][1], l_FactoryCP[i][2])) {
					return 1;
				}
			}
		}
		
		case 2 : {
			for(new i; i < sizeof r_FactoryCP; i++) {
				if(IsPlayerInRangeOfPoint(playerid, 0.5, r_FactoryCP[i][0], r_FactoryCP[i][1], r_FactoryCP[i][2])) {
					return 1;
				}
			}
		}
	}
	return 0;
}

public: OnPlayerEndJob(playerid, jobid) {
	if(StartJob[playerid]) {
		switch(jobid) {
			case 1 : {
				KG[playerid][0] = 0;
				StartJob[playerid] = 0;
				DestroyObject(PlayerObject[playerid]);
				PlayerObject[playerid] = INVALID_OBJECT_ID;
				if(IsPlayerAttachedObjectSlotUsed(playerid,1)) RemovePlayerAttachedObject(playerid,1);
				if(IsPlayerAttachedObjectSlotUsed(playerid,2)) RemovePlayerAttachedObject(playerid,2);
				ApplyAnimation(playerid,"CARRY","crry_prtial",4.1,1,0,0,1,1);
				SetPlayerAttachedObject(playerid, 1 , 1279, 1, 0.062397, 0.453746, 0.000000, 0.000000, 94.689308, 0.000000);
				GameTextForPlayer(playerid,"~y~ success", 2500, 1);
			}
		}
	}
}

stock UpdateFactory() {
	new string[150];
	format(string,sizeof(string),"{ffffff}Cклад:\n {f4c430}Топливо: %d литров\n{00ff00}Продукты: %d кг\n{f4c430}Металл:%d кг",Gm::Info[Gm::FactoryFuel], Gm::Info[Gm::FactoryProds], Gm::Info[Gm::FactoryMetal]);
	UpdateDynamic3DTextLabelText(FactoryInfo[0], -1, string);
	format(string,sizeof(string),"{ffffff}Склад:\n {f4c430}Топливо: %d л\nПродукты: %d кг\nМеталл:%d кг", Gm::Info[Gm::FactoryFuel], Gm::Info[Gm::FactoryProds], Gm::Info[Gm::FactoryMetal]);
	UpdateDynamic3DTextLabelText(FactoryInfo[1], -1, string);
	return 1;
}


stock ShowLMenu(playerid, dialogid=D_LMENU-1) {
	dialog[0] = '\0';
	new fracid = Pl::FracID(playerid);
	switch(dialogid) {
		case D_LMENU-1 : {
			if(isTeamVehicle(fracid, GetPlayerVehicleID(playerid))) {
				strcat(dialog, ""#_GREY_ARROW"Транспорт\n");
			}
			strcat(dialog, ""#_GREY_ARROW"Ранги\n");
			switch(Pl::FracID(playerid)) {
				case 1..4, 7, 10 : {
					scf(dialog, temp, ""#_GREY_ARROW"Ранг новостей {AA3333}[%i]\n", GetGRank(fracid));
				}
				case 5, 6, 13 : {
					strcat(dialog, ""#_GREY_ARROW"Черный список\n");
				}
				
				case 11 : {
					scf(dialog, temp, ""#_GREY_ARROW"Ранг новостей {AA3333}[%i]\n", GetGRank(fracid));
					strcat(dialog, ""#_GREY_ARROW"Управление автошколой\n");
				}
				case 12, 14..19 : {
					strcat(dialog, ""#_GREY_ARROW"Черный список\n");
					scf(dialog, temp, ""#_GREY_ARROW"Ранг захвата {AA3333}[%i]\n", GetZRank(fracid));
				}
			}
			SPD(playerid, dialogid, DIALOG_STYLE_LIST, ""#__SERVER_PREFIX""#__SERVER_NAME_LC": LEADER MENU", dialog, "SELECT", "CANCEL");
		}
		
		case D_LMENU+9 : {
			format(dialog, sizeof dialog, ""#_GREY_ARROW"Ранг для добавления в ЧС {AA3333}[%i]\n"#_GREY_ARROW"Сумма выхода из ЧС {AA3333}[$%i]\n"#_GREY_ARROW"Убийств для выхода из ЧС {AA3333}[%i]",
			GetBRank(fracid), FracInfo[fracid][fBConf][bPRICE], FracInfo[fracid][fBConf][bKILLS]);
			SPD(playerid, D_LMENU+9, DIALOG_STYLE_LIST, "L-Menu. Черный список", dialog, "SELECT", "CANCEL");
		}
	}
	return 1;
}

stock updateBenzinTD(playerid, vehicleid) {
	if(0 <= playerid <= MAX_PLAYERS) {
		if(1 <= vehicleid <= MAX_VEHICLES) {
			format(temp, sizeof temp, (AutoInfo[vehicleid][aFuel] < 16.0)?("~w~Benzin: ~r~%.1fL"):("~w~Benzin: ~b~%.1fL"), AutoInfo[vehicleid][aFuel]);
			Pt::SetString(playerid, Pt::Fuel[playerid], temp);
		}
	}
	return 1;
}

stock ShowCantina(playerid) {
	if(Pl::FracID(playerid) == 3) {
		dialog = "Блюдо\n";
		for(new i; i < sizeof EatInfo; i++) {
			scf(dialog, temp, ""#_GREY_ARROW" %s\n", EatInfo[i][bDescription], EatInfo[i][bPrice]);
		}
	} else {
		dialog = "Блюдо\tЦена\n";
		for(new i; i < sizeof EatInfo; i++) {
			scf(dialog, temp, ""#_GREY_ARROW" %s\t{33AA33}%i${FFFFFF}\n", EatInfo[i][bDescription], EatInfo[i][bPrice]);
		}
	}
	return SPD(playerid, 149, DIALOG_STYLE_TABLIST_HEADERS, "Столовая", dialog, "Взять", "Отмена");
}

public: OnPlayerBankTransfer(playerid) {
	if(Pl::isLogged(playerid)) {
		if(GetPVarInt(playerid, "TransferPlayer")) {
			SetPVarInt(playerid, "TransferPlayer", INVALID_PLAYER_ID);
			SetPVarInt(playerid, "TransferAmount", 0);
		}
	}
}

stock ShowLoginForm(playerid, id) {
	switch(id) {
		case 0 : {
			format(dialog, sizeof dialog, "\tДля регистрации персанажа %s\n\
			\tвведите пароль и нажите \"REGISTER\"\n\nНе рекомендуется использовать простые пароли. Чтобы\n\
			 Пароль был надежным, он должен содержать цифры, \nзаглавные и малые буквы латинского алфавита.", GetName(playerid));
			SPD(playerid, D_REGG + 1, 1, ""#__SERVER_PREFIX""#__SERVER_NAME_C" REGISTRATION", dialog, "REGISTER", "CANCEL");
		}
		
		case 1 : {
			format(dialog, sizeof dialog, "Вы зашли как %s! Пожалуйста, авторизуйтесь!\nВ случаии 3-х кратного неверного ввода КИК!\n\
			Оталось папыток ввода: %i", GetName(playerid), WrongLogin[playerid]);
			SPD(playerid, D_AUTH, DIALOG_STYLE_PASSWORD, ""#__SERVER_PREFIX""#__SERVER_NAME_C" AUTORISATION. Введите ваш пароль!", dialog, "LOGIN", "CANCEL");
		}
		
		case 2 : {
			ShowDialog(playerid, D_REGG, DIALOG_STYLE_MSGBOX, "Правила сервера", "dialog/rules.txt", "I AGREE", "CANCEL");
		}
	}
	return 1;
}

public: LoadExtraVehicles(playerid) {
	new rows = cache_get_row_count();
	if(rows) {
		for(new i; i < rows; i++) {
			cache_get_int(i, 0, ExtraVehicles[playerid][i][evID1]);
			cache_get_int(i, 1, ExtraVehicles[playerid][i][evOwner]);
			cache_get_int(i, 2, ExtraVehicles[playerid][i][evModel]);
			cache_get_int(i, 3, ExtraVehicles[playerid][i][evPark]);
			cache_get_str(i, 4, "p<,>ii", ExtraVehicles[playerid][i][evColor1], ExtraVehicles[playerid][i][evColor2]);
			cache_get_str(i, 5, "p<,>ffff", ExtraVehicles[playerid][i][evSpawnX], ExtraVehicles[playerid][i][evSpawnY], ExtraVehicles[playerid][i][evSpawnZ], ExtraVehicles[playerid][i][evSpawnA]);
			
			if(ExtraVehicles[playerid][i][evPark] == PARK_HOME) {
				ExtraVehicles[playerid][i][evID2] = Veh::Create(
					ExtraVehicles[playerid][i][evModel],
					ExtraVehicles[playerid][i][evSpawnX],
					ExtraVehicles[playerid][i][evSpawnY],
					ExtraVehicles[playerid][i][evSpawnZ],
					ExtraVehicles[playerid][i][evSpawnA],
					ExtraVehicles[playerid][i][evColor1],
					ExtraVehicles[playerid][i][evColor2],
					INFINITY
				);
				AutoInfo[ExtraVehicles[playerid][i][evID2]][aOwner] = playerid;
				SetVehicleNumber(ExtraVehicles[playerid][i][evID2]);
				SetVehicleNumber(ExtraVehicles[playerid][i][evID2]);
				ToggleVehicleDoor(ExtraVehicles[playerid][i][evID2], false);
				
			} else if((ExtraVehicles[playerid][i][evPark] / Pl::Info[playerid][pHouseKey]) == PARK_HOME_GARAGE) {
				ExtraVehicles[playerid][i][evID2] = Veh::Create(
					ExtraVehicles[playerid][i][evModel],
					ExtraVehicles[playerid][i][evSpawnX],
					ExtraVehicles[playerid][i][evSpawnY],
					ExtraVehicles[playerid][i][evSpawnZ],
					ExtraVehicles[playerid][i][evSpawnA],
					ExtraVehicles[playerid][i][evColor1],
					ExtraVehicles[playerid][i][evColor2],
					INFINITY
				);
				AutoInfo[ExtraVehicles[playerid][i][evID2]][aOwner] = playerid;
				SetVehicleNumber(ExtraVehicles[playerid][i][evID2]);
				ToggleVehicleDoor(ExtraVehicles[playerid][i][evID2], false);
				LinkVehicleToInterior(ExtraVehicles[playerid][i][evID2], 3);
				SetVehicleVirtualWorld(ExtraVehicles[playerid][i][evID2], Pl::Info[playerid][pHouseKey]);
			
			} else {
				AddExtraVehicleToGarage(playerid, i);
				ExtraVehicles[playerid][i][evID2] = INVALID_VEHICLE_ID;
			}
			Iter::Add(ExtraVehicles[playerid], i);
		}
		TotalExtraVehicles[playerid] = rows;
	}
	return 1;
}

stock AddExtraVehicle(playerid, model, Float:spawn_x, Float:spawn_y, Float:spawn_z, Float:spawn_a, color1, color2, park = PARK_GARAGE, create = 1, resptime = INFINITY) {
	if(Pl::isLogged(playerid)) {
		if(TotalExtraVehicles[playerid] < MAX_EXTRA_VEHICLES) {
			new id = TotalExtraVehicles[playerid] ++;			
			format(query, sizeof query, "INSERT INTO `"#__TableExtraVehicles__"` (`owner`,`model`,`park`,`color`,`spawn`) VALUES (");
			scf(query, temp, "'%i',", Pl::Info[playerid][pID]);
			scf(query, temp, "'%i',", model);
			scf(query, temp, "'%i',", park);
			scf(query, temp, "'%i,%i',", color1, color2);
			scf(query, temp, "'%.3f,%.3f,%.3f,%.3f')", spawn_x, spawn_y, spawn_z, spawn_a);
			new Cache:result = Db::query(connDb, query, true);
			
			ExtraVehicles[playerid][id][evID1] = cache_insert_id();
			ExtraVehicles[playerid][id][evModel] = model;
			ExtraVehicles[playerid][id][evOwner] = Pl::Info[playerid][pID];
			ExtraVehicles[playerid][id][evPark] = park;
			ExtraVehicles[playerid][id][evColor1] = color1;
			ExtraVehicles[playerid][id][evColor2] = color2;
			ExtraVehicles[playerid][id][evSpawnX] = spawn_x;
			ExtraVehicles[playerid][id][evSpawnY] = spawn_y;
			ExtraVehicles[playerid][id][evSpawnZ] = spawn_z;
			ExtraVehicles[playerid][id][evSpawnA] = spawn_a;
			
			if(create) {
				ExtraVehicles[playerid][id][evID2] = Veh::Create(model, spawn_x, spawn_y, spawn_z, spawn_a, color1, color2, resptime);
				AutoInfo[ExtraVehicles[playerid][id][evID2]][aOwner] = playerid;
				SetVehicleNumber(ExtraVehicles[playerid][id][evID2]);
			} else {
				AddExtraVehicleToGarage(playerid, id);
				ExtraVehicles[playerid][id][evID2] = INVALID_PLAYER_ID;
			}
			
			Iter::Add(ExtraVehicles[playerid], id);
			cache_delete(result);
			return id;
		}
	}
	return INVALID_VEHICLE_ID;
}

stock AddExtraVehicleToGarage(playerid, slot) {
	if(TotalVehicleInGarage[playerid] < MAX_EXTRA_VEHICLES) {
		for(new i; i < TotalVehicleInGarage[playerid]; i++) {
			if(VehicleInGarage[playerid][i] == slot) return 1;
		}
		VehicleInGarage[playerid][TotalVehicleInGarage[playerid]++] = slot;
	}
	return 1;
}

stock RemoveExtraVehicleFromGarage(playerid, slot) {
	if(0 <= slot < MAX_EXTRA_VEHICLES) {
		for(new i; i < TotalVehicleInGarage[playerid]; i++) {
			if(VehicleInGarage[playerid][i] == slot) {
				VehicleInGarage[playerid][i] = VehicleInGarage[playerid][--TotalVehicleInGarage[playerid]];
				return 1;
			}
		}
	}
	return 1;
}

stock RemoveExtraVehicle(playerid, slot) {
	if(0 <= slot < MAX_EXTRA_VEHICLES) {
		format(query, sizeof query, "DELETE FROM `"#__TableExtraVehicles__"` WHERE `owner` = '%i' AND `id` = '%i'", Pl::Info[playerid][pID], ExtraVehicles[playerid][slot][evID1]);
		Db::tquery(connDb, query, "", "");
		
		Veh::Destroy(ExtraVehicles[playerid][slot][evID2]);
		new i = --TotalExtraVehicles[playerid];

		ExtraVehicles[playerid][slot][evID1] = ExtraVehicles[playerid][i][evID1];
		ExtraVehicles[playerid][slot][evID2] = ExtraVehicles[playerid][i][evID2];
		ExtraVehicles[playerid][slot][evOwner] = ExtraVehicles[playerid][i][evOwner];
		ExtraVehicles[playerid][slot][evModel] = ExtraVehicles[playerid][i][evModel];
		ExtraVehicles[playerid][slot][evPark] = ExtraVehicles[playerid][i][evPark];
		ExtraVehicles[playerid][slot][evColor1] = ExtraVehicles[playerid][i][evColor1];
		ExtraVehicles[playerid][slot][evColor2] = ExtraVehicles[playerid][i][evColor2];
		ExtraVehicles[playerid][slot][evSpawnX] = ExtraVehicles[playerid][i][evSpawnX];
		ExtraVehicles[playerid][slot][evSpawnY] = ExtraVehicles[playerid][i][evSpawnY];
		ExtraVehicles[playerid][slot][evSpawnZ] = ExtraVehicles[playerid][i][evSpawnZ];
		ExtraVehicles[playerid][slot][evSpawnA] = ExtraVehicles[playerid][i][evSpawnA];
		RemoveExtraVehicleFromGarage(playerid, i);
		Iter::Remove(ExtraVehicles[playerid], i);
		
		if(ExtraVehicles[playerid][slot][evPark] == PARK_GARAGE) {
			AddExtraVehicleToGarage(playerid, slot);
		} else {
			RemoveExtraVehicleFromGarage(playerid, slot);
		}
		return 1;
	}
	return 0;
}

stock UpdateExtraVehicle(playerid, slot) {
	if(0 <= slot < MAX_EXTRA_VEHICLES) {
		format(query, sizeof query, "UPDATE `"#__TableExtraVehicles__"` SET ");
		scf(query, temp, "`owner`='%i',", ExtraVehicles[playerid][slot][evOwner]);
		scf(query, temp, "`model`='%i',", ExtraVehicles[playerid][slot][evModel]);
		scf(query, temp, "`park`='%i',", ExtraVehicles[playerid][slot][evPark]);
		scf(query, temp, "`color`='%i,%i',", ExtraVehicles[playerid][slot][evColor1], ExtraVehicles[playerid][slot][evColor2]);
		scf(query, temp, "`spawn`='%.3f,%.3f,%.3f,%.3f' ", ExtraVehicles[playerid][slot][evSpawnX], ExtraVehicles[playerid][slot][evSpawnY], ExtraVehicles[playerid][slot][evSpawnZ], ExtraVehicles[playerid][slot][evSpawnA]);
		scf(query, temp, "WHERE `id` = '%i'", ExtraVehicles[playerid][slot][evID1]);
		Db::tquery(connDb, query, "", "");
	}
	return 1;
}

stock ShowExtraVehiclesMenu(playerid, dialogid=D_EV_MENU) {
	switch(dialogid) {
		case D_EV_MENU : {
			dialog[0] = '\0';
			new listitem;
			foreach(new i : ExtraVehicles[playerid]) {
				format(temp, sizeof temp, "extra[%i]", listitem++), SetPVarInt(playerid, temp, i);
				if(ExtraVehicles[playerid][i][evID2] != INVALID_VEHICLE_ID) {
					scf(dialog, temp, "%s %s %s\n", VehicleNames[ExtraVehicles[playerid][i][evModel] - 400],\
					gCarLock{ExtraVehicles[playerid][i][evID2]} ? ("{AA3333}[закрыт]") : ("{33AA33}[открыт]"),\
					ExtraVehicles[playerid][i][evPark] == PARK_HOME ? ("{33AA33}[домашний]") : (" "));
				} else {
					scf(dialog, temp, "%s {AA3333}[закрыт] [в гараже]\n", VehicleNames[ExtraVehicles[playerid][i][evModel] - 400]);
				}
			}
			if(!strlen(dialog)) return Send(playerid, COLOR_GREY, "* У Вас нет доп. машин!");
			SPD(playerid, D_EV_MENU, DIALOG_STYLE_LIST, "Ваш личный транспорт", dialog, "SELECT", "CANCEL");
		}
	}
	return 1;
}


stock IsPlayerTakeExtraVehicle(playerid) {
	foreach(new i : ExtraVehicles[playerid]) {
		if(ExtraVehicles[playerid][i][evID2] != INVALID_VEHICLE_ID && ExtraVehicles[playerid][i][evPark] == PARK_GARAGE) {
			return 1;
		}
	}
	return 0;
}

stock GetIdxExtraVehicleFromVehicleID(playerid, vehicleid) {
	foreach(new i : ExtraVehicles[playerid]) {
		if(ExtraVehicles[playerid][i][evID2] == vehicleid) {
			return i;
		}
	}
	return -1;
}

stock IsPlayerInHouseGarage(playerid) {
	return (IsPlayerInRangeOfPoint(playerid, 10.0, 616.0352, -124.1155, 997.7648) && Pl::Info[playerid][pLocal] == (OFFSET_HOUSE + Pl::Info[playerid][pHouseKey]));
}

stock GetPlayerPosEx(playerid, &Float:x, &Float:y, &Float:z, &Float:a) {
	new veh = GetPlayerVehicleID(playerid);
	if(veh != 0) {
		GetVehiclePos(veh, x, y, z);
		GetVehicleZAngle(veh, a);
	} else {
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, a);
	}
	return 1;
}

stock LoadGates() {
	new Cache:result = Db::query(connDb, "SELECT * FROM `gate` ORDER BY `id` ASC", true);
	new time = GetTickCount(), rows = cache_get_row_count();
	if(rows) {
		for(new i; i < rows; i++) {
			new id = cache_get_row_int(i, 0);
			GateData[id][GateID] = CreateGate();
			cache_get_int(i, 1, GateData[id][GateAttach]);
			switch(GateData[id][GateAttach]) {
				case GATE_ATTACH_FRAC : {
					cache_get_row(i, 2, temp);
					for(new j, len = strlen(temp); j < len;) {
						split(src, temp, j, ',');
						GateData[id][GateAllowed][strval(src)] = 1;
					}
				}
				default : cache_get_int(i, 2, GateData[id][GateAllowed][0]);
			}
			cache_get_int(i, 3, GateData[id][GateMode]);
			LoadGateLeaf(id, GateData[id][GateID]);
			LoadGatePickup(id, GateData[id][GateID]);
			
			switch(GateData[id][GateMode]) {
				case GATE_MODE_PICKUP : Iter::Add(GateModePickup, id);
				case GATE_MODE_KEY : Iter::Add(GateModeKey, id);
				default : Iter::Add(GateModePickup, id);
			}
			cache_set_active(result);
		}
		debug("LoadGates() - Ok! Gates: %i. Run time: %i (ms)", rows, GetTickCount()-time);
	}
	cache_delete(result);
}

stock LoadGateLeaf(id, gateid) {
	format(query, sizeof query, "SELECT * FROM `gate_leaf` WHERE `gate_id` = '%i'", id);
	new Cache:result = Db::query(connDb, query, true);
	new rows = cache_get_row_count();
	if(rows) {
		for(new i; i < rows; i++) {
			new Float:close_pos[6], Float:open_pos[6];
			cache_get_str(i, 3, "p<,>a<f>[6]", close_pos);
			cache_get_str(i, 4, "p<,>a<f>[6]", open_pos);
			new leafid = AddLeafToGate(gateid, cache_get_row_int(i, 1), close_pos, open_pos);
			SetLeafType(gateid, leafid, cache_get_row_int(i, 2));
		}
	}
	cache_delete(result);
}

stock LoadGatePickup(id, gateid) {
	format(query, sizeof query, "SELECT * FROM `gate_pickup` WHERE `gate_id` = '%i'", id);
	new Cache:result = Db::query(connDb, query, true);
	new rows = cache_get_row_count();
	if(rows) {
		for(new i; i < rows; i++) {
			new Float:pos[3];
			cache_get_str(i, 2, "p<,>a<f>[3]", pos);
			AddPickupToGate(gateid, cache_get_row_int(i, 1), pos);
		}
	}
	cache_delete(result);
}


public: EnterHouse(playerid, house) {
	Pl::Info[playerid][pLocal] = OFFSET_HOUSE + house;
	new Float:x, Float:y;
	GetXYInFrontOfPoint(x, y, HouseInfo[house][hExit][3], 1.3);
	Rac::SetPlayerPos(playerid, HouseInfo[house][hExit][0] + x, HouseInfo[house][hExit][1] + y, HouseInfo[house][hExit][2]);
	SetPlayerFacingAngle(playerid, HouseInfo[house][hExit][3]);
	Rac::SetPlayerInterior(playerid, HouseInfo[house][hInt]);
	Rac::SetPlayerVirtualWorld(playerid, HouseInfo[house][hVirtual]);
	SetCameraBehindPlayer(playerid);
	return 1;
}

public: ExitHouse(playerid, house) {
	Pl::Info[playerid][pLocal] = 0;
	new Float:x, Float:y;
	GetXYInFrontOfPoint(x, y, HouseInfo[house][hEnter][3], 1.3);
	Rac::SetPlayerPos(playerid, HouseInfo[house][hEnter][0] + x, HouseInfo[house][hEnter][1] + y, HouseInfo[house][hEnter][2]);
	SetPlayerFacingAngle(playerid, HouseInfo[house][hEnter][3]);
	Rac::SetPlayerInterior(playerid, 0);
	Rac::SetPlayerVirtualWorld(playerid, 0);
	SetCameraBehindPlayer(playerid);
	BlockPickupForPlayer(playerid, HouseInfo[house][hPickup]);
	return 1;
}

public: EnterBiz(playerid, biz) {
	Pl::Info[playerid][pLocal] = OFFSET_BIZZ + biz;
	new Float:x, Float:y;
	GetXYInFrontOfPoint(x, y, BizzInfo[biz][bExit][3], 1.3);
	Rac::SetPlayerInterior(playerid,BizzInfo[biz][bInterior]);
	Rac::SetPlayerVirtualWorld(playerid, BizzInfo[biz][bVirtual]);
	Rac::SetPlayerPos(playerid, BizzInfo[biz][bExit][0] + x, BizzInfo[biz][bExit][1] + y, BizzInfo[biz][bExit][2]);
	SetPlayerFacingAngle(playerid, BizzInfo[biz][bExit][3]);
	SetCameraBehindPlayer(playerid);
	BlockPickupForPlayer(playerid, BizzInfo[biz][bPickupExit]);
	return 1;
}

public: ExitBiz(playerid, biz) {
	Pl::Info[playerid][pLocal] = 0;
	new Float:x, Float:y;
	GetXYInFrontOfPoint(x, y, BizzInfo[biz][bEnter][3], 1.3);
	Rac::SetPlayerInterior(playerid, 0);
	Rac::SetPlayerVirtualWorld(playerid, 0);
	Rac::SetPlayerPos(playerid, BizzInfo[biz][bEnter][0] + x, BizzInfo[biz][bEnter][1] + y, BizzInfo[biz][bEnter][2]);
	SetPlayerFacingAngle(playerid, BizzInfo[biz][bEnter][3]);
	SetCameraBehindPlayer(playerid);
	BlockPickupForPlayer(playerid, BizzInfo[biz][bPickupEnter]);
	return 1;
}

stock ShowFracBank(playerid) {
	dialog[0] = '\0';
	for(new i; i < sizeof(FracID); i++) scf(dialog, temp, "%s\n", FracInfo[FracID[i]][fName]);
	return SPD(playerid, D_FBANK, DIALOG_STYLE_LIST, ""#__SERVER_PREFIX""#__SERVER_NAME_LC": Bank", dialog, "ENTER", "CANCLE");
}


stock GiveBizzProfit(biz, money) {
	BizzInfo[biz][bProfit] += money;
	BizzInfo[biz][bSafe] += money;
	return 1;
}

stock AddHouse(level, price, Float:enter[4]) {
	new Cache:result = Db::query(connDb, "INSERT INTO `houses` (`owner`) VALUES ('The State')", true);
	if(cache_affected_rows()) {
		new h = Iter::Count(Houses) + 1;
		Iter::Add(Houses, h);
		new inter = random(sizeof HouseInt);
		HouseInfo[h][hID] = cache_insert_id();
		strmid(HouseInfo[h][hOwner], "The State", 0, 9, 24);
		GetPoint3DZone(enter[0], enter[1], enter[2], HouseInfo[h][hDescription], 28);
		HouseInfo[h][hLevel] = level;
		HouseInfo[h][hPrice] = price;
		HouseInfo[h][hInt] = HouseInt[inter][Interior];
		CopyArray(HouseInfo[h][hEnter], enter, 4);
		CopyArray(HouseInfo[h][hExit], HouseInt[inter][InteriorPos], 4);
		ClearHouse(h);
		UpdateHouse(h);
		cache_delete(result);
		return h;
	}
	cache_delete(result);
	return INVALID_HOUSE_ID;
}

stock DeleteHouse(h) {
	new last = Iter::Count(Houses);
	
	format(query, sizeof query, "DELETE FROM `houses` WHERE `id` = '%i'", HouseInfo[h][hID]);
	Db::query(connDb, query, false);
	format(query, sizeof query, "UPDATE `users` SET `House` = '%i' WHERE `House` = '%i'", INVALID_HOUSE_ID, HouseInfo[h][hID]);
	Db::query(connDb, query, false);
	
	DestroyDynamicPickup(HouseInfo[h][hPickup]);
	DestroyDynamicMapIcon(HouseInfo[h][hMapIcon]);
	DeleteHouseGarage(h);
	
	new playerid = ReturnUser(HouseInfo[h][hOwner]);
	if(Pl::isLogged(playerid)) Pl::Info[playerid][pHouseKey] = INVALID_HOUSE_ID;
	
	if(last > h) {
		Iter::Remove(Houses, last);
		format(query, sizeof query, "UPDATE `houses` SET `id` = '%i' WHERE `id` = '%i'", h, last);
		Db::query(connDb, query, false);
		format(query, sizeof query, "UPDATE `users` SET `House` = '%i' WHERE `House` = '%i'", h, last);
		Db::query(connDb, query, false);

		playerid = ReturnUser(HouseInfo[last][hOwner]);
		if(Pl::isLogged(playerid)) Pl::Info[playerid][pHouseKey] = h;
		
		if(HouseInfo[last][hgGarage]) {
			format(query, sizeof query, "UPDATE `houses_garage` SET `house` = '%i' WHERE `house` = '%i'", h, last);
			Db::tquery(connDb, query);
			
		}
		HouseInfo[h][hOwned] = HouseInfo[last][hOwned];
		HouseInfo[h][hLock] = HouseInfo[last][hLock];
		CopyArray(HouseInfo[h][hOwner], HouseInfo[last][hOwner], 24);
		CopyArray(HouseInfo[h][hDescription], HouseInfo[last][hDescription], 28);
		HouseInfo[h][hPrice] = HouseInfo[last][hPrice];
		HouseInfo[h][hLevel] = HouseInfo[last][hLevel];
		HouseInfo[h][hInt] = HouseInfo[last][hInt];
		HouseInfo[h][hTv] = HouseInfo[last][hTv];
		HouseInfo[h][hDate] = HouseInfo[last][hDate];
		CopyArray(HouseInfo[h][hRent], HouseInfo[last][hRent], 2);
		CopyArray(HouseInfo[h][hSafe], HouseInfo[last][hSafe], 5);
		CopyArray(HouseInfo[h][hGuns], HouseInfo[last][hGuns], MAX_HWEAP);
		CopyArray(HouseInfo[h][hAmmos], HouseInfo[last][hAmmos], MAX_HWEAP);
		CopyArray(HouseInfo[h][hEnter], HouseInfo[last][hEnter], 4);
		CopyArray(HouseInfo[h][hExit], HouseInfo[last][hExit], 4);
		HouseInfo[h][hvModel] = HouseInfo[last][hvModel];
		CopyArray(HouseInfo[h][hvColor], HouseInfo[last][hvColor], 2);
		CopyArray(HouseInfo[h][hvSpawn], HouseInfo[last][hvSpawn], 4);
		HouseInfo[h][hvPark] = HouseInfo[last][hvPark];
		CopyArray(HouseInfo[h][hvSpawn], HouseInfo[last][hvSpawn], 4);
		
		HouseInfo[h][hgGarage] = HouseInfo[last][hgGarage];
		CopyArray(HouseInfo[h][hgIntPos], HouseInfo[last][hgIntPos], 4);
		CopyArray(HouseInfo[h][hgStreetPos], HouseInfo[last][hgStreetPos], 4);
		HouseInfo[h][hgPickupInt] = HouseInfo[last][hgPickupInt];
		HouseInfo[h][hgPickupStreet] = HouseInfo[last][hgPickupStreet];
		
		HouseInfo[h][hPickup] = HouseInfo[last][hPickup];
		HouseInfo[h][hMapIcon] = HouseInfo[last][hMapIcon];
		HouseInfo[h][hVirtual] = HouseInfo[last][hVirtual];
		HouseInfo[h][hAuto] = HouseInfo[last][hAuto];
	} else {
		Iter::Remove(Houses, h);
	}
	
	format(query, sizeof query, "ALTER TABLE `houses` AUTO_INCREMENT = %i", last < 1 ? 1 : last);
	Db::query(connDb, query, false);
	return 1;
}

stock UpdateSpeedometer(playerid, speed) {
	switch(speed) {
		case 0..9: Pt::SetString(playerid, Pt::Speed[playerid][0], "~w~~h~I");
		case 10..14: Pt::SetString(playerid, Pt::Speed[playerid][0], "~w~~h~II");
		case 15..19: Pt::SetString(playerid, Pt::Speed[playerid][0], "~g~III");
		case 20..24: Pt::SetString(playerid, Pt::Speed[playerid][0], "~g~IIII");
		case 25..29: Pt::SetString(playerid, Pt::Speed[playerid][0], "~g~~h~IIIII");
		case 30..34: Pt::SetString(playerid, Pt::Speed[playerid][0], "~g~~h~IIIIII");
		case 35..39: Pt::SetString(playerid, Pt::Speed[playerid][0], "~g~~h~IIIIIII");
		case 40..44: Pt::SetString(playerid, Pt::Speed[playerid][0], "~g~~h~IIIIIIII");
		case 45..49: Pt::SetString(playerid, Pt::Speed[playerid][0], "~g~~h~~h~IIIIIIIII");
		case 50..59: Pt::SetString(playerid, Pt::Speed[playerid][0], "~g~~h~~h~IIIIIIIIII");
		case 60..64: Pt::SetString(playerid, Pt::Speed[playerid][0], "~g~~h~~h~IIIIIIIIIII");
		case 65..69: Pt::SetString(playerid, Pt::Speed[playerid][0], "~g~~h~~h~IIIIIIIIIIII");
		case 70..79: Pt::SetString(playerid, Pt::Speed[playerid][0], "~y~IIIIIIIIIIIII");
		case 80..89: Pt::SetString(playerid, Pt::Speed[playerid][0], "~y~IIIIIIIIIIIIII");
		case 90..99: Pt::SetString(playerid, Pt::Speed[playerid][0], "~y~~h~IIIIIIIIIIIIIII");
		case 100..109: Pt::SetString(playerid, Pt::Speed[playerid][0], "~y~~h~IIIIIIIIIIIIIIII");
		case 110..119: Pt::SetString(playerid, Pt::Speed[playerid][0], "~y~~h~IIIIIIIIIIIIIIIII");
		case 120..129: Pt::SetString(playerid, Pt::Speed[playerid][0], "~y~~h~IIIIIIIIIIIIIIIIII");
		case 130..139: Pt::SetString(playerid, Pt::Speed[playerid][0], "~y~~h~IIIIIIIIIIIIIIIIIII");
		case 140..149: Pt::SetString(playerid, Pt::Speed[playerid][0], "~y~~h~IIIIIIIIIIIIIIIIIIII");
		case 150..164: Pt::SetString(playerid, Pt::Speed[playerid][0], "~y~~h~IIIIIIIIIIIIIIIIIIIII");
		case 165..174: Pt::SetString(playerid, Pt::Speed[playerid][0], "~y~~h~IIIIIIIIIIIIIIIIIIIIII");
		case 175..189: Pt::SetString(playerid, Pt::Speed[playerid][0], "~r~IIIIIIIIIIIIIIIIIIIIIII");
		case 190..199: Pt::SetString(playerid, Pt::Speed[playerid][0], "~r~IIIIIIIIIIIIIIIIIIIIIIII");
		case 200..209: Pt::SetString(playerid, Pt::Speed[playerid][0], "~r~~h~IIIIIIIIIIIIIIIIIIIIIIIII");
		case 210..219: Pt::SetString(playerid, Pt::Speed[playerid][0], "~r~~h~IIIIIIIIIIIIIIIIIIIIIIIIII");
		case 220..229: Pt::SetString(playerid, Pt::Speed[playerid][0], "~r~~h~IIIIIIIIIIIIIIIIIIIIIIIIIII");
		case 230..239: Pt::SetString(playerid, Pt::Speed[playerid][0], "~r~~h~~h~IIIIIIIIIIIIIIIIIIIIIIIIIIII");
		case 240..249: Pt::SetString(playerid, Pt::Speed[playerid][0], "~r~~h~~h~IIIIIIIIIIIIIIIIIIIIIIIIIIIII");
		default: Pt::SetString(playerid, Pt::Speed[playerid][0], "~r~~h~~h~IIIIIIIIIIIIIIIIIIIIIIIIIIIII");
	}
	return 1;
}

stock GetSkillLevel(playerid, skill) {
	new level = Pl::Info[playerid][pSkill][skill];
	if(0 <= level <= 50) return 1;
	else if(51 <= level <= 100) return 2;
	else if(101 <= level <= 200) return 3;
	else if(201 <= level <= 400) return 4;
	else if(level >= 401) return 5;
	return 1;
}

stock ShowRefillDialog(playerid, biz) {
	if(BizzInfo[biz][bProds] <= 0) return GameTextForPlayer(playerid, "~r~Out of stock", 5000, 1);
	format(dialog, sizeof dialog, "На заправке имеется %i литров.\nСтоимость 1 литра: %i$\n\nВведите количество литров, которое хотите заправить:",
	BizzInfo[biz][bProds] * 10, BizzInfo[biz][bEnterCost]/100);
	SPD(playerid, D_REFILL, DIALOG_STYLE_INPUT, BizzInfo[biz][bDescription], dialog, "ENTER", "CENCEL");
	SetCameraBehindPlayer(playerid);
	return 1;
}