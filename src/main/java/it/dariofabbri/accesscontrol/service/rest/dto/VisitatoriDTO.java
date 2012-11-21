package it.dariofabbri.accesscontrol.service.rest.dto;

import java.util.ArrayList;
import java.util.List;

public class VisitatoriDTO extends BaseQueryResultDTO {

	private List<VisitatoreDTO> results = new ArrayList<VisitatoreDTO>();

	public List<VisitatoreDTO> getResults() {
		return results;
	}

	public void setResults(List<VisitatoreDTO> results) {
		this.results = results;
	}
}
