package it.dariofabbri.accesscontrol.service.local.accesso;

import it.dariofabbri.accesscontrol.model.accesscontrol.Accesso;
import it.dariofabbri.accesscontrol.service.local.QueryResult;
import it.dariofabbri.accesscontrol.service.local.Service;

import java.util.Date;

public interface AccessoService extends Service {

	QueryResult<Accesso> listAccessi(
			Integer stato,
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
			Integer limit);

	Accesso retrieveAccessoById(Integer id);

	void deleteAccessoById(Integer id);

	Accesso createAccesso(
			Integer idVisitatore, 
			Integer idStato, 
			Integer idOperatore,
			String passi,
			String destinatario, 
			String autorizzatoDa, 
			Date ingresso, 
			Date uscita, 
			String note);

	Accesso updateAccesso(
			Integer id, 
			Integer idVisitatore, 
			Integer idStato, 
			Integer idOperatore,
			String passi,
			String destinatario, 
			String autorizzatoDa, 
			Date ingresso, 
			Date uscita, 
			String note);
}