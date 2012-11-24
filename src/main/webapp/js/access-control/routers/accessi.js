define([
	"underscore", 
	"backbone",
	"access-control/views/accessi/accessilist",
	"access-control/views/accessi/accessireport",
	"access-control/collections/accessi"], 
	function(
			_, 
			Backbone, 
			AccessiListView,
			AccessiReportView,
			Accessi) {

	var accessi = Backbone.Router.extend({
		
		collection: new Accessi(),
		
		routes: {
			"AccessiList": "list",
			"AccessiList/page/:page": "page",
			"AccessiReport/id/:id": "report"
		},
		
		list: function() {
			
			this.collection.fetchPage();
			var view = new AccessiListView({collection: this.collection});
			
			this.show(view, "#container");
		},
		
		page: function(page) {
			
			this.collection.fetchPage(page);
		},
		
		report: function(id) {
			
			var model = new (this.collection.model)({id: id});
			model.fetch();

			var view = new AccessiReportView({
				model: model
			});
			
			this.show(view, "#container");
		}
	});

	return accessi;
});
