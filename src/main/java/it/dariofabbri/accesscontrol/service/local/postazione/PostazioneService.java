package it.dariofabbri.accesscontrol.service.local.postazione;

import it.dariofabbri.accesscontrol.model.accesscontrol.Postazione;
import it.dariofabbri.accesscontrol.service.local.QueryResult;
import it.dariofabbri.accesscontrol.service.local.Service;

public interface PostazioneService extends Service {

	QueryResult<Postazione> listPostazioni(
			String descrizione,
			String luogo,
			String note,
			Integer offset,
			Integer limit);

	Postazione retrievePostazioneById(Integer id);

	void deletePostazioneById(Integer id);

	Postazione createPostazione(
			String descrizione,
			String luogo, 
			String note);

	Postazione updatePostazione(
			Integer id, 
			String descrizione,
			String luogo, 
			String note);
}