CREATE TABLE acc_tipo_documento
(
	id INTEGER NOT NULL PRIMARY KEY,
	descrizione VARCHAR(255) NOT NULL
);

CREATE TABLE acc_visitatore
(
	id SERIAL NOT NULL PRIMARY KEY,
	nome VARCHAR(255) NOT NULL,
	cognome VARCHAR(255) NOT NULL,
  data_nascita DATE,
  luogo_nascita VARCHAR(255),
	id_tipo_documento INTEGER REFERENCES acc_tipo_documento(id),
	numero_documento VARCHAR(255),
	ultimo_accesso TIMESTAMP
);

CREATE TABLE acc_stato_accesso
(
	id INTEGER NOT NULL PRIMARY KEY,
	descrizione VARCHAR(255) NOT NULL
);

CREATE TABLE acc_accesso
(
	id SERIAL NOT NULL PRIMARY KEY,
	id_visitatore INTEGER NOT NULL REFERENCES acc_visitatore(id),
	id_stato INTEGER NOT NULL REFERENCES acc_stato_permesso(id),
	id_user INTEGER NOT NULL REFERENCES sec_user(id),
	destinatario VARCHAR(255),
	autorizzato_da VARCHAR(255),
	ingresso TIMESTAMP,
	uscita TIMESTAMP,
	note VARCHAR(4000)
);
