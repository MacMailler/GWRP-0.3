#if defined __sort_included
	#endinput 
#endif
#define __sort_included


#define Sort:: Sort_

#define METHOD_ASC (0)
#define METHOD_DESC (1)

#define Sort_Swap(%1,%2) %1 ^= %2, %2 ^= %1, %1 ^= %2


stock Sort::Gnome({Float, _}:dest[], method = METHOD_ASC, size = sizeof dest) {
	new i = 1;
	new j = 2;
	
	switch(method) {
		case METHOD_ASC : {
			while(i < size) {
				if(dest[i - 1] <= dest[i]) {
					i = j;
					j ++;
				} else {
					Sort::Swap(dest[i - 1], dest[i]);
					if(!--i){
						i = j;
						j ++;
					}
				}
			}
		}
		
		case METHOD_ASC : {
			while(i < size) {
				if(dest[i - 1] >= dest[i]) {
					i = j;
					j ++;
				} else {
					Sort::Swap(dest[i - 1], dest[i]);
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

stock Sort::Gnome2D({Float, _}:dest[][], len, elem, method = METHOD_ASC, size = sizeof dest) {
	new i = 1;
	new j = 2;
	
	switch(method) {
		case METHOD_ASC : {
			while(i < size) {
				if(dest[i - 1][elem] <= dest[i][elem]) {
					i = j;
					j ++;
				} else {
					for(new l; l < len; l++) {
						Sort::Swap(dest[i][l], dest[i - 1][l]);
					}
					if(!--i) {
						i = j;
						j ++;
					}
				}
			}
		}
		
		case METHOD_DESC : {
			while(i < size ) {
				if(dest[i - 1][elem] >= dest[i][elem]) {
					i = j;
					j ++;
				} else {
					for(new l; l < len; l++) {
						Sort::Swap(dest[i][l], dest[i - 1][l]);
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


stock Sort::Bubble({Float, _}:dest[], method = METHOD_ASC, size = sizeof dest) {
	switch(method) {
		case METHOD_ASC : {
			for(new i; i < size; i++) {
				for(new j; j < i; j++) {
					if(dest[j] > dest[j + 1]) {
						Sort::Swap(dest[j], dest[j + 1]);
					}
				}
			}
		}
		
		case METHOD_DESC : {
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

stock Sort::Bubble2D({Float, _}:dest[][], len, elem, method = METHOD_ASC, size = sizeof dest) {
	switch(method) {
		case METHOD_ASC : {
			for(new i; i < size; i++) {
				for(new j; j < i; j++) {
					if(dest[j][elem] > dest[j + 1][elem]) {
						for(new l; l < len; l++) {
							Sort::Swap(dest[j][l], dest[j + 1][l]);
						}
					}
				}
			}
		}
		
		case METHOD_DESC : {
			for(new i; i < size; i++) {
				for(new j; j < i; j++) {
					if(dest[j][elem] < dest[j + 1][elem]) {
						for(new l; l < len; l++) {
							Sort::Swap(dest[j][l], dest[j + 1][l]);
						}
					}
				}
			}
		}
	}
	
	return ;
}
	
stock Sort::Shaker(dest[], start, n) {// НЕ РАБОТАЕТ
	new left, right;
 
	left = start;
	right = n - 1;
 
	do {
		for(new i = right; i >= left; i--) {
			if(dest[i - 1] > dest[i]) {
				Sort::Swap(dest[i], dest[i - 1]);
			}
		}
 
		left ++;
 
		for(new i = left; i <= right; i++) {
			if(dest[i - 1 ] > dest[i]) {
				Sort::Swap(dest[i], dest[i - 1]);
			}
		}
 
		right --;
	}
	while(left <= right);
	
	return 1;
}


stock Sort::ArrayOutput(dest[], start, n) {
	for(new i = start; i < n; i++) {
		printf("%i", dest[i]);
	}
    return 1;
}


stock Sort::SwapInt(a, b) {
	new t = a;
	a = b;
	b = t;
	
	return 1;
}