
#if !defined _System_Property_
#define _System_Property_

new prop::TaxValue;
new prop::PritonDrugs;
new prop::AmbarDrugs;
new prop::FactoryMetal;
new prop::FactoryFuel;
new prop::FactoryProds;
new prop::EnableReg;
new prop::isAutoRest;

stock prop::Load() {
	new t = GetTickCount();
	new Cache:result = db::query(db::Handle, "SELECT * FROM `"#__TableStuffs__"` WHERE 1", true);
	if(cache_num_rows()) {
		cache_get_int(0, 0, prop::TaxValue);
		cache_get_int(0, 1, prop::PritonDrugs);
		cache_get_int(0, 2, prop::AmbarDrugs);
		cache_get_int(0, 3, prop::FactoryMetal);
		cache_get_int(0, 4, prop::FactoryFuel);
		cache_get_int(0, 5, prop::FactoryProds);
		cache_get_int(0, 6, prop::EnableReg);
		debug("Loading property... Ok! latency: %i (ms)", GetTickCount()-t);
	}
	cache_delete(result);
	return 1;
}

stock prop::Update() {
	format(query, sizeof query, "UPDATE `"#__TableStuffs__"` SET ");
	scf(query, temp, "`TaxValue`='%i',", prop::TaxValue);
	scf(query, temp, "`PDrugs`='%i',", prop::PritonDrugs);
	scf(query, temp, "`ADrugs`='%i',", prop::AmbarDrugs);
	scf(query, temp, "`fmetal`='%i',", prop::FactoryMetal);
	scf(query, temp, "`ffuel`='%i',", prop::FactoryFuel);
	scf(query, temp, "`fprods`='%i',", prop::FactoryProds);
	scf(query, temp, "`regged`='%i'", prop::EnableReg);
	db::tquery(db::Handle, query, "", "");
	return 1;
}

#endif