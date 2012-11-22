define([
	"underscore", 
	"backbone",
	"jquery",
	"text!templates/visitatori/visitatorisearch.html"], 
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
						
			var nome = $("#nome").val();
			var cognome = $("#cognome").val();

			var that = this;
			this.collection.fetchPage(1, {
				nome: nome,
				cognome: cognome
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
			$("input#nome", this.el).focus();
		}
	});
	
	return view;
});
