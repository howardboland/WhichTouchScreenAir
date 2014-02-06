define(['text!templates/login.html', 'jquery', 'underscore', 'backbone',  'model/LoginModel'], 
	function(Template, $, _, Backbone, LoaderModel) {
		
		var LoaderView = Backbone.View.extend( {
			el: '#login',
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

