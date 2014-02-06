define(['backbone', 'model/PageModel'], function(Backbone, PageModel ) {
	var PageView = Backbone.View.extend( {
		featured: null,
		page: null,
		options: null,
		template: _.template( $("#page-template").html()),
		events: {
			/*'keypress .edit': 'updateOnEnter' */

		},
		render: function(){
			var self = this;

			console.log( "Render PageView" );
			
			this.page = $( this.template( this.model.toJSON() ));
			this.page.find("img").each(function(i, e ) {
				if ($(e).attr("src").indexOf("http://")==-1 && document.location.hostname=="localhost")
				{
					$(e).attr("src", "http://lm.c-lab.co.uk/"+$(e).attr("src"))	
				}
			});

			this.page.hide().css({"width": "100%"});
			console.log(this.el)
			$("#content").append( this.page );
			this.page.fadeIn(500);
			$("#bottom").css({position: "relative", bottom: ""});
			return this;

		},


		initialize : function(options)
		{
			this.options = options;
			console.log("initialize")//
			//options.EventMediator.bind()

			this.render();

			
			this.model.on( 'change', this.render, this );
			//console.log("Initialize");
			$(window).bind("resize", $.proxy(this.onresize, this));
		
			
		},
		transitionOut: function()
		{
			console.log(this.page)
			this.page.fadeOut('slow', $.proxy(this.transitionOutComplete, this));
		},
		transitionOutComplete: function()
		{
			this.trigger("transitionOutComplete");
			this.close(true);
		},
		close: function (done) {
 
 			console.log("close")
 			if (done)
 			{
 				console.log('Kill: ', this);
		        if (this.list)	 
		        {
		        	this.list.close();
		        }
		        if (this.flickrgallery)
		        	this.flickrgallery.close();
		        this.unbind(); // Unbind all local event bindings
		         this.remove(); // Remove view from DOM

 			} else 
 			{
 				this.transitionOut();	
		        
 			}
 			

    	}
	});

	return PageView;
});