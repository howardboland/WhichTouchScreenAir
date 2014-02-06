define(['text!templates/newslist.html','backbone', 'jquery.ui', 'jquery.sortable',
  	'collection/NewsCollection', //Request NewsCollection.js
  	'view/NewsListItem', //Request NewsElementView.js
  	'model/NewsModel', //Request NewsElementView.js
  	'view/NewsFormView', //Request NewsElementView.js
  	'crossdomain' //Request NewsElementView.js
], 	function(Template, Backbone, UI, Sortable, NewsCollection, NewsListItem, NewsModel, NewsFormView, crossdomain)
	{
	var NewsListView = Backbone.View.extend( {
		el: '#news',
		newsform: null,
		currentSelected: -1,
		dropmodel: null,
		dragmodel: null,
		template: _.template( Template ),
		events: {
			'keypress #addnews': 'filterOnEnter',
			'click #submit-news': 'create',
			'click li.news' : 'select',
			'sortstart li.news'   :  'sortBegin',
			'sortend li.news'   :  'sortEnd',
			/*'keypress li.news' : 'delete'*/
          	

		},
		render: function()
		{
			console.log( "Render News " +this.collection.length);
			//this.collection.unshift( (new NewsModel()).set("name", "menu").set("title", "menu") )
			this.$el.html( this.template() );
			for (var i=0;i<this.collection.length;i++)
			{
				//console.log( this.collection.at(i).get("orderid") )
			 	var navItem = new NewsListItem( { model: this.collection.at(i) } );
			 	var $item = $( navItem.render().el );
			 	$(this.el).find("ul").append( $item );

			}
/*			this.$el.find("ul li").draggable({revert: true})
			this.$el.find("ul li a").droppable({drop: function(event, ui) {
				   	//	console.log("drop "+ui.draggable[0].outerHTML)
				   	//	console.log("drop "+$(event.target)[0].outerHTML)
				   }});
*/

			this.trigger('complete', this.collection);
			
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
			//alert('creating new '+$("#addnews").val());
			if ( $("#addnews").val().length>2)
			{
			var model = (new NewsModel()).set("title", $("#addnews").val()).set("header", $("#addnews").val());
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
			//alert('creating new '+$("#addnews").val());
			
			// we should create a new model and open input form.
		},
		edit: function( model )
		{
			this.collection.each(function(m) { m.set("selected", -1)});
			model.set("selected", 1);
			if (this.newsform==null)
				this.newsform = new NewsFormView();
			this.newsform.model = model;
			this.newsform.render();
			this.newsform.on("delete", this.delete);
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
			this.collection = new NewsCollection;

			// not using get
			this.collection.fetch({ 
					data: { method: "getNews" }, 
					success: function(){
							console.info("NewsCollection successfully loaded"); 
							self.render();
							self.listenTo( self.collection, 'add', self.render );
							self.listenTo( self.collection, 'remove', self.render );
					},
					error: function(data, response, status) {
							
							console.error("NewsCollection loading error of url '"+data.url+"' caused by '"+response.statusText+"' server returned code " +response.status); 							
							//for (var m in status)
							//	console.error(m+" "+status[m]); 
							//for (var m in xhr.xhr)
						//		console.error(m+" "+xhr.xhr[m]); 
							self.trigger('error',["News", response]); }
			});
			$("#addnews").focus();
			$(window).bind("resize", $.proxy(this.onresize, this));
			console.log("Initialize NewsListView");
		}
	});

	return NewsListView;
});