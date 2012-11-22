define([
	"underscore", 
	"backbone",
	"access-control/models/dateawaremodel"], 
	function(_, Backbone, DateAwareModel) {
	
	var accesso = DateAwareModel.extend({
	
		defaults: {
			id: null,
			idVisitatore: null,
			nomeVisitatore: null,
			cognomeVisitatore: null,
			idStato: null,
			descrizioneStato: null,
			idOperatore: null,
			destinatario: null,
			autorizzatoDa: null,
			ingresso: null,
			uscita: null,
			note: null
		},
		
		urlRoot: "api/accessi",		

		parse: function(response) {
			
			var adjusted = _.clone(response);

			if(adjusted) {
				adjusted.ingresso = this.makeStringTimestamp(response.ingresso);
				adjusted.uscita = this.makeStringTimestamp(response.uscita);
			}
			
			return adjusted;
		},
		
		toJSON: function(options) {
			
			var json = _.clone(this.attributes);
			
			json.ingresso = this.makeIsoDate(this.get("ingresso"));
			json.uscita = this.makeIsoDate(this.get("uscita"));
			return json;
		},
		
		validate: function(changed) {
			
			var errors = {};

			if(_.isNull(changed.idVisitatore)) {
				errors.idVisitatore = "Il campo è obbligatorio.";
			}

			if(_.isNull(changed.idOperatore)) {
				errors.idOperatore = "Il campo è obbligatorio.";
			}
			
			if(_.isEmpty(changed.destinatario)) {
				errors.destinatario = "Il campo è obbligatorio.";
			}

			if(_.isEmpty(changed.autorizzatoDa)) {
				errors.autorizzatoDa = "Il campo è obbligatorio.";
			}
			
			if(!_.isEmpty(errors)) {
				return errors;
			}
		}
	});
	
	return accesso;
});