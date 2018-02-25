
#if !defined _Core_Macro_
#define _Core_Macro_

#define __GamemodeName__		"GWRP"
#define __GamemodeVersion__		"0.3"
#define __GamemodeCopyright__	"(c) MacMailler, 2018"

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

#define _GREY_ARROW				"{888888}» {ffffff}"

#define INFINITY 				0x7F800000
#define REPLACE_TEXT 			"**ADBlock**"

#define scf(%0,%1,%2)				format(%1,sizeof(%1),%2), strcat(%0,%1)
#define sendf(%0,%1,%2,%3)			format(%1,sizeof(%1),%3),SendClientMessage(%0,%2,%1)
#define getname(%0->%1,%2->%3)		GetPlayerName(%0,%1,24), GetPlayerName(%2,%3,24)

#define HOLDING(%0)					((newkeys & (%0)) == (%0))
#define PRESSED(%0)					(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
#define RELEASED(%0)				(((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))

#define KEY_AIM 					(128)
#define KEY_RADIO 					(262144)

#define Send						SendClientMessage
#define SendToAll					SendClientMessageToAll
#define SPD							ShowPlayerDialog

#define issqlnull(%0)				(strcmp(%0,"NULL",false)==0)

#define debug(%0,%1)				printf("[debug] "#%0"",%1)

#define public:%0(%1)				forward %0(%1); public %0(%1)

#define stock:%0(%1)				forward %0(%1); stock %0(%1)

#define KickEx(%0,%1,%2)			Send(%0,%2,%1),Kick(%0)

#define BODY_PART_TORSO (3)
#define BODY_PART_GROIN (4)
#define BODY_PART_LEFT_ARM (5)
#define BODY_PART_RIGHT_ARM (6)
#define BODY_PART_LEFT_LEG (7)
#define BODY_PART_RIGHT_LEG (8)
#define BODY_PART_HEAD (9)

#define FOREACH_NO_BOTS

#define STRING_SIZE_8 8
#define STRING_SIZE_16 16
#define STRING_SIZE_32 32
#define STRING_SIZE_64 64
#define STRING_SIZE_128 128
#define STRING_SIZE_256 256
#define STRING_SIZE_512 512
#define STRING_SIZE_1024 1024

native IsValidVehicle(vehicleid);

#endif