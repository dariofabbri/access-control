package it.dariofabbri.accesscontrol.service.rest.dto;

import java.util.ArrayList;
import java.util.List;

public class PostazioniDTO extends BaseQueryResultDTO {

	private List<PostazioneDTO> results = new ArrayList<PostazioneDTO>();

	public List<PostazioneDTO> getResults() {
		return results;
	}

	public void setResults(List<PostazioneDTO> results) {
		this.results = results;
	}
}
