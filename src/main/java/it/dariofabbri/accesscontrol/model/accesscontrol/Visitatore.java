package it.dariofabbri.accesscontrol.model.accesscontrol;


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
@Table(name = "acc_visitatore")
public class Visitatore {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY, generator = "acc_visitatore_id_seq")
	@SequenceGenerator(name = "acc_visitatore_id_seq", sequenceName = "acc_visitatore_id_seq")
	@Column(name="id")
	private Integer id;

	@Column(name="nome")
	private String nome;

	@Column(name="cognome")
	private String cognome;

	@Column(name="data_nascita")
	private Date dataNascita;

	@Column(name="luogo_nascita")
	private String luogoNascita;

	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="id_tipo_documento")
	private TipoDocumento tipoDocumento;
	
	@Column(name="numero_documento")
	private String numeroDocumento;

	@Column(name="ultimo_accesso")
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

	public TipoDocumento getTipoDocumento() {
		return tipoDocumento;
	}

	public void setTipoDocumento(TipoDocumento tipoDocumento) {
		this.tipoDocumento = tipoDocumento;
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
