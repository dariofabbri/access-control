package it.dariofabbri.accesscontrol.service.local.postazione;

import it.dariofabbri.accesscontrol.model.accesscontrol.Postazione;
import it.dariofabbri.accesscontrol.service.local.Query;

import org.hibernate.Session;

public class QueryPostazioneByDescrizioneLuogoNote extends Query<Postazione> {

	private String descrizione;
	private String luogo;
	private String note;
	
	public QueryPostazioneByDescrizioneLuogoNote(Session session) {
		
		super(session);
	}

	public String getDescrizione() {
		return descrizione;
	}

	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}

	public String getLuogo() {
		return luogo;
	}

	public void setLuogo(String luogo) {
		this.luogo = luogo;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	@Override
	protected boolean checkQueryArguments() {

		return true;
	}

	@Override
	protected String getCountHql() {

		String hql = 
				"select count(*) " +
				"from Postazione pos " +
				"where 1 = 1 ";

		if(descrizione != null)
			hql += "and upper(pos.descrizione) like :descrizione ";

		if(luogo != null)
			hql += "and upper(pos.luogo) like :luogo ";

		if(note != null)
			hql += "and upper(pos.note) like :note ";

		return hql;
	}

	@Override
	protected String getQueryHql() {

		String hql = 
				"from Postazione pos " +
				"where 1 = 1 ";

		if(descrizione != null)
			hql += "and upper(pos.descrizione) like :descrizione ";

		if(luogo != null)
			hql += "and upper(pos.luogo) like :luogo ";

		if(note != null)
			hql += "and upper(pos.note) like :note ";

		hql += "order by pos.descrizione ";
		
		return hql;
	}

	@Override
	protected void setQueryArguments(org.hibernate.Query q) {

		String[] named_params = q.getNamedParameters();
		for (int i = 0; i < named_params.length; ++i) {
			String param = named_params[i];

			if (param.equals("descrizione"))
				q.setParameter("descrizione", "%" + descrizione.toUpperCase() + "%");

			else if (param.equals("luogo"))
				q.setParameter("luogo", "%" + luogo.toUpperCase() + "%");

			else if (param.equals("note"))
				q.setParameter("note", "%" + note.toUpperCase() + "%");
		}
	}
}