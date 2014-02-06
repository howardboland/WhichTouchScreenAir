define(['backbone'], function(Backbone) {

var BannerModel = Backbone.Model.extend({
		defaults: { id: -1, name: '', body:'', url: '', title: '', index: 0, images: []},

		initialize: function() {
			//console.log("BannerModel ready");

			var body = $( this.get("body") );
			if (body.length>0)
			{
				if (body.find("img").length>0)
				{

					this.set("images", body.find("img") );	
				} 
			} 
			this.set( "url", this.lookupRandomImage() );
			this.set( "index", this.get("cid") );
			this.set( "title", this.get("name") );

//			console.log( this.get("images") );
			/*
			var e = $(data.body).find("img")[ Math.round(($(data.body).find("img").length-1)*Math.random()) ]; 
					
					
						var no = $("#featured img").length;	
					
						//e = '<img src="userdata/12March_02.jpg"  />';
						var orbs= $("#featured").children("img, div, a");
						var spans = $("#featured").children("span");
						var dir = $("#featured").attr("dir");
						var index = Number( $("#featured").attr("activeIndex") );
					//	index = $("#featured").attr("prevIndex");
						
						var caption = data.name==null ? "" : data.name;
						*/
		}, 
		hasImage: function()
		{
			return (this.get("images").length>0)
		},
		lookupRandomImage: function()
		{
			return !this.hasImage() ? '' : $(this.get("images")[ /*Math.round( (this.get("images").length-1)*Math.random() )*/ 0 ]).attr("src");	
			
		}
	});
	return BannerModel;
});