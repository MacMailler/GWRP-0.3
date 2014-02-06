/*
	Daniel's Command Processing Plugin
	© 2012-2013, Daniel_Cortez

License:		http://creativecommons.org/licenses/by-sa/3.0/
*/


native DC_CMD(playerid, cmdtext[]);
native RegisterAlt(const command[], alt1[], ...);

#define CMD:%0(%1) \
			forward _%0(%1); \
			public _%0(%1)

#define COMMAND:%1(%2) \
			CMD:%1(%2)

#define DC_CMD:%1(%2) \
			CMD:%1(%2)

#define ALT:%0:%1; \
			forward _%1(playerid, params[]); \
			public _%1(playerid, params[]) \
				return _%0(playerid, params);

#define	cmd::%0(%1)	\
			_%0(%1)

#if !defined isnull
	#define isnull(%1) \
				((!(%1[0])) || (((%1[0]) == '\1') && (!(%1[1]))))
#endif

forward OnPlayerCommandReceived(playerid, cmdtext[]);
forward OnPlayerCommandPerformed(playerid, cmdtext[], success);