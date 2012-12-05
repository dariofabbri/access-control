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
			
			// Populate stato drop down list.
			//
			var that = this;
			_.each(this.statoAccessoList.models, function(item) {
				
				var $option = $("<option/>")
					.appendTo($("select#idStato", that.$el))
					.attr("value", item.get("id"))
					.text(item.get("descrizione"));
				
				if(item.get("id") === that.collection.queryArguments.idStato) {
					$option.attr("selected", true);
				}
			});
			
			// Populate postazione drop down list.
			//
			var that = this;
			_.each(application.postazioni.models, function(item) {
				
				var $option = $("<option/>")
					.appendTo($("select#idPostazione", that.$el))
					.attr("value", item.get("id"))
					.text(item.get("descrizione"));
				
				if(item.get("id") == that.collection.queryArguments.idPostazione) {
					$option.attr("selected", true);
				}
			});

			return this;
		},
		
		initialize: function(options) {
			
			this.statoAccessoList = options.statoAccessoList;
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
			var passi = $("#passi").val();
			var destinatario = $("#destinatario").val();
			var autorizzatoDa = $("#autorizzatoDa").val();
			var idStato = $("#idStato").val();
			var idPostazione = $("#idPostazione").val();
			var ingressoDa = $("#ingressoDa").val();
			var ingressoA = $("#ingressoA").val();
			var uscitaDa = $("#uscitaDa").val();
			var uscitaA = $("#uscitaA").val();
			
			this.collection.fetchPage(1, {
				nomeVisitatore: nomeVisitatore,
				cognomeVisitatore: cognomeVisitatore,
				passi: passi,
				destinatario: destinatario,
				autorizzatoDa: autorizzatoDa,
				idStato: idStato,
				idPostazione: idPostazione,
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
			$("input#cognomeVisitatore", this.el).focus();
		}
	});
	
	return view;
});
