package it.dariofabbri.accesscontrol.service.local.accesso;

import it.dariofabbri.accesscontrol.model.accesscontrol.Accesso;
import it.dariofabbri.accesscontrol.model.accesscontrol.TipoDocumento;
import it.dariofabbri.accesscontrol.model.accesscontrol.Visitatore;
import it.dariofabbri.accesscontrol.service.local.QueryResult;
import it.dariofabbri.accesscontrol.service.local.Service;

import java.util.Date;
import java.util.List;

public interface AccessoService extends Service {

	QueryResult<Visitatore> listVisitatori(
			String nome,
			String cognome,
			Integer offset,
			Integer limit);

	Visitatore retrieveVisitatoreById(Integer id);

	void deleteVisitatoreById(Integer id);

	Visitatore createVisitatore(String nome, String cognome, Date dataNascita, String luogoNascita, TipoDocumento tipoDocumento, Date ultimoAccesso);

	Visitatore updateVisitatore(Integer id, String nome, String cognome, Date dataNascita, String luogoNascita, TipoDocumento tipoDocumento, Date ultimoAccesso);

	List<Accesso> retrieveAccessiVisitatore(Integer id);
}