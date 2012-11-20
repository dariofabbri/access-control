define([
	"underscore", 
	"backbone",
	"access-control/collections/pagingcollection",
	"access-control/models/role"], 
	function(_, Backbone, PagingCollection, Role) {
	
	var roles = PagingCollection.extend({

		model: Role,
		
		url: "api/roles",
	});
	
	return roles;
});