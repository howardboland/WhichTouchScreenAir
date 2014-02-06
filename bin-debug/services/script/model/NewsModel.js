define(['backbone'], function(Backbone) {

var NewsModel = Backbone.Model.extend({
		idAttribute: "id",
		urlRoot: 'news/',
		defaults: { id: -1, header: '', title: '', url: '', body: '', public: -1, orderid: -1, selected: -1 },
		url: function()
		{
			return (document.location.hostname == "localhost" ? 'http://localhost/whichDirect' : '') +'/services/news.php'+ (this.has("id")  ? ((this.get("id")>0) ? "?id=" + this.get("id") : "") : "")
		}, 	

		initialize: function() {
			console.log("Ready");
		}
	});
	return NewsModel;
});