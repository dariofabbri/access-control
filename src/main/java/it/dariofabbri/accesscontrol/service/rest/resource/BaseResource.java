package it.dariofabbri.accesscontrol.service.rest.resource;

import it.dariofabbri.accesscontrol.service.rest.param.DateParam;

import java.util.Date;

public abstract class BaseResource {

	public Date extractDateParam(DateParam param) {
		
		if(param == null)
			return null;
		
		return param.getValue();
	}
	
}
