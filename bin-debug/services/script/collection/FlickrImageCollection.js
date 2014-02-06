define(['backbone', 'model/FlickrItemModel'], function(Backbone, FlickrItemModel) {

	var FlickrImageCollection = Backbone.Collection.extend({
		model: FlickrItemModel,
		url:  "http://api.flickr.com/services/rest/",
		initialize: function(models,options)
		{

			console.log("flickr collection init "+this.url);
	
		},
		parse: function(response, xhr) {
				//need to select photoset
			  return response.photoset.photo;
			},
		complete: function() {
		
				console.log("list images loaded")

		}
	});
	return FlickrImageCollection;
});