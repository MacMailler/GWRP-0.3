/* 
	CTime Library Plugin For Pawn
    Copyright © 2011 RyDeR`
*/

#if defined _CTime_Included
	#endinput
#endif

#define _Ctime_Included

#pragma library "CTime"

enum e_tm {
	tm_sec,
	tm_min,
	tm_hour,
	tm_mday,
	tm_mon,
	tm_year,
	tm_wday,
	tm_yday,
	tm_isdst
};

#define tm<%0> \
	tm: %0[e_tm]
	
#define CLOCKS_PER_SEC (1000)

native clock();
native difftime(Time: tTime1, Time: tTime2);
native mktime(tm <tmPtr>);
native asctime(tm <tmPtr>, szBuf[], const iSize = sizeof(szBuf));
native ctime(Time: tTime, szBuf[], const iSize = sizeof(szBuf));
native gmtime(Time: tTime, tm <tmPtr>);
native localtime(Time: tTime, tm <tmPtr>);
native strftime(szBuf[], const iSize, const szFormat[], tm <tmPtr>);

/***
"strftime" format specifiers

Specifier							Replaced by							Example
%a	Abbreviated weekday name												Thu
%A	Full weekday name 														Thursday
%b	Abbreviated month name													Aug
%B	Full month name															August
%c	Date and time representation											Thu Aug 23 14:55:02 2001
%d	Day of the month (01-31)												23
%H	Hour in 24h format (00-23)												14
%I	Hour in 12h format (01-12)												02
%j	Day of the year (001-366)												235
%m	Month as a decimal number (01-12)										08
%M	Minute (00-59)															55
%p	AM or PM designation													PM
%S	Second (00-61)															02
%U	Week number with the first Sunday as the first day of week one (00-53)	33
%w	Weekday as a decimal number with Sunday as 0 (0-6)	4
%W	Week number with the first Monday as the first day of week one (00-53)	34
%x	Date representation														08/23/01
%X	Time representation 													14:55:02
%y	Year, last two digits (00-99)											01
%Y	Year																	2001
%Z	Timezone name or abbreviation											CDT
%%	A % sign																%


*/