define([
	"underscore", 
	"backbone"], 
	function(_, Backbone) {
	
	var dateAwareModel = Backbone.Model.extend({
		
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
		
		makeStringTimestamp: function(isoDate) {
			
			if(!isoDate) {
				return null;
			}
			
			var m = moment(isoDate);
			return m.format("DD/MM/YYYY HH:mm:ss");
		},
		
		makeIsoDate: function(dateString) {
			
			if(!this.checkDate(dateString)) {
				return null;
			}
			
			return moment.utc(dateString, "D/M/YYYY").format();
		},
		
		makeIsoTimestamp: function(dateString) {
			
			if(!this.checkDate(dateString)) {
				return null;
			}
			
			return moment(dateString, "D/M/YYYY HH:mm:ss").format();
		}
	});
	
	return dateAwareModel;
});