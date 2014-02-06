define(['backbone', 'model/NewsModel'], function(Backbone, NewsModel) {

	var NewsCollection = Backbone.Collection.extend({
		model: NewsModel,
		comparator: function(a,b) {
       	 	 var a = a.get('orderid'),
      		 b = b.get('orderid');
   			if (a == b) return 0;
   			return a > b ? 1 : -1;
    	},
		url: (document.location.hostname == "localhost" ? 'http://localhost/whichDirect/' : '') +'/services/news.php', 	
		initialize: function()
		{

			console.log("News collection init");

		//	this.BannerCollection.bind("completed", co)
		}
	});
	return NewsCollection;
});