define([
	"underscore", 
	"backbone",
	"access-control/collections/pagingcollection",
	"access-control/models/user"], 
	function(_, Backbone, PagingCollection, User) {
	
	var users = PagingCollection.extend({

		model: User,
		
		url: "api/users",
	});
	
	return users;
});