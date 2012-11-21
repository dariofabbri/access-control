package it.dariofabbri.accesscontrol.service.local.visitatore;

import it.dariofabbri.accesscontrol.model.accesscontrol.Accesso;
import it.dariofabbri.accesscontrol.model.accesscontrol.Visitatore;
import it.dariofabbri.accesscontrol.service.local.QueryResult;
import it.dariofabbri.accesscontrol.service.local.Service;

import java.util.Date;
import java.util.List;

public interface VisitatoreService extends Service {

	QueryResult<Visitatore> listVisitatori(
			String nome,
			String cognome,
			Integer offset,
			Integer limit);

	Visitatore retrieveVisitatoreById(Integer id);

	void deleteVisitatoreById(Integer id);

	Visitatore createVisitatore(String nome, String cognome, Date dataNascita, String luogoNascita, Integer idTipoDocumento, String numeroDocumento, Date ultimoAccesso);

	Visitatore updateVisitatore(Integer id, String nome, String cognome, Date dataNascita, String luogoNascita, Integer idTipoDocumento, String numeroDocumento, Date ultimoAccesso);

	List<Accesso> retrieveAccessiVisitatore(Integer id);
}