/***
	The MIT License (MIT)

	Copyright (c) 2014 MacMailler

	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in all
	copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
	SOFTWARE.
***/

#if defined __container_include
	#endinput
#endif
#define __container_include

#define Container::	container_
#define MAX_CONTAINER_ELEMENTS (512)


enum {
	Container::Next,
	Container::Previous,
	Container::First,
	Container::Last,
	Container::Current,
}

enum Container::e_Data {
	Container::Index,
	Container::Value,
}
static Container::Data[MAX_CONTAINER_ELEMENTS][Container::e_Data];
new Container::Length;


stock Container::Add(index, value) {
	if(Container::Length < sizeof Container::Data) {
		new i = Container::Length ++;
		Container::Data[i][Container::Index] = index;
		Container::Data[i][Container::Value] = value;
	}
	return 1;
}

stock Container::AddEx(index, ...) {
	for(new argCount = numarg(), i; i < argCount; i++) {
		Container::Add(index, getarg(i, 0));
	}
	return 1;
}

stock Container::AddArray(index, value[], length = sizeof value) {
	for(new i; i < length; i++) {
		Container::Add(index, value[i]);
	}
	return 1;
}

stock Container::Remove(index, value) {
	new i = interpolationSearch2D(Container::Data, index, Container::Index, Container::Length);
	if(i != -1) {
		if(Container::Data[i][Container::Value] == value) {
			new j = Container::Length --;
			Container::Data[i][Container::Index] = Container::Data[j][Container::Index];
			Container::Data[i][Container::Value] = Container::Data[j][Container::Value];
		}
	}
	return 1;
}

stock Container::Find(index, value) {
	for(new i ; i < Container::Length; i++) {
		if(Container::Data[i][Container::Index] == index) {
			if(Container::Data[i][Container::Value] == value) {
				return 1;
			}
		}
	}
	return 0;
}


stock Container::At(index, mode, &idx, &val) {
	switch(mode) {
		case Container::Next : {
			for(new i = idx + 1; i < Container::Length; i++) {
				if(Container::Data[i][Container::Index] == index) {
					idx = i;
					val = Container::Data[i][Container::Value];
					
					return 1;
				}
			}
			
			for(new i; i < Container::Length; i++) {
				if(Container::Data[i][Container::Index] == index) {
					idx = i;
					val = Container::Data[i][Container::Value];
					
					return 1;
				}
			}
		}
		
		case Container::Previous : {
			for(new i = idx - 1; i != -1; i--) {
				if(Container::Data[i][Container::Index] == index) {
					idx = i;
					val = Container::Data[i][Container::Value];
					
					return 1;
				}
			}
			
			for(new i = Container::Length; i != -1; i--) {
				if(Container::Data[i][Container::Index] == index) {
					idx = i;
					val = Container::Data[i][Container::Value];
					
					return 1;
				}
			}
		}
		
		case Container::Current : {
			val = Container::Data[idx][Container::Value];
		}
		
		case Container::First : {
			for(new i; i < Container::Length; i++) {
				if(Container::Data[i][Container::Index] == index) {
					idx = i;
					val = Container::Data[i][Container::Value];
					
					return 1;
				}
			}
		}
		
		case Container::Last : {
			for(new i = Container::Length - 1; i != -1; i--) {
				if(Container::Data[i][Container::Index] == index) {
					idx = i;
					val = Container::Data[Container::Length - 1][Container::Value];
					
					return 1;
				}
			}
		}
	}
	return 1;
}