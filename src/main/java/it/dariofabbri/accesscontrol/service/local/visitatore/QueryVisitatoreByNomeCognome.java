package it.dariofabbri.accesscontrol.service.local.visitatore;

import it.dariofabbri.accesscontrol.model.accesscontrol.Visitatore;
import it.dariofabbri.accesscontrol.service.local.Query;

import org.hibernate.Session;

public class QueryVisitatoreByNomeCognome extends Query<Visitatore> {

	private String nome;
	private String cognome;
	
	public QueryVisitatoreByNomeCognome(Session session) {
		
		super(session);
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getCognome() {
		return cognome;
	}

	public void setCognome(String cognome) {
		this.cognome = cognome;
	}

	@Override
	protected boolean checkQueryArguments() {

		return true;
	}

	@Override
	protected String getCountHql() {

		String hql = 
				"select count(*) " +
				"from Visitatore vis " +
				"left join vis.tipoDocumento tdo " +
				"where 1 = 1 ";
		
		if(nome != null)
			hql += "and upper(vis.nome) like :nome ";
		
		if(cognome != null)
			hql += "and upper(vis.cognome) like :cognome ";

		return hql;
	}

	@Override
	protected String getQueryHql() {

		String hql = 
				"from Visitatore vis " +
				"left join fetch vis.tipoDocumento tdo " +
				"where 1 = 1 ";
		
		if(nome != null)
			hql += "and upper(vis.nome) like :nome ";
		
		if(cognome != null)
			hql += "and upper(vis.cognome) like :cognome ";

		hql += "order by vis.cognome, vis.nome ";
		
		return hql;
	}

	@Override
	protected void setQueryArguments(org.hibernate.Query q) {

		String[] named_params = q.getNamedParameters();
		for (int i = 0; i < named_params.length; ++i) {
			String param = named_params[i];

			if (param.equals("nome"))
				q.setParameter("nome", "%" + nome.toUpperCase() + "%");

			else if (param.equals("cognome"))
				q.setParameter("cognome", "%" + cognome.toUpperCase() + "%");
		}
	}
}