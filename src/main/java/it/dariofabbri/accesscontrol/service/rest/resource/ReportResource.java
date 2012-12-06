package it.dariofabbri.accesscontrol.service.rest.resource;


import it.dariofabbri.accesscontrol.service.local.report.BasicReportService;
import it.dariofabbri.accesscontrol.service.local.report.ReportService;
import it.dariofabbri.accesscontrol.service.rest.param.DateParam;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.Map;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Path("/reports")
@Produces("application/pdf")
public class ReportResource extends BaseResource {

	private static final Logger logger = LoggerFactory.getLogger(ReportResource.class);
	
	@GET
	@Path("/basictest")
	public Response getBasicTestReport() {

		logger.debug("getBasicTestReport called!");
		
		Subject currentUser = SecurityUtils.getSubject();
		if(!currentUser.isPermitted("reports:basictest")) {
			return Response.status(Status.UNAUTHORIZED).entity("Operation not permitted.").build();
		}

		BasicReportService brs = new BasicReportService();
		byte[] report = brs.generateReport("reports/basictest.jasper");
		
		return Response.ok().entity(report).build();
	}

	@GET
	@Path("/passi/{id}")
	public Response getPassiReport(@PathParam("id") Integer id) {

		logger.debug("getPassiReport called!");
		
		Subject currentUser = SecurityUtils.getSubject();
		if(!currentUser.isPermitted("reports:passi")) {
			return Response.status(Status.UNAUTHORIZED).entity("Operation not permitted.").build();
		}

		// Prepare parameter map.
		//
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("id_accesso", id);
		
		ReportService rs = new ReportService();
		byte[] report = rs.generateReport("reports/passi.jasper", parameters);
		
		return Response.ok().entity(report).build();
	}

	@GET
	@Path("/listaaccessi")
	public Response getListaAccessiReport(
			@QueryParam("dataDa") DateParam dataDa,
			@QueryParam("dataA") DateParam dataA,
			@QueryParam("idPostazione") Integer idPostazione)
	{
		logger.debug("getListaAccessiReport called!");
		
		Subject currentUser = SecurityUtils.getSubject();
		if(!currentUser.isPermitted("reports:listaccessi")) {
			return Response.status(Status.UNAUTHORIZED).entity("Operation not permitted.").build();
		}

		// Validate input parameters.
		//
		if(dataDa == null) {
			return Response.status(Status.BAD_REQUEST).entity("Parameter dataDa not specified.").build();
		}
		if(dataA == null) {
			return Response.status(Status.BAD_REQUEST).entity("Parameter dataA not specified.").build();
		}

		// Prepare parameter map.
		//
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("dataDa", new Timestamp(dataDa.getValue().getTime()));
		parameters.put("dataA", new Timestamp(dataA.getValue().getTime()));
		parameters.put("idPostazione", idPostazione);
		
		ReportService rs = new ReportService();
		byte[] report = rs.generateReport("reports/listaaccessi.jasper", parameters);
		
		return Response.ok().entity(report).build();
	}
}
