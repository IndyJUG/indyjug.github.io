function isExternal(url) {
	return url.startsWith('//') || !!url.match(/^[a-z]+:(?!\d)/i);
};

angular.module('app', ['ngRoute'])

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
	console.log("MarkdownController: " + $routeParams.page);
	$http.get($routeParams.page + '.md').then(function(response) {
		var html = markdown.toHTML(response.data);
		console.log(html);
		html = html.replace(/(a href=")(?![a-z]+\:)(?!\/\/)(?!(\d{0,3}\.){3})(?!(\w{4}\:){7})/gi, 'a href="#');
		console.log(html);
		$scope.html = $sce.trustAsHtml( html );
	}, function(response) { 
		$scope.html = $sce.trustAsHtml('<h1>(' + response.status + ') ' + response.statusText + '</h1><p>&nbsp;</p>');
	});
});
