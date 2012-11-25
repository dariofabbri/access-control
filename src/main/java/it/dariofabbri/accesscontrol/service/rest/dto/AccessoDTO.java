package it.dariofabbri.accesscontrol.service.rest.dto;

import java.util.Date;

public class AccessoDTO {

	private Integer id;
	private Integer idVisitatore;
	private String nomeVisitatore;
	private String cognomeVisitatore;
	private Integer idStato;
	private String descrizioneStato;
	private Integer idOperatore;
	private String passi;
	private String destinatario;
	private String autorizzatoDa;
	private Date ingresso;
	private Date uscita;
	private String note;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getIdVisitatore() {
		return idVisitatore;
	}

	public void setIdVisitatore(Integer idVisitatore) {
		this.idVisitatore = idVisitatore;
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

	public Integer getIdStato() {
		return idStato;
	}

	public void setIdStato(Integer idStato) {
		this.idStato = idStato;
	}

	public String getDescrizioneStato() {
		return descrizioneStato;
	}

	public void setDescrizioneStato(String descrizioneStato) {
		this.descrizioneStato = descrizioneStato;
	}

	public Integer getIdOperatore() {
		return idOperatore;
	}

	public void setIdOperatore(Integer idOperatore) {
		this.idOperatore = idOperatore;
	}

	public String getPassi() {
		return passi;
	}

	public void setPassi(String passi) {
		this.passi = passi;
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
