define(['text!templates/assetlist.html','backbone', 'jquery.ui', 'jquery.sortable',
  	'collection/AssetCollection', //Request AssetCollection.js
  	'view/AssetListItem', 
  	'model/AssetModel', 
  	'view/AssetFormView', 
  	'crossdomain' 
], 	function(Template, Backbone, UI, Sortable, AssetCollection, AssetListItem, AssetModel, AssetFormView, crossdomain)
	{
	var assetListView = Backbone.View.extend( {
		el: '#asset',
		assetform: new AssetFormView(),
		currentSelected: -1,
		dropmodel: null,
		dragmodel: null,
		template: _.template( Template ),
		events: {
			'keypress #addasset': 'filterOnEnter',
			'click #submit-asset': 'create',
			'click li.asset' : 'select',
			'sortstart li.asset'   :  'sortBegin',
			'sortend li.asset'   :  'sortEnd',
			/*'keypress li.asset' : 'delete'*/
          	

		},
		render: function()
		{
			console.log( "Render asset " +this.collection.length);
			//this.collection.unshift( (new AssetModel()).set("name", "menu").set("title", "menu") )
			
			this.$el.html( this.template() );
			this.recurse( this.$el.find("ul"), -1)
			this.trigger('complete', this.collection);
			
		}, 
		recurse: function(parentItem, pid)
		{
			var models = this.collection.where({"pid": pid});
			console.log("models:"+models.length);
			var parent = parentItem;
			if (pid>-1)
			{
				parent = $("<ul/>");
				parentItem.append( parent );
			}

			
			for (var i=0;i<models.length;i++)
			{
				model = models[i];

				//console.log( this.collection.at(i).get("orderid") )
			 	var navItem = new AssetListItem( { model: model } );
			 	var $item = $( navItem.render().el );
parent.append( $item );
			 	this.recurse( parent, model.get("id") );
			 ///	parent.append( $item );

			}
		},
		sortBegin: function(e, model)
		{
			this.dragmodel = model;
		},
		sortEnd: function(e, model)
		{
			this.dropmodel = model;
			this.sort();
		},
		sort:  function() 
		{
			var wasOrderid = this.dragmodel.get("orderid");
			console.log(this.dragmodel.get("title")+"=>"+this.dropmodel.get("title"))
			this.dragmodel.set("orderid", this.dropmodel.get("orderid"));
			this.dropmodel.set("orderid", wasOrderid);
			this.dropmodel.save();
			this.dragmodel.save();
			this.collection.sort();
			this.render();

		},
		delete: function()
		{
			//alert("delete");
		},
		filterOnEnter: function(e) {
	        if (e.keyCode != 13) return;
	        this.create();
	     },
		create: function()
		{
			//alert('creating new '+$("#addasset").val());
			if ( $("#addasset").val().length>2)
			{
			var model = (new AssetModel()).set("title", $("#addasset").val()).set("header", $("#addasset").val());
			model.save( {},{ headers: {'accesskey' :'KEY_CODE_TO_BE_IMPLEMENTED'}, 
						 success: this.saved, 
						 error: this.errorResult });
			} else {
				alert("Please provide longer title...");
			}
		},
		saved: function(model, resp)
		{
			model.set("id", resp.result);
			console.log(this.collection.length)
			this.collection.add( model );
			console.log(this.collection.length)
			this.edit( model );
		},
		errorResult: function(resp)
		{
			console.log("Error...");
			// Need to trigger update of list
			//this.$el.trigger('render');
		},
		select: function(e)
		{

			e.preventDefault();
			var model = this.collection.get($(e.target).data("id"));
			this.edit( model );
			//alert('creating new '+$("#addasset").val());
			
			// we should create a new model and open input form.
		},
		edit: function( model )
		{
			this.collection.each(function(m) { m.set("selected", -1)});
			model.set("selected", 1);
			this.assetform.model = model;
			this.assetform.render();
			this.assetform.on("delete", this.delete);
		},
		onresize: function()
		{

		},
		initialize : function()
		{
			 _.bind(this, this.render);
			 _.bindAll(this);
			var self = this;
			this.on( 'change', this.update, this );
			this.collection = new AssetCollection;

			// not using get
			this.collection.fetch({ 
					data: { method: "getasset" }, 
					success: function(){
							console.info("AssetCollection successfully loaded"); 
							self.render();
							self.listenTo( self.collection, 'add', self.render );
							self.listenTo( self.collection, 'remove', self.render );
					},
					error: function(data, response, status) {
							
							console.error("AssetCollection loading error of url '"+data.url+"' caused by '"+response.statusText+"' server returned code " +response.status); 							
							//for (var m in status)
							//	console.error(m+" "+status[m]); 
							//for (var m in xhr.xhr)
						//		console.error(m+" "+xhr.xhr[m]); 
							self.trigger('error',["asset", response]); }
			});
			$("#addasset").focus();
			$(window).bind("resize", $.proxy(this.onresize, this));
			console.log("Initialize assetListView");
		}
	});

	return assetListView;
});