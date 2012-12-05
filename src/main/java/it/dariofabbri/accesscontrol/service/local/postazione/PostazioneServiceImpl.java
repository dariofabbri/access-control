package it.dariofabbri.accesscontrol.service.local.postazione;

import it.dariofabbri.accesscontrol.model.accesscontrol.Postazione;
import it.dariofabbri.accesscontrol.service.local.AbstractService;
import it.dariofabbri.accesscontrol.service.local.NotFoundException;
import it.dariofabbri.accesscontrol.service.local.QueryResult;

import org.hibernate.Query;

public class PostazioneServiceImpl extends AbstractService implements PostazioneService {

	@Override
	public QueryResult<Postazione> listPostazioni(
			String descrizione,
			String luogo,
			String note,
			Integer offset,
			Integer limit) {

		QueryPostazioneByDescrizioneLuogoNote q = 
				new QueryPostazioneByDescrizioneLuogoNote(session);

		q.setDescrizione(descrizione);
		q.setLuogo(luogo);
		q.setNote(note);
		q.setOffset(offset);
		q.setLimit(limit);
		
		return q.query();
	}

	@Override
	public Postazione retrievePostazioneById(Integer id) {

		String hql = 
				"from Postazione pos " +
				"where pos.id = :id ";
		
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		
		Postazione postazione = (Postazione)query.uniqueResult();
		logger.debug("Postazione found: " + postazione);
		
		return postazione;
	}

	@Override
	public void deletePostazioneById(Integer id) {
		
		Postazione postazione = retrievePostazioneById(id);
		if(postazione == null) {
			String message = String.format("It has not been possible to retrieve specified entity: %d", id);
			logger.info(message);
			throw new NotFoundException(message);
		}
		
		session.delete(postazione);
	}

	@Override
	public Postazione createPostazione(
			String descrizione,
			String luogo, 
			String note) { 
		
		Postazione postazione = new Postazione();
		postazione.setDescrizione(descrizione);
		postazione.setLuogo(luogo);
		postazione.setNote(note);
		session.save(postazione);
		
		return postazione;
	}

	
	@Override
	public Postazione updatePostazione(
			Integer id,
			String descrizione,
			String luogo, 
			String note) {
		
		Postazione postazione = retrievePostazioneById(id);
		if(postazione == null) {
			String message = String.format("It has not been possible to retrieve specified entity: %d", id);
			logger.info(message);
			throw new NotFoundException(message);
		}

		postazione.setDescrizione(descrizione);
		postazione.setLuogo(luogo);
		postazione.setNote(note);
		session.update(postazione);
		
		return postazione;
	}
}