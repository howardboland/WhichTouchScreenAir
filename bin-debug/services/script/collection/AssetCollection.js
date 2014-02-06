define(['backbone', 'model/AssetModel'], function(Backbone, AssetModel) {

	var AssetCollection = Backbone.Collection.extend({
		model: AssetModel,
		comparator: function(a,b) {
       	 	 var a = a.get('orderid'),
      		 b = b.get('orderid');
   			if (a == b) return 0;
   			return a > b ? 1 : -1;
    	},
		url: (document.location.hostname == "localhost" ? 'http://localhost/whichDirect/' : '') +'/services/asset.php', 	
		initialize: function()
		{

			console.log("Asset collection init");

		//	this.BannerCollection.bind("completed", co)
		}
	});
	return AssetCollection;
});