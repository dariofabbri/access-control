package it.dariofabbri.accesscontrol.service.rest.dto;

import java.util.Date;

public class VisitatoreDTO {

	private Integer id;
	private String nome;
	private String cognome;
	private Date dataNascita;
	private String luogoNascita;
	private Integer idTipoDocumento;
	private String numeroDocumento;
	private Date ultimoAccesso;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
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

	public Date getDataNascita() {
		return dataNascita;
	}

	public void setDataNascita(Date dataNascita) {
		this.dataNascita = dataNascita;
	}

	public String getLuogoNascita() {
		return luogoNascita;
	}

	public void setLuogoNascita(String luogoNascita) {
		this.luogoNascita = luogoNascita;
	}

	public Integer getIdTipoDocumento() {
		return idTipoDocumento;
	}

	public void setIdTipoDocumento(Integer idTipoDocumento) {
		this.idTipoDocumento = idTipoDocumento;
	}

	public String getNumeroDocumento() {
		return numeroDocumento;
	}

	public void setNumeroDocumento(String numeroDocumento) {
		this.numeroDocumento = numeroDocumento;
	}

	public Date getUltimoAccesso() {
		return ultimoAccesso;
	}

	public void setUltimoAccesso(Date ultimoAccesso) {
		this.ultimoAccesso = ultimoAccesso;
	}
}
