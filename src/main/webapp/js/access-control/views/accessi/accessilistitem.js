define([
	"underscore", 
	"backbone",
	"jquery",
	"access-control/views/accessi/accessidetail",
	"access-control/views/accessi/accessireport",
	"text!templates/accessi/accessilistitem.html"], 
	function(_, Backbone, $, DetailView, ReportView, itemTemplate) {
	
	var view = Backbone.View.extend({
		
		tagName: "tr",
		
		events: {
			"click a#detail": "showDetail",
			"click a#report": "showReport",
			"click a#close": "setToClose",
			"click a#cancel": "setToCancel"
		},
		
		render: function() {
			
			this.$el.html(_.template(itemTemplate, this.model.toJSONView()));
			$("a#detail", this.el).tooltip();
			$("a#report", this.el).tooltip();
			$("a#close:not(.disabled)", this.el).tooltip();
			$("a#cancel:not(.disabled)", this.el).tooltip();
			return this;
		},

		initialize: function() {
			this.model.on("change", this.render, this);
		},

		onClose: function() {
			this.model.off("change", this.render);

			$("a#detail", this.el).tooltip("destroy");
			$("a#report", this.el).tooltip("destroy");
			$("a#close", this.el).tooltip("destroy");
			$("a#cancel", this.el).tooltip("destroy");
		},

		childViews: [],

		showDetail: function() {

			$("a#detail", this.el).tooltip("destroy");			

			var detailView = new DetailView({
				model: this.model
			});
			
			// Keep a reference to search view for later clean-up.
			//
			this.childViews.push(detailView);
				
			// Render the view and show modal.
			//
			$("div#modalContainer").html(detailView.render().el);
			$("div#detailModal", detailView.el).modal("show");
		},
		
		showReportNewWindow: function() {
			
			// TODO: if the session has expired this will open
			//       a new window only to show an error message.
			//
			var url = 
				"api/reports/passi/" + 
				this.model.id + 
				"?x-security-token=" + 
				application.loginInfo.get("securityToken");
			window.open(url);
		},
		
		showReport: function() {

			$("a#report", this.el).tooltip("destroy");			

			Backbone.history.navigate("AccessiReport/id/" + this.model.id, true);
		},
		
		setToClose: function() {

			if(this.model.get("idStato") !== 1)
				return;
			
			application.modalDialog.show({
				title: "Chiusura",
				message: "Confermi la chiusura dell'accesso selezionato?",
				okCaption: "Sì",
				okCallback: this.doSetToClose,
				showOk: true,
				cancelCaption: "No",
				cancelCallback: null,
				showCancel: true,
				context: this
			});
		},
		
		setToCancel: function() {
			
			if(this.model.get("idStato") !== 1)
				return;

			application.modalDialog.show({
				title: "Annullamento",
				message: "Confermi l'annullamento dell'accesso selezionato?",
				okCaption: "Sì",
				okCallback: this.doSetToCancel,
				showOk: true,
				cancelCaption: "No",
				cancelCallback: null,
				showCancel: true,
				context: this
			});
		},
		
		doSetToClose: function() {

			$("a#close", this.el).tooltip("destroy");			

			this.model.set("idStato", 2);
			this.model.save({}, {async: false});
			this.model.fetch();					
		},
		
		doSetToCancel: function() {
			
			$("a#cancel", this.el).tooltip("destroy");			

			this.model.set("idStato", 3);
			this.model.save({}, {async: false});
			this.model.fetch();					
		}
	});
	
	return view;
});
