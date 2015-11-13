function isExternal(url) {
	return url.startsWith('//') || !!url.match(/^[a-z]+:(?!\d)/i);
};

angular.module('app', ['ngRoute', 'angulartics', 'angulartics.google.analytics.cordova'])

.config(function($routeProvider) {
	$routeProvider
		.when('/:page.md', {
			templateUrl: 'template.html',
			controller: 'MarkdownController'
		})
		.when('/:page.html', {
			templateUrl: function(param) {
				return param.page + '.html';
			}
		})
		.when('/:page.shtml', {
			templateUrl: function(param) {
				return param.page + '.shtml';
			}
		})
		.otherwise({
			redirectTo: '/index.md'
		});
})

.controller('MarkdownController', function($scope, $http, $sce, $routeParams, $compile) {
	$http.get($routeParams.page + '.md').then(function(response) {
		var html = markdown.toHTML(response.data);
		html = html.replace(/(a href=")(?![a-z]+\:)(?!\/\/)(?!(\d{0,3}\.){3})(?!(\w{4}\:){7})/g, 'a href="#');
		$scope.html = $sce.trustAsHtml( html );
	}, function(response) { 
		$scope.html = $sce.trustAsHtml('<h1>(' + response.status + ') ' + response.statusText + '</h1><p>&nbsp;</p>');
	});
});
