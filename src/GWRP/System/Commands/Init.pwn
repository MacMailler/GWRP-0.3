#if !defined _System_Commands_Init_
#define _System_Commands_Init_

stock commands::Init() {
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
}

#endif