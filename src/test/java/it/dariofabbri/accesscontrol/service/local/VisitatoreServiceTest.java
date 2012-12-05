package it.dariofabbri.accesscontrol.service.local;

import it.dariofabbri.accesscontrol.model.accesscontrol.Accesso;
import it.dariofabbri.accesscontrol.model.accesscontrol.StatoAccesso;
import it.dariofabbri.accesscontrol.model.accesscontrol.TipoDocumento;
import it.dariofabbri.accesscontrol.model.accesscontrol.Visitatore;
import it.dariofabbri.accesscontrol.model.security.User;
import it.dariofabbri.accesscontrol.service.local.accesso.AccessoService;
import it.dariofabbri.accesscontrol.service.local.user.UserService;
import it.dariofabbri.accesscontrol.service.local.visitatore.VisitatoreService;

import java.util.Date;

import org.junit.Assert;
import org.junit.Test;

public class VisitatoreServiceTest extends BaseServiceTest {

	@Test
	public void testCreateVisitatore() {
		
		VisitatoreService vs = ServiceFactory.createVisitatoreService();
		
		Visitatore visitatore = vs.createVisitatore("Gino", "Pilota", new Date(), "Firenze", TipoDocumento.CARTA_DI_IDENTITA, "AM123456", null);
		Assert.assertNotNull(visitatore);
	}

	@Test
	public void testCreateVisitatoreAndAccesso() {
		
		VisitatoreService vs = ServiceFactory.createVisitatoreService();
		AccessoService as = ServiceFactory.createAccessoService();
		UserService us = ServiceFactory.createUserService();
		
		Visitatore visitatore = vs.createVisitatore("Gino", "Pilota", new Date(), "Firenze", TipoDocumento.CARTA_DI_IDENTITA, "AB123456", null);
		Assert.assertNotNull(visitatore);
		
		User operatore = us.retrieveUserByUsername("admin");
		
		Accesso accesso = as.createAccesso(
				visitatore.getId(), 
				StatoAccesso.IN_CORSO, 
				operatore.getId(),
				1,
				"101",
				"Conte Ugolino", 
				"Cecco Angiolieri", 
				new Date(), 
				new Date(), 
				"Attenzione!");
		Assert.assertNotNull(accesso);
	}
}
