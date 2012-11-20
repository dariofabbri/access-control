package it.dariofabbri.accesscontrol.service.local.security;

import it.dariofabbri.accesscontrol.model.security.Permission;
import it.dariofabbri.accesscontrol.model.security.Role;
import it.dariofabbri.accesscontrol.model.security.User;
import it.dariofabbri.accesscontrol.service.local.Service;

import java.util.List;

public interface SecurityService extends Service {

	User getByUsername(String username);

	List<Role> getUserRoles(String username);

	List<Permission> getUserPermissions(String username);
}