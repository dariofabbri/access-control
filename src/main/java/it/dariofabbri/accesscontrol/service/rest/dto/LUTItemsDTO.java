package it.dariofabbri.accesscontrol.service.rest.dto;

import java.util.ArrayList;
import java.util.List;

public class LUTItemsDTO extends BaseQueryResultDTO {

	private List<LUTItemDTO> results = new ArrayList<LUTItemDTO>();

	public List<LUTItemDTO> getResults() {
		return results;
	}

	public void setResults(List<LUTItemDTO> results) {
		this.results = results;
	}
}
