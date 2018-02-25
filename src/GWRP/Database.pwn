
#if !defined _Core_Database_
#define _Core_Database_


new cache_row[STRING_SIZE_512];
#define cache_get_scn(%0,%1,%2) cache_get_value_index(%0,%1,cache_row),sscanf(cache_row,%2)
#define cache_get_str(%0,%1,%2) cache_get_value_index(%0,%1,%2)
#define cache_get_int(%0,%1,%2) cache_get_value_index_int(%0,%1,%2)
#define cache_get_float(%0,%1,%2) cache_get_value_index_float(%0,%1,%2)


static db::Host[STRING_SIZE_128] = "localhost";
static db::User[STRING_SIZE_64] = "root";
static db::Base[STRING_SIZE_64] = "";
static db::Pass[STRING_SIZE_64] = "";
static db::Charset[STRING_SIZE_16] = "cp1251";
static db::Debug = 0;
new db::Salt[STRING_SIZE_32] = "NDgxNTE2MjM0Mg==";

new MySQL:db::Handle;


stock db::Init() {
	if(db::configInit()) {
		db::log(db::Debug == 1 ? (ERROR | WARNING | DEBUG) : (ERROR | WARNING));
		
		db::Handle = db::connect(db::Host, db::User, db::Pass, db::Base);
		
		new errno = db::errno();
		if(errno == 0) {
			db::FixCharset();
			db::Prepare();
		}
		return errno == 0;
	}
	return false;
}

stock db::FixCharset() {
	new temp1[64];
	db::set_charset(db::Charset);
	format(temp1, sizeof temp1, "SET NAMES '%s'", db::Charset);
	db::query(db::Handle, temp1, false);
	db::query(db::Handle, "SET SESSION character_set_server='utf8';", false);
	return 1;
}

stock db::Prepare() {
	if(fexist("update.sql")) {
		db::query_file(db::Handle, "update.sql", false);
	}
	return 1;
}

stock db::configInit() {
	new iniFile = iniOpen("conf.ini");
	if(iniFile != INI_FILE_NOT_FOUND) {
		iniGet(iniFile, "mysql.host", db::Host, STRING_SIZE_128);
		iniGet(iniFile, "mysql.user", db::User, STRING_SIZE_64);
		iniGet(iniFile, "mysql.base", db::Base, STRING_SIZE_64);
		iniGet(iniFile, "mysql.pass", db::Pass, STRING_SIZE_64);
		iniGet(iniFile, "mysql.charset", db::Charset, STRING_SIZE_16);
		iniGetInt(iniFile, "mysql.debug", db::Debug);
		iniGet(iniFile, "mysql.key_salt", db::Salt, STRING_SIZE_32);
		
		iniClose(iniFile);
		
		return 1;
	}
	return 0;
}

#endif