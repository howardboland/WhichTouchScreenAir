define(['backbone', 'model/PageModel'], function(Backbone, PageModel) {

	var NavigationCollection = Backbone.Collection.extend({
		model: PageModel,
		url: (document.location.hostname == "localhost" ? 'http://localhost/whichDirect/' : '') +'/services/pages.php', 	
		initialize: function()
		{

			console.log("Navigation collection init");

		//	this.BannerCollection.bind("completed", co)
		}
	});
	return NavigationCollection;
});