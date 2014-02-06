define(['backbone'], function(Backbone) {

var PageModel = Backbone.Model.extend({
		defaults: { id: -1, name: '', title: '', body: ''},
		initialize: function() {
			console.log("Ready");
		}
	});
	return PageModel;
});