define(['backbone'], function(Backbone) {

var NavigationModel = Backbone.Model.extend({
		defaults: { id: -1, name: '', title: '' },
		initialize: function() {
			console.log("Ready");
		}
	});
	return NavigationModel;
});