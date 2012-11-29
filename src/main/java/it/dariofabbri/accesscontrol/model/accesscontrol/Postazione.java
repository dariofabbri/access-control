package it.dariofabbri.accesscontrol.model.accesscontrol;


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

@Entity
@Table(name = "acc_postazione")
public class Postazione {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY, generator = "acc_postazione_id_seq")
	@SequenceGenerator(name = "acc_postazione_id_seq", sequenceName = "acc_postazione_id_seq")
	@Column(name="id")
	private Integer id;
	
	@Column(name="descrizione")
	private String descrizione;
	
	@Column(name="luogo")
	private String luogo;
	
	@Column(name="note")
	private String note;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
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
}
