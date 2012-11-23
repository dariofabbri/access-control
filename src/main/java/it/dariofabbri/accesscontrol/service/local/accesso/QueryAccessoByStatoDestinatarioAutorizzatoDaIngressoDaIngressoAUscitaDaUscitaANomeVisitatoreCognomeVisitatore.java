package it.dariofabbri.accesscontrol.service.local.accesso;

import it.dariofabbri.accesscontrol.model.accesscontrol.Accesso;
import it.dariofabbri.accesscontrol.service.local.Query;

import java.util.Date;

import org.hibernate.Session;

public class QueryAccessoByStatoDestinatarioAutorizzatoDaIngressoDaIngressoAUscitaDaUscitaANomeVisitatoreCognomeVisitatore extends Query<Accesso> {

	private Integer idStato;
	private String destinatario;
	private String autorizzatoDa;
	private Date ingressoDa;
	private Date ingressoA;
	private Date uscitaDa;
	private Date uscitaA;
	private String nomeVisitatore;
	private String cognomeVisitatore;
	
	public QueryAccessoByStatoDestinatarioAutorizzatoDaIngressoDaIngressoAUscitaDaUscitaANomeVisitatoreCognomeVisitatore(Session session) {
		
		super(session);
	}

	public Integer getIdStato() {
		return idStato;
	}

	public void setIdStato(Integer idStato) {
		this.idStato = idStato;
	}

	public String getDestinatario() {
		return destinatario;
	}

	public void setDestinatario(String destinatario) {
		this.destinatario = destinatario;
	}

	public String getAutorizzatoDa() {
		return autorizzatoDa;
	}

	public void setAutorizzatoDa(String autorizzatoDa) {
		this.autorizzatoDa = autorizzatoDa;
	}

	public Date getIngressoDa() {
		return ingressoDa;
	}

	public void setIngressoDa(Date ingressoDa) {
		this.ingressoDa = ingressoDa;
	}

	public Date getIngressoA() {
		return ingressoA;
	}

	public void setIngressoA(Date ingressoA) {
		this.ingressoA = ingressoA;
	}

	public Date getUscitaDa() {
		return uscitaDa;
	}

	public void setUscitaDa(Date uscitaDa) {
		this.uscitaDa = uscitaDa;
	}

	public Date getUscitaA() {
		return uscitaA;
	}

	public void setUscitaA(Date uscitaA) {
		this.uscitaA = uscitaA;
	}

	public String getNomeVisitatore() {
		return nomeVisitatore;
	}

	public void setNomeVisitatore(String nomeVisitatore) {
		this.nomeVisitatore = nomeVisitatore;
	}

	public String getCognomeVisitatore() {
		return cognomeVisitatore;
	}

	public void setCognomeVisitatore(String cognomeVisitatore) {
		this.cognomeVisitatore = cognomeVisitatore;
	}

	@Override
	protected boolean checkQueryArguments() {

		return true;
	}

	@Override
	protected String getCountHql() {

		String hql = 
				"select count(*) " +
				"from Accesso acc " +
				"left join acc.visitatore vis " +
				"left join acc.stato sta " +
				"left join acc.operatore ope " +
				"where 1 = 1 ";

		if(idStato != null)
			hql += "and acc.stato.id = :idStato ";
		
		if(destinatario != null)
			hql += "and upper(acc.destinatario) like :destinatario ";
		
		if(autorizzatoDa != null)
			hql += "and upper(acc.autorizzatoDa) like :autorizzatoDa ";

		if(ingressoDa != null)
			hql += "and acc.ingresso >= :ingressoDa ";

		if(ingressoA != null)
			hql += "and acc.ingresso <= :ingressoA ";

		if(uscitaDa != null)
			hql += "and acc.uscita >= :uscitaDa ";

		if(uscitaA != null)
			hql += "and acc.uscita >= :uscitaA ";
		
		if(nomeVisitatore != null)
			hql += "and upper(vis.nome) like :nomeVisitatore ";
		
		if(cognomeVisitatore != null)
			hql += "and upper(vis.cognome) like :cognomeVisitatore ";

		return hql;
	}

	@Override
	protected String getQueryHql() {

		String hql = 
				"from Accesso acc " +
				"left join fetch acc.visitatore vis " +
				"left join fetch acc.stato sta " +
				"left join fetch acc.operatore ope " +
				"where 1 = 1 ";

		if(idStato != null)
			hql += "and acc.stato.id = :idStato ";
		
		if(destinatario != null)
			hql += "and upper(acc.destinatario) like :destinatario ";
		
		if(autorizzatoDa != null)
			hql += "and upper(acc.autorizzatoDa) like :autorizzatoDa ";

		if(ingressoDa != null)
			hql += "and acc.ingresso >= :ingressoDa ";

		if(ingressoA != null)
			hql += "and acc.ingresso <= :ingressoA ";

		if(uscitaDa != null)
			hql += "and acc.uscita >= :uscitaDa ";

		if(uscitaA != null)
			hql += "and acc.uscita >= :uscitaA ";
		
		if(nomeVisitatore != null)
			hql += "and upper(vis.nome) like :nomeVisitatore ";
		
		if(cognomeVisitatore != null)
			hql += "and upper(vis.cognome) like :cognomeVisitatore ";

		hql += "order by acc.ingresso desc ";
		
		return hql;
	}

	@Override
	protected void setQueryArguments(org.hibernate.Query q) {

		String[] named_params = q.getNamedParameters();
		for (int i = 0; i < named_params.length; ++i) {
			String param = named_params[i];

			if (param.equals("idStato"))
				q.setParameter("idStato", idStato);

			else if (param.equals("destinatario"))
				q.setParameter("destinatario", "%" + destinatario.toUpperCase() + "%");

			else if (param.equals("autorizzatoDa"))
				q.setParameter("autorizzatoDa", "%" + autorizzatoDa.toUpperCase() + "%");

			else if (param.equals("ingressoDa"))
				q.setParameter("ingressoDa", ingressoDa);

			else if (param.equals("ingressoA"))
				q.setParameter("ingressoA", ingressoA);

			else if (param.equals("uscitaDa"))
				q.setParameter("uscitaDa", uscitaDa);

			else if (param.equals("uscitaA"))
				q.setParameter("uscitaA", uscitaA);

			else if (param.equals("nomeVisitatore"))
				q.setParameter("nomeVisitatore", "%" + nomeVisitatore.toUpperCase() + "%");

			else if (param.equals("cognomeVisitatore"))
				q.setParameter("cognomeVisitatore", "%" + cognomeVisitatore.toUpperCase() + "%");
		}
	}
}