package it.dariofabbri.accesscontrol.service.local.visitatore;

import it.dariofabbri.accesscontrol.model.accesscontrol.Accesso;
import it.dariofabbri.accesscontrol.model.accesscontrol.TipoDocumento;
import it.dariofabbri.accesscontrol.model.accesscontrol.Visitatore;
import it.dariofabbri.accesscontrol.service.local.AbstractService;
import it.dariofabbri.accesscontrol.service.local.NotFoundException;
import it.dariofabbri.accesscontrol.service.local.QueryResult;
import it.dariofabbri.accesscontrol.service.local.ServiceException;

import java.util.Date;
import java.util.List;

import org.hibernate.Query;

public class VisitatoreServiceImpl extends AbstractService implements VisitatoreService {

	@Override
	public QueryResult<Visitatore> listVisitatori(
			String nome,
			String cognome,
			Integer offset,
			Integer limit) {

		QueryVisitatoreByNomeCognome q = new QueryVisitatoreByNomeCognome(session);

		q.setNome(nome);
		q.setCognome(cognome);
		q.setOffset(offset);
		q.setLimit(limit);
		
		return q.query();
	}

	@Override
	public Visitatore retrieveVisitatoreById(Integer id) {

		String hql = 
				"from Visitatore vis " +
				"left join fetch vis.tipoDocumento tdo " +
				"where vis.id = :id ";
		
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		
		Visitatore visitatore = (Visitatore)query.uniqueResult();
		logger.debug("Visitatore found: " + visitatore);
		
		return visitatore;
	}

	@Override
	public void deleteVisitatoreById(Integer id) {
		
		Visitatore visitatore = retrieveVisitatoreById(id);
		if(visitatore == null) {
			String message = String.format("It has not been possible to retrieve specified entity: %d", id);
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
			Integer idTipoDocumento,
			String numeroDocumento,
			Date ultimoAccesso) {
		
		TipoDocumento tipoDocumento = (TipoDocumento)session.get(TipoDocumento.class, idTipoDocumento);
		if(tipoDocumento == null) {
			throw new ServiceException("Unable to look up tipo documento using passed id: " + idTipoDocumento); 
		}
		
		Visitatore visitatore = new Visitatore();
		
		visitatore.setNome(nome);
		visitatore.setCognome(cognome);
		visitatore.setDataNascita(dataNascita);
		visitatore.setLuogoNascita(luogoNascita);
		visitatore.setTipoDocumento(tipoDocumento);
		visitatore.setNumeroDocumento(numeroDocumento);
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
			Integer idTipoDocumento, 
			String numeroDocumento,
			Date ultimoAccesso) {

		Visitatore visitatore = retrieveVisitatoreById(id);
		if(visitatore == null) {
			String message = String.format("It has not been possible to retrieve specified entity: %d", id);
			logger.info(message);
			throw new NotFoundException(message);
		}
		
		TipoDocumento tipoDocumento = (TipoDocumento)session.get(TipoDocumento.class, idTipoDocumento);
		if(tipoDocumento == null) {
			throw new ServiceException("Unable to look up tipo documento using passed id: " + idTipoDocumento); 
		}

		visitatore.setNome(nome);
		visitatore.setCognome(cognome);
		visitatore.setDataNascita(dataNascita);
		visitatore.setLuogoNascita(luogoNascita);
		visitatore.setTipoDocumento(tipoDocumento);
		visitatore.setNumeroDocumento(numeroDocumento);
		visitatore.setUltimoAccesso(ultimoAccesso);
		
		session.update(visitatore);
		
		return visitatore;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Accesso> retrieveAccessiVisitatore(Integer id) {

		Visitatore visitatore = retrieveVisitatoreById(id);
		if(visitatore == null) {
			String message = String.format("It has not been possible to retrieve specified entity: %d", id);
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