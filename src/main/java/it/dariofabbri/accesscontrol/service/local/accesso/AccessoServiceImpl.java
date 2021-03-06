package it.dariofabbri.accesscontrol.service.local.accesso;

import it.dariofabbri.accesscontrol.model.accesscontrol.Accesso;
import it.dariofabbri.accesscontrol.model.accesscontrol.Postazione;
import it.dariofabbri.accesscontrol.model.accesscontrol.StatoAccesso;
import it.dariofabbri.accesscontrol.model.accesscontrol.Visitatore;
import it.dariofabbri.accesscontrol.model.security.User;
import it.dariofabbri.accesscontrol.service.local.AbstractService;
import it.dariofabbri.accesscontrol.service.local.NotFoundException;
import it.dariofabbri.accesscontrol.service.local.QueryResult;
import it.dariofabbri.accesscontrol.service.local.ServiceException;

import java.util.Date;

import org.hibernate.Query;

public class AccessoServiceImpl extends AbstractService implements AccessoService {

	@Override
	public QueryResult<Accesso> listAccessi(
			Integer stato,
			Integer idPostazione,
			String passi,
			String destinatario,
			String autorizzatoDa,
			Date ingressoDa,
			Date ingressoA,
			Date uscitaDa,
			Date uscitaA,
			String nomeVisitatore,
			String cognomeVisitatore,
			Integer offset,
			Integer limit) {

		QueryAccessoByStatoPostazionePassiDestinatarioAutorizzatoDaIngressoDaIngressoAUscitaDaUscitaANomeVisitatoreCognomeVisitatore q = 
				new QueryAccessoByStatoPostazionePassiDestinatarioAutorizzatoDaIngressoDaIngressoAUscitaDaUscitaANomeVisitatoreCognomeVisitatore(session);

		q.setIdStato(stato);
		q.setIdPostazione(idPostazione);
		q.setPassi(passi);
		q.setDestinatario(destinatario);
		q.setAutorizzatoDa(autorizzatoDa);
		q.setIngressoDa(ingressoDa);
		q.setIngressoA(ingressoA);
		q.setUscitaDa(uscitaDa);
		q.setUscitaA(uscitaA);
		q.setNomeVisitatore(nomeVisitatore);
		q.setCognomeVisitatore(cognomeVisitatore);
		q.setOffset(offset);
		q.setLimit(limit);
		
		return q.query();
	}

	@Override
	public Accesso retrieveAccessoById(Integer id) {

		String hql = 
				"from Accesso acc " +
				"left join fetch acc.visitatore vis " +
				"left join fetch acc.stato sta " +
				"left join fetch acc.operatore ope " +
				"left join fetch acc.postazione pos " +
				"where acc.id = :id ";

		
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		
		Accesso accesso = (Accesso)query.uniqueResult();
		logger.debug("Accesso found: " + accesso);
		
		return accesso;
	}

	@Override
	public void deleteAccessoById(Integer id) {
		
		Accesso accesso = retrieveAccessoById(id);
		if(accesso == null) {
			String message = String.format("It has not been possible to retrieve specified entity: %d", id);
			logger.info(message);
			throw new NotFoundException(message);
		}
		
		session.delete(accesso);
	}

	@Override
	public Accesso createAccesso(
			Integer idVisitatore, 
			Integer idStato, 
			Integer idOperatore,
			Integer idPostazione,
			String passi,
			String destinatario, 
			String autorizzatoDa, 
			Date ingresso, 
			Date uscita, 
			String note) {
		
		Visitatore visitatore = (Visitatore)session.get(Visitatore.class, idVisitatore);
		if(visitatore == null) {
			throw new ServiceException("Unable to look up visitatore using passed id: " + idVisitatore); 
		}
		
		idStato = idStato == null ? StatoAccesso.IN_CORSO : idStato;
		StatoAccesso stato = (StatoAccesso)session.get(StatoAccesso.class, idStato);
		if(stato == null) {
			throw new ServiceException("Unable to look up stato accesso using passed id: " + idStato); 
		}
		
		User operatore = (User)session.get(User.class, idOperatore);
		if(operatore == null) {
			throw new ServiceException("Unable to look up operatore using passed id: " + idOperatore); 
		}
		
		Postazione postazione = (Postazione)session.get(Postazione.class, idPostazione);
		if(postazione == null) {
			throw new ServiceException("Unable to look up postazione using passed id: " + idPostazione); 
		}

		if(ingresso == null) {
			ingresso = new Date();
		}
		
		Accesso accesso = new Accesso();
		accesso.setVisitatore(visitatore);
		accesso.setStato(stato);
		accesso.setOperatore(operatore);
		accesso.setPostazione(postazione);
		accesso.setPassi(passi);
		accesso.setDestinatario(destinatario);
		accesso.setAutorizzatoDa(autorizzatoDa);
		accesso.setIngresso(ingresso);
		accesso.setUscita(uscita);
		accesso.setNote(note);
		session.save(accesso);

		visitatore.setUltimoAccesso(ingresso);
		session.update(visitatore);
		
		return accesso;
	}

	
	@Override
	public Accesso updateAccesso(
			Integer id,
			Integer idVisitatore, 
			Integer idStato, 
			Integer idOperatore,
			Integer idPostazione,
			String passi,
			String destinatario, 
			String autorizzatoDa, 
			Date ingresso, 
			Date uscita, 
			String note) {
		
		Accesso accesso = retrieveAccessoById(id);
		if(accesso == null) {
			String message = String.format("It has not been possible to retrieve specified entity: %d", id);
			logger.info(message);
			throw new NotFoundException(message);
		}

		// Fetch visitatore.
		//
		Visitatore visitatore = (Visitatore)session.get(Visitatore.class, idVisitatore);
		if(visitatore == null) {
			throw new ServiceException("Unable to look up visitatore using passed id: " + idVisitatore); 
		}
		
		// Fetch new stato.
		//
		StatoAccesso stato = (StatoAccesso)session.get(StatoAccesso.class, idStato);
		if(stato == null) {
			throw new ServiceException("Unable to look up stato accesso using passed id: " + idStato); 
		}
		
		// Fetch operatore.
		//
		User operatore = (User)session.get(User.class, idOperatore);
		if(operatore == null) {
			throw new ServiceException("Unable to look up operatore using passed id: " + idOperatore); 
		}

		// Fetch postazione.
		//
		Postazione postazione = (Postazione)session.get(Postazione.class, idPostazione);
		if(postazione == null) {
			throw new ServiceException("Unable to look up postazione using passed id: " + idPostazione); 
		}

		// Check current status and verify possible transitions.
		// In case update uscita field.
		//
		Integer currentStatus = accesso.getStato().getId();
		if(currentStatus != StatoAccesso.IN_CORSO) {
			if(idStato != currentStatus) {
				throw new ServiceException("The status cannot be updated, already in terminal state.");
			}
		} else {
			if(idStato != currentStatus) {
				accesso.setUscita(new Date());
			}
		}

		accesso.setVisitatore(visitatore);
		accesso.setStato(stato);
		accesso.setOperatore(operatore);
		accesso.setPostazione(postazione);
		accesso.setPassi(passi);
		accesso.setDestinatario(destinatario);
		accesso.setAutorizzatoDa(autorizzatoDa);
		//accesso.setIngresso(ingresso);
		//accesso.setUscita(uscita);
		accesso.setNote(note);
		session.update(accesso);
		
		return accesso;
	}
}