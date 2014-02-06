define(['jquery',
  'underscore',
  'modernizr',
  'backbone',
  'event/EventMediator',
  'router/PageRouter', // Request PageRouter.js
  'collection/PageCollection', //Request PageCollection.js
  'view/LoaderView',
  'view/LoginView',
  'view/PageView',
  'view/NavigationListView',
  'view/NewsListView',
  'view/AssetListView',
  'crossdomain'
], function($, Modernizr, _, Backbone, EventMediator, PageRouter, PageCollection, LoaderView, LoginView, PageView, NavigationListView, NewsListView, AssetListView) {

	var initialize = function()
	{
		

		$this = this;

		//$.support.cors = true;
		Backbone.emulateHTTP = true;
		//Backbone.emulateJSON = true;
		//var EventMediator = _.extend({}, Backbone.Events);
		
/*
		$.ajaxPrefilter( function( options, originalOptions, jqXHR ) { 
			// Your server goes below //options.url = 'http://localhost:8000' + options.url; 
			if (document.location.hostname == "localhost" && options.url.indexOf("http://")==-1)
			{
 				options.url = 'http://test.c-lab.co.uk' + options.url; 
			}
			
		}); 
		*/
		
			
		//- See more at: http://backbonetutorials.com/cross-domain-sessions/#sthash.GlboKibv.dpuf

		console.log("AppView initialize");
	
		this.page = null;
		this.loaderView = new LoaderView;
		new LoginView();
		this.router = new PageRouter;

		this.error = function(obj) {
			
			$this.loaderView.trigger("error", obj);
		}
	
		this.collection = new PageCollection;
		this.navigation = new NavigationListView;
		//this.news = new NewsListView;
		this.assets = new AssetListView; 


/*
		this.navigation.on("error", this.error)
		this.navigation.on("complete", function(coll) 
		{ 			

				console.info("navigation collection "+coll.length)
				$this.router.update(coll)  
		});

		this.router.on("changePage", function(name) { 

				var id = typeof(name)=="object" ? name.id : -1;				
				var name = typeof(name)=="object" ? name.name : name;
				if ($this.navigation.collection.length>0)
				{

					$this.collection.fetch( { 
						data: { 
							method: 'getPage', 
							id: name!="" ? $this.navigation.collection.where({name:name})[0].get("id") : $this.navigation.collection.at(0).get("id") }, 
							success: function(){ console.log("collection loaded succesfully");	$this.render(name, id);	},
							error: function(data,response,status) { console.error("There was an error in loading the collection "+response.statusText); $("window").trigger('error', ["Router", response]); } 
					});
				} else {
					console.error("No navigation collection loaded")
				}
				$this.navigation.trigger("unpopmenu", name);
				$this.topmenu.trigger("unpopmenu", name);
				$this.navigation.trigger("change", name);
				$this.topmenu.trigger("change", name);
				$this.pagenavigation.trigger("change", name);
				$this.footernavigation.trigger("change", name);
			 
		});
		this.router.on("onListItem", function( id )
		{

				
				if ($this.page!=null)
				{
					$this.page.trigger("onListItem", id);
				}
					
//				else

		});

		this.router.on("onMenu", function( name ) {
			
			$this.navigation.trigger("popmenu", name);
			$this.topmenu.trigger("popmenu", name)
		});

		
		this.render = function(name, id)
		{
			//console.log("render AppView");

			//console.log( this.collection.at(0).get("name") );
			console.log("render AppView");
			var isSame = false;
			this.loaderView.trigger("complete");

			if (this.page!=null)
			{
				if (this.page.model.get("name")==name)
				{
					isSame = true;
				}
			}

			if (!isSame)
			{
			
				// generate page view
				if (this.page!=null)
					this.page.close();
				if (this.slide)
					this.slide.close();

				this.page = new PageView({EventMediator: EventMediator, model: this.collection.at(0), id:id});				
				this.slide = new SlideView({model: this.collection.at(0)});
				// set document title
				$("title").text( this.page.model.get("name").toUpperCase() );
				 $("html, body").animate({opacity: 1}, 1500);

			 }
		}
		this.addOne = function( pagemodel )
		{
			//var view = new view.PageView({ model: pagemodel });

		}
		//this.collection.on('add', this.add, this);

		this.collection.on('addOne', this.addOne, this);
		//$("body").fadeIn('slow');
		//this.collection.on('all', this.render, this);
		//this.collection.fetch( { data: { method: 'getPage', id: 2 }, success:  function(){	self.render()	} });
	//	this.collection.create({title:'Read the whole book', id: 2});

	*/
	}

	return { initialize: initialize };	

});
