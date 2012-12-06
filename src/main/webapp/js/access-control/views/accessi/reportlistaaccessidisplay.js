define([
	"underscore", 
	"backbone",
	"jquery",
	"text!templates/accessi/reportlistaaccessidisplay.html"], 
	function(_, Backbone, $, reportTemplate) {
	
	var view = Backbone.View.extend({
		
		tagName: "div",
		
		events: {
			"click a#back": "back"
		},
		
		render: function() {

			var m = this.model.adjustForReport();
			this.$el.html(_.template(reportTemplate, {
				dataDa: m.dataDa,
				dataA: m.dataA,
				idPostazione: m.idPostazione,
				token: application.loginInfo.get("securityToken")
			}));
			return this;
		},
		
		back: function() {
			
			Backbone.history.navigate("AccessiReportListaAccessi/parameter", true);			
		}
	});
	
	return view;
});
