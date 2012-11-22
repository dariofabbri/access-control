define([
	"underscore", 
	"backbone",
	"access-control/views/visitatori/visitatorilist",
	"access-control/views/visitatori/visitatoriedit",
	"access-control/collections/visitatori"], 
	function(
			_, 
			Backbone, 
			VisitatoriListView, 
			VisitatoriEditView,
			Visitatori) {

	var visitatori = Backbone.Router.extend({
		
		collection: new Visitatori(),
		
		routes: {
			"VisitatoriList": "list",
			"VisitatoriList/page/:page": "page",
			"VisitatoriNew": "create",
			"VisitatoriEdit/:id": "edit"
		},
		
		list: function() {
			
			this.collection.fetchPage();
			var view = new VisitatoriListView({collection: this.collection});
			
			this.show(view, "#container");
		},
		
		page: function(page) {
			
			this.collection.fetchPage(page);
		},
		
		create: function() {

			var model = new (this.collection.model)();
			
			var view = new VisitatoriEditView({
				model: model
			});
			
			this.show(view, "#container");
		},
		
		edit: function(id) {
			
			var model = new (this.collection.model)({id: id});
			model.fetch();

			var view = new VisitatoriEditView({
				model: model
			});
			
			this.show(view, "#container");
		}
	});

	return visitatori;
});
