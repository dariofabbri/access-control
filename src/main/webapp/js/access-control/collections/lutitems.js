define([
	"underscore", 
	"backbone",
	"access-control/collections/pagingcollection",
	"access-control/models/lutitem"], 
	function(_, Backbone, PagingCollection, LUTItem) {
	
	var lutItems = PagingCollection.extend({

		model: LUTItem,
		
		url: "api/luts",
	});
	
	return lutItems;
});