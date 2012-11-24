define([
	"underscore", 
	"backbone",
	"jquery",
	"text!templates/accessi/accessireport.html"], 
	function(_, Backbone, $, reportTemplate) {
	
	var view = Backbone.View.extend({
		
		tagName: "div",
		
		events: {
			"click a#back": "back"
		},
		
		render: function() {

			this.$el.html(_.template(reportTemplate, {
				id: this.model.get("id"),
				token: application.loginInfo.get("securityToken")
			}));
			return this;
		},
		
		back: function() {
			
			Backbone.history.navigate("AccessiList", true);			
		}
	});
	
	return view;
});
