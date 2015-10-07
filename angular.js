angular.module('app', ['ngRoute'])

.config(function($routeProvider) {
	$routeProvider
		.when('/', {
			templateUrl: 'template.html',
			controller: 'PageController'
		})
		.otherwise({
			redirectTo: '/'
		});
})

.controller('PageController', function($scope, $http, $sce) {
	console.log("PageController");
	$http.get('index.md').success(function(data) {
		$scope.html = $sce.trustAsHtml(markdown.toHTML(data));
	});
});
