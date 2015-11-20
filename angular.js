function isExternal(url) {
	return url.startsWith('//') || !!url.match(/^[a-z]+:(?!\d)/i);
};

angular.module('app', ['ngRoute', 'ui.bootstrap'])

.run(function($rootScope, $location) {
	$rootScope.$on('$routeChangeSuccess', function() {
		var current = $location.path().substring(1).split('.')[0];
		$rootScope.pageclass = current;
		ga('send', 'pageview', { page: $location.url() });
	});
})

.config(function($routeProvider) {
	$routeProvider
		//Redirect old index page to new home page
		.when('/index', { redirectTo: '/home' })
		//Handle Markdown files
		.when('/:page.md', {
			templateUrl: 'template.html',
			controller: 'MarkdownController'
		})
		//Handle other file types
		.when('/:page.:ext', {
			templateUrl: function(param) {
				return param.page + '.' + param.ext;
			}
		})
		//Handle Subfolders
		.when('/:path*/:page.:ext', {
			templateUrl: function(param) {
				return param.path + '/' + param.page + '.' + param.ext;
			}
		})
		//Assume Markdown files
		.when('/:page', {
			templateUrl: 'template.html',
			controller: 'MarkdownController'
		})
		//Redirect from root (/)
		.otherwise({ redirectTo: '/home' });
})

.controller('MarkdownController', function($scope, $http, $sce, $routeParams, $compile) {
	$http.get($routeParams.page + '.md').then(function(response) {
		var html = markdown.toHTML(response.data);
		html = html.replace(/(a href=")(?![a-z]+\:)(?!\/\/)(?!(\d{0,3}\.){3})(?!(\w{4}\:){7})/gi, 'a href="#');
		$scope.html = $sce.trustAsHtml( html );
	}, function(response) { 
		$scope.html = $sce.trustAsHtml('<h1>(' + response.status + ') ' + response.statusText + '</h1><p>&nbsp;</p>');
	});
})

/* Implements Active Menu selection */
.controller('NavController', function($scope, $location) {
	$scope.menuClass = function(page) {
		var current = $location.path().substring(1).split('.')[0];
		return page === current ? "active" : "";
	};
});
