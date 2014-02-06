define(['text!templates/newsitem.html','backbone'], function(Template, Backbone) {
	var NewsListItem = Backbone.View.extend( {
		tagName: 'li',
		className: 'news',
		template: _.template( Template ),
		events: {
			/*'keypress .edit': 'updateOnEnter' */
			 'drop' : 'onDrop',
			 'dropable' : 'onDrop',
			 'dragenter' : 'onDrag',
			 'dragstart' : 'dragStart',
			 'dragleave' : 'dragLeave',
			 'dragend' : 'dragEnd',
			 'dragover' : 'dragOver',
			 'keypress a': 'filterOnDelete',

		},
		render: function(){
			//console.log( "Render NewsListItem" );
			//console.log( this.model.toJSON() );
			this.$el.html( this.template( this.model.toJSON() ) );
			//console.log( "selected "+ this.model.get("selected"))
			//$(document).on("keypress", this.filterOnDelete);
			if (this.model.get("selected")>0)
				this.$el.find("a").addClass("selected").focus();
			else
				this.$el.find("a").removeClass("selected");
			return this;

		},
		filterOnDelete: function(e) {
	        if (e.keyCode != 100) return;
	        if (window.confirm("Deleting item! Are you sure?"))	
		        this.model.destroy();
	     },
		unrender: function()
	    {
	        $(this.el).fadeOut().animate({"height":"0px"});
	    },
		onSortStart: function(event) {
			
		},
		onDrop: function(event) {
			event.preventDefault();
	        this.$el.trigger('sortend', [this.model]);


    	}, 
    	onDrag: function(e) {
	        
    	},  
    	dragStart: function(event) {
			//event.preventDefault();
			this.$el.trigger('sortstart', [this.model]);
			
    	},  
    	dragLeave: function(event) {
			event.preventDefault();
		//	console.log("dragLeave")
    	},  
    	dragEnd: function(event) {
			event.preventDefault();
		//	console.log("dragEnd")
    	},
    	dragOver: function(event) {
			event.preventDefault();
		//	console.log("dragEnd")
    	},  
    	change: function(event)
    	{
    		this.render();
    	},
		initialize : function()
		{
			_.bindAll(this);
			console.log("Initialize NewsListItem");
			this.model.on( 'change', this.change, this );
		}
	});

	return NewsListItem;
});