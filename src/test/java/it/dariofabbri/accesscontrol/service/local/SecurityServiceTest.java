package it.dariofabbri.accesscontrol.service.local;

import it.dariofabbri.accesscontrol.model.security.User;
import it.dariofabbri.accesscontrol.service.local.ServiceFactory;
import it.dariofabbri.accesscontrol.service.local.security.SecurityService;

import org.junit.Test;

public class SecurityServiceTest extends BaseServiceTest {
	
	@Test
	public void test() {
		
		SecurityService ss = ServiceFactory.createSecurityService();
		
		User user = ss.getByUsername("admin");
		System.out.println(user);
	}
}
