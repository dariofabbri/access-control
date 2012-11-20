define([
	"underscore", 
	"backbone",
	"access-control/views/roles/roleslist",
	"access-control/views/roles/rolesedit",
	"access-control/models/role",
	"access-control/collections/roles"], 
	function(
			_, 
			Backbone, 
			RolesListView, 
			RolesEditView,
			Role,
			Roles) {

	var roles = Backbone.Router.extend({
		
		collection: new Roles(),
		
		routes: {
			"RolesList": "list",
			"RolesList/page/:page": "page",
			"RolesNew": "create",
			"RolesEdit/:id": "edit"
		},
		
		list: function() {
			
			this.collection.fetchPage();
			var view = new RolesListView({collection: this.collection});
			
			this.show(view, "#container");
		},
		
		page: function(page) {
			
			this.collection.fetchPage(page);
		},
		
		create: function() {

			var model = new Role();
			
			var view = new RolesEditView({
				model: model
			});
			
			this.show(view, "#container");
		},
		
		edit: function(id) {
			
			var model = new Role({id: id});
			model.fetch();

			var view = new RolesEditView({
				model: model
			});
			
			this.show(view, "#container");
		}
	});

	return roles;
});
