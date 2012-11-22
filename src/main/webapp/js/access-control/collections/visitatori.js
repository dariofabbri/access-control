define([
	"underscore", 
	"backbone",
	"access-control/collections/pagingcollection",
	"access-control/models/visitatore"], 
	function(_, Backbone, PagingCollection, Visitatore) {
	
	var visitatori = PagingCollection.extend({

		model: Visitatore,
		
		url: "api/visitatori",
	});
	
	return visitatori;
});