define(['text!templates/navigation.html','backbone'], function(Template, Backbone) {
	var NavigationListItem = Backbone.View.extend( {
		tagName: 'li',
		className: 'menu-tab',
		template: _.template( Template ),
		events: {
			/*'keypress .edit': 'updateOnEnter' */
		},
		render: function(){
		//	console.log( "Render NavigationElementView" );
			console.log( this.model.toJSON() );
			this.$el.html( this.template( this.model.toJSON() ) );
				if (this.model.get("name")=="home")  //home button is logo
				{
					this.$el.addClass("menu-logo-li")
					$($(this.$el[0]).find("a:first")).addClass("menu-logo")
				}
					
				else if (this.model.get("name")=="menu")  //home button is list 
				{
					this.$el.addClass("menu-list")
					$($(this.$el[0]).find("a:first")).addClass("menu-list-icon");

				}

					
				else					
					$($(this.$el[0]).find("a:first")).addClass("menu-link")
			return this;

		},


		initialize : function()
		{
			console.log("Initialize NavigationElementView");
			this.model.on( 'change', this.render, this );
		}
	});

	return NavigationListItem;
});