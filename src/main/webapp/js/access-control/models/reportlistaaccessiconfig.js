define([
	"underscore", 
	"backbone",
	"access-control/models/dateawaremodel"], 
	function(_, Backbone, DateAwareModel) {
	
	var reportListaAccessiConfig = DateAwareModel.extend({
	
		defaults: {
			dataDa: null,
			dataA: null
		},

		parse: function(response) {
			
			var adjusted = _.clone(response);

			if(adjusted) {
				adjusted.dataDa = this.makeStringDate(response.dataDa);
				adjusted.dataA = this.makeStringDate(response.dataA);
			}
			
			return adjusted;
		},
		
		toJSON: function(options) {
			
			var json = _.clone(this.attributes);
			
			json.dataDa = this.makeIsoTimestamp(this.get("dataDa"));
			json.dataA = this.makeIsoTimestamp(this.get("dataA"));
			return json;
		},
		
		adjustForReport: function() {

			var json = _.clone(this.attributes);
			
			json.dataDa = this.makeIsoTimestampSod(this.get("dataDa"));
			json.dataA = this.makeIsoTimestampEod(this.get("dataA"));
			return json;
		},
		
		validate: function(changed) {
			
			var errors = {};
			
			if(_.isEmpty(changed.dataDa)) {
				errors.dataDa = "Il campo è obbligatorio";
			} else if(!this.checkDate(changed.dataDa)) {
				errors.dataDa = "La data immessa non è valida (gg/mm/aaaa).";
			}
			
			if(_.isEmpty(changed.dataA)) {
				errors.dataA = "Il campo è obbligatorio";
			} else if(!this.checkDate(changed.dataA)) {
				errors.dataA = "La data immessa non è valida (gg/mm/aaaa).";
			}
			
			if(!_.isEmpty(errors)) {
				return errors;
			}
		},
		
		setForToday: function() {
			
			var today = moment().format("DD/MM/YYYY");
			this.set({
				dataDa: today,
				dataA: today
			});
		}
	});
	
	return reportListaAccessiConfig;
});