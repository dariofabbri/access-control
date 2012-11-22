package it.dariofabbri.accesscontrol.service.rest.resource;


import it.dariofabbri.accesscontrol.service.local.ServiceFactory;
import it.dariofabbri.accesscontrol.service.local.lut.LUTService;
import it.dariofabbri.accesscontrol.service.rest.dto.LUTItemDTO;
import it.dariofabbri.accesscontrol.service.rest.dto.LUTItemsDTO;
import it.dariofabbri.accesscontrol.util.MappingUtil;

import java.util.List;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Path("/luts")
@Produces("application/json")
public class LUTResource extends BaseResource {

	private static final Logger logger = LoggerFactory.getLogger(LUTResource.class);
	
	@GET
	@Path("/tipodocumento")
	public Response getTipoDocumentoList() {

		logger.debug("getTipoDocumentoList called!");
		
		Subject currentUser = SecurityUtils.getSubject();
		if(!currentUser.isPermitted("luts:tipodocumento")) {
			return Response.status(Status.UNAUTHORIZED).entity("Operation not permitted.").build();
		}
		
		LUTService ls = ServiceFactory.createLUTService();
		List<Object> items = ls.listItems("TipoDocumento");
		LUTItemsDTO dto = buildDTO(items);

		return Response.ok().entity(dto).build();
	}
	
	@GET
	@Path("/statoaccesso")
	public Response getStatoAccessoList() {

		logger.debug("getStatoAccessoList called!");
		
		Subject currentUser = SecurityUtils.getSubject();
		if(!currentUser.isPermitted("luts:statoaccesso")) {
			return Response.status(Status.UNAUTHORIZED).entity("Operation not permitted.").build();
		}
		
		LUTService ls = ServiceFactory.createLUTService();
		List<Object> items = ls.listItems("StatoAccesso");
		LUTItemsDTO dto = buildDTO(items);

		return Response.ok().entity(dto).build();
	}
	
	
	private LUTItemsDTO buildDTO(List<Object> items) {
		
		MappingUtil<LUTItemDTO> mu = new MappingUtil<LUTItemDTO>();
		
		List<LUTItemDTO> list = mu.map(items, LUTItemDTO.class);
		LUTItemsDTO dto = new LUTItemsDTO();
		dto.setRecords(items.size());
		dto.setResults(list);
		
		return dto;
	}
}