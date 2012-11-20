define([
	"underscore", 
	"backbone",
	"access-control/collections/pagingcollection",
	"access-control/models/permission"], 
	function(_, Backbone, PagingCollection, Permission) {
	
	var permissions = PagingCollection.extend({

		model: Permission,
		
		url: "api/permissions",
	});
	
	return permissions;
});