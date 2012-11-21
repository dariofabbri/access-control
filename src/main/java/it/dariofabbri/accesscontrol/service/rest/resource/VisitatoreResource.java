package it.dariofabbri.accesscontrol.service.rest.resource;


import it.dariofabbri.accesscontrol.model.accesscontrol.Visitatore;
import it.dariofabbri.accesscontrol.service.local.NotFoundException;
import it.dariofabbri.accesscontrol.service.local.QueryResult;
import it.dariofabbri.accesscontrol.service.local.ServiceFactory;
import it.dariofabbri.accesscontrol.service.local.visitatore.VisitatoreService;
import it.dariofabbri.accesscontrol.service.rest.dto.PermissionDTO;
import it.dariofabbri.accesscontrol.service.rest.dto.VisitatoreDTO;
import it.dariofabbri.accesscontrol.service.rest.dto.VisitatoriDTO;

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

@Path("/visitatori")
@Produces("application/json")
public class VisitatoreResource {

	private static final Logger logger = LoggerFactory.getLogger(VisitatoreResource.class);
	
	@GET
	public Response getVisitatori(
			@QueryParam("nome") String nome,
			@QueryParam("cognome") String cognome,
			@QueryParam("offset") Integer offset,
			@QueryParam("limit") Integer limit) {

		logger.debug("getVisitatori called!");
		
		Subject currentUser = SecurityUtils.getSubject();
		if(!currentUser.isPermitted("visitatori:list")) {
			return Response.status(Status.UNAUTHORIZED).entity("Operation not permitted.").build();
		}
		
		// Execute query.
		//
		VisitatoreService vs = ServiceFactory.createVisitatoreService();
		QueryResult<Visitatore> result = vs.listVisitatori(
				nome, 
				cognome, 
				offset, 
				limit);
		
		// Set up response.
		//
		Mapper mapper = DozerBeanMapperSingletonWrapper.getInstance();
        VisitatoriDTO dto = mapper.map(result, VisitatoriDTO.class);
		
		return Response.ok().entity(dto).build();
	}
	
	@GET
	@Path("/{id}")
	public Response getVisitatore(@PathParam("id") Integer id) {

		logger.debug("getVisitatore called!");
		
		Subject currentUser = SecurityUtils.getSubject();
		if(!currentUser.isPermitted("visitatori:get")) {
			return Response.status(Status.UNAUTHORIZED).entity("Operation not permitted.").build();
		}
		
		VisitatoreService vs = ServiceFactory.createVisitatoreService();
		Visitatore visitatore = vs.retrieveVisitatoreById(id);
		if(visitatore == null) {
			return Response.status(Status.NOT_FOUND).build();
		}

		Mapper mapper = DozerBeanMapperSingletonWrapper.getInstance();
        VisitatoreDTO dto = mapper.map(visitatore, VisitatoreDTO.class);

		return Response.ok().entity(dto).build();
	}
	
	@DELETE
	@Path("/{id}")
	public Response deleteVisitatore(@PathParam("id") Integer id) {
		
		logger.debug("deleteVisitatore called!");
		
		Subject currentUser = SecurityUtils.getSubject();
		if(!currentUser.isPermitted("visitatori:delete")) {
			return Response.status(Status.UNAUTHORIZED).entity("Operation not permitted.").build();
		}
		
		VisitatoreService vs = ServiceFactory.createVisitatoreService();
		try {
			vs.deleteVisitatoreById(id);
		}
		catch(NotFoundException nfe) {
			return Response.status(Status.NOT_FOUND).entity(nfe.getMessage()).build();			
		}
		
		return Response.ok().build();
	}
	
	@POST
	@Consumes("application/json")
	public Response createVisitatore(VisitatoreDTO visitatore) {
		
		logger.debug("createVisitatore called!");
		
		Subject currentUser = SecurityUtils.getSubject();
		if(!currentUser.isPermitted("visitatori:create")) {
			return Response.status(Status.UNAUTHORIZED).entity("Operation not permitted.").build();
		}

		VisitatoreService vs = ServiceFactory.createVisitatoreService();
		Visitatore entity = vs.createVisitatore(
				visitatore.getNome(),
				visitatore.getCognome(),
				visitatore.getDataNascita(),
				visitatore.getLuogoNascita(),
				visitatore.getIdTipoDocumento(),
				visitatore.getNumeroDocumento(),
				visitatore.getUltimoAccesso());
		
		if(entity == null) {
			return Response.status(Status.CONFLICT).build();
		}
		
		Mapper mapper = DozerBeanMapperSingletonWrapper.getInstance();
		PermissionDTO dto = mapper.map(entity, PermissionDTO.class);
		return Response.status(Status.CREATED).entity(dto).build();
	}

	@PUT
	@Consumes("application/json")
	@Path("/{id}")
	public Response updateVisitatore(@PathParam("id") Integer id, VisitatoreDTO visitatore) {
		
		logger.debug("updatePermission called!");
		
		Subject currentUser = SecurityUtils.getSubject();
		if(!currentUser.isPermitted("visitatori:update")) {
			return Response.status(Status.UNAUTHORIZED).entity("Operation not permitted.").build();
		}

		VisitatoreService vs = ServiceFactory.createVisitatoreService();
		try {
			vs.updateVisitatore(
				id,
				visitatore.getNome(),
				visitatore.getCognome(),
				visitatore.getDataNascita(),
				visitatore.getLuogoNascita(),
				visitatore.getIdTipoDocumento(),
				visitatore.getNumeroDocumento(),
				visitatore.getUltimoAccesso());
			
		} catch(NotFoundException nfe) {
			return Response.status(Status.NOT_FOUND).entity(nfe.getMessage()).build();
		}
		
		return Response.ok().build();
	}
}