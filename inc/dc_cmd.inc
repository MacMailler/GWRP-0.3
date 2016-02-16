/*
	Daniel's Command Processing Plugin
	© 2012-2014, Daniel_Cortez

You may use this plugin however you want.
Just don't claim this work as yours and do not try to decompile/disassemble it, etc.
*/

#if defined _Pawn && defined DC_CMD
	#endinput
#endif

#define	DC_CMD_VERSION_MAJOR	2
#define	DC_CMD_VERSION_MINOR	8

enum dc_cmd_script_type{
	dc_cmd_filterscript = 0,
	dc_cmd_gamemode
};

// "#if defined _Pawn" is crashing Pawn compiler for some reason
#if !defined __STDC__ && !defined __cplusplus
	native DC_CMD(playerid, cmdtext[]);
	native DC_CMD_Init(dc_cmd_script_type:script_type);
	native RegisterAlt(const command[], alt1[], ...);
	native RemoveCmd(const command[]);
	native RenameCmd(const oldname[], const newname[]);

	public DC_CMD_include_version = DC_CMD_VERSION_MAJOR<<16 | DC_CMD_VERSION_MINOR;
	#pragma unused DC_CMD_include_version


	#define CMD:%0(%1)	\
				public cmd_%0(%1);	\
				public cmd_%0(%1)

	#define COMMAND:%1(%2)	\
				CMD:%1(%2)

	#define DC_CMD:%1(%2)	\
				CMD:%1(%2)

	#define ALT:%0:%1; \
				public cmd_%1(playerid, params[]);	\
				public cmd_%1(playerid, params[])	\
					return cmd_%0(playerid, params);

	#define ALTX:%0(%1);	\
		public alt_%0();	\
		public alt_%0()	\
			RegisterAlt("/"#%0, %1);

	#define	cmd::%0(%1)	\
				cmd_%0(%1)

	#if !defined isnull
		#define isnull(%1) \
					(((%1[0]) == 0) || ((%1[0]) == '\1') && ((%1[1]) == 0))
	#endif

	public OnPlayerCommandText(playerid, cmdtext[]){
		return DC_CMD(playerid, cmdtext);
	}
	#if defined _ALS_OnPlayerCommandText
		#undef OnPlayerCommandText
	#else
		#define _ALS_OnPlayerCommandText
	#endif
	#if defined dc_cmd_OnPlayerCommandText
		forward dc_cmd_OnPlayerCommandText(playerid, cmdtext[]);
	#endif
	#define	OnPlayerCommandText dc_cmd_OnPlayerCommandText


	public OnFilterScriptInit(){
		DC_CMD_Init(dc_cmd_filterscript);
		#if defined dc_cmd_OnFilterScriptInit
			dc_cmd_OnFilterScriptInit();
		#endif
		return 1;
	}
	#if defined _ALS_OnFilterScriptInit
		#undef OnFilterScriptInit
	#else
		#define _ALS_OnFilterScriptInit
	#endif
	#if	defined	dc_cmd_OnFilterScriptInit
		forward dc_cmd_OnFilterScriptInit();
	#endif
	#define	OnFilterScriptInit dc_cmd_OnFilterScriptInit

	public OnGameModeInit(){
		DC_CMD_Init(dc_cmd_gamemode);
		#if defined dc_cmd_OnGameModeInit
			dc_cmd_OnGameModeInit();
		#endif
		return 1;
	}
	#if defined _ALS_OnGameModeInit
		#undef OnGameModeInit
	#else
		#define _ALS_OnGameModeInit
	#endif
	#if	defined	dc_cmd_OnGameModeInit
		forward dc_cmd_OnGameModeInit();
	#endif
	#define	OnGameModeInit dc_cmd_OnGameModeInit


	#if	defined	OnPlayerCommandReceived
		forward OnPlayerCommandReceived(playerid, cmdtext[]);
	#endif
	#if	defined	OnPlayerCommandPerformed
		forward OnPlayerCommandPerformed(playerid, cmdtext[], success);
	#endif
#endif