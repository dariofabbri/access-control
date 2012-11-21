package it.dariofabbri.accesscontrol.service.local.accesso;

import it.dariofabbri.accesscontrol.model.accesscontrol.Accesso;
import it.dariofabbri.accesscontrol.model.accesscontrol.TipoDocumento;
import it.dariofabbri.accesscontrol.model.accesscontrol.Visitatore;
import it.dariofabbri.accesscontrol.service.local.AbstractService;
import it.dariofabbri.accesscontrol.service.local.NotFoundException;
import it.dariofabbri.accesscontrol.service.local.QueryResult;

import java.util.Date;
import java.util.List;

import org.hibernate.Query;

public class AccessoServiceImpl extends AbstractService implements AccessoService {

	@Override
	public QueryResult<Visitatore> listVisitatori(
			String nome,
			String cognome,
			Integer offset,
			Integer limit) {

		QueryAccessoByStatoDestinatarioAutorizzatoDaIngressoDaIngressoAUscitaDaUscitaA q = new QueryAccessoByStatoDestinatarioAutorizzatoDaIngressoDaIngressoAUscitaDaUscitaA(session);

		q.setNome(nome);
		q.setCognome(cognome);
		q.setOffset(offset);
		q.setLimit(limit);
		
		return q.query();
	}

	@Override
	public Visitatore retrieveVisitatoreById(Integer id) {

		Visitatore visitatore = (Visitatore)session.get(Visitatore.class, id);
		logger.debug("Visitatore found: " + visitatore);
		
		return visitatore;
	}

	@Override
	public void deleteVisitatoreById(Integer id) {
		
		Visitatore visitatore = retrieveVisitatoreById(id);
		if(visitatore == null) {
			String message = String.format("It has not been possible to retrieve specified visitatore: %d", id);
			logger.info(message);
			throw new NotFoundException(message);
		}
		
		session.delete(visitatore);
	}

	@Override
	public Visitatore createVisitatore(
			String nome, 
			String cognome, 
			Date dataNascita, 
			String luogoNascita, 
			TipoDocumento tipoDocumento, 
			Date ultimoAccesso) {
		
		Visitatore visitatore = new Visitatore();
		
		visitatore.setNome(nome);
		visitatore.setCognome(cognome);
		visitatore.setDataNascita(dataNascita);
		visitatore.setLuogoNascita(luogoNascita);
		visitatore.setTipoDocumento(tipoDocumento);
		visitatore.setUltimoAccesso(ultimoAccesso);
		
		session.save(visitatore);
		
		return visitatore;
	}

	@Override
	public Visitatore updateVisitatore(
			Integer id,
			String nome, 
			String cognome, 
			Date dataNascita, 
			String luogoNascita, 
			TipoDocumento tipoDocumento, 
			Date ultimoAccesso) {

		Visitatore visitatore = retrieveVisitatoreById(id);
		if(visitatore == null) {
			String message = String.format("It has not been possible to retrieve specified visitatore: %d", id);
			logger.info(message);
			throw new NotFoundException(message);
		}
		
		visitatore.setNome(nome);
		visitatore.setCognome(cognome);
		visitatore.setDataNascita(dataNascita);
		visitatore.setLuogoNascita(luogoNascita);
		visitatore.setTipoDocumento(tipoDocumento);
		visitatore.setUltimoAccesso(ultimoAccesso);
		
		session.update(visitatore);
		
		return visitatore;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Accesso> retrieveAccessiVisitatore(Integer id) {

		Visitatore visitatore = retrieveVisitatoreById(id);
		if(visitatore == null) {
			String message = String.format("It has not been possible to retrieve specified visitatore: %d", id);
			logger.info(message);
			throw new NotFoundException(message);
		}

		String hql = 
				"select distinct acc from Accesso acc " +
				"inner join acc.visitatore vis " +
				"where vis.id = :id";
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		List<Accesso> list = (List<Accesso>)query.list();
		logger.debug("Accessi found: " + list);
		
		return list;
	}
}