INSERT INTO sec_role (rolename, description)
  VALUES ('operatore', 'Ruolo degli operatori');

INSERT INTO sec_role_permission (roleid, permissionid)
  VALUES (
	(select id from sec_role where rolename = 'operatore'), 
	(select id from sec_permission where permstring = 'accessi:*')
  );

INSERT INTO sec_role_permission (roleid, permissionid)
  VALUES (
	(select id from sec_role where rolename = 'operatore'), 
	(select id from sec_permission where permstring = 'visitatori:*')
  );

INSERT INTO sec_role_permission (roleid, permissionid)
  VALUES (
	(select id from sec_role where rolename = 'operatore'), 
	(select id from sec_permission where permstring = 'luts:*')
  );

INSERT INTO sec_role_permission (roleid, permissionid)
  VALUES (
	(select id from sec_role where rolename = 'operatore'), 
	(select id from sec_permission where permstring = 'reports:passi')
  );
