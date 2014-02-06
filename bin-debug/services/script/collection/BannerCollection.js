define(['backbone', 'model/BannerModel'], function(Backbone, BannerModel) {

	var BannerCollection = Backbone.Collection.extend({
		model: BannerModel,
		url: (document.location.hostname == "localhost" ? 'http://lm.c-lab.co.uk' : '') +'/php/list.php', 
		initialize: function()
		{
			console.log("banner collection init");
		//	this.BannerCollection.bind("completed", co)
		},
		complete: function() {
				console.log("banner images loaded")
		},
		fill: function() {
		
			this.models = this.models.reverse();
		
			while (this.length<3)
			{
				var b1 = this.at(0);
				var b2 = new BannerModel;
				b2.set("url", b1.get("url"));
				b2.set("body", b1.get("body"));
				b2.set("images", b1.get("images"));
				b2.set("title", b1.get("title"));
				this.push(b2);
			}

		}
	});
	return BannerCollection      ;
});