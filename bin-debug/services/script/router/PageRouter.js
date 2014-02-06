define(['backbone'], function(Backbone) 
	{
		var PageRouter = Backbone.Router.extend({
			routes: {
				"about" : "showPage",
				"/:id" : "viewPage",
				"/:id/edit" : "editPage",
				"/:id/download/*documentpath" : "downloadDocument",
				"search/query" : "searchPages",
				"diary/:id" : "viewItem",
				"diary?id=:id" : "viewItem",
				"menu" : "showMenu",
				"*other" : "defaultRoute"
			},
			showPage: function() {
					console.log(Backbone.history.fragment+' page');
					this.trigger("changePage", Backbone.history.fragment);
					this.navigate(Backbone.history.fragment);
					if (Backbone.history.fragment=="diary")
					{
						this.trigger("onListItem", "diary");
					}

			},
			viewItem: function(id) {
				console.log("View list requested.");
				
				this.trigger("changePage", {name: "diary", id: id==null ? -1 : id});
				this.trigger("onListItem", id);
			},			
			viewPage: function(id) {
				console.log("View page requested.");
				//if (Backbone.history.fragment!="diary")
				
				this.navigate("diary");
				//this.navigate("page/" + id + '/view');
			},
			editPage: function(id) {
				console.log("Edit page requested.");
				this.navigate("page/" + id + '/edit');
			},
			showMenu: function()
			{
				
				this.trigger("onMenu", Backbone.history.fragment);
				//this.navigate(Backbone.history.fragment);
			},
			search: function(query) {},
			downloadDocument: function(id, path) {},
			defaultRoute: function(other) {
				console.log('Invalid. You attempted to reach:' + other);
			},
			initialize: function()
			{
				console.log("PageRouter started");
				
				//Backbone.history.start({pushState: true, root:"index.html"});

				
			},
			update: function(coll) {
				Backbone.history.start();
				for (var i=0;i<coll.length;i++)
				{

					var item = (coll.at(i).get("name"));
					
					this.route(item, "showPage");
				}
				this.route("menu", "showMenu");

				console.log("Router: "+Backbone.history.fragment)	
				console.log("Router: "+this.routes)
				if (Backbone.history.fragment=="menu") {
					//alert(coll.at(coll.length-1).get("name"))
					this.trigger("changePage", "home");
					this.showMenu();	

				} else if (Backbone.history.fragment.indexOf("diary")!=-1)
				{
				
					if (Backbone.history.fragment.indexOf("?id="))
					{
							this.viewItem(Backbone.history.fragment.split("?id=")[1]);
					} else 
					{
						this.viewItem(Backbone.history.fragment.split("/")[1]);	
					}
					
				} else
				{
					//alert(Backbone.history.fragment)
					if (Backbone.history.fragment=='')
					{
						this.trigger("changePage", "home");
						//this.trigger("changePage", (coll.at(0).get("name")));
					} else
					{
						this.trigger("changePage", Backbone.history.fragment);	
					}
					
				}
					
			}



		});
		return PageRouter;

	});
//Integrate google tracker