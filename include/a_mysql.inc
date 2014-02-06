/*
	SA-MP MySQL plugin R5
	Copyright (c) 2008-2010, G-sTyLeZzZ 
*/

#if defined mysql_included
	#endinput
#endif
#define mysql_included

//Common error codes (http://dev.mysql.com/doc/refman/5.0/en/error-messages-(client|server).html)

#define ER_DBACCESS_DENIED_ERROR 1044
#define ER_ACCESS_DENIED_ERROR 1045
#define ER_UNKNOWN_TABLE 1109
#define ER_SYNTAX_ERROR 1149
#define CR_SERVER_GONE_ERROR 2006
#define CR_SERVER_LOST 2013
#define CR_COMMAND_OUT_OF_SYNC 2014
#define CR_SERVER_LOST_EXTENDED 2055

//Native functions

#define mysql_fetch_row(%1) mysql_fetch_row_format(%1,"|")
#define mysql_next_row() mysql_retrieve_row()
#define mysql_get_field(%1,%2) mysql_fetch_field_row(%2,%1)

native mysql_affected_rows(connectionHandle = 1);
native mysql_close(connectionHandle = 1);
native mysql_connect(const host[],const user[],const database[],const password[]);
native mysql_debug(enable = 1);
native mysql_errno(connectionHandle = 1);
native mysql_fetch_int(connectionHandle = 1);
native mysql_fetch_field(number,dest[],connectionHandle = 1);
native mysql_fetch_field_row(string[],const fieldname[],connectionHandle = 1);
native mysql_fetch_float(&Float:result,connectionHandle = 1);
native mysql_fetch_row_format(string[],const delimiter[] = "|",connectionHandle = 1);
native mysql_field_count(connectionHandle = 1);
native mysql_free_result(connectionHandle = 1);
native mysql_get_charset(destination[],connectionHandle = 1);
native mysql_insert_id(connectionHandle = 1);
native mysql_num_rows(connectionHandle = 1);
native mysql_num_fields(connectionHandle = 1);
native mysql_ping(connectionHandle = 1);
native mysql_query(query[],resultid = (-1),extraid = (-1),connectionHandle = 1);
native mysql_query_callback(index,query[],callback[],extraid = (-1),connectionHandle = 1);
native mysql_real_escape_string(const source[],destination[],connectionHandle = 1);
native mysql_reconnect(connectionHandle = 1);
native mysql_reload(connectionHandle = 1);
native mysql_retrieve_row(connectionHandle = 1);
native mysql_set_charset(charset[],connectionHandle = 1);
native mysql_stat(const destination[],connectionHandle = 1);
native mysql_store_result(connectionHandle = 1);
native mysql_warning_count(connectionHandle = 1);

//forward declarations

forward OnQueryFinish(query[], resultid, extraid, connectionHandle);
forward OnQueryError(errorid, error[], resultid, extraid, callback[], querystr[], connectionHandle);