package it.dariofabbri.accesscontrol.model.accesscontrol;


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "acc_stato_accesso")
public class StatoAccesso {

	public static final Integer IN_CORSO = 1;
	public static final Integer ANNULLATO = 2;
	public static final Integer CHIUSO = 3;
	
	@Id
	@Column(name="id")
	private Integer id;
	
	@Column(name="descrizione")
	private String descrizione;

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
}
