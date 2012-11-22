define([
	"underscore", 
	"backbone"], 
	function(_, Backbone) {
	
	var permission = Backbone.Model.extend({
	
		defaults: {
			id: null,
			permissionString: ""
		},
		
		urlRoot: "api/permissions",			

		validate: function(changed) {
			
			var errors = {};
			
			if(!_.isUndefined(changed.permissionString)) {
				if(_.isEmpty(changed.permissionString)) {
					errors.permissionString = "Il campo è obbligatorio.";
				}
			}
		}
	});
	
	return permission;
});