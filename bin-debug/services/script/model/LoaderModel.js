define(['backbone'], function(Backbone) {

var LoaderModel = Backbone.Model.extend({
		defaults: {  title: 'Loading....' },

		initialize: function() {
		}
	});
	return LoaderModel;
});