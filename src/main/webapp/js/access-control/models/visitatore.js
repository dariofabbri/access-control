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
			
			var adjusted = _.clone(response);

			if(adjusted) {
				adjusted.dataNascita = this.makeStringDate(response.dataNascita);
			}
			
			return adjusted;
		},
		
		toJSON: function(options) {
			
			var json = _.clone(this.attributes);
			
			json.dataNascita = this.makeIsoDate(this.get("dataNascita"));
			return json;
		},
		
		toJSONView: function(options) {
			
			return _.clone(this.attributes);
		},
		
		checkDate: function(dateString) {
			
			if(!dateString)
				return false;
			
			var re = /\d{1,2}\/\d{1,2}\/\d{4}/;
			if(!re.test(dateString))
				return false;
			
			return moment(dateString, "D/M/YYYY").isValid();
		},
		
		makeStringDate: function(isoDate) {
			
			if(!isoDate) {
				return null;
			}
			
			var m = moment(isoDate);
			return m.format("DD/MM/YYYY");
		},
		
		makeIsoDate: function(dateString) {
			
			if(!this.checkDate(dateString)) {
				return null;
			}
			
			return moment.utc(dateString, "D/M/YYYY").format();
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