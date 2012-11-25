define([
	"underscore", 
	"backbone",
	"access-control/models/dateawaremodel"], 
	function(_, Backbone, DateAwareModel) {
	
	var visitatore = DateAwareModel.extend({
	
		defaults: {
			id: null,
			nome: null,
			cognome: null,
			dataNascita: null,
			luogoNascita: null,
			idTipoDocumento: null,
			numeroDocumento: null,
			ultimoAccesso: null
		},
		
		urlRoot: "api/visitatori",		

		parse: function(response) {
			
			var adjusted = _.clone(response);

			if(adjusted) {
				adjusted.dataNascita = this.makeStringDate(response.dataNascita);
				adjusted.ultimoAccesso = this.makeStringTimestamp(response.ultimoAccesso);
			}
			
			return adjusted;
		},
		
		toJSON: function(options) {
			
			var json = _.clone(this.attributes);
			
			json.dataNascita = this.makeIsoDate(this.get("dataNascita"));
			json.ultimoAccesso = this.makeIsoDate(this.get("ultimoAccesso"));
			return json;
		},
		
		validate: function(changed) {
			
			var errors = {};
			
			if(_.isEmpty(changed.nome)) {
				errors.nome = "Il campo è obbligatorio.";
			}

			if(_.isEmpty(changed.cognome)) {
				errors.cognome = "Il campo è obbligatorio.";
			}

			if(_.isNull(changed.idTipoDocumento)) {
				errors.idTipoDocumento = "Il campo è obbligatorio.";
			}

			if(_.isEmpty(changed.numeroDocumento)) {
				errors.numeroDocumento = "Il campo è obbligatorio.";
			}
			
			if(!_.isEmpty(changed.dataNascita)) {
				
				if(!this.checkDate(changed.dataNascita)) {
					errors.dataNascita = "La data immessa non è valida (gg/mm/aaaa).";
				}
			}
			
			if(!_.isEmpty(errors)) {
				return errors;
			}
		}
	});
	
	return visitatore;
});