define(['text!templates/newsform.html', 'jquery', 'underscore', 'backbone',  'model/NewsModel'], 
	function(Template, $, _, Backbone, NewsModel) {
		
		var LoaderView = Backbone.View.extend( {
			el: '#news',
			form: null,
			template: _.template( Template ),

			events: {
				'click .save' : 'save',
				'click .delete' : 'delete'
				/*'keypress .edit': 'updateOnEnter' */
			},
			save: function()
			{

				this.model.save( { 
									'header': this.$el.find('input[name="header"]').val(),
									'title'	: this.$el.find('input[name="title"]').val(),
									'body'	: this.$el.find('textarea[name="body"]').val(),
									'url'	: this.$el.find('input[name="url"]').val(),									
									'public': this.$el.find('input[name="public"]').is(":checked") ? 1 : 0 
							}, 
							{ 	headers: {'accesskey' :'KEY_CODE_TO_BE_IMPLEMENTED'}, 
								success: this.saved, 
								error: this.errorResult});
			
			},
			saved: function(model, resp)
			{
				alert("Saved ");
				// Need to trigger update of list
				//this.$el.trigger('render');
			},
			delete: function()
			{
				if (window.confirm("Deleting item! Are you sure?"))
				{
					var self = this;
					this.model.destroy( {	headers: {'accesskey' :'KEY_CODE_TO_BE_IMPLEMENTED'}, 
											success: this.deleted, 
											error: this.errorResult,
											wait: true });
				}
			},
			deleted: function(model, resp)
			{
				// Need to trigger update of list
				  this.$el.trigger('delete');

			},
			errorResult: function()
			{
				
				alert("Error ");
			},
			render: function() {
				console.log("Render newsform "+this.model.get("title"))
				$(this.el).find("#newsform").remove();
				$(this.el).append( this.template( this.model.toJSON() ));
				this.onresize();

				$(this.el).find("#newsform").hide().fadeIn('slow');
			},
			initialize : function()
			{
				_.bindAll(this);
			
				console.log("loader initiated")
				$(this.loader).hide();
				this.model = new NewsModel;
				this.render();
				this.model.on("change", this.render);
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

