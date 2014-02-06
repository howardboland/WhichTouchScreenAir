define(['backbone', 'model/ListItemModel'], function(Backbone, ListItemModel) {

	var ListCollection = Backbone.Collection.extend({
		model: ListItemModel,
		url: (document.location.hostname == "localhost" ? 'http://lm.c-lab.co.uk' : '') +'/php/list.php', 
		initialize: function()
		{
			console.log("list collection init");
	
		},
		complete: function() {
				console.log("list images loaded")
		}
	});
	return ListCollection;
});