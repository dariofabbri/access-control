CREATE TABLE acc_postazione
(
  id SERIAL NOT NULL PRIMARY KEY,
  descrizione VARCHAR(255) NOT NULL,
  luogo VARCHAR(255),
  note VARCHAR(4000)
);

INSERT INTO acc_postazione (descrizione) values ('Mercati');
INSERT INTO acc_postazione (descrizione) values ('Direzionale A');
INSERT INTO acc_postazione (descrizione) values ('Direzionale B');

ALTER TABLE acc_accesso ADD COLUMN id_postazione INTEGER REFERENCES acc_postazione(id);

UPDATE acc_accesso acc 
  SET id_postazione = pos.id
  FROM acc_postazione pos inner join sec_user use on pos.descrizione = use.firstname
  WHERE use.firstname <> 'Administrator'
  AND acc.id_user = use.id;

DELETE FROM acc_accesso where id_postazione is null;

ALTER TABLE acc_accesso ALTER COLUMN id_postazione SET NOT NULL;
