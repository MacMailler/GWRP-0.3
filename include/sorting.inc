#if !defined SORTING_INC
	#define  SORTING_INC
	
	#pragma tabsize					0
	
	#define sorting::				sorting_
	
	#define stype					{Float, _}
	#define sorting_swap(%1,%2)		%1 ^= %2, %2 ^= %1, %1 ^= %2

	
	enum sorting::method
	{
		sorting::asc,
		sorting::desc,
	}

	stock sorting::gnome( stype: dest[], sorting::method: sort = sorting::asc, size = sizeof dest )
	{
		new i = 1;
		new j = 2;
		
		switch( sort )
		{
			case sorting::asc :
			{
				while( i < size )
					if( dest[ i - 1 ] <= dest[ i ] )
				{
					i = j;
					j ++;
				}
				else
				{
					sorting::swap( dest[ i - 1 ], dest[ i ] );
					
					i --;
					
					if( !i )
					{
						i = j;
						j ++;
					}
				}
			}
			
			case sorting::desc :
			{
				while( i < size )
					if( dest[ i - 1 ] >= dest[ i ] )
				{
					i = j;
					j ++;
				}
				else
				{
					sorting::swap( dest[ i - 1 ], dest[ i ] );
					
					i --;
					
					if( !i )
					{
						i = j;
						j ++;
					}
				}
			}
		}
		
		return 1;
	}

	stock sorting::bubble( stype: dest[], sorting::method: sort = sorting::asc, len = sizeof dest )
	{
		switch( sort )
		{
			case sorting::asc :
			{
				for( new i = len-1; i != -1; --i )
					for( new j; j < i; ++j )
						if( dest[ j ] > dest[ j + 1 ] )
							sorting::swap( dest[ j ], dest[ j + 1 ] );
			}
			
			case sorting::desc :
			{
				for( new i = len-1; i != -1; --i )
					for( new j; j < i; ++j )
						if( dest[ j ] < dest[ j + 1 ] )
							sorting::swap( dest[ j ], dest[ j + 1 ] );
			}
		}
		
		return ;
	}

	stock sorting::gnome_ex( stype: dest[][], len, elem, sorting::method: sort = sorting::asc, size = sizeof dest )
	{
		new i = 1;
		new j = 2;
		
		switch( sort )
		{
			case sorting::asc :
			{
				while( i < size )
					if( dest[ i - 1 ][ elem ] <= dest[ i ][ elem ] )
				{
					i = j;
					j ++;
				}
				else
				{
					for( new y; y < len; ++y )
						sorting::swap(dest[ i ][ y ], dest[ i - 1 ][ y ]);
					
					i --;
					
					if( !i )
					{
						i = j;
						j ++;
					}
				}
			}
			
			case sorting::desc :
			{
				while( i < size )
					if( dest[ i - 1 ][ elem ] >= dest[ i ][ elem ] )
				{
					i = j;
					j ++;
				}
				else
				{
					for( new y; y < len; ++y )
						sorting::swap(dest[ i ][ y ], dest[ i - 1 ][ y ]);
					
					i --;
					
					if( !i )
					{
						i = j;
						j ++;
					}
				}
			}
		}
		
		return 1;
	}

	stock sorting::bubble_ex( stype: dest[][], len, elem, sorting::method: sort = sorting::asc, size = sizeof dest )
	{
		switch( sort )
		{
			case sorting::asc :
			{
				for( new i = size-1; i != -1; --i )
					for( new j; j < i; ++j )
						if( dest[ j ][ elem ] > dest[ j + 1 ][ elem ] )
							for( new y; y < len; ++y )
								sorting::swap( dest[ j ][ y ], dest[ j + 1 ][ y ] );
			}
			
			case sorting::desc :
			{
				for( new i = size-1; i != -1; --i )
					for( new j; j < i; ++j )
						if( dest[ j ][ elem ] < dest[ j + 1 ][ elem ] )
							for( new y; y < len; ++y )
								sorting::swap( dest[ j ][ y ], dest[ j + 1 ][ y ] );
			}
		}
		
		return ;
	}
	
	stock sorting::shaker(dest[], start, n) // Не работает
	{
		new left, right;
		new last;
	 
		left = start;
		right = n - 1;
		last = n - 1;
	 
		do
		{
			for( new i = right; i >= left; i-- )
			{
				if( dest[ i - 1 ] > dest[ i ] )
				{
					sorting::swap(dest[ i ], dest[ i - 1 ]);
					last = i;
				}
			}
	 
			left = last + 1;
	 
			for ( new i = left; i <= right; i++ )
			{
				if ( dest[ i - 1 ] > dest[ i ])
				{
					sorting::swap(dest[ i ], dest[ i - 1 ]);
					last = i;
				}
			}
	 
			right = last - 1;
		}
		while ( left <= right);
		
		return ;
	}

	/*stock sorting::quick(dest[], low = 0, high = sizeof dest) // Не работает
	{
		new i = low ;
		new j = high ;
		new x = dest[ (low+high)/2 ];
		
		do
		{
			while( dest[ i ] < x ) ++ i ;
			while( dest[ j ] > x ) -- j ;
			
			if( i <= j )
			{
				sorting::swap(dest[ i ], dest[ j ]);
				i ++, j ++ ;
			}
		}
		while( i <= j );
		
		if( low < j ) sorting::quick(dest, low, j);
		if( i < high ) sorting::quick(dest, i, high);
	}*/
	
#endif