#if defined __sort_included
	#endinput 
#endif
#define __sort_included


#define Sort:: Sort_

enum Sort::METHODS {
	Sort::METHOD_ASC,
	Sort::METHOD_DESC
};


stock Sort::Gnome(_:dest[], Sort::METHODS:method = Sort::METHOD_ASC, size = sizeof dest) {
	new i = 1;
	new j = 2;
	
	switch(method) {
		case Sort::METHOD_ASC : {
			while(i < size) {
				if(dest[i - 1] <= dest[i]) {
					i = j;
					j ++;
				} else {
					Sort::SwapInt(dest[i - 1], dest[i]);
					if(!--i){
						i = j;
						j ++;
					}
				}
			}
		}
		
		case Sort::METHOD_DESC : {
			while(i < size) {
				if(dest[i - 1] >= dest[i]) {
					i = j;
					j ++;
				} else {
					Sort::SwapInt(dest[i - 1], dest[i]);
					if(!--i){
						i = j;
						j ++;
					}
				}
			}
		}
	}
	return 1;
}

stock Sort::Gnome2D(_:dest[][], len, elem, Sort::METHODS:method = Sort::METHOD_ASC, size = sizeof dest) {
	new i = 1;
	new j = 2;
	
	switch(method) {
		case Sort::METHOD_ASC : {
			while(i < size) {
				if(dest[i - 1][elem] <= dest[i][elem]) {
					i = j;
					j ++;
				} else {
					for(new l; l < len; l++) {
						Sort::SwapInt(dest[i][l], dest[i - 1][l]);
					}
					if(!--i) {
						i = j;
						j ++;
					}
				}
			}
		}
		
		case Sort::METHOD_DESC : {
			while(i < size ) {
				if(dest[i - 1][elem] >= dest[i][elem]) {
					i = j;
					j ++;
				} else {
					for(new l; l < len; l++) {
						Sort::SwapInt(dest[i][l], dest[i - 1][l]);
					}
					if(!--i) {
						i = j;
						j ++;
					}
				}
			}
		}
	}
	
	return 1;
}


stock Sort::Bubble(_:dest[], Sort::METHODS:method = Sort::METHOD_ASC, size = sizeof dest) {
	switch(method) {
		case Sort::METHOD_ASC : {
			for(new i; i < size; i++) {
				for(new j; j < i; j++) {
					if(dest[j] > dest[j + 1]) {
						Sort::SwapInt(dest[j], dest[j + 1]);
					}
				}
			}
		}
		
		case Sort::METHOD_DESC : {
			for(new i; i < size; i++) {
				for(new j; j < i; j++) {
					if(dest[j] < dest[j + 1]) {
						Sort::SwapInt(dest[j], dest[j + 1]);
					}
				}
			}
		}
	}
	
	return 1;
}

stock Sort::Bubble2D(_:dest[][], len, elem, Sort::METHODS:method = Sort::METHOD_ASC, size = sizeof dest) {
	switch(method) {
		case Sort::METHOD_ASC : {
			for(new i; i < size; i++) {
				for(new j; j < i; j++) {
					if(dest[j][elem] > dest[j + 1][elem]) {
						for(new l; l < len; l++) {
							Sort::SwapInt(dest[j][l], dest[j + 1][l]);
						}
					}
				}
			}
		}
		
		case Sort::METHOD_DESC : {
			for(new i; i < size; i++) {
				for(new j; j < i; j++) {
					if(dest[j][elem] < dest[j + 1][elem]) {
						for(new l; l < len; l++) {
							Sort::SwapInt(dest[j][l], dest[j + 1][l]);
						}
					}
				}
			}
		}
	}
	
	return ;
}


stock Sort::ArrayOutput(dest[], start, n) {
	for(new i = start; i < n; i++) {
		printf("%i", dest[i]);
	}
    return 1;
}


stock Sort::SwapInt(&_:a, &_:b) {
	new _:t = _:a;
	a = b;
	b = t;
}