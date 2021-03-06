define([
	"underscore", 
	"backbone",
	"jquery",
	"text!templates/common/pager.html"], 
	function(_, Backbone, $, pagerTemplate) {
	
	var view = Backbone.View.extend({
		
		tagName: "div",
		
		className: "row",
		
		events: {
			"click a.page-goto": "gotoPage"
		},
		
		baseUrl: "#",
		
		buttonsShown: 5,
		
		initialize: function(options) {
			
			this.collection.on("all", this.render, this);
			
			if(options.baseUrl)
				this.baseUrl = options.baseUrl;
			
			if(options.buttonsShown)
				this.buttonsShown = options.buttonsShown;
		},
		
		onClose: function() {
			this.collection.off("all", this.render);
		},

		render: function() {

			this.$el.html(_.template(pagerTemplate, { 
				collection: this.collection,
				buttonsShown: this.buttonsShown
			}));
			return this;
		},
		
		gotoPage: function(e) {

			e.preventDefault();
			
			// Skip disabled buttons.
			//
			if($(e.target).parent().hasClass("disabled")) {
				return;
			}

			// Request new page to router.
			//
			var page = $(e.target).attr("id");
			Backbone.history.navigate(this.baseUrl + page, true);
		}
	});
	
	return view;
});
