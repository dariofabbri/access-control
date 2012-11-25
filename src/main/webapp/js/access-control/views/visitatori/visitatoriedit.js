define([
	"underscore", 
	"backbone",
	"jquery",
	"access-control/collections/lutitems",
	"text!templates/visitatori/visitatoriedit.html"], 
	function(_, Backbone, $, LUTItems, editTemplate) {
	
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
			
			// Populate drop down lists.
			//
			var that = this;
			_.each(this.tipoDocumentoList.models, function(item) {
				
				var $option = $("<option/>")
					.appendTo($("select#tipoDocumento", that.$el))
					.attr("value", item.get("id"))
					.text(item.get("descrizione"));
				
				if(item.get("id") === that.model.get("idTipoDocumento")) {
					$option.attr("selected", true);
				}
			});
			
			return this;
		},
		
		initialize: function() {

			this.tipoDocumentoList = new LUTItems();
			this.tipoDocumentoList.url += "/tipodocumento";
			this.tipoDocumentoList.fetch({async: false});
			
			this.model.on("error", this.showErrors, this);
			this.model.on("change", this.render, this);
		},

		onClose: function() {
			
			this.model.off("error", this.showErrors);
			this.model.off("change", this.render, this);
		},
		
		autofocus: "#nome",

		save: function() {
						
			var nome = $("#nome").val();
			var cognome = $("#cognome").val();
			var idTipoDocumento = $("#tipoDocumento").val();
			var numeroDocumento = $("#numeroDocumento").val();
			var dataNascita = $("#dataNascita").val();
			var luogoNascita = $("#luogoNascita").val();

			var result = this.model.set({
				nome: nome,
				cognome: cognome,
				idTipoDocumento: idTipoDocumento,
				numeroDocumento: numeroDocumento,
				dataNascita: dataNascita,
				luogoNascita: luogoNascita
			});
			
			if(result) {
				this.model.save({}, {
					success: function() {
						Backbone.history.navigate("VisitatoriList", true);		
					}
				});
			}
		},
		
		cancel: function() {
			
			Backbone.history.navigate("VisitatoriList", true);
		},
		
		showErrors: function(model, errors) {
			
			if(errors.nome) {
				this.highlightField("#nome", "error", errors.nome);
			}
			else {
				this.highlightField("#nome", "success");
			}
			
			if(errors.cognome) {
				this.highlightField("#cognome", "error", errors.cognome);
			}
			else {
				this.highlightField("#cognome", "success");
			}
			
			if(errors.tipoDocumento) {
				this.highlightField("#tipoDocumento", "error", errors.tipoDocumento);
			}
			else {
				this.highlightField("#tipoDocumento", "success");
			}
			
			if(errors.numeroDocumento) {
				this.highlightField("#numeroDocumento", "error", errors.numeroDocumento);
			}
			else {
				this.highlightField("#numeroDocumento", "success");
			}
			
			if(errors.dataNascita) {
				this.highlightField("#dataNascita", "error", errors.dataNascita);
			}
			else {
				this.highlightField("#dataNascita", "success");
			}
			
			if(errors.luogoNascita) {
				this.highlightField("#luogoNascita", "error", errors.luogoNascita);
			}
			else {
				this.highlightField("#luogoNascita", "success");
			}
		}
	});
	
	return view;
});
