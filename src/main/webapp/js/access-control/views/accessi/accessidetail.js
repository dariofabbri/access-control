define([
	"underscore", 
	"backbone",
	"jquery",
	"text!templates/accessi/accessidetail.html"], 
	function(_, Backbone, $, detailTemplate) {
	
	var view = Backbone.View.extend({
		
		tagName: "div",
		
		events: {
			"click a#printAccesso": "printAccesso",
			"click a#closeModal": "cancel"
		},
		
		render: function() {

			this.$el.html(_.template(detailTemplate, this.model.toJSONView()));
			return this;
		},
		
		cancel: function() {
			
			$("div#detailModal", this.el).modal("hide");
			this.close();
		},
		
		printAccesso: function() {
			
			$("div#detailModal", this.el).modal("hide");
			this.close();
			
			Backbone.history.navigate("AccessiReport/id/" + this.model.id, true);
		}
	});
	
	return view;
});
