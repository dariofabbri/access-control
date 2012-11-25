define([
	"underscore", 
	"backbone",
	"jquery",
	"text!templates/visitatori/visitatorilistitem.html"], 
	function(_, Backbone, $, itemTemplate) {
	
	var view = Backbone.View.extend({
		
		tagName: "tr",
		
		events: {
			"click a#remove": "removeItem",
			"click a#edit": "editItem",
			"click a#newAccesso": "newAccesso"
		},
		
		render: function() {

			this.$el.append(_.template(itemTemplate, this.model.toJSONView()));
			$("a#newAccesso", this.el).tooltip();
			$("a#edit", this.el).tooltip();
			return this;
		},
		
		onClose: function() {
			
			$("a#newAccesso", this.el).tooltip("destroy");			
			$("a#edit", this.el).tooltip("destroy");			
		},
		
		removeItem: function() {

			application.modalDialog.show({
				title: "Attenzione",
				message: "Confermi la cancellazione del visitatore selezionato?",
				okCaption: "Sì",
				okCallback: this.doRemoveItem,
				showOk: true,
				cancelCaption: "No",
				cancelCallback: this.cancelRemoveItem,
				showCancel: true,
				context: this
			});
		},
		
		editItem: function() {

			$("a#edit", this.el).tooltip("destroy");			
			Backbone.history.navigate("VisitatoriEdit/" + this.model.id, true);
		},
		
		newAccesso: function() {
			
			$("a#newAccesso", this.el).tooltip("destroy");
			Backbone.history.navigate("VisitatoriNewAccesso/" + this.model.id, true);
		},
		
		cancelRemoveItem: function() {
			
		},
		
		doRemoveItem: function() {
			
			this.model.destroy({wait: true});
			this.remove();
		}
	});
	
	return view;
});
