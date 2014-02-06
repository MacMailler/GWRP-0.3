#if !defined _samp_included
	#error Please include 'samp.inc'
#endif
#if !defined SKINSORT_INC
	#define  SKINSORT_INC
	
	#define skin::					skin_
	
	#define skin_MAX_SKINS			(400)
	
	#define skin_isValid(%0)		(%0 >= 0 && %0 <= 299)
	
	#define skin_validIndex(%0)		(%0 >= 0 && %0 <= skin_MAX_SKINS)
	
	
	new
		skin::total_count
	;
	
	enum skin::enum
	{
		skin::classid,
		skin::modelid,
	}
	new skin::data[ skin::MAX_SKINS ][ skin::enum ];
	
	enum gotomode
	{
		skin::next,
		skin::prev,
		skin::last,
		skin::first,
		skin::current,
	}
	
	stock skin::add(classid, skinid)
	{
		if( !skin::isValid(skinid) )
		{
			print("skin::addSkin() > Invalid skin id!");
			return 0 ;
		}
			
		if( skin::total_count >= skin::MAX_SKINS )
		{
			print("skin::addSkin() > Array overflow!");
			return 0 ;
		}
		
		skin::data[ skin::total_count ][ skin::classid ] = classid;
		skin::data[ skin::total_count ][ skin::modelid ] = skinid;
		skin::total_count ++ ;
		
		return 1 ;
	}
	
	stock skin::add_ex(classid, ...)
	{
		for(new = numarg()-1; i != 0; --i)
			skin::add( classid, getarg[ i ] );
			
		return 1 ;
	}
	
	stock skin::addOfArray(classid, skins[], len = sizeof skins)
	{
		for(new i; i < len; ++i)
			skin::add(classid, skins[ i ]);
			
		return 1 ;
	}
	
	stock skin::remove(classid, skinid)
	{
		if( skin::isValid(skinid) )
			return 0 ;
			
		for(new i; i < skin::total_count; ++i)
		{
			if( skin::data[ i ][ skin::classid ] == classid )
			{
				if(  skin::data[ i ][ skin::modelid ] == skinid )
				{
					skin::total_count -- ;
					skin::data[ i ][ skin::classid ] = skin::data[ skin::total_count ][ skin::classid ];
					skin::data[ i ][ skin::modelid ] = skin::data[ skin::total_count ][ skin::modelid ];
					
					return 1 ;
				}
			}
		}
		
		return 0 ;
	}
	
	stock skin::find(classid, skinid)
	{
		if( skin::isValid(skinid) )
			return 0 ;
			
		for(new i; i < skin::total_count; ++i)
			if( skin::data[ i ][ skin::classid ] == classid )
				if(  skin::data[ i ][ skin::modelid ] == skinid )
					return 1 ;
						
		return 0 ;
	}
	
	stock skin::count(classid)
	{
		new count ;
		for(new i; i < skin::total_count; ++i)
			if( skin::data[ i ][ skin::classid ] == classid )
				count ++ ;
				
		return count ;
	}
	
	stock skin::clear( classid )
	{
		for(new i; i != skin::total_count; --i)
		{
			if( skin::data[ i ][ skin::classid ] == classid )
			{
				skin::tota_count -- ;
				skin::data[ i ][ skin::classid ] = skin::data[ skin::total_count ][ skin::classid ];
				skin::data[ i ][ skin::modelid ] = skin::data[ skin::total_count ][ skin::modelid ];
			}
		}
		
		return ;
	}
	
	stock skin::goto(classid, gotomode: mode, &index, &skin)
	{
		switch( mode )
		{
			case skin::current :
			{
				if( !skin::validIndex(index) )
					return 0 ;
					
				skin = skin::data[ index ][ skin::modelid ];
				return 1 ;
			}
			
			case skin::first :
			{
				for( new i; i < skin::total_count; ++i )
					if( skin::data[ i ][ skin::classid ] == classid )
				{
					index = i;
					skin = skin::data[ i ][ skin::modelid ];
					return 1 ;
				}
			}
			
			case skin::last :
			{
				for( new i = skin::total_count-1; i != -1; --i )
					if( skin::data[ i ][ skin::classid ] == classid )
				{
					index = i;
					skin = skin::data[ i ][ skin::modelid ];
					return 1 ;
				}
			}
			
			case skin::next :
			{
				for( new i = index+1; i < skin::total_count; ++i )
					if( skin::data[ i ][ skin::classid ] == classid )
				{
					index = i;
					skin = skin::data[ i ][ skin::modelid ];
					
					return 1 ;
				}
				
				for( new i; i < skin::total_count; ++i )
					if( skin::data[ i ][ skin::classid ] == classid )
				{
					index = i;
					skin = skin::data[ i ][ skin::modelid ];
					
					return 1 ;
				}
			}
			
			case skin::prev :
			{
				for( new i = index-1; i != -1; --i )
					if( skin::data[ i ][ skin::classid ] == classid )
				{
					index = i;
					skin = skin::data[ i ][ skin::modelid ];
					
					return 1 ;
				}
				
				for( new i = skin::total_count-1; i != -1; --i )
					if( skin::data[ i ][ skin::classid ] == classid )
				{
					index = i;
					skin = skin::data[ i ][ skin::modelid ];
					
					return 1 ;
				}
			}
		}
		
		return 0 ;
	}
	
#endif