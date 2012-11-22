package it.dariofabbri.accesscontrol.service.rest.dto;

import java.util.ArrayList;
import java.util.List;

public class AccessiDTO extends BaseQueryResultDTO {

	private List<AccessoDTO> results = new ArrayList<AccessoDTO>();

	public List<AccessoDTO> getResults() {
		return results;
	}

	public void setResults(List<AccessoDTO> results) {
		this.results = results;
	}
}
