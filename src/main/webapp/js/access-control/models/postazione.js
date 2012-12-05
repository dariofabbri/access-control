define([
	"underscore", 
	"backbone"], 
	function(_, Backbone) {
	
	var postazione = Backbone.Model.extend({
	
		defaults: {
			id: null,
			descrizione: null,
			luogo: null,
			note: null
		},
		
		urlRoot: "api/postazioni",		
		
		validate: function(changed) {
			
			var errors = {};
			
			if(_.isEmpty(changed.descrizione)) {
				errors.destinatario = "Il campo è obbligatorio.";
			}
			
			if(!_.isEmpty(errors)) {
				return errors;
			}
		}
	});
	
	return postazione;
});