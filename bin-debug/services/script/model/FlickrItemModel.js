define(['backbone'], function(Backbone) {

var FlickrItemModel = Backbone.Model.extend({
		defaults: {id: -1, name: '', server: '', secret: '', farm: null, title:'', small_image:'', large_image: '', title_description: ''},
		initialize: function() {
			console.log("Ready");
			
			var imagelocation =  "http://farm" + this.get("farm") + ".static.flickr.com/" + this.get("server") + "/" + this.get("id") + "_" + this.get("secret") + "_";
			this.set("small_image", imagelocation+  "s.jpg");
			this.set("large_image", imagelocation+  "b.jpg");
			this.set("title_description", this.get("title")=='' ? "LIVING MIRROR" : "LIVING MIRROR - " + this.get("title").toUpperCase() );

		}
	});
	return FlickrItemModel;
});


/*

 var img_src = "http://farm" + photo.farm + ".static.flickr.com/" + photo.server + "/" + photo.id + "_" + photo.secret + "_" + "s.jpg";

        //LINK TO IMAGE PAGE (REQUIRED BY FLICKR TOS)
        var a_href = "http://www.flickr.com/photos/c-lab/sets/72157627655771412/";

        //PLACE IMAGE IN IMAGE TAG AND APPEND TO IMAGES DIV 
        $("<img/>").load(function(){ len-=1; if (len==0) { flickrLoaded() } }).attr("src", img_src).attr("title", photo.title).attr("alt", photo.title).appendTo("#Flickr")


*/