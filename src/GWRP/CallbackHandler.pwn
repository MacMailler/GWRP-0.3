
#if !defined _Core_CallbackHandler_
#define _Core_CallbackHandler_

public OnGameModeInit() {
	core::Init();
	commands::Init();
	return 1;
}

#endif