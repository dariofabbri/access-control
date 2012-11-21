package it.dariofabbri.accesscontrol.service.local.lut;

import it.dariofabbri.accesscontrol.service.local.Service;

import java.util.List;

public interface LUTService extends Service {

	Object retrieveItem(String lut, Object id);
	
	Object retrieveItemByDescrizione(String lut, String descrizione);
	
	Object retrieveItemByDescrizione(String lut, String column, String descrizione);
	
	List<Object> listItems(String lut);

	List<Object> listItems(String lut, String orderColumn);

	List<Object> listItems(String lut, String orderColumn, String filterColumn, Object filterValue);
}