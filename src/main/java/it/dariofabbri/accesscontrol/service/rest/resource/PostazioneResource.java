package it.dariofabbri.accesscontrol.service.rest.resource;


import it.dariofabbri.accesscontrol.model.accesscontrol.Postazione;
import it.dariofabbri.accesscontrol.service.local.NotFoundException;
import it.dariofabbri.accesscontrol.service.local.QueryResult;
import it.dariofabbri.accesscontrol.service.local.ServiceFactory;
import it.dariofabbri.accesscontrol.service.local.postazione.PostazioneService;
import it.dariofabbri.accesscontrol.service.rest.dto.PostazioneDTO;
import it.dariofabbri.accesscontrol.service.rest.dto.PostazioniDTO;

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

@Path("/postazioni")
@Produces("application/json")
public class PostazioneResource extends BaseResource {

	private static final Logger logger = LoggerFactory.getLogger(PostazioneResource.class);
	
	@GET
	public Response getPostazioni(
			@QueryParam("descrizione") String descrizione,
			@QueryParam("luogo") String luogo,
			@QueryParam("note") String note,
			@QueryParam("offset") Integer offset,
			@QueryParam("limit") Integer limit) {

		logger.debug("getPostazioni called!");
		
		Subject currentUser = SecurityUtils.getSubject();
		if(!currentUser.isPermitted("postazioni:list")) {
			return Response.status(Status.UNAUTHORIZED).entity("Operation not permitted.").build();
		}
		
		// Execute query.
		//
		PostazioneService ps = ServiceFactory.createPostazioneService();
		QueryResult<Postazione> result = ps.listPostazioni(
				descrizione,
				luogo,
				note,
				offset, 
				limit);
		
		// Set up response.
		//
		Mapper mapper = DozerBeanMapperSingletonWrapper.getInstance();
        PostazioniDTO dto = mapper.map(result, PostazioniDTO.class);
		
		return Response.ok().entity(dto).build();
	}
	
	@GET
	@Path("/{id}")
	public Response getPostazione(@PathParam("id") Integer id) {

		logger.debug("getPostazione called!");
		
		Subject currentUser = SecurityUtils.getSubject();
		if(!currentUser.isPermitted("postazioni:get")) {
			return Response.status(Status.UNAUTHORIZED).entity("Operation not permitted.").build();
		}
		
		PostazioneService ps = ServiceFactory.createPostazioneService();
		Postazione postazione = ps.retrievePostazioneById(id);
		if(postazione == null) {
			return Response.status(Status.NOT_FOUND).build();
		}

		Mapper mapper = DozerBeanMapperSingletonWrapper.getInstance();
		PostazioneDTO dto = mapper.map(postazione, PostazioneDTO.class);

		return Response.ok().entity(dto).build();
	}
	
	@DELETE
	@Path("/{id}")
	public Response deletePostazione(@PathParam("id") Integer id) {
		
		logger.debug("deletePostazione called!");
		
		Subject currentUser = SecurityUtils.getSubject();
		if(!currentUser.isPermitted("postazioni:delete")) {
			return Response.status(Status.UNAUTHORIZED).entity("Operation not permitted.").build();
		}
		
		PostazioneService ps = ServiceFactory.createPostazioneService();
		try {
			ps.deletePostazioneById(id);
		}
		catch(NotFoundException nfe) {
			return Response.status(Status.NOT_FOUND).entity(nfe.getMessage()).build();			
		}
		
		return Response.ok().build();
	}
	
	@POST
	@Consumes("application/json")
	public Response createPostazione(PostazioneDTO postazione) {
		
		logger.debug("createPostazione called!");
		
		Subject currentUser = SecurityUtils.getSubject();
		if(!currentUser.isPermitted("postazioni:create")) {
			return Response.status(Status.UNAUTHORIZED).entity("Operation not permitted.").build();
		}

		PostazioneService ps = ServiceFactory.createPostazioneService();
		Postazione entity = ps.createPostazione(
				postazione.getDescrizione(),
				postazione.getLuogo(),
				postazione.getNote());
		
		if(entity == null) {
			return Response.status(Status.CONFLICT).build();
		}
		
		Mapper mapper = DozerBeanMapperSingletonWrapper.getInstance();
		PostazioneDTO dto = mapper.map(entity, PostazioneDTO.class);
		return Response.status(Status.CREATED).entity(dto).build();
	}

	@PUT
	@Consumes("application/json")
	@Path("/{id}")
	public Response updatePostazione(@PathParam("id") Integer id, PostazioneDTO postazione) {
		
		logger.debug("updatePostazione called!");
		
		Subject currentUser = SecurityUtils.getSubject();
		if(!currentUser.isPermitted("postazioni:update")) {
			return Response.status(Status.UNAUTHORIZED).entity("Operation not permitted.").build();
		}

		PostazioneService ps = ServiceFactory.createPostazioneService();
		try {
			ps.updatePostazione(
				id,
				postazione.getDescrizione(),
				postazione.getLuogo(),
				postazione.getNote());
			
		} catch(NotFoundException nfe) {
			return Response.status(Status.NOT_FOUND).entity(nfe.getMessage()).build();
		}
		
		return Response.ok().build();
	}
}