define([
	"underscore", 
	"backbone",
	"access-control/views/login/login",
	"access-control/views/common/navbar",
	"access-control/views/common/footer"], 
	function(
			_, 
			Backbone, 
			LoginView, 
			NavbarView,
			FooterView) {

	var main = Backbone.Router.extend({
		
		routes: {
			"login": "login",
			"home": "home"
		},
		
		login: function() {
			this.close("#navbar");
			this.close("#footer");

			var view = new LoginView();
			this.show(view, "#container");
		},
		
		home: function() {
			this.close("#container");

			var navbar = new NavbarView({model: application.loginInfo});
			this.show(navbar, "#navbar");
			
			var footer = new FooterView({model: application.loginInfo});
			this.show(footer, "#footer");
		}
	});

	return main;
});
