define([
	"underscore", 
	"backbone"], 
	function(_, Backbone) {
	
	var visitatore = Backbone.Model.extend({
	
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
			
			return response;
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
				
				var m = moment(changed.dataNascita, "D/M/YYYY");
				alert(m.format("DD/MM/YYYY"));
				if(!moment(changed.dataNascita, "D/M/YYYY").isValid()) {
					errors.dataNascita = "La data immessa non è valida.";
				}
			}
			
			if(!_.isEmpty(errors)) {
				return errors;
			}
		}
	});
	
	return visitatore;
});