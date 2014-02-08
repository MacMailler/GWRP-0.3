/** 
	Автор/Author:
		Fro aka Fro1sha
	
	Описание/Description:
		Позволяет шифровать любой текст, файлы(_file).
		Создавать свой уникальный ключ(_hmac).
		
		Allows you to encrypt any text, file (_file).
		Create a unique key (_hmac).
		
		Размерность/Dimension hesh:
			sha1 - 41
			sha2(224, 256) - 65
			sha2(384, 512) - 129
			md5 - 33
	
	Права/Legal:
		Copyright © 2010 Fro <TBG>

		Функции шифрования взяты из <http://xyssl.sourcearchive.com/documentation/0.9-2/main.html>
		
		Credit <http://xyssl.sourcearchive.com/documentation/0.9-2/main.html>
 **/

#if defined _encrypt_included
	#endinput
#endif
#define _encrypt_included
#pragma library encrypt

#define SCF(%1) 	"scriptfiles/"%1
#define FS(%1) 		"filterscripts/"%1
#define GM(%1) 		"gamemodes/"%1
#define NPC(%1) 	"npcmodes/"%1
#define PLG(%1) 	"plugins/"%1

enum sha2_method
{
	sha_224,
	sha_256,
	sha_384,
	sha_512
}

native sha1(const text[], hesh[]);
native sha1_file(const filename[], hesh[]);
native sha1_hmac(const key[], const text[], hesh[]);
native sha2(const text[], hesh[], sha2_method:method=sha_256);
native sha2_file(const filename[], hesh[], sha2_method:method=sha_256);
native sha2_hmac(const key[], const text[], hesh[], sha2_method:method=sha_256);
native md5(const text[], hesh[]);
native md5_file(const filename[], hesh[]);
native md5_hmac(const key[], const text[], hesh[]);