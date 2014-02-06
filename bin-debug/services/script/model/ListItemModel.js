define(['backbone', 'jquery.dateformat'], function(Backbone) {

var ListItemModel = Backbone.Model.extend({
		defaults: { id: -1, name: '', body:'', url: '', title: '', index: 0, featured: '', images: null, startdate: null, enddate: null, posted: null, daterange: '', prettyPosted: '', postedISO8601: ''},

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
			this.set( "featured", this.lookupRandomImage() );

			
			this.set( "index", this.get("cid") );
			this.set( "title", this.get("name") );


			var UTCOffset = 0;
			
			var sdate =new Date();
			if (this.get("startdate")!=null && this.get("startdate")>0) {
						sdate = new Date(this.get("startdate")*1000);
						sdate.setUTCHours(sdate.getHours()+UTCOffset);
			}
			
			var edate =new Date();
			if (this.get("enddate")!=null && this.get("enddate")>0) {
					edate = new Date(this.get("enddate")*1000);
					edate.setUTCHours(edate.getHours()+UTCOffset);
			} 

			if ($.format.date(edate, 'HH:mm dd-MMM-yyyy')==$.format.date(sdate, 'HH:mm dd-MMM-yyyy') || edate.getFullYear()<2000 || this.get("enddate") == null)
			{
					this.set( "daterange", $.format.date(sdate, 'HH:mm dd-MMM-yyyy') );
			} else if ($.format.date(edate, 'dd-MMM-yyyy')==$.format.date(sdate, 'dd-MMM-yyyy')) 
			{
					this.set( "daterange", $.format.date(sdate, 'HH:mm') +"-"+ $.format.date(edate, 'HH:mm dd-MMM-yyyy'));
			} else
			{
					this.set( "daterange", $.format.date(sdate,  $.format.date(sdate, 'HH:mm dd-MMM-yyyy')) +"-"+ $.format.date(edate, 'HH:mm dd-MMM-yyyy') );
			}
				edate = $.format.date(sdate, 'HH:mm dd-MMM-yyyy'); 
				sdate = $.format.date(sdate, 'HH:mm dd-MMM-yyyy'); 
			
			var posted = new Date();
			if (this.get("posted")!=null && this.get("posted")>0) {
					posted = new Date(this.get("posted")*1000);
					posted.setUTCHours(posted.getHours()+UTCOffset);
			} 
			this.set("postedISO8601", $.format.date(posted, 'yyyy-MM-ddTHH:mm:ssZ') );
			this.set("prettyPosted",  $.format.date(posted, 'HH:mm dd-MMM-yyyy') );

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
			return this.get("images")!=null
		},
		lookupRandomImage: function()
		{
			var rndIndex = 0;
			//rndIndex =Math.round( (this.get("images").length-1)*Math.random() )
			return !this.hasImage() ? '' : $(this.get("images")[ rndIndex ]).attr("src");	
			
		}
	});
	return ListItemModel;
});