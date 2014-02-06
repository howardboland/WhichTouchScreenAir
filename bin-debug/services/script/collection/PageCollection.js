define(['backbone', 'model/PageModel'], function(Backbone, PageModel) {

	var PageCollection = Backbone.Collection.extend({
		model: PageModel,
		url: (document.location.hostname == "localhost" ? 'http://lm.c-lab.co.uk' : '') +'/php/page.php', 
		//localStorage: new Backbone.localStorage('pages-backbone'),
		completed: function() {
				console.log( "loading completed" );
				console.log( this.get(2).get( "title" ) );
		}
	});
	return PageCollection;
});