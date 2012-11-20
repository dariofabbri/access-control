package it.dariofabbri.accesscontrol.service.local;

import it.dariofabbri.accesscontrol.service.local.report.BasicReportService;

import org.junit.Test;

public class BasicReportServiceTest {

	@Test
	public void test() {

		BasicReportService brs = new BasicReportService();
		byte[] report = brs.generateReport("reports/basictest.jasper");
		System.out.println(new String(report));
	}
}
