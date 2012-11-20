define([
	"underscore", 
	"backbone",
	"access-control/models/grant"], 
	function(_, Backbone, Grant) {
	
	var grants = Backbone.Collection.extend({

		model: Grant,
		
		url: "api/security/grants",
	});
	
	return grants;
});