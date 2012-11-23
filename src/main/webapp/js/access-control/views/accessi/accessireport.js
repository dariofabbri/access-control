define([
	"underscore", 
	"backbone",
	"jquery",
	"text!templates/accessi/accessireport.html"], 
	function(_, Backbone, $, reportTemplate) {
	
	var view = Backbone.View.extend({
		
		tagName: "div",
		
		events: {
			"click a#saveModalSelection": "cancel",
			"click a#closeModal": "cancel"
		},
		
		render: function() {

			this.$el.html(_.template(reportTemplate, {
				id: this.model.get("id"),
				token: application.loginInfo.get("securityToken")
			}));
			return this;
		},
		
		cancel: function() {
			
			$("div#reportModal", this.el).modal("hide");
			this.close();
		}
	});
	
	return view;
});
