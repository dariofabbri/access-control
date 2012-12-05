package it.dariofabbri.accesscontrol.service.rest.resource;


import it.dariofabbri.accesscontrol.model.accesscontrol.Postazione;
import it.dariofabbri.accesscontrol.service.local.QueryResult;
import it.dariofabbri.accesscontrol.service.local.ServiceFactory;
import it.dariofabbri.accesscontrol.service.local.postazione.PostazioneService;
import it.dariofabbri.accesscontrol.service.rest.dto.PostazioniDTO;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Response;

import org.dozer.DozerBeanMapperSingletonWrapper;
import org.dozer.Mapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Path("/public/postazioni")
@Produces("application/json")
public class PublicPostazioneResource extends BaseResource {

	private static final Logger logger = LoggerFactory.getLogger(PublicPostazioneResource.class);
	
	@GET
	public Response getPostazioni() {

		logger.debug("getPostazioni called!");
		
		// Execute query.
		//
		PostazioneService ps = ServiceFactory.createPostazioneService();
		QueryResult<Postazione> result = ps.listPostazioni(
				null,
				null,
				null,
				null, 
				null);
		
		// Set up response.
		//
		Mapper mapper = DozerBeanMapperSingletonWrapper.getInstance();
        PostazioniDTO dto = mapper.map(result, PostazioniDTO.class);
		
		return Response.ok().entity(dto).build();
	}
}