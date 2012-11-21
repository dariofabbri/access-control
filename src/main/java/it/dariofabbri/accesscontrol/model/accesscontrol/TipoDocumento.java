package it.dariofabbri.accesscontrol.model.accesscontrol;


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "acc_tipo_documento")
public class TipoDocumento {

	public static final Integer CARTA_DI_IDENTITA = 1;
	public static final Integer PATENTE = 2;
	public static final Integer PASSAPORTO = 3;
	public static final Integer PORTO_D_ARMI = 4;
	
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
