define([
	"underscore", 
	"backbone",
	"access-control/collections/pagingcollection",
	"access-control/models/contact"], 
	function(_, Backbone, PagingCollection, Contact) {
	
	var contacts = PagingCollection.extend({

		model: Contact,
		
		url: "api/contacts",
	});
	
	return contacts;
});