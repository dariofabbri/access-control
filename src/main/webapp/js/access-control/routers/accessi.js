define([
	"underscore", 
	"backbone",
	"access-control/views/accessi/accessilist",
	"access-control/views/accessi/accessireport",
	"access-control/views/accessi/reportlistaaccessiparameter",
	"access-control/views/accessi/reportlistaaccessidisplay",
	"access-control/collections/accessi",
	"access-control/models/reportlistaaccessiconfig"], 
	function(
			_, 
			Backbone, 
			AccessiListView,
			AccessiReportView,
			AccessiReportListaParameterView,
			AccessiReportListaDisplayView,
			Accessi,
			ReportListaAccessiConfig) {

	var accessi = Backbone.Router.extend({
		
		collection: new Accessi(),
		listaAccessiConfig: new ReportListaAccessiConfig(),
		
		routes: {
			"AccessiList": "list",
			"AccessiList/page/:page": "page",
			"AccessiReport/id/:id": "reportPassi",
			"AccessiReportListaAccessi/parameter": "reportListaAccessiParameter",
			"AccessiReportListaAccessi/display": "reportListaAccessiDisplay"
		},
		
		list: function() {
			
			this.collection.fetchPage();
			var view = new AccessiListView({collection: this.collection});
			
			this.show(view, "#container");
		},
		
		page: function(page) {
			
			this.collection.fetchPage(page);
		},
		
		reportPassi: function(id) {
			
			var model = new (this.collection.model)({id: id});
			model.fetch();

			var view = new AccessiReportView({
				model: model
			});
			
			this.show(view, "#container");
		},
		
		reportListaAccessiParameter: function() {
			
			this.listaAccessiConfig = new ReportListaAccessiConfig();
			this.listaAccessiConfig.setForToday();

			var view = new AccessiReportListaParameterView({
				model: this.listaAccessiConfig
			});
			
			this.show(view, "#container");
		},
		
		reportListaAccessiDisplay: function(dataDa, dataA) {
			
			var view = new AccessiReportListaDisplayView({
				model: this.listaAccessiConfig
			});
			
			this.show(view, "#container");
		}
	});

	return accessi;
});
