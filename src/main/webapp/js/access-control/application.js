require.config({

	baseUrl: "js",
	
	paths: {
		"jquery": "jquery/jquery-1.8.3",
		"underscore": "underscore/underscore",
		"backbone": "backbone/backbone",
		"text": "require/text",
		"bootstrap": "bootstrap/bootstrap",
		"momentjs": "momentjs/moment",
		"momentjs-it": "momentjs/it"
	},
	
	shim: {
		"backbone": {
			deps: ["jquery", "underscore"],
			exports: "Backbone"
		},
		underscore: {
			exports: "_"
		},
		bootstrap: {
			deps: ["jquery"]
		},
		momentjs: {
			deps: ["momentjs-it"]
		}
	}
});

var application = {
};

require([
	"jquery",
	"underscore",
	"backbone",
	"access-control/viewmanager",
	"access-control/routers/main",
	"access-control/routers/contacts",
	"access-control/routers/pagingcontacts",
	"access-control/routers/users",
	"access-control/routers/roles",
	"access-control/routers/permissions",
	"access-control/routers/visitatori",
	"access-control/routers/accessi",
	"access-control/models/logininfo",
	"access-control/collections/postazioni",
	"access-control/views/common/modaldialog",
	"bootstrap",
	"momentjs"], 
	function(
			$, 
			_, 
			Backbone,
			viewManager, 
			MainRouter, 
			ContactsRouter,
			PagingContactsRouter,
			UsersRouter,
			RolesRouter,
			PermissionsRouter,
			VisitatoriRouter,
			AccessiRouter,
			LoginInfo,
			Postazioni,
			ModalDialogView) {
	
	$(function() {
	
		Backbone.Router.prototype.show = function(view, selector) {

			// Clean from selector, just in case.
			//
			this.close(selector);
			
			// Store new view in view manager.
			//
			viewManager[selector] = view;
			
			// Show the new view, with style.
			//
			$(selector).hide();
			$(selector).html(view.render().el);
			$(selector).fadeIn(function() {
				if(view.autofocus) {
					$(view.autofocus, $(selector)).focus();
				}
			});
		};
		
		Backbone.Router.prototype.close = function(selector) {
			
			// Get existing view from view manager.
			// If found, remove it.
			//
			var oldView = viewManager[selector];
			if(oldView) {
				oldView.close();
				delete viewManager[selector];
			}
			
			$(selector).fadeOut();
		};
		
		Backbone.View.prototype.close = function() {
			this.remove();
			this.unbind();
			
			if (this.onClose){
				this.onClose();
			}
			
			this.cleanChildViews();
		};
		
		Backbone.View.prototype.cleanChildViews = function() {
			
			if(this.childViews) {
				_.each(this.childViews, function(childView) {
					if(childView.close)
						childView.close();
				});
				
				this.childViews = [];
			}			
		};	
		
		Backbone.View.prototype.highlightField = function(fieldSelector, cssClass, text) {
			
			// Reset highlight class in field control group.
			//
			$(fieldSelector, this.el)
				.closest(".control-group")
				.removeClass()
				.addClass("control-group");
			
			// If specified, set highlight class.
			//
			if(cssClass) {
				$(fieldSelector, this.el)
					.closest(".control-group")
					.addClass(cssClass);
			}
			
			// If specified, set highlight text next to field.
			//
			if(text) {
				$(fieldSelector, this.el)
					.next("span")
					.text(text);
			}
			else {
				$(fieldSelector, this.el)
				.next("span")
				.text("");				
			}
		};


		(function() {
			var proxied = Backbone.sync;

			Backbone.sync = function(method, model, options) {

				// If no loginInfo is present, move to login form.
				//
				if(_.isUndefined(application.loginInfo))
					Backbone.history.navigate("login", true);
				
				// Get security token.
				//
				var token = application.loginInfo.get("securityToken");
				if(_.isUndefined(token))
					Backbone.history.navigate("login", true);
				
				// Extract passed headers.
				//
				var headers = options.headers || {};
				headers["X-Security-Token"] = token;
				
				// Set back headers.
				//
				options.headers = headers;
				
				// Set status code management.
				//
				options.statusCode = {
						
					401: function() {
						
						// Clean application's login info.
						//
						application.loginInfo = new LoginInfo();
						
						// Signal the unauthorized access.
						//
						application.modalDialog.show({
							title: "Errore",
							message: 
								"Il server ha rilevato un accesso non autorizzato, " +
								"è possibile che la sessione sia scaduta " +
								"o che sia stata inaspettatamente selezionata " +
								"una funzione per la quale non si hanno le necessarie autorizzazioni. " +
								"Premi OK per visualizzare la pagina di login.",
							okCaption: "OK",
							okCallback: function() {
								Backbone.history.navigate("login", true);
							},
							showOk: true,
							context: this
						});
					}	
				};
				
				// Call proxied sync.
				//
				return proxied(method, model, options);
			};
		})();

		
		application.grantActions = [
			"accessi:create",
			"accessi:delete",
			"accessi:get",
			"accessi:list",
			"accessi:update",
			"luts:statoaccesso",
			"luts:tipodocumento",
			"permissions:create",
			"permissions:delete",
			"permissions:get",
			"permissions:list",
			"permissions:update",
			"reports:basictest",
			"reports:passi",
			"reports:listaaccessi",
			"roles:addpermission",
			"roles:create",
			"roles:delete",
			"roles:deletepermission",
			"roles:get",
			"roles:getpermissions",
			"roles:list",
			"roles:update",
			"users:addrole",
			"users:create",
			"users:delete",
			"users:deleterole",
			"users:get",
			"users:getroles",
			"users:list",
			"users:update",
			"visitatori:create",
			"visitatori:delete",
			"visitatori:get",
			"visitatori:list",
			"visitatori:update",
			"postazioni:create",
			"postazioni:delete",
			"postazioni:get",
			"postazioni:list",
			"postazioni:update"
		];
		
		application.routers = [];
		application.routers.push(new MainRouter());
		application.routers.push(new ContactsRouter());
		application.routers.push(new PagingContactsRouter());
		application.routers.push(new UsersRouter());
		application.routers.push(new RolesRouter());
		application.routers.push(new PermissionsRouter());
		application.routers.push(new VisitatoriRouter());
		application.routers.push(new AccessiRouter());
		
		
		
		application.buildNewLoginInfo = function() {

			if(application.loginInfo) {
				application.loginInfo.off();
			}
			
			application.loginInfo = new LoginInfo();
			application.loginInfo.on("destroy", application.buildNewLoginInfo, application);
			
			application.postazioni = new Postazioni();
			application.postazioni.url = "api/public/postazioni";
			application.postazioni.fetchPage();
		};
		application.buildNewLoginInfo();
		
		
		
		application.modalDialog = new ModalDialogView();
		$("#modaldialog").html(application.modalDialog.render().el);
		
		Backbone.history.start({root: "/access-control"});
		Backbone.history.navigate("login", true);	
	});
});
