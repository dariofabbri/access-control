define([
	"underscore", 
	"backbone",
	"access-control/collections/pagingcollection",
	"access-control/models/accesso"], 
	function(_, Backbone, PagingCollection, Accesso) {
	
	var accessi = PagingCollection.extend({

		model: Accesso,
		
		url: "api/accessi",
	});
	
	return accessi;
});