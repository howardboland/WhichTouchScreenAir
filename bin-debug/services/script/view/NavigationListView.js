define(['backbone',
  	'collection/NavigationCollection', //Request NavigationCollection.js
  	'view/NavigationListItem', //Request NavigationElementView.js
  	'model/NavigationModel', //Request NavigationElementView.js
  	'crossdomain' //Request NavigationElementView.js
], 	function(Backbone, NavigationCollection, NavigationListItem, NavigationModel, crossdomain)
	{
	var NavigationListView = Backbone.View.extend( {
		el: '#menu ul',
		currentSelected: '',
		events: {
			/*'keypress .edit': 'updateOnEnter' */

		},
		render: function()
		{
			console.log( "Render Navigation " +this.collection.length);
			//this.collection.unshift( (new NavigationModel()).set("name", "menu").set("title", "menu") )
			for (var i=0;i<this.collection.length;i++)
			{
				console.log( this.collection.at(i) )
			 	var navItem = new NavigationListItem( { model: this.collection.at(i) } );
			 	var $item = $( navItem.render().el );
			 	$(this.el).append( $item );
			 	//var $span = $($item.find("span"));
			 	
			 	//$span.css({  top : (($span.parent().height()-$span.height()) / 2)})
			}
			this.update(this.currentSelected);
			this.trigger('complete', this.collection);
		}, 
		update: function(name)
		{
			$(this.el).find("li").removeClass("selected");
			for (var i=0;i<this.collection.length;i++)
			{
				if (this.collection.at(i).get("name")==name)
				{
					$($(this.el).find("li")[i]).addClass("selected");
					
				}
			}
			this.currentSelected = name;
		},

		onresize: function()
		{

		},
		popmenu: function() 
		{
			console.log('pop')	
			 $(".video-wrapper").switchClass("onscreen", "offscreen");
			 $(this.el).removeClass("hide-menu-items").addClass( "show-menu-items");
			 $($(this.el).find(".menu-list a")).attr("href", Backbone.history.fragment!="menu" ? "javascript:window.history.back()" : "#home")
		},

		unpopmenu: function() 
		{
			console.log('unpop')
			if ($(".video-wrapper").hasClass("offscreen"))
				$(".video-wrapper").switchClass("offscreen", "onscreen");
			//$(".video-wrapper").switchClass("", "onscreen");
			//$(".video-wrapper").animate({"left": "0"})
			$(this.el).removeClass("show-menu-items").addClass( "hide-menu-items");
			$($(this.el).find(".menu-list a")).attr("href", "#menu")
			
		},
		initialize : function()
		{
			 _.bind(this, this.render);
			var self = this;
			this.on( 'change', this.update, this );
			this.on( 'popmenu', this.popmenu, this );
			this.on( 'unpopmenu', this.unpopmenu, this );
			this.collection = new NavigationCollection;

			// not using get
			this.collection.fetch({ 
					data: { method: "getNavigation" }, 
					success: function(){
							console.info("NavigationCollection successfully loaded"); 
							self.render();
					},
					error: function(data, response, status) {
							
							console.error("NavigationCollection loading error of url '"+data.url+"' caused by '"+response.statusText+"' server returned code " +response.status); 							
							//for (var m in status)
							//	console.error(m+" "+status[m]); 
							//for (var m in xhr.xhr)
						//		console.error(m+" "+xhr.xhr[m]); 
							self.trigger('error',["Navigation", response]); }
			})
			$(window).bind("resize", $.proxy(this.onresize, this));
			console.log("Initialize");
		}
	});

	return NavigationListView;
});