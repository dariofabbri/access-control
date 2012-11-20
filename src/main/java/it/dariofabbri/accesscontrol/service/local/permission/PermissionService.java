package it.dariofabbri.accesscontrol.service.local.permission;

import it.dariofabbri.accesscontrol.model.security.Permission;
import it.dariofabbri.accesscontrol.service.local.QueryResult;
import it.dariofabbri.accesscontrol.service.local.Service;

public interface PermissionService extends Service {

	QueryResult<Permission> listPermissions(
			String permissionString,
			Integer offset,
			Integer limit);

	Permission retrievePermissionById(Integer id);

	void deletePermissionById(Integer id);

	Permission createPermission(String permissionString);

	Permission updatePermission(Integer id, String permissionString);
}