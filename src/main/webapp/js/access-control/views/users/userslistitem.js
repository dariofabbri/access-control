define([
	"underscore", 
	"backbone",
	"jquery",
	"text!templates/users/userslistitem.html"], 
	function(_, Backbone, $, itemTemplate) {
	
	var view = Backbone.View.extend({
		
		tagName: "tr",
		
		events: {
			"click a#remove": "removeItem",
			"click a#edit": "editItem"
		},
		
		render: function() {
			
			this.$el.append(_.template(itemTemplate, this.model.toJSON()));
			return this;
		},
		
		removeItem: function() {

			application.modalDialog.show({
				title: "Attenzione",
				message: "Confermi la cancellazione dell'utente selezionato?",
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
			Backbone.history.navigate("UsersEdit/" + this.model.id, true);
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
