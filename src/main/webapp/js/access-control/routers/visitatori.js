define([
	"underscore", 
	"backbone",
	"access-control/views/visitatori/visitatorilist",
	"access-control/views/visitatori/visitatoriedit",
	"access-control/views/visitatori/visitatorinewaccesso",
	"access-control/collections/visitatori",
	"access-control/models/accesso"], 
	function(
			_, 
			Backbone, 
			VisitatoriListView, 
			VisitatoriEditView,
			VisitatoriNewAccessoView,
			Visitatori,
			Accesso) {

	var visitatori = Backbone.Router.extend({
		
		collection: new Visitatori(),
		
		routes: {
			"VisitatoriList": "list",
			"VisitatoriList/page/:page": "page",
			"VisitatoriNew": "create",
			"VisitatoriEdit/:id": "edit",
			"VisitatoriNewAccesso/:id": "newAccesso"
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
		},
		
		newAccesso: function(id) {
			
			var model = new Accesso({
				idVisitatore: id,
				idOperatore: application.loginInfo.get("idUser")
			});

			var view = new VisitatoriNewAccessoView({
				model: model
			});
			
			this.show(view, "#container");
		}
	});

	return visitatori;
});
