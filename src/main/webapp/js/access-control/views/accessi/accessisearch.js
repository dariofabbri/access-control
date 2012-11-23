define([
	"underscore", 
	"backbone",
	"jquery",
	"text!templates/accessi/accessisearch.html"], 
	function(_, Backbone, $, searchTemplate) {
	
	var view = Backbone.View.extend({
		
		tagName: "div",
		
		events: {
			"click a#saveModalSelection": "search",
			"click a#closeModal": "cancel",
			"keypress": "manageEnter"
		},
		
		render: function() {

			this.$el.html(_.template(searchTemplate, {
				collection: this.collection
			}));
			return this;
		},
		
		initialize: function() {
		},
		
		manageEnter: function(e) {
			if (e.keyCode == 13) {
				e.preventDefault();
				this.search();
			}
		},

		search: function() {
						
			var nomeVisitatore = $("#nomeVisitatore").val();
			var cognomeVisitatore = $("#cognomeVisitatore").val();
			var destinatario = $("#destinatario").val();
			var autorizzatoDa = $("#autorizzatoDa").val();
			var idStato = $("#idStato").val();
			var ingressoDa = $("#ingressoDa").val();
			var ingressoA = $("#ingressoA").val();
			var uscitaDa = $("#uscitaDa").val();
			var uscitaA = $("#uscitaA").val();
			
			this.collection.fetchPage(1, {
				nomeVisitatore: nomeVisitatore,
				cognomeVisitatore: cognomeVisitatore,
				destinatario: destinatario,
				autorizzatoDa: autorizzatoDa,
				idStato: idStato,
				ingressoDa: ingressoDa,
				ingressoA: ingressoA,
				uscitaDa: uscitaDa,
				uscitaA: uscitaA				
			});

			$("div#searchModal", this.el).modal("hide");
			this.close();
		},
		
		cancel: function() {
			
			$("div#searchModal", this.el).modal("hide");
			this.close();
		},
		
		setFocus: function() {
			
			// Set focus to first field.
			//
			$("input#nomeVisitatore", this.el).focus();
		}
	});
	
	return view;
});
