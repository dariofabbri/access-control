define([
	"underscore", 
	"backbone"], 
	function(_, Backbone) {
	
	var grant = Backbone.Model.extend({
	
		defaults: {
			action: null,
			allowed: false
		},

		urlRoot: "api/security/grants",
		
		idAttribute: "action"
	});
	
	return grant;
});
