package it.dariofabbri.accesscontrol.model.accesscontrol;


import it.dariofabbri.accesscontrol.model.security.User;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

@Entity
@Table(name = "acc_accesso")
public class Accesso {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY, generator = "acc_accesso_id_seq")
	@SequenceGenerator(name = "acc_accesso_id_seq", sequenceName = "acc_accesso_id_seq")
	@Column(name="id")
	private Integer id;

	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="id_visitatore")
	private Visitatore visitatore;

	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="id_stato")
	private StatoAccesso stato;

	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="id_user")
	private User operatore;

	@Column(name="passi")
	private String passi;

	@Column(name="destinatario")
	private String destinatario;

	@Column(name="autorizzato_da")
	private String autorizzatoDa;

	@Column(name="ingresso")
	private Date ingresso;

	@Column(name="uscita")
	private Date uscita;

	@Column(name="note")
	private String note;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Visitatore getVisitatore() {
		return visitatore;
	}

	public void setVisitatore(Visitatore visitatore) {
		this.visitatore = visitatore;
	}

	public StatoAccesso getStato() {
		return stato;
	}

	public void setStato(StatoAccesso stato) {
		this.stato = stato;
	}

	public User getOperatore() {
		return operatore;
	}

	public void setOperatore(User operatore) {
		this.operatore = operatore;
	}

	public String getDestinatario() {
		return destinatario;
	}

	public String getPassi() {
		return passi;
	}

	public void setPassi(String passi) {
		this.passi = passi;
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

	public Date getIngresso() {
		return ingresso;
	}

	public void setIngresso(Date ingresso) {
		this.ingresso = ingresso;
	}

	public Date getUscita() {
		return uscita;
	}

	public void setUscita(Date uscita) {
		this.uscita = uscita;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}
}