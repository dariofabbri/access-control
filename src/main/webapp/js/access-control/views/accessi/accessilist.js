define([
	"underscore", 
	"backbone",
	"jquery",
	"access-control/collections/lutitems",
	"access-control/views/common/pager",
	"access-control/views/accessi/accessilistitem",
	"access-control/views/accessi/accessisearch",
	"text!templates/accessi/accessilist.html"], 
	function(_, Backbone, $, LUTItems, Pager, ItemView, SearchView, listTemplate) {
	
	var view = Backbone.View.extend({
		
		tagName: "div",

		events: {
			"click a#search": "search",
			"click a#inCorso": "searchInCorso",
			"click a#reset-filters": "resetFilters"
		},

		initialize: function() {
			this.collection.on("reset", this.render, this);

			this.statoAccessoList = new LUTItems();
			this.statoAccessoList.url += "/statoaccesso";
			this.statoAccessoList.fetch();
		},

		onClose: function() {
			this.collection.off("reset", this.render);

			$("a#reset-filters", this.el).tooltip("destroy");
			$("a#search", this.el).tooltip("destroy");
			$("a#inCorso", this.el).tooltip("destroy");
		},

		childViews: [],

		render: function(e) {

			this.cleanChildViews();
			
			// Show main part of the view.
			//
			this.$el.html(_.template(listTemplate, {
				collection: this.collection
			}));
			
			// Activate tooltips.
			//
			$("a#reset-filters", this.el).tooltip();
			$("a#search", this.el).tooltip();
			$("a#inCorso", this.el).tooltip();

			// Render an item view for each model in the collection.
			//
			var that = this;
			_.each(this.collection.models, function(item) {
				that.renderItem(item);
			}, this);
			that = null;
			
			// Add a pager at the bottom of the view.
			//
			var pager = new Pager({
				collection: this.collection,
				baseUrl: "AccessiList/page/"
			});
			this.$el.append(pager.render().el);
			
			// Store the pager view in the list of child views, to avoid
			// memory leaks.
			//
			this.childViews.push(pager);
			
			return this;
		},
		
		renderItem: function(item) {
			
			// Create and render the item view.
			//
			var itemView = new ItemView({
				model : item
			});
			$("tbody", this.el).append(itemView.render().el);
			
			// Store the item view in the list of child views, to avoid
			// memory leaks.
			//
			this.childViews.push(itemView);
		},
		
		search: function() {
			
			// Destroy the tooltip (prevents leaving the tooltip
			// open in the new window).
			//
			$("a#search", this.el).tooltip("destroy");

			// Create the search view object by passing the
			// current collection, that will be used for reissuing
			// the query on the backend.
			// 
			var searchView = new SearchView({
				collection: this.collection,
				statoAccessoList: this.statoAccessoList
			});
			
			// Keep a reference to search view for later clean-up.
			//
			this.childViews.push(searchView);
				
			// Render the view and show modal.
			//
			$("div#modalContainer", this.el).html(searchView.render().el);
			$("div#searchModal", this.el).modal("show");
			$("div#searchModal", this.el).on("shown", searchView.setFocus);
		},
		
		searchInCorso: function() {
			
			// Destroy the tooltip (prevents leaving the tooltip
			// open in the new window).
			//
			$("a#inCorso", this.el).tooltip("destroy");

			this.collection.queryArguments.idStato = 1;
			this.collection.fetchPage();
		},

		resetFilters: function() {
			
			// Destroy the tooltip (prevents leaving the tooltip
			// open in the new window).
			//
			$("a#reset-filters", this.el).tooltip("destroy");

			this.collection.resetFilters();
			this.collection.fetchPage();
		}
	});
	
	return view;
});