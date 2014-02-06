define(['backbone'], function(Backbone) {

var LoginModel = Backbone.Model.extend({
		defaults: {  email: '', password: '', role:'' },

		initialize: function() {
		}
	});
	return LoginModel;
});