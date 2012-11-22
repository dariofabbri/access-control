package it.dariofabbri.accesscontrol.service.rest.resource;

import java.util.Date;

public abstract class BaseResource {

	public Date makeDateParam(Long millis) {
		
		if(millis == null)
			return null;
		
		return new Date(millis);
	}
	
}
