define([
	"underscore", 
	"backbone",
	"jquery",
	"text!templates/accessi/reportlistaaccessiparameter.html"], 
	function(_, Backbone, $, parameterTemplate) {
	
	var view = Backbone.View.extend({
		
		tagName: "div",
		
		events: {
			"click a#generate": "generate",
			"click a#today": "today",
			"click a#yesterday": "yesterday",
			"click a#month": "month",
			"keypress": "manageEnter"
		},
		
		manageEnter: function(e) {
			if (e.keyCode == 13) {
				e.preventDefault();
				this.save();
			}
		},

		render: function() {

			this.$el.html(_.template(parameterTemplate, this.model.toJSONView()));
			return this;
		},
		
		initialize: function() {
			
			this.model.on("error", this.showErrors, this);
			this.model.on("change", this.render, this);
		},

		onClose: function() {
			
			this.model.off("error", this.showErrors);
			this.model.off("change", this.render, this);
		},
		
		autofocus: "#dataDa",

		generate: function() {
						
			var dataDa = $("#dataDa").val();
			var dataA = $("#dataA").val();

			var result = this.model.set({
				dataDa: dataDa,
				dataA: dataA
			});
			
			if(result) {
				Backbone.history.navigate("AccessiReportListaAccessi/display", true);
			}
		},
		
		today: function() {
			
			this.model.setForToday();
		},
		
		yesterday: function() {
			
			this.model.setForYesterday();
		},
		
		month: function() {
			
			this.model.setForCurrentMonth();
		},

		showErrors: function(model, errors) {
			
			if(errors.dataDa) {
				this.highlightField("#dataDa", "error", errors.dataDa);
			}
			else {
				this.highlightField("#dataDa", "success");
			}
			
			if(errors.dataA) {
				this.highlightField("#dataA", "error", errors.dataA);
			}
			else {
				this.highlightField("#dataA", "success");
			}
		}
	});
	
	return view;
});
