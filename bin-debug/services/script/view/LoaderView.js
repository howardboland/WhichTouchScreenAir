define(['text!templates/loader.html', 'jquery', 'underscore', 'backbone',  'model/LoaderModel'], 
	function(Template, $, _, Backbone, LoaderModel) {
		
		var LoaderView = Backbone.View.extend( {
			el: '#loader',
			template: _.template( Template ),

			events: {
				/*'keypress .edit': 'updateOnEnter' */
			},
			render: function() {
				$(this.el).append( this.template( this.model.toJSON() ) );
				this.onresize();

				$(this.el).hide().fadeIn('slow');
			},
			initialize : function()
			{
				
				console.log("loader initiated")
				$(this.loader).hide();
				this.model = new LoaderModel;
				this.render();
				this.on("complete", this.completed);
				this.on("error", this.error);
				$(window).bind("resize", $.proxy(this.onresize, this));
				this.onresize();	
			},
			onresize: function()
			{
				if ($(this.el).length>0)
				{

				
				$(this.el).css({ "position" : "absolute", 	
									left: ( ( $(window).width()-$(this.el).width() )/2 )+"px",
									top: ( ( $(window).height()-$(this.el).height() )/2 )+"px",
									})	
				}

				
			},
			completed: function()
			{
				console.log("loader completed")
				$(this.el).hide();
				$(this.el).empty();
				//this.unbind();
				//this.remove();

			},
			error: function(msg)
			{
				var errormsg = msg[1];
				$(this.el).show();
				
				$(this.el).text("Loading error in '" +msg[0]+"'\n").delay(2000).fadeOut('slow')
			}

			
		});

	return LoaderView;

});

