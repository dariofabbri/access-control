define([
	"underscore", 
	"backbone",
	"jquery",
	"access-control/collections/grants",
	"text!templates/login/loginpanel.html",
	"text!templates/common/alert.html"], 
	function(_, Backbone, $, Grants, loginPanelTemplate, alertTemplate) {
	
	var loginView = Backbone.View.extend({
	
		events: {
			"click #login": "processSubmit",
			"keypress": "manageEnter"
		},
		
		initialize: function() {
			
			application.postazioni.on("reset", this.render, this);
		},
		
		onClose: function() {
			
			application.postazioni.off("reset", this.render);			
		},
		
		render: function() {
			
			this.$el.html(_.template(loginPanelTemplate));
			
			
			// Populate drop down lists.
			//
			var that = this;
			_.each(application.postazioni.models, function(item) {
				
				var $option = $("<option/>")
					.appendTo($("select#idPostazione", that.$el))
					.attr("value", item.get("id"))
					.text(item.get("descrizione"));

				// Set selected item.
				//
				if(item.get("id") === application.loginInfo.get("idPostazione")) {
					$option.attr("selected", true);
				}
			});


			return this;
		},
		
		autofocus: "#username",
		
		manageEnter: function(e) {
			if (e.keyCode == 13) {
				e.preventDefault();
				this.executeLogin();
			}
		},
		
		processSubmit: function(e) {
			
			e.preventDefault();
			this.executeLogin();
		},
		
		executeLogin: function() {
			
			var username = $("#username").val();
			var password = $("#password").val();
			var idPostazione = $("#idPostazione").val();
			
			application.loginInfo.save({username: username,	password: password}, {
				success: function() {
					
					// Set up options for grants collection fetch.
					//
					var options = {
						async: false,
						data: {
							actions: application.grantActions.join(",")
						}
					};

					// Execute server call.
					//
					var grants = new Grants();
					grants.fetch(options);
					
					// Set grants property in loginInfo object.
					//
					application.loginInfo.set("grants", grants.toJSON());
					
					// Save selected postazione.
					//
					application.loginInfo.set("idPostazione", idPostazione);
					application.loginInfo.set("postazione", application.postazioni.get(idPostazione).get("descrizione"));
					
					// Move to home page.
					//
					Backbone.history.navigate("home", true);
				},
				error: function() {
					$("#notification").remove();
				    $("form>legend").after(
				   		_.template(alertTemplate, {
								alertClass: "alert-error", 
								title: "Errore", 
								message: "Le credenziali immesse non sono valide."}));
				}
			});
		}
	});
	
	return loginView;
});
