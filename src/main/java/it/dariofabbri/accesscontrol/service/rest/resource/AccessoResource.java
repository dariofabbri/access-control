package it.dariofabbri.accesscontrol.service.rest.resource;


import it.dariofabbri.accesscontrol.model.accesscontrol.Accesso;
import it.dariofabbri.accesscontrol.service.local.NotFoundException;
import it.dariofabbri.accesscontrol.service.local.QueryResult;
import it.dariofabbri.accesscontrol.service.local.ServiceFactory;
import it.dariofabbri.accesscontrol.service.local.accesso.AccessoService;
import it.dariofabbri.accesscontrol.service.rest.dto.AccessiDTO;
import it.dariofabbri.accesscontrol.service.rest.dto.AccessoDTO;
import it.dariofabbri.accesscontrol.service.rest.param.DateParam;

import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.dozer.DozerBeanMapperSingletonWrapper;
import org.dozer.Mapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Path("/accessi")
@Produces("application/json")
public class AccessoResource extends BaseResource {

	private static final Logger logger = LoggerFactory.getLogger(AccessoResource.class);
	
	@GET
	public Response getAccessi(
			@QueryParam("idStato") Integer idStato,
			@QueryParam("idPostazione") Integer idPostazione,
			@QueryParam("passi") String passi,
			@QueryParam("destinatario") String destinatario,
			@QueryParam("autorizzatoDa") String autorizzatoDa,
			@QueryParam("ingressoDa") DateParam ingressoDa,
			@QueryParam("ingressoA") DateParam ingressoA,
			@QueryParam("uscitaDa") DateParam uscitaDa,
			@QueryParam("uscitaA") DateParam uscitaA,
			@QueryParam("nomeVisitatore") String nomeVisitatore,
			@QueryParam("cognomeVisitatore") String cognomeVisitatore,
			@QueryParam("offset") Integer offset,
			@QueryParam("limit") Integer limit) {

		logger.debug("getAccessi called!");
		
		Subject currentUser = SecurityUtils.getSubject();
		if(!currentUser.isPermitted("accessi:list")) {
			return Response.status(Status.UNAUTHORIZED).entity("Operation not permitted.").build();
		}
		
		// Execute query.
		//
		AccessoService as = ServiceFactory.createAccessoService();
		QueryResult<Accesso> result = as.listAccessi(
				idStato,
				idPostazione,
				passi,
				destinatario,
				autorizzatoDa,
				extractDateParam(ingressoDa),
				extractDateParam(ingressoA),
				extractDateParam(uscitaDa),
				extractDateParam(uscitaA),
				nomeVisitatore,
				cognomeVisitatore,
				offset, 
				limit);
		
		// Set up response.
		//
		Mapper mapper = DozerBeanMapperSingletonWrapper.getInstance();
        AccessiDTO dto = mapper.map(result, AccessiDTO.class);
		
		return Response.ok().entity(dto).build();
	}
	
	@GET
	@Path("/{id}")
	public Response getAccesso(@PathParam("id") Integer id) {

		logger.debug("getAccesso called!");
		
		Subject currentUser = SecurityUtils.getSubject();
		if(!currentUser.isPermitted("accessi:get")) {
			return Response.status(Status.UNAUTHORIZED).entity("Operation not permitted.").build();
		}
		
		AccessoService as = ServiceFactory.createAccessoService();
		Accesso accesso = as.retrieveAccessoById(id);
		if(accesso == null) {
			return Response.status(Status.NOT_FOUND).build();
		}

		Mapper mapper = DozerBeanMapperSingletonWrapper.getInstance();
        AccessoDTO dto = mapper.map(accesso, AccessoDTO.class);

		return Response.ok().entity(dto).build();
	}
	
	@DELETE
	@Path("/{id}")
	public Response deleteAccesso(@PathParam("id") Integer id) {
		
		logger.debug("deleteAccesso called!");
		
		Subject currentUser = SecurityUtils.getSubject();
		if(!currentUser.isPermitted("accessi:delete")) {
			return Response.status(Status.UNAUTHORIZED).entity("Operation not permitted.").build();
		}
		
		AccessoService as = ServiceFactory.createAccessoService();
		try {
			as.deleteAccessoById(id);
		}
		catch(NotFoundException nfe) {
			return Response.status(Status.NOT_FOUND).entity(nfe.getMessage()).build();			
		}
		
		return Response.ok().build();
	}
	
	@POST
	@Consumes("application/json")
	public Response createAccesso(AccessoDTO accesso) {
		
		logger.debug("createAccesso called!");
		
		Subject currentUser = SecurityUtils.getSubject();
		if(!currentUser.isPermitted("accessi:create")) {
			return Response.status(Status.UNAUTHORIZED).entity("Operation not permitted.").build();
		}

		AccessoService as = ServiceFactory.createAccessoService();
		Accesso entity = as.createAccesso(
				accesso.getIdVisitatore(),
				accesso.getIdStato(),
				accesso.getIdOperatore(),
				accesso.getIdPostazione(),
				accesso.getPassi(),
				accesso.getDestinatario(),
				accesso.getAutorizzatoDa(),
				accesso.getIngresso(),
				accesso.getUscita(),
				accesso.getNote());
		
		if(entity == null) {
			return Response.status(Status.CONFLICT).build();
		}
		
		Mapper mapper = DozerBeanMapperSingletonWrapper.getInstance();
		AccessoDTO dto = mapper.map(entity, AccessoDTO.class);
		return Response.status(Status.CREATED).entity(dto).build();
	}

	@PUT
	@Consumes("application/json")
	@Path("/{id}")
	public Response updateAccesso(@PathParam("id") Integer id, AccessoDTO accesso) {
		
		logger.debug("updateAccesso called!");
		
		Subject currentUser = SecurityUtils.getSubject();
		if(!currentUser.isPermitted("accessi:update")) {
			return Response.status(Status.UNAUTHORIZED).entity("Operation not permitted.").build();
		}

		AccessoService as = ServiceFactory.createAccessoService();
		try {
			as.updateAccesso(
				id,
				accesso.getIdVisitatore(),
				accesso.getIdStato(),
				accesso.getIdOperatore(),
				accesso.getIdPostazione(),
				accesso.getPassi(),
				accesso.getDestinatario(),
				accesso.getAutorizzatoDa(),
				accesso.getIngresso(),
				accesso.getUscita(),
				accesso.getNote());
			
		} catch(NotFoundException nfe) {
			return Response.status(Status.NOT_FOUND).entity(nfe.getMessage()).build();
		}
		
		return Response.ok().build();
	}
}