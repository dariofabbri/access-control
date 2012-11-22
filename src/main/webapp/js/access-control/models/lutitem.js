define([
	"underscore", 
	"backbone"], 
	function(_, Backbone) {
	
	var lutItem = Backbone.Model.extend({
	
		defaults: {
			id: null,
			descrizione: null
		},
		
		urlRoot: "api/luts"
	});
	
	return lutItem;
});