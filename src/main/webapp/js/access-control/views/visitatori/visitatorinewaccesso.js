define([
	"underscore", 
	"backbone",
	"jquery",
	"text!templates/visitatori/visitatorinewaccesso.html"], 
	function(_, Backbone, $, editTemplate) {
	
	var view = Backbone.View.extend({
		
		tagName: "div",
		
		events: {
			"click a#save": "save",
			"click a#cancel": "cancel",
			"keypress": "manageEnter"
		},
		
		manageEnter: function(e) {
			if (e.keyCode == 13) {
				e.preventDefault();
				this.save();
			}
		},

		render: function() {

			this.$el.html(_.template(editTemplate, this.model.toJSONView()));
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

		autofocus: "#passi",

		save: function() {
						
			var passi = $("#passi").val();
			var destinatario = $("#destinatario").val();
			var autorizzatoDa = $("#autorizzatoDa").val();
			var note = $("#note").val();

			var result = this.model.set({
				passi: passi,
				destinatario: destinatario,
				autorizzatoDa: autorizzatoDa,
				note: note
			});
			
			if(result) {
				var that = this;
				this.model.save({}, {
					success: function() {
						Backbone.history.navigate("AccessiReport/id/" + that.model.id, true);		
					}
				});
			}
		},
		
		cancel: function() {
			
			Backbone.history.navigate("VisitatoriList", true);
		},
		
		showErrors: function(model, errors) {
			
			if(errors.passi) {
				this.highlightField("#passi", "error", errors.passi);
			}
			else {
				this.highlightField("#passi", "success");
			}
			
			if(errors.destinatario) {
				this.highlightField("#destinatario", "error", errors.destinatario);
			}
			else {
				this.highlightField("#destinatario", "success");
			}
			
			if(errors.autorizzatoDa) {
				this.highlightField("#autorizzatoDa", "error", errors.autorizzatoDa);
			}
			else {
				this.highlightField("#autorizzatoDa", "success");
			}
			
			if(errors.note) {
				this.highlightField("#note", "error", errors.note);
			}
			else {
				this.highlightField("#note", "success");
			}
		}
	});
	
	return view;
});
