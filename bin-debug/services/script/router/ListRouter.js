define(['backbone'], function(Backbone) 
	{
		var ListRouter = Backbone.Router.extend({
			routes: {
				"diary/:id" : "viewItem"
			},
			viewItem: function(id) {
				console.log("View list requested.");
				this.navigate("diary/" + id + '/view');
			},
			initialize: function()
			{
				console.log("ListRouter started");
				
			},
			update: function(coll) {
				for (var i=0;i<coll.length;i++)
				{

					var item = (coll.at(i).get("name"));
					this.route(item, "showItem");
				}
				
				console.log(this.routes)
				console.log("updating ListRouter");
				this.trigger("changeList", Backbone.history.fragment);
			}



		});
		return ListRouter;

	});
//Integrate google tracker