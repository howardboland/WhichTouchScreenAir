require.config({
	paths: {
		jquery: "vendor/jquery/jquery",
    'jquery.ui': 'vendor/jquery-ui/ui/minified/jquery-ui.min',
    'jquery.effect': 'vendor/jquery-ui/ui/minified/jquery.ui.effect.min',
    modernizr: "vendor/modernizr/modernizr",
		underscore: "vendor/underscore-amd/underscore",
		backbone: "vendor/backbone-amd/backbone",
    crossdomain: "vendor/Backbone.CrossDomain/Backbone.CrossDomain",
		'scrollTo': 'vendor/jquery.scrollTo/jquery.scrollTo',
    'jquery.prettydate': 'vendor/jquery-prettydate/jquery.prettydate',
    'jquery.dateformat': 'vendor/jquery-dateFormat/jquery.dateFormat-1.0',
    'jquery.sortable': 'vendor/jquery-sortable/source/js/jquery-sortable-min',
    'slimbox': 'vendor/slimbox/js/slimbox2',
    'text': "vendor/requirejs-text/text",

	},

  text: {
        "text" : "components/requirejs-text/text"
  },
	shim: {
    'jquery': {
      exports: '$'
    },
    'underscore': {
      exports: '_'
    },
    'backbone': {
      deps: ['underscore', 'jquery'],
      exports: 'Backbone'
    },
    'jquery.ui' : {
      deps: ['jquery'],
      exports: 'jquery-ui'
    },
     'jquery.ui.effect' : {
      deps: ['jquery'],
      exports: 'jquery.ui.effect'
    },
    'jquery.prettydate': {     //<-- cookie depends on Jquery and exports nothing
        deps: ['jquery'],
        exports: 'prettydate'

    },
    'jquery.sortable': {     //<-- cookie depends on Jquery and exports nothing
        deps: ['jquery'],
        exports: 'sortable'

    },
    'jquery.dateformat': {     //<-- cookie depends on Jquery and exports nothing
        deps: ['jquery'],
        exports: 'dateformat'

    },
    'scrollTo' : {
      deps: ['jquery'],
        exports: 'scrollTo'
    },  
    'jquery.imagesloaded' : {
      deps: ['jquery'],
      exports: 'imagesloaded'
    }, 
    'slimbox' : {
      deps: ['jquery'],
      exports: 'slimbox'
    }

  }
});

var Application = require(["view/AppView"], function(AppView){
	AppView.initialize();
});
