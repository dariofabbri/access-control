define([
	"underscore", 
	"backbone",
	"access-control/views/accessi/accessilist",
	"access-control/collections/accessi"], 
	function(
			_, 
			Backbone, 
			AccessiListView, 
			Accessi) {

	var accessi = Backbone.Router.extend({
		
		collection: new Accessi(),
		
		routes: {
			"AccessiList": "list",
			"AccessiList/page/:page": "page"
		},
		
		list: function() {
			
			this.collection.fetchPage();
			var view = new AccessiListView({collection: this.collection});
			
			this.show(view, "#container");
		},
		
		page: function(page) {
			
			this.collection.fetchPage(page);
		}
	});

	return accessi;
});
