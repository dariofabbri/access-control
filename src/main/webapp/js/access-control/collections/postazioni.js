define([
	"underscore", 
	"backbone",
	"access-control/collections/pagingcollection",
	"access-control/models/postazione"], 
	function(_, Backbone, PagingCollection, Postazione) {
	
	var postazioni = PagingCollection.extend({

		model: Postazione,
		
		url: "api/postazioni",
	});
	
	return postazioni;
});