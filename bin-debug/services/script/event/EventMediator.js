define(['backbone'], 
	function(Backbone) {
		
		var EventMediator = _.extend({}, Backbone.Events);
	/*var EventMediator = Backbone.Events.extend( {

		
	});*/
	return EventMediator;
});	
